#!/usr/bin/env node
/**
 * Anchor — Seed Admin Account
 * Creates admin01@anchor.com / adminadmin in Firebase Auth + Firestore.
 * Uses only built-in Node.js modules (no npm install required).
 *
 * Run: node scripts/seed-admin.js
 */

"use strict";

const https = require("https");

// ─── Config ───────────────────────────────────────────────────────────────────
const API_KEY = "AIzaSyDShRLVx5V2Mc2qbQHN_823Q83gCo2XpOI";
const PROJECT_ID = "anchor-81b45";
const ADMIN_EMAIL = "admin01@anchor.com";
const ADMIN_PASSWORD = "adminadmin";
const ADMIN_NAME = "Anchor Admin";
const NOW = new Date().toISOString();

// ─── Helpers ──────────────────────────────────────────────────────────────────
function post(hostname, path, body, headers = {}) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify(body);
    const req = https.request(
      {
        hostname,
        path,
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Content-Length": Buffer.byteLength(data),
          ...headers,
        },
      },
      (res) => {
        let raw = "";
        res.on("data", (c) => (raw += c));
        res.on("end", () => {
          try {
            resolve({ status: res.statusCode, body: JSON.parse(raw) });
          } catch {
            resolve({ status: res.statusCode, body: raw });
          }
        });
      },
    );
    req.on("error", reject);
    req.write(data);
    req.end();
  });
}

function patch(hostname, path, body, token) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify(body);
    const req = https.request(
      {
        hostname,
        path,
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "Content-Length": Buffer.byteLength(data),
          Authorization: `Bearer ${token}`,
        },
      },
      (res) => {
        let raw = "";
        res.on("data", (c) => (raw += c));
        res.on("end", () => {
          try {
            resolve({ status: res.statusCode, body: JSON.parse(raw) });
          } catch {
            resolve({ status: res.statusCode, body: raw });
          }
        });
      },
    );
    req.on("error", reject);
    req.write(data);
    req.end();
  });
}

// ─── Main ─────────────────────────────────────────────────────────────────────
async function main() {
  // ── Step 1: Create Firebase Auth user ─────────────────────────────────────
  console.log(`\n[1/3] Creating Firebase Auth user: ${ADMIN_EMAIL}`);
  const signUp = await post(
    "identitytoolkit.googleapis.com",
    `/v1/accounts:signUp?key=${API_KEY}`,
    { email: ADMIN_EMAIL, password: ADMIN_PASSWORD, returnSecureToken: true },
  );

  let uid, idToken;

  if (signUp.status === 200) {
    uid = signUp.body.localId;
    idToken = signUp.body.idToken;
    console.log(`   ✓ Auth user created  UID: ${uid}`);
  } else if (signUp.body?.error?.message === "EMAIL_EXISTS") {
    // Account already exists → sign in to get idToken + uid
    console.log("   ~ Email already exists, signing in instead…");
    const signIn = await post(
      "identitytoolkit.googleapis.com",
      `/v1/accounts:signInWithPassword?key=${API_KEY}`,
      { email: ADMIN_EMAIL, password: ADMIN_PASSWORD, returnSecureToken: true },
    );
    if (signIn.status !== 200) {
      console.error("   ✗ Sign-in failed:", JSON.stringify(signIn.body));
      process.exit(1);
    }
    uid = signIn.body.localId;
    idToken = signIn.body.idToken;
    console.log(`   ✓ Signed in. UID: ${uid}`);
  } else {
    console.error("   ✗ Auth error:", JSON.stringify(signUp.body));
    process.exit(1);
  }

  // ── Step 2: Update Firebase Auth display name ──────────────────────────────
  console.log(`\n[2/3] Setting display name: "${ADMIN_NAME}"`);
  const update = await post(
    "identitytoolkit.googleapis.com",
    `/v1/accounts:update?key=${API_KEY}`,
    { idToken, displayName: ADMIN_NAME },
  );
  if (update.status === 200) {
    console.log("   ✓ Display name set");
  } else {
    console.warn(
      "   ~ Could not set display name:",
      JSON.stringify(update.body),
    );
  }

  // ── Step 3: Write users/{uid} document in Firestore ───────────────────────
  console.log(`\n[3/3] Writing Firestore users/${uid}`);
  const fsPath = `/v1/projects/${PROJECT_ID}/databases/(default)/documents/users/${uid}`;
  const fsBody = {
    fields: {
      email: { stringValue: ADMIN_EMAIL },
      full_name: { stringValue: ADMIN_NAME },
      role: { stringValue: "admin" },
      phone_number: { stringValue: "" },
      country: { stringValue: "Philippines" },
      profile_photo_url: { nullValue: null },
      verification_status: { stringValue: "verified" },
      created_at: { timestampValue: NOW },
      updated_at: { timestampValue: NOW },
    },
  };

  const fs = await patch("firestore.googleapis.com", fsPath, fsBody, idToken);
  if (fs.status === 200) {
    console.log("   ✓ Firestore document written");
  } else {
    console.error("   ✗ Firestore error:", JSON.stringify(fs.body));
    process.exit(1);
  }

  // ── Done ──────────────────────────────────────────────────────────────────
  console.log(`
╔═══════════════════════════════════════════════╗
║          Admin account ready                  ║
╠═══════════════════════════════════════════════╣
║  Email   : admin01@anchor.com                 ║
║  Password: adminadmin                         ║
║  Role    : admin                              ║
║  UID     : ${uid.padEnd(33)} ║
╚═══════════════════════════════════════════════╝
  `);
}

main().catch((err) => {
  console.error("Fatal:", err.message);
  process.exit(1);
});
