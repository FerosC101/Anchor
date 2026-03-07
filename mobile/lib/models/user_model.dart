import 'package:cloud_firestore/cloud_firestore.dart';

// ─── Enums ────────────────────────────────────────────────────────────────────

enum UserRole { ofw, agency, verifier, admin }

enum VerificationStatus { pending, verified, rejected }

enum ContractStatus { none, uploaded, analyzed }

enum OrganizationType { government, ngo, embassy }

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
  final String? agencyId;
  final ContractStatus contractStatus;
  final DateTime createdAt;

  const OFWProfile({
    required this.id,
    required this.userId,
    this.passportNumber,
    this.destinationCountry,
    this.jobTitle,
    this.experienceYears,
    this.agencyId,
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
      agencyId: data['agency_id'],
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
        'agency_id': agencyId,
        'contract_status': contractStatus.name,
        'created_at': Timestamp.fromDate(createdAt),
      };
}

// ─── Agency ───────────────────────────────────────────────────────────────────

class AgencyModel {
  final String id;
  final String userId;
  final String agencyName;
  final String licenseNumber;
  final String country;
  final String address;
  final String contactEmail;
  final String contactPhone;
  final String verificationStatus; // pending | verified | suspended
  final DateTime createdAt;

  const AgencyModel({
    required this.id,
    required this.userId,
    required this.agencyName,
    required this.licenseNumber,
    required this.country,
    required this.address,
    required this.contactEmail,
    required this.contactPhone,
    required this.verificationStatus,
    required this.createdAt,
  });

  factory AgencyModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AgencyModel(
      id: doc.id,
      userId: data['user_id'] ?? '',
      agencyName: data['agency_name'] ?? '',
      licenseNumber: data['license_number'] ?? '',
      country: data['country'] ?? '',
      address: data['address'] ?? '',
      contactEmail: data['contact_email'] ?? '',
      contactPhone: data['contact_phone'] ?? '',
      verificationStatus: data['verification_status'] ?? 'pending',
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'user_id': userId,
        'agency_name': agencyName,
        'license_number': licenseNumber,
        'country': country,
        'address': address,
        'contact_email': contactEmail,
        'contact_phone': contactPhone,
        'verification_status': verificationStatus,
        'created_at': Timestamp.fromDate(createdAt),
      };
}

// ─── Verifier Profile ─────────────────────────────────────────────────────────

class VerifierProfile {
  final String id;
  final String userId;
  final String organizationName;
  final OrganizationType organizationType;
  final String roleTitle;
  final int verificationLevel;
  final DateTime createdAt;

  const VerifierProfile({
    required this.id,
    required this.userId,
    required this.organizationName,
    required this.organizationType,
    required this.roleTitle,
    required this.verificationLevel,
    required this.createdAt,
  });

  factory VerifierProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return VerifierProfile(
      id: doc.id,
      userId: data['user_id'] ?? '',
      organizationName: data['organization_name'] ?? '',
      organizationType: OrganizationType.values.firstWhere(
        (t) => t.name == data['organization_type'],
        orElse: () => OrganizationType.government,
      ),
      roleTitle: data['role_title'] ?? '',
      verificationLevel: data['verification_level'] ?? 1,
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'user_id': userId,
        'organization_name': organizationName,
        'organization_type': organizationType.name,
        'role_title': roleTitle,
        'verification_level': verificationLevel,
        'created_at': Timestamp.fromDate(createdAt),
      };
}
