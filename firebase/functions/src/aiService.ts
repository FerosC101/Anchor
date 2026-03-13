import { GoogleGenerativeAI } from "@google/generative-ai";

const GEMINI_FALLBACK_MODELS = [
  "gemini-2.5-flash",
  "gemini-2.5-flash-lite",
  "gemini-1.5-flash",
];

type FlaggedClause = {
  clause: string;
  reason: string;
  severity?: "low" | "medium" | "high";
  category?: string;
  suggested_fix?: string;
};

type ComparisonItem = {
  category: string;
  status: "ok" | "review" | "red_flag";
  your_contract: string;
  standard_practice: string;
};

export type ContractAnalysisPayload = {
  risk_score: number;
  risk_level: "low" | "medium" | "high";
  ai_summary: string;
  overview_summary?: string;
  flagged_clauses: FlaggedClause[];
  issue_count?: number;
  critical_count?: number;
  comparison_items?: ComparisonItem[];
  recommended_actions?: string[];
  model_loaded: boolean;
  model_note?: string;
};

type AnalyzeInput = {
  text: string;
  fileName?: string;
  contractId?: string;
  fileUrl?: string;
};

export async function analyzeContractWithModel(
  input: AnalyzeInput,
): Promise<ContractAnalysisPayload> {
  const gemini = await analyzeWithGemini(input);
  if (gemini != null) {
    return gemini;
  }

  const processAny = (
    globalThis as { process?: { env?: Record<string, string> } }
  ).process;
  const endpoint = processAny?.env?.CONTRACT_ANALYZER_URL;

  if (!endpoint) {
    if (input.text.trim().length === 0) {
      return buildUnreadableContractPayload(input.fileName);
    }
    return analyzeHeuristically(input);
  }

  const response = await fetch(endpoint, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      text: input.text,
      file_name: input.fileName,
      contract_id: input.contractId,
    }),
  });

  if (!response.ok) {
    const body = await response.text();
    console.error("Contract analyzer API error", {
      status: response.status,
      body,
      endpoint,
    });
    throw new Error(
      `Contract analyzer API failed (${response.status}): ${body}`,
    );
  }

  const data = (await response.json()) as ContractAnalysisPayload;

  return {
    risk_score: Number(data.risk_score ?? 0),
    risk_level: data.risk_level ?? "low",
    ai_summary: data.ai_summary ?? "No summary provided.",
    overview_summary:
      typeof data.overview_summary === "string"
        ? data.overview_summary
        : undefined,
    flagged_clauses: Array.isArray(data.flagged_clauses)
      ? data.flagged_clauses
      : [],
    issue_count:
      typeof data.issue_count === "number"
        ? data.issue_count
        : Array.isArray(data.flagged_clauses)
          ? data.flagged_clauses.length
          : 0,
    critical_count:
      typeof data.critical_count === "number" ? data.critical_count : 0,
    comparison_items: Array.isArray(data.comparison_items)
      ? data.comparison_items
      : [],
    recommended_actions: Array.isArray(data.recommended_actions)
      ? data.recommended_actions
      : [],
    model_loaded: Boolean(data.model_loaded),
    model_note: data.model_note,
  };
}

