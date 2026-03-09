import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';
import '../constants/firebase_constants.dart';

// ─── Custom exception ─────────────────────────────────────────────────────────

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

// ─── Auth Service ─────────────────────────────────────────────────────────────

class AuthService {
  AuthService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  /// Emits whenever the auth state changes (login / logout).
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Synchronous reference to the currently signed-in Firebase user.
  User? get currentUser => _auth.currentUser;

  // ── Sign In ────────────────────────────────────────────────────────────────

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final uid = credential.user!.uid;
      final doc = await _firestore
          .collection(FirebaseConstants.usersCollection)
          .doc(uid)
          .get();

      if (!doc.exists) {
        throw const AuthException(
          'Account data not found. Please contact support.',
        );
      }

      return UserModel.fromFirestore(doc);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseError(e.code));
    } catch (_) {
      throw const AuthException(
          'Sign-in failed. Please check your connection and try again.');
    }
  }

  // ── Register ───────────────────────────────────────────────────────────────

  /// Creates a Firebase Auth user and writes all Firestore documents
  /// (users + role-specific profile) in a single batch.
  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
    required String phoneNumber,
    required String country,
    Map<String, dynamic>? roleData,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final uid = credential.user!.uid;
      final now = DateTime.now();

      final user = UserModel(
        id: uid,
        email: email.trim(),
        fullName: fullName.trim(),
        role: role,
        phoneNumber: phoneNumber.trim(),
        country: country,
        verificationStatus: VerificationStatus.pending,
        createdAt: now,
        updatedAt: now,
      );

      final batch = _firestore.batch();

      // ── users/{uid} ────────────────────────────────────────────────────────
      final userRef =
          _firestore.collection(FirebaseConstants.usersCollection).doc(uid);
      batch.set(userRef, user.toFirestore());

      // ── Role-specific profile ──────────────────────────────────────────────
      switch (role) {
        case UserRole.ofw:
          final ofwRef = _firestore
              .collection(FirebaseConstants.ofwProfilesCollection)
              .doc();
          final ofw = OFWProfile(
            id: ofwRef.id,
            userId: uid,
            passportNumber: roleData?['passport_number'] as String?,
            destinationCountry: roleData?['destination_country'] as String?,
            jobTitle: roleData?['job_title'] as String?,
            experienceYears: roleData?['experience_years'] as int?,
            contractStatus: ContractStatus.none,
            createdAt: now,
          );
          batch.set(ofwRef, ofw.toFirestore());

        case UserRole.agency:
          final agencyRef =
              _firestore.collection(FirebaseConstants.agenciesCollection).doc();
          final agency = AgencyModel(
            id: agencyRef.id,
            userId: uid,
            agencyName: roleData?['agency_name'] as String? ?? '',
            licenseNumber: roleData?['license_number'] as String? ?? '',
            country: roleData?['country'] as String? ?? country,
            address: roleData?['address'] as String? ?? '',
            contactEmail: roleData?['contact_email'] as String? ?? email.trim(),
            contactPhone:
                roleData?['contact_phone'] as String? ?? phoneNumber.trim(),
            verificationStatus: 'pending',
            createdAt: now,
          );
          batch.set(agencyRef, agency.toFirestore());

        case UserRole.verifier:
          final verifierRef = _firestore
              .collection(FirebaseConstants.verifierProfilesCollection)
              .doc();
          final orgTypeStr =
              roleData?['organization_type'] as String? ?? 'government';
          final verifier = VerifierProfile(
            id: verifierRef.id,
            userId: uid,
            organizationName: roleData?['organization_name'] as String? ?? '',
            organizationType: OrganizationType.values.firstWhere(
              (t) => t.name == orgTypeStr,
              orElse: () => OrganizationType.government,
            ),
            roleTitle: roleData?['role_title'] as String? ?? '',
            verificationLevel: 1,
            createdAt: now,
          );
          batch.set(verifierRef, verifier.toFirestore());

        default:
          break;
      }

      await batch.commit();
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mapFirebaseError(e.code));
    } catch (_) {
      throw const AuthException(
          'Registration failed. Please check your connection and try again.');
    }
  }

  // ── Load current user ──────────────────────────────────────────────────────

  /// Fetches the Firestore [UserModel] for the currently signed-in Firebase
  /// user, or returns null if nobody is logged in.
  Future<UserModel?> loadCurrentUser() async {
    final fbUser = _auth.currentUser;
    if (fbUser == null) return null;
    final doc = await _firestore
        .collection(FirebaseConstants.usersCollection)
        .doc(fbUser.uid)
        .get();
    if (!doc.exists) return null;
    return UserModel.fromFirestore(doc);
  }

  // ── Sign Out ───────────────────────────────────────────────────────────────

  Future<void> signOut() => _auth.signOut();

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled. Contact support.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
