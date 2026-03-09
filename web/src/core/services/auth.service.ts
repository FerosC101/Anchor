import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  signOut as firebaseSignOut,
  updateProfile,
} from "firebase/auth";
import { collection, doc, getDoc, writeBatch } from "firebase/firestore";
import { auth, db } from "../config/firebase";
import {
  USERS_COLLECTION,
  OFW_PROFILES_COLLECTION,
  AGENCIES_COLLECTION,
  VERIFIER_PROFILES_COLLECTION,
} from "../constants/firebase";
import type { UserModel, UserRole, OrganizationType } from "@/types";
import {
  userModelFromFirestore,
  userModelToFirestoreData,
  ofwProfileToFirestoreData,
  agencyModelToFirestoreData,
  verifierProfileToFirestoreData,
  USER_ROLE,
  VERIFICATION_STATUS,
  CONTRACT_STATUS,
  ORGANIZATION_TYPE,
} from "@/types";

// ─── Custom exception ─────────────────────────────────────────────────────────

export class AuthException extends Error {
  constructor(message: string) {
    super(message);
    this.name = "AuthException";
  }
}

// ─── Error mapping ───────────────────────────────────────────────────────────

function mapFirebaseError(code: string): string {
  // Firebase JS SDK often prefixes error codes, e.g. "auth/wrong-password".
  // Normalise to the final segment so we can switch on stable codes.
  const normalized = code.includes("/")
    ? (code.split("/").pop() ?? code)
    : code;

  switch (normalized) {
    case "user-not-found":
      return "No account found with this email.";
    case "wrong-password":
    case "invalid-login-credentials":
    case "invalid-credential":
      return "Incorrect email or password.";
    case "email-already-in-use":
      return "An account with this email already exists.";
    case "weak-password":
      return "Password is too weak. Use at least 6 characters.";
    case "invalid-email":
      return "Please enter a valid email address.";
    case "user-disabled":
      return "This account has been disabled. Contact support.";
    case "too-many-requests":
      return "Too many failed attempts. Please try again later.";
    case "network-request-failed":
      return "No internet connection. Please check your network.";
    case "permission-denied":
      return "You don't have permission to access your account data. Please contact support.";
    default:
      return "An unexpected error occurred. Please try again.";
  }
}

// ─── Sign In ─────────────────────────────────────────────────────────────────

/**
 * Signs in with email/password, then fetches the Firestore user document.
 * Returns UserModel or throws AuthException.
 */
export async function signIn(
  email: string,
  password: string,
): Promise<UserModel> {
  try {
    const credential = await signInWithEmailAndPassword(
      auth,
      email.trim(),
      password,
    );
    const uid = credential.user.uid;
    const userRef = doc(db, USERS_COLLECTION, uid);
    const userSnap = await getDoc(userRef);
    if (!userSnap.exists()) {
      throw new AuthException(
        "Account data not found. Please contact support.",
      );
    }
    return userModelFromFirestore(userSnap);
  } catch (err) {
    if (err instanceof AuthException) throw err;
    const code =
      err && typeof err === "object" && "code" in err
        ? String((err as { code: string }).code)
        : "";
    throw new AuthException(mapFirebaseError(code || "unknown"));
  }
}

// ─── Register ───────────────────────────────────────────────────────────────

export type RegisterRoleData = {
  // OFW
  passport_number?: string;
  destination_country?: string;
  job_title?: string;
  experience_years?: number;
  // Agency
  agency_name?: string;
  license_number?: string;
  country?: string;
  address?: string;
  contact_email?: string;
  contact_phone?: string;
  // Verifier
  organization_name?: string;
  organization_type?: string;
  role_title?: string;
};

/**
 * Creates Firebase Auth user and writes users + role-specific profile in a batch.
 * Returns UserModel or throws AuthException.
 */
export async function register(
  email: string,
  password: string,
  fullName: string,
  role: UserRole,
  phoneNumber: string,
  country: string,
  roleData?: RegisterRoleData,
): Promise<UserModel> {
  try {
    const credential = await createUserWithEmailAndPassword(
      auth,
      email.trim(),
      password,
    );
    const uid = credential.user.uid;
    const displayName = fullName.trim();
    if (displayName) {
      await updateProfile(credential.user, { displayName });
    }

    const now = new Date();
    const user: UserModel = {
      id: uid,
      email: email.trim(),
      fullName: displayName || email.trim(),
      role,
      phoneNumber: phoneNumber.trim(),
      country,
      profilePhotoUrl: null,
      verificationStatus: VERIFICATION_STATUS.PENDING,
      createdAt: now,
      updatedAt: now,
    };

    const batch = writeBatch(db);

    // users/{uid}
    const userRef = doc(db, USERS_COLLECTION, uid);
    batch.set(userRef, userModelToFirestoreData(user));

    // Role-specific profile
    const rd = roleData ?? {};
    switch (role) {
      case USER_ROLE.OFW: {
        const ofwRef = doc(collection(db, OFW_PROFILES_COLLECTION));
        batch.set(
          ofwRef,
          ofwProfileToFirestoreData({
            id: ofwRef.id,
            userId: uid,
            passportNumber: rd.passport_number ?? null,
            destinationCountry: rd.destination_country ?? null,
            jobTitle: rd.job_title ?? null,
            experienceYears: rd.experience_years ?? null,
            agencyId: null,
            contractStatus: CONTRACT_STATUS.NONE,
            createdAt: now,
          }),
        );
        break;
      }
      case USER_ROLE.AGENCY: {
        const agencyRef = doc(collection(db, AGENCIES_COLLECTION));
        batch.set(
          agencyRef,
          agencyModelToFirestoreData({
            id: agencyRef.id,
            userId: uid,
            agencyName: rd.agency_name ?? "",
            licenseNumber: rd.license_number ?? "",
            country: rd.country ?? country,
            address: rd.address ?? "",
            contactEmail: rd.contact_email ?? email.trim(),
            contactPhone: rd.contact_phone ?? phoneNumber.trim(),
            verificationStatus: "pending",
            createdAt: now,
          }),
        );
        break;
      }
      case USER_ROLE.VERIFIER: {
        const verifierRef = doc(collection(db, VERIFIER_PROFILES_COLLECTION));
        const orgType =
          (rd.organization_type as OrganizationType) ??
          ORGANIZATION_TYPE.GOVERNMENT;
        batch.set(
          verifierRef,
          verifierProfileToFirestoreData({
            id: verifierRef.id,
            userId: uid,
            organizationName: rd.organization_name ?? "",
            organizationType: orgType,
            roleTitle: rd.role_title ?? "",
            verificationLevel: 1,
            createdAt: now,
          }),
        );
        break;
      }
      default:
        break;
    }

    await batch.commit();
    return user;
  } catch (err) {
    if (err instanceof AuthException) throw err;
    const code =
      err && typeof err === "object" && "code" in err
        ? String((err as { code: string }).code)
        : "";
    throw new AuthException(mapFirebaseError(code || "unknown"));
  }
}

// ─── Sign Out ───────────────────────────────────────────────────────────────

export async function signOut(): Promise<void> {
  await firebaseSignOut(auth);
}
