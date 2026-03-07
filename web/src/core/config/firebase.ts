import { initializeApp, getApps, type FirebaseApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getFirestore } from "firebase/firestore";
import { getStorage } from "firebase/storage";
import { getFunctions } from "firebase/functions";
import { getAnalytics, isSupported } from "firebase/analytics";

const firebaseConfig = {
  apiKey: "AIzaSyDShRLVx5V2Mc2qbQHN_823Q83gCo2XpOI",
  authDomain: "anchor-81b45.firebaseapp.com",
  projectId: "anchor-81b45",
  storageBucket: "anchor-81b45.firebasestorage.app",
  messagingSenderId: "472108302995",
  appId: "1:472108302995:web:9d2356e97cfc9ff2888366",
  measurementId: "G-8JCLYHK7JM",
};

// Prevent duplicate app initialization (e.g. HMR in Vite)
const app: FirebaseApp =
  getApps().length === 0 ? initializeApp(firebaseConfig) : getApps()[0];

export const auth = getAuth(app);
export const db = getFirestore(app);
export const storage = getStorage(app);
export const functions = getFunctions(app);

// Analytics is only available in browser environments
export const analyticsPromise = isSupported().then((yes) =>
  yes ? getAnalytics(app) : null,
);

export default app;
