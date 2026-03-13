import { Timestamp, type DocumentSnapshot } from "firebase/firestore";

// ─── Enums (string unions for JSON/Firestore) ─────────────────────────────────

export const USER_ROLE = {
  OFW: "ofw",
  AGENCY: "agency",
  VERIFIER: "verifier",
  ADMIN: "admin",
} as const;
export type UserRole = (typeof USER_ROLE)[keyof typeof USER_ROLE];

export const VERIFICATION_STATUS = {
  PENDING: "pending",
  VERIFIED: "verified",
  REJECTED: "rejected",
} as const;
export type VerificationStatus =
  (typeof VERIFICATION_STATUS)[keyof typeof VERIFICATION_STATUS];

export const CONTRACT_STATUS = {
  NONE: "none",
  UPLOADED: "uploaded",
  ANALYZED: "analyzed",
} as const;
export type ContractStatus =
  (typeof CONTRACT_STATUS)[keyof typeof CONTRACT_STATUS];

export const ORGANIZATION_TYPE = {
  GOVERNMENT: "government",
  NGO: "ngo",
  EMBASSY: "embassy",
} as const;
export type OrganizationType =
  (typeof ORGANIZATION_TYPE)[keyof typeof ORGANIZATION_TYPE];

// ─── User ─────────────────────────────────────────────────────────────────────

export interface UserModel {
  id: string;
  email: string;
  fullName: string;
  role: UserRole;
  phoneNumber: string;
  country: string;
  profilePhotoUrl: string | null;
  verificationStatus: VerificationStatus;
  createdAt: Date;
  updatedAt: Date;
}

const VERIFICATION_STATUS_VALUES: VerificationStatus[] = [
  VERIFICATION_STATUS.PENDING,
  VERIFICATION_STATUS.VERIFIED,
  VERIFICATION_STATUS.REJECTED,
];

function parseRole(value: unknown): UserRole {
  if (typeof value === "string") {
    // Map Flutter role names to web role names
    const roleMap: Record<string, UserRole> = {
      ofw: USER_ROLE.OFW,
      agency: USER_ROLE.AGENCY,
      government: USER_ROLE.AGENCY, // Flutter uses "government", web uses "agency"
      verifier: USER_ROLE.VERIFIER,
      ngo: USER_ROLE.VERIFIER, // Flutter uses "ngo", web uses "verifier"
      admin: USER_ROLE.ADMIN,
    };
    const mapped = roleMap[value as string];
    if (mapped) return mapped;
  }
  return USER_ROLE.OFW;
}

function parseVerificationStatus(value: unknown): VerificationStatus {
  if (
    typeof value === "string" &&
    VERIFICATION_STATUS_VALUES.includes(value as VerificationStatus)
  )
    return value as VerificationStatus;
  return VERIFICATION_STATUS.PENDING;
}

function toDate(value: unknown): Date {
  if (value && typeof value === "object" && "toDate" in value)
    return (value as { toDate(): Date }).toDate();
  if (value instanceof Date) return value;
  return new Date(0);
}

export function userModelFromFirestore(doc: DocumentSnapshot): UserModel {
  const data = doc.data() ?? {};
  return {
    id: doc.id,
    email: (data["email"] as string) ?? "",
    fullName: (data["full_name"] as string) ?? "",
    role: parseRole(data["role"]),
    phoneNumber: (data["phone_number"] as string) ?? "",
    country: (data["country"] as string) ?? "",
    profilePhotoUrl: (data["profile_photo_url"] as string | null) ?? null,
    verificationStatus: parseVerificationStatus(data["verification_status"]),
    createdAt: toDate(data["created_at"]),
    updatedAt: toDate(data["updated_at"]),
  };
}

export function userModelToFirestoreData(
  user: UserModel
): Record<string, unknown> {
  return {
    email: user.email,
    full_name: user.fullName,
    role: user.role,
    phone_number: user.phoneNumber,
    country: user.country,
    profile_photo_url: user.profilePhotoUrl,
    verification_status: user.verificationStatus,
    created_at: Timestamp.fromDate(user.createdAt),
    updated_at: Timestamp.fromDate(user.updatedAt),
  };
}

// ─── OFW Profile ──────────────────────────────────────────────────────────────

export interface OFWProfile {
  id: string;
  userId: string;
  passportNumber: string | null;
  destinationCountry: string | null;
  jobTitle: string | null;
  experienceYears: number | null;
  agencyId: string | null;
  contractStatus: ContractStatus;
  createdAt: Date;
}

const CONTRACT_STATUS_VALUES: ContractStatus[] = [
  CONTRACT_STATUS.NONE,
  CONTRACT_STATUS.UPLOADED,
  CONTRACT_STATUS.ANALYZED,
];

