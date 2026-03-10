import 'package:cloud_firestore/cloud_firestore.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────

enum UserRole { ofw, government, ngo, admin }

enum VerificationStatus { pending, verified, rejected }

enum ContractStatus { none, uploaded, analyzed }

// ─── User ─────────────────────────────────────────────────────────────────────

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final UserRole role;
  final String phoneNumber;
  final String country;
  final String? profilePhotoUrl;
  final VerificationStatus verificationStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.phoneNumber,
    required this.country,
    this.profilePhotoUrl,
    required this.verificationStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      fullName: data['full_name'] ?? '',
      role: UserRole.values.firstWhere(
        (r) => r.name == data['role'],
        orElse: () => UserRole.ofw,
      ),
      phoneNumber: data['phone_number'] ?? '',
      country: data['country'] ?? '',
      profilePhotoUrl: data['profile_photo_url'],
      verificationStatus: VerificationStatus.values.firstWhere(
        (s) => s.name == data['verification_status'],
        orElse: () => VerificationStatus.pending,
      ),
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'email': email,
        'full_name': fullName,
        'role': role.name,
        'phone_number': phoneNumber,
        'country': country,
        'profile_photo_url': profilePhotoUrl,
        'verification_status': verificationStatus.name,
        'created_at': Timestamp.fromDate(createdAt),
        'updated_at': Timestamp.fromDate(updatedAt),
      };
}

// ─── OFW Profile ──────────────────────────────────────────────────────────────

class OFWProfile {
  final String id;
  final String userId;
  final String? passportNumber;
  final String? destinationCountry;
  final String? jobTitle;
  final int? experienceYears;
  final ContractStatus contractStatus;
  final DateTime createdAt;

  const OFWProfile({
    required this.id,
    required this.userId,
    this.passportNumber,
    this.destinationCountry,
    this.jobTitle,
    this.experienceYears,
    required this.contractStatus,
    required this.createdAt,
  });

  factory OFWProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OFWProfile(
      id: doc.id,
      userId: data['user_id'] ?? '',
      passportNumber: data['passport_number'],
      destinationCountry: data['destination_country'],
      jobTitle: data['job_title'],
      experienceYears: data['experience_years'],
      contractStatus: ContractStatus.values.firstWhere(
        (s) => s.name == data['contract_status'],
        orElse: () => ContractStatus.none,
      ),
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'user_id': userId,
        'passport_number': passportNumber,
        'destination_country': destinationCountry,
        'job_title': jobTitle,
        'experience_years': experienceYears,
        'contract_status': contractStatus.name,
        'created_at': Timestamp.fromDate(createdAt),
      };
}

// ─── Organization Profile (Government / NGO) ──────────────────────────────────

class OrganizationProfile {
  final String id;
  final String userId;
  final String organizationName;
  final String roleTitle;
  final DateTime createdAt;

  const OrganizationProfile({
    required this.id,
    required this.userId,
    required this.organizationName,
    required this.roleTitle,
    required this.createdAt,
  });

  factory OrganizationProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrganizationProfile(
      id: doc.id,
      userId: data['user_id'] ?? '',
      organizationName: data['organization_name'] ?? '',
      roleTitle: data['role_title'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'user_id': userId,
        'organization_name': organizationName,
        'role_title': roleTitle,
        'created_at': Timestamp.fromDate(createdAt),
      };
}