async function analyzeWithGemini(
  input: AnalyzeInput,
): Promise<ContractAnalysisPayload | null> {
  const processAny = (
    globalThis as { process?: { env?: Record<string, string> } }
  ).process;
  const apiKey = processAny?.env?.GEMINI_API_KEY;
  if (!apiKey) return null;

  const client = new GoogleGenerativeAI(apiKey);
  const filePayload = await getFilePayload(input.fileUrl, input.fileName);
  const extractedFromFile =
    filePayload != null
      ? await extractContractTextWithGemini(client, filePayload)
      : "";
  const combinedText = [input.text, extractedFromFile]
    .map((item) => item.trim())
    .filter((item) => item.length > 0)
    .join("\n\n")
    .trim();

  if (combinedText.length === 0 && filePayload == null) {
    return null;
  }

  const heuristicBaseline =
    combinedText.length > 0
      ? analyzeHeuristically({ ...input, text: combinedText })
      : null;

  try {
    const prompt = [
      "You are a contract risk analyst for OFW labor contracts.",
      "Return ONLY valid JSON with this shape:",
      "{",
      '  "risk_score": number (0.0 to 1.0),',
      '  "risk_level": "low"|"medium"|"high",',
      '  "ai_summary": string,',
      '  "overview_summary": string (max 160 chars, plain language, 1 sentence),',
      '  "flagged_clauses": [{"clause": string, "reason": string, "severity": "low"|"medium"|"high", "category": string, "suggested_fix": string}],',
      '  "issue_count": number,',
      '  "critical_count": number,',
      '  "comparison_items": [{"category": string, "status": "ok"|"review"|"red_flag", "your_contract": string, "standard_practice": string}],',
      '  "recommended_actions": [string] ',
      "}",
      "If data is missing, use conservative defaults.",
      "Always provide at least 3 comparison_items and 3 recommended_actions.",
    ].join("\n");

    const parts: Array<
      { text: string } | { inlineData: { mimeType: string; data: string } }
    > = [{ text: prompt }];

    if (combinedText.length > 0) {
      parts.push({ text: `Contract text:\n${combinedText.slice(0, 45000)}` });
    }

    if (filePayload != null) {
      parts.push({
        inlineData: {
          mimeType: filePayload.mimeType,
          data: filePayload.bytes.toString("base64"),
        },
      });
    }

    const result = await generateContentWithModelFallback(client, parts);
    const raw = result.text;
    const parsed = parseJsonFromModel(raw);

    const riskScore = clamp01(
      Number(parsed.risk_score ?? heuristicBaseline?.risk_score ?? 0.5),
    );
    const riskLevel = toRiskLevel(parsed.risk_level, riskScore);
    const flagged = Array.isArray(parsed.flagged_clauses)
      ? parsed.flagged_clauses
      : (heuristicBaseline?.flagged_clauses ?? []);
    const normalizedComparisons = ensureComparisonItems(
      Array.isArray(parsed.comparison_items) ? parsed.comparison_items : [],
      flagged,
    );

    const criticalCount = flagged.filter(
      (item: unknown) =>
        typeof item === "object" &&
        item != null &&
        (item as { severity?: string }).severity === "high",
    ).length;

    return {
      risk_score: riskScore,
      risk_level: riskLevel,
      ai_summary:
        typeof parsed.ai_summary === "string" &&
        parsed.ai_summary.trim().length > 0
          ? parsed.ai_summary
          : (heuristicBaseline?.ai_summary ?? "Contract analyzed with Gemini."),
      overview_summary:
        typeof parsed.overview_summary === "string" &&
        parsed.overview_summary.trim().length > 0
          ? parsed.overview_summary.trim().slice(0, 160)
          : (heuristicBaseline?.overview_summary ??
            buildOverviewSummary(riskLevel, flagged.length, criticalCount)),
      flagged_clauses: flagged,
      issue_count:
        typeof parsed.issue_count === "number"
          ? parsed.issue_count
          : flagged.length,
      critical_count:
        typeof parsed.critical_count === "number"
          ? parsed.critical_count
          : criticalCount,
      comparison_items: normalizedComparisons,
      recommended_actions: ensureRecommendedActions(
        Array.isArray(parsed.recommended_actions)
          ? parsed.recommended_actions
          : [],
        riskLevel,
      ),
      model_loaded: true,
      model_note:
        combinedText.length > 0 && filePayload != null
          ? `Gemini analysis (file + extracted text via ${result.model})`
          : combinedText.length > 0
            ? `Gemini analysis (text via ${result.model})`
            : `Gemini analysis (file via ${result.model})`,
    };
  } catch (error) {
    console.error("Gemini contract analysis failed", error);
    if (heuristicBaseline != null) {
      return {
        ...heuristicBaseline,
        model_loaded: false,
        model_note: "Heuristic fallback after Gemini failure",
      };
    }
    if (filePayload != null) {
      return buildUnreadableContractPayload(input.fileName);
    }
    return null;
  }
}

