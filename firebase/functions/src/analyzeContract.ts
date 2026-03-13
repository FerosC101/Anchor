import * as admin from "firebase-admin";
import { HttpsError, onCall } from "firebase-functions/v2/https";
import { analyzeContractWithModel } from "./aiService";

if (!admin.apps.length) {
  admin.initializeApp();
}

const db = admin.firestore();

export const analyzeContractUpload = onCall(
  {
    region: "us-central1",
    timeoutSeconds: 60,
    memory: "512MiB",
    secrets: ["GEMINI_API_KEY"],
  },
  async (request) => {
    if (!request.auth?.uid) {
      throw new HttpsError("unauthenticated", "Authentication is required.");
    }

    const contractId = String(request.data?.contractId ?? "").trim();
    const fileUrl = String(request.data?.fileUrl ?? "").trim();
    const fileName = String(request.data?.fileName ?? "").trim();
    const text = String(request.data?.text ?? "");

    if (!contractId) {
      throw new HttpsError("invalid-argument", "contractId is required.");
    }

    const contractRef = db.collection("contracts").doc(contractId);
    const analysisRef = db.collection("contract_analysis").doc(contractId);

    await contractRef.set(
      {
        user_id: request.auth.uid,
        contract_file_url: fileUrl,
        file_name: fileName,
        ai_analysis_status: "pending",
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true },
    );

    try {
      const analysis = await analyzeContractWithModel({
        text,
        fileName,
        contractId,
        fileUrl,
      });

      await analysisRef.set(
        {
          contract_id: contractId,
          user_id: request.auth.uid,
          risk_score: analysis.risk_score,
          risk_level: analysis.risk_level,
          ai_summary: analysis.ai_summary,
          overview_summary: analysis.overview_summary ?? null,
          flagged_clauses: analysis.flagged_clauses,
          issue_count:
            typeof analysis.issue_count === "number"
              ? analysis.issue_count
              : analysis.flagged_clauses.length,
          critical_count:
            typeof analysis.critical_count === "number"
              ? analysis.critical_count
              : analysis.flagged_clauses.filter(
                  (item) => item.severity === "high",
                ).length,
          comparison_items: analysis.comparison_items ?? [],
          recommended_actions: analysis.recommended_actions ?? [],
          model_loaded: analysis.model_loaded,
          model_note: analysis.model_note ?? null,
          created_at: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true },
      );

      await contractRef.set(
        {
          ai_analysis_status: "completed",
          risk_score: analysis.risk_score,
          risk_level: analysis.risk_level,
          overview_summary: analysis.overview_summary ?? null,
          issue_count:
            typeof analysis.issue_count === "number"
              ? analysis.issue_count
              : analysis.flagged_clauses.length,
          critical_count:
            typeof analysis.critical_count === "number"
              ? analysis.critical_count
              : analysis.flagged_clauses.filter(
                  (item) => item.severity === "high",
                ).length,
          comparison_items: analysis.comparison_items ?? [],
          recommended_actions: analysis.recommended_actions ?? [],
          updated_at: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true },
      );

      const profileQuery = await db
        .collection("ofw_profiles")
        .where("user_id", "==", request.auth.uid)
        .limit(1)
        .get();

      if (!profileQuery.empty) {
        await profileQuery.docs[0].ref.set(
          {
            contract_status: "analyzed",
          },
          { merge: true },
        );
      }

      return {
        contractId,
        riskScore: analysis.risk_score,
        riskLevel: analysis.risk_level,
        aiSummary: analysis.ai_summary,
        overviewSummary: analysis.overview_summary ?? null,
        flaggedClauses: analysis.flagged_clauses,
        issueCount:
          typeof analysis.issue_count === "number"
            ? analysis.issue_count
            : analysis.flagged_clauses.length,
        criticalCount:
          typeof analysis.critical_count === "number"
            ? analysis.critical_count
            : analysis.flagged_clauses.filter(
                (item) => item.severity === "high",
              ).length,
        comparisonItems: analysis.comparison_items ?? [],
        recommendedActions: analysis.recommended_actions ?? [],
        modelLoaded: analysis.model_loaded,
        modelNote: analysis.model_note ?? null,
      };
    } catch (error) {
      await contractRef.set(
        {
          ai_analysis_status: "failed",
          updated_at: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true },
      );

      throw new HttpsError(
        "internal",
        error instanceof Error ? error.message : "Contract analysis failed.",
      );
    }
  },
);
