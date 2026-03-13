import * as admin from "firebase-admin";
import { analyzeContractUpload } from "./analyzeContract";

if (!admin.apps.length) {
  admin.initializeApp();
}

export { analyzeContractUpload };