function buildUnreadableContractPayload(
  fileName?: string,
): ContractAnalysisPayload {
  const detectedName = fileName?.trim().length ? fileName : "uploaded file";

  return {
    risk_score: 0.35,
    risk_level: "medium",
    overview_summary:
      "Could not read contract text clearly. Please upload a clearer contract image, PDF, or TXT copy.",
    ai_summary: `We couldn't extract readable contract terms from ${detectedName}. The upload succeeded, but analysis confidence is low until readable text is provided.`,
    flagged_clauses: [
      {
        clause: "Text extraction check",
        reason:
          "The document appears non-contract or unreadable for automated clause parsing.",
        severity: "medium",
        category: "Document Quality",
        suggested_fix:
          "Upload the contract pages only, use clearer scans, or upload a TXT copy of the terms.",
      },
    ],
    issue_count: 1,
    critical_count: 0,
    comparison_items: [
      {
        category: "Document Readability",
        status: "review",
        your_contract: "No reliably extracted clause text was detected.",
        standard_practice:
          "Contracts should be readable and machine-extractable for accurate AI clause analysis.",
      },
      {
        category: "Salary & Payment",
        status: "review",
        your_contract: "Unable to verify salary and deduction clauses.",
        standard_practice:
          "Base salary, pay cycle, and deductions should be clearly stated in writing.",
      },
      {
        category: "Working Hours",
        status: "review",
        your_contract: "Unable to verify working-hours and overtime terms.",
        standard_practice:
          "Contracts should define hours, overtime pay, and weekly rest day requirements.",
      },
    ],
    recommended_actions: [
      "Upload a clearer copy focused on contract pages only.",
      "If available, upload PDF or TXT instead of photo-only images.",
      "Retry analysis after improving readability to get clause-level risk results.",
    ],
    model_loaded: false,
    model_note: "Unreadable document fallback",
  };
}

async function getFilePayload(
  fileUrl?: string,
  fileName?: string,
): Promise<{ bytes: Buffer; mimeType: string } | null> {
  if (!fileUrl) return null;

  try {
    const fileResponse = await fetch(fileUrl);
    if (!fileResponse.ok) {
      console.error("Failed to download contract file", {
        status: fileResponse.status,
      });
      return null;
    }

    const fileBuffer = Buffer.from(await fileResponse.arrayBuffer());
    if (fileBuffer.length === 0 || fileBuffer.length > 10 * 1024 * 1024) {
      return null;
    }

    return {
      bytes: fileBuffer,
      mimeType: inferMimeType(fileName),
    };
  } catch (error) {
    console.error("Contract file fetch failed", error);
    return null;
  }
}

async function extractContractTextWithGemini(
  client: GoogleGenerativeAI,
  filePayload: { bytes: Buffer; mimeType: string },
): Promise<string> {
  try {
    const result = await generateContentWithModelFallback(client, [
      {
        text: [
          "Extract the contract text exactly as written.",
          "Focus on salary, deductions, working hours, termination, fees, passport handling, and dispute clauses.",
          "Return plain text only.",
        ].join(" "),
      },
      {
        inlineData: {
          mimeType: filePayload.mimeType,
          data: filePayload.bytes.toString("base64"),
        },
      },
    ]);

    return result.text.trim();
  } catch (error) {
    console.error("Gemini text extraction failed", error);
    return "";
  }
}

