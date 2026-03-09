import { doc, getDoc, setDoc } from "firebase/firestore";
import { db } from "../config/firebase";
import { USERS_COLLECTION } from "../constants/firebase";
import {
  type UserModel,
  type UserRole,
  userModelFromFirestore,
  userModelToFirestoreData,
  USER_ROLE,
  VERIFICATION_STATUS,
} from "@/types";

/**
 * Creates the Firestore user document in the same shape as mobile (UserModel).
 * Call after Firebase Auth user is created (e.g. on register).
 */
export async function createUserDocument(
  uid: string,
  data: {
    email: string;
    fullName: string;
    role?: UserRole;
    phoneNumber?: string;
    country?: string;
  },
): Promise<void> {
  const now = new Date();
  const user: UserModel = {
    id: uid,
    email: data.email,
    fullName: data.fullName,
    role: data.role ?? USER_ROLE.OFW,
    phoneNumber: data.phoneNumber ?? "",
    country: data.country ?? "",
    profilePhotoUrl: null,
    verificationStatus: VERIFICATION_STATUS.PENDING,
    createdAt: now,
    updatedAt: now,
  };
  const ref = doc(db, USERS_COLLECTION, uid);
  await setDoc(ref, userModelToFirestoreData(user));
}

/**
 * Fetches the app user (UserModel) by Firebase Auth UID.
 * Returns null if the document does not exist.
 */
export async function getUserDocument(uid: string): Promise<UserModel | null> {
  const ref = doc(db, USERS_COLLECTION, uid);
  const snap = await getDoc(ref);
  if (!snap.exists()) return null;
  return userModelFromFirestore(snap);
}