function parseContractStatus(value: unknown): ContractStatus {
  if (
    typeof value === "string" &&
    CONTRACT_STATUS_VALUES.includes(value as ContractStatus)
  )
    return value as ContractStatus;
  return CONTRACT_STATUS.NONE;
}

export function ofwProfileFromFirestore(
  doc: DocumentSnapshot
): OFWProfile {
  const data = doc.data() ?? {};
  return {
    id: doc.id,
    userId: (data["user_id"] as string) ?? "",
    passportNumber: (data["passport_number"] as string | null) ?? null,
    destinationCountry:
      (data["destination_country"] as string | null) ?? null,
    jobTitle: (data["job_title"] as string | null) ?? null,
    experienceYears: (data["experience_years"] as number | null) ?? null,
    agencyId: (data["agency_id"] as string | null) ?? null,
    contractStatus: parseContractStatus(data["contract_status"]),
    createdAt: toDate(data["created_at"]),
  };
}

export function ofwProfileToFirestoreData(
  profile: OFWProfile
): Record<string, unknown> {
  return {
    user_id: profile.userId,
    passport_number: profile.passportNumber,
    destination_country: profile.destinationCountry,
    job_title: profile.jobTitle,
    experience_years: profile.experienceYears,
    agency_id: profile.agencyId,
    contract_status: profile.contractStatus,
    created_at: Timestamp.fromDate(profile.createdAt),
  };
}

// ─── Agency ───────────────────────────────────────────────────────────────────

export interface AgencyModel {
  id: string;
  userId: string;
  agencyName: string;
  licenseNumber: string;
  country: string;
  address: string;
  contactEmail: string;
  contactPhone: string;
  verificationStatus: string; // "pending" | "verified" | "suspended"
  createdAt: Date;
}

export function agencyModelFromFirestore(
  doc: DocumentSnapshot
): AgencyModel {
  const data = doc.data() ?? {};
  return {
    id: doc.id,
    userId: (data["user_id"] as string) ?? "",
    agencyName: (data["agency_name"] as string) ?? "",
    licenseNumber: (data["license_number"] as string) ?? "",
    country: (data["country"] as string) ?? "",
    address: (data["address"] as string) ?? "",
    contactEmail: (data["contact_email"] as string) ?? "",
    contactPhone: (data["contact_phone"] as string) ?? "",
    verificationStatus: (data["verification_status"] as string) ?? "pending",
    createdAt: toDate(data["created_at"]),
  };
}

export function agencyModelToFirestoreData(
  agency: AgencyModel
): Record<string, unknown> {
  return {
    user_id: agency.userId,
    agency_name: agency.agencyName,
    license_number: agency.licenseNumber,
    country: agency.country,
    address: agency.address,
    contact_email: agency.contactEmail,
    contact_phone: agency.contactPhone,
    verification_status: agency.verificationStatus,
    created_at: Timestamp.fromDate(agency.createdAt),
  };
}

// ─── Verifier Profile ─────────────────────────────────────────────────────────

export interface VerifierProfile {
  id: string;
  userId: string;
  organizationName: string;
  organizationType: OrganizationType;
  roleTitle: string;
  verificationLevel: number;
  createdAt: Date;
}

const ORGANIZATION_TYPE_VALUES: OrganizationType[] = [
  ORGANIZATION_TYPE.GOVERNMENT,
  ORGANIZATION_TYPE.NGO,
  ORGANIZATION_TYPE.EMBASSY,
];

function parseOrganizationType(value: unknown): OrganizationType {
  if (
    typeof value === "string" &&
    ORGANIZATION_TYPE_VALUES.includes(value as OrganizationType)
  )
    return value as OrganizationType;
  return ORGANIZATION_TYPE.GOVERNMENT;
}

export function verifierProfileFromFirestore(
  doc: DocumentSnapshot
): VerifierProfile {
  const data = doc.data() ?? {};
  return {
    id: doc.id,
    userId: (data["user_id"] as string) ?? "",
    organizationName: (data["organization_name"] as string) ?? "",
    organizationType: parseOrganizationType(data["organization_type"]),
    roleTitle: (data["role_title"] as string) ?? "",
    verificationLevel: (data["verification_level"] as number) ?? 1,
    createdAt: toDate(data["created_at"]),
  };
}

export function verifierProfileToFirestoreData(
  profile: VerifierProfile
): Record<string, unknown> {
  return {
    user_id: profile.userId,
    organization_name: profile.organizationName,
    organization_type: profile.organizationType,
    role_title: profile.roleTitle,
    verification_level: profile.verificationLevel,
    created_at: Timestamp.fromDate(profile.createdAt),
  };
}