async function generateContentWithModelFallback(
  client: GoogleGenerativeAI,
  parts: Array<
    { text: string } | { inlineData: { mimeType: string; data: string } }
  >,
): Promise<{ text: string; model: string }> {
  const processAny = (
    globalThis as { process?: { env?: Record<string, string> } }
  ).process;
  const preferred = processAny?.env?.GEMINI_MODEL?.trim();

  const candidates = [
    ...(preferred ? [preferred] : []),
    ...GEMINI_FALLBACK_MODELS,
  ].filter((value, index, array) => array.indexOf(value) === index);

  let lastError: unknown = null;
  for (const modelName of candidates) {
    try {
      const model = client.getGenerativeModel({ model: modelName });
      const result = await model.generateContent(parts);
      return {
        text: result.response.text(),
        model: modelName,
      };
    } catch (error) {
      lastError = error;
      const message = String(error);
      const missingModel =
        message.includes("404") ||
        message.includes("not available") ||
        message.includes("Not Found");

      if (!missingModel) {
        throw error;
      }
      console.warn(`Gemini model unavailable: ${modelName}. Trying next.`);
    }
  }

  throw lastError instanceof Error
    ? lastError
    : new Error("No available Gemini model for analysis.");
}

function analyzeHeuristically(input: AnalyzeInput): ContractAnalysisPayload {
  const text = input.text.trim();
  const lowered = text.toLowerCase();

  const rules: Array<{
    regex: RegExp;
    reason: string;
    severity: "low" | "medium" | "high";
    category: string;
    suggested_fix: string;
    standard_practice: string;
  }> = [
    {
      regex: /\b(passport|withhold passport|retain passport)\b/,
      reason: "Possible passport retention or confiscation risk.",
      severity: "high",
      category: "Document Control",
      suggested_fix:
        "Add a clause confirming the worker keeps personal identity documents at all times.",
      standard_practice:
        "Workers retain passports and IDs unless voluntarily submitting for limited processing.",
    },
    {
      regex:
        /\b(salary deduction|deduct salary|unpaid|no pay|penalty deduction)\b/,
      reason: "Possible wage deduction or unpaid labor risk.",
      severity: "high",
      category: "Salary & Payment",
      suggested_fix:
        "Require itemized, capped deductions and guaranteed monthly payment schedule.",
      standard_practice:
        "Contracts should state base salary clearly and list lawful deductions transparently.",
    },
    {
      regex: /\b(termination without notice|immediate termination|at-will)\b/,
      reason: "Potential one-sided termination clause.",
      severity: "medium",
      category: "Termination",
      suggested_fix:
        "Add notice period, due process, and return travel obligations upon termination.",
      standard_practice:
        "Termination terms should include notice, cause, and final settlement obligations.",
    },
    {
      regex: /\b(recruitment fee|placement fee|processing fee)\b/,
      reason: "Possible excessive recruitment or placement fee language.",
      severity: "medium",
      category: "Recruitment Fees",
      suggested_fix:
        "State that prohibited fees will not be charged to the worker.",
      standard_practice:
        "Worker-paid recruitment fees should be prohibited or strictly regulated.",
    },
    {
      regex:
        /\b(10-12 hours|12 hours|no rest day|6 days\/week|7 days\/week|overtime not paid)\b/,
      reason:
        "Possible excessive working hours or missing overtime protections.",
      severity: "high",
      category: "Working Hours",
      suggested_fix:
        "Specify regular hours, overtime pay, weekly rest days, and maximum hours.",
      standard_practice:
        "Contracts should define regular hours, overtime rates, and rest periods.",
    },
  ];

  const flaggedClauses = rules
    .filter((rule) => rule.regex.test(lowered))
    .map((rule) => ({
      clause: extractMatchedPhrase(lowered, rule.regex),
      reason: rule.reason,
      severity: rule.severity,
      category: rule.category,
      suggested_fix: rule.suggested_fix,
    }));

  const comparisonItems: ComparisonItem[] = flaggedClauses.map((item) => ({
    category: item.category ?? "General",
    status: item.severity === "high" ? "red_flag" : "review",
    your_contract: item.clause,
    standard_practice:
      rules.find((rule) => rule.category === item.category)
        ?.standard_practice ??
      "Contract language should be specific, fair, and compliant with labor standards.",
  }));

  const criticalCount = flaggedClauses.filter(
    (item) => item.severity === "high",
  ).length;

  const issueCount = flaggedClauses.length;
  const riskScore = clamp01(
    text.length === 0
      ? 0.35
      : 0.2 + criticalCount * 0.22 + (issueCount - criticalCount) * 0.12,
  );
  const riskLevel = toRiskLevel(undefined, riskScore);

  const recommendedActions =
    riskLevel === "high"
      ? [
          "Do not sign until the flagged clauses are reviewed by a legal or embassy advisor.",
          "Ask the recruiter or employer to revise the one-sided clauses in writing.",
          "Keep a copy of this report and share it with a trusted support organization.",
        ]
      : riskLevel === "medium"
        ? [
            "Request clarification on the flagged sections before signing.",
            "Compare the offer with standard POEA or destination-country labor protections.",
            "Save the report and consult your agency or support desk if terms remain unclear.",
          ]
        : [
            "Keep a copy of the contract and this report for your records.",
            "Verify employer and agency details before signing.",
            "Monitor any changes between the reviewed contract and final version.",
          ];

  return {
    risk_score: riskScore,
    risk_level: riskLevel,
    overview_summary: buildOverviewSummary(
      riskLevel,
      issueCount,
      criticalCount,
    ),
    ai_summary:
      issueCount == 0
        ? "No strong red flags were detected from the available contract content, but a full extracted-text review is still recommended."
        : `Detected ${issueCount} potential contract issue(s), including ${criticalCount} critical concern(s). Review the flagged clauses before signing.`,
    flagged_clauses: flaggedClauses,
    issue_count: issueCount,
    critical_count: criticalCount,
    comparison_items: comparisonItems,
    recommended_actions: recommendedActions,
    model_loaded: false,
    model_note: "Heuristic fallback analysis",
  };
}

function extractMatchedPhrase(text: string, regex: RegExp): string {
  const match = text.match(regex);
  return match?.[0] ?? "flagged clause";
}

function parseJsonFromModel(raw: string): Record<string, unknown> {
  const fenced = raw.match(/```json\s*([\s\S]*?)```/i);
  const jsonText = fenced ? fenced[1] : raw;
  try {
    return JSON.parse(jsonText) as Record<string, unknown>;
  } catch {
    const firstBrace = jsonText.indexOf("{");
    const lastBrace = jsonText.lastIndexOf("}");
    if (firstBrace >= 0 && lastBrace > firstBrace) {
      const sliced = jsonText.slice(firstBrace, lastBrace + 1);
      return JSON.parse(sliced) as Record<string, unknown>;
    }
    throw new Error("Failed to parse Gemini JSON output");
  }
}

function inferMimeType(fileName?: string): string {
  if (!fileName) return "application/octet-stream";
  const ext = fileName.split(".").pop()?.toLowerCase();
  switch (ext) {
    case "pdf":
      return "application/pdf";
    case "jpg":
    case "jpeg":
      return "image/jpeg";
    case "png":
      return "image/png";
    case "txt":
      return "text/plain";
    default:
      return "application/octet-stream";
  }
}

function clamp01(value: number): number {
  if (Number.isNaN(value)) return 0.5;
  if (value < 0) return 0;
  if (value > 1) return 1;
  return value;
}

function toRiskLevel(value: unknown, score: number): "low" | "medium" | "high" {
  if (value === "low" || value === "medium" || value === "high") {
    return value;
  }
  if (score >= 0.7) return "high";
  if (score >= 0.4) return "medium";
  return "low";
}

function buildOverviewSummary(
  riskLevel: "low" | "medium" | "high",
  issueCount: number,
  criticalCount: number,
): string {
  if (riskLevel === "high") {
    return `High risk: ${criticalCount} critical issue(s) found. Pause signing until clauses are revised.`;
  }
  if (riskLevel === "medium") {
    return `Moderate risk: ${issueCount} issue(s) detected. Clarify key terms before signing.`;
  }
  return issueCount > 0
    ? `Low risk overall, but ${issueCount} item(s) still need review.`
    : "Low risk based on available text; keep records and verify final signed copy.";
}

function ensureComparisonItems(
  rawItems: unknown[],
  flagged: unknown[],
): ComparisonItem[] {
  const parsed = rawItems
    .map((item) => {
      if (typeof item !== "object" || item == null) return null;
      const data = item as Record<string, unknown>;
      const status =
        data.status === "ok" ||
        data.status === "review" ||
        data.status === "red_flag"
          ? data.status
          : "review";
      return {
        category: String(data.category ?? "General"),
        status,
        your_contract: String(data.your_contract ?? "Not clearly specified"),
        standard_practice: String(
          data.standard_practice ??
            "Contract terms should be clear, measurable, and compliant with labor standards.",
        ),
      } as ComparisonItem;
    })
    .filter((item): item is ComparisonItem => item != null);

  if (parsed.length >= 3) return parsed.slice(0, 6);

  const fromFlags = flagged
    .map((item) => {
      if (typeof item !== "object" || item == null) return null;
      const data = item as Record<string, unknown>;
      const severity = String(data.severity ?? "medium");
      return {
        category: String(data.category ?? "General"),
        status: severity === "high" ? "red_flag" : "review",
        your_contract: String(data.clause ?? "Clause requires review"),
        standard_practice:
          "Terms should define rights, obligations, pay, hours, and dispute process clearly.",
      } as ComparisonItem;
    })
    .filter((item): item is ComparisonItem => item != null);

  const defaults: ComparisonItem[] = [
    {
      category: "Salary & Payment",
      status: "review",
      your_contract: "Payment and deductions are not fully itemized.",
      standard_practice:
        "Salary, pay cycle, and all deductions should be explicitly listed and capped.",
    },
    {
      category: "Working Hours",
      status: "review",
      your_contract: "Daily/weekly limits and overtime terms are unclear.",
      standard_practice:
        "Regular hours, rest days, and overtime compensation should be clearly defined.",
    },
    {
      category: "Termination & Repatriation",
      status: "review",
      your_contract:
        "Exit process and return-travel obligations are not detailed.",
      standard_practice:
        "Contracts should define termination notice, final pay, and return travel responsibilities.",
    },
  ];

  const merged = [...parsed, ...fromFlags, ...defaults];
  const unique: ComparisonItem[] = [];
  const seen = new Set<string>();
  for (const item of merged) {
    const key = `${item.category}-${item.your_contract}`.toLowerCase();
    if (!seen.has(key)) {
      seen.add(key);
      unique.push(item);
    }
    if (unique.length >= 6) break;
  }

  return unique.slice(0, Math.max(3, unique.length));
}

function ensureRecommendedActions(
  rawActions: unknown[],
  riskLevel: "low" | "medium" | "high",
): string[] {
  const parsed = rawActions
    .map((item) => String(item ?? "").trim())
    .filter((item) => item.length > 0);

  if (parsed.length >= 3) return parsed.slice(0, 6);

  const defaultsByRisk: Record<"low" | "medium" | "high", string[]> = {
    high: [
      "Do not sign yet; request written revisions for critical clauses.",
      "Consult your embassy, POEA support desk, or legal advisor before proceeding.",
      "Keep this report and all contract versions as documentation.",
    ],
    medium: [
      "Ask the recruiter/employer to clarify ambiguous clauses in writing.",
      "Request revisions on payment, hours, and termination terms before signing.",
      "Save this report and compare it with the final contract copy.",
    ],
    low: [
      "Keep a signed copy of the contract and this analysis report.",
      "Verify that final terms match the reviewed version before departure.",
      "Seek advice immediately if any clause changes after signing.",
    ],
  };

  const merged = [...parsed, ...defaultsByRisk[riskLevel]];
  const unique: string[] = [];
  const seen = new Set<string>();
  for (const item of merged) {
    const key = item.toLowerCase();
    if (!seen.has(key)) {
      seen.add(key);
      unique.push(item);
    }
    if (unique.length >= 6) break;
  }

  return unique.slice(0, Math.max(3, unique.length));
}
