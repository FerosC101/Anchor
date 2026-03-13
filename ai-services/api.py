from __future__ import annotations

import pickle
import re
from pathlib import Path
from typing import Any

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field

MODEL_PATH = Path(__file__).with_name("Contract_Analyst_Model.pkl")


class AnalyzeRequest(BaseModel):
    text: str = Field(default="", description="Raw contract text")
    file_name: str | None = None
    contract_id: str | None = None


class ClauseFlag(BaseModel):
    clause: str
    reason: str


class AnalyzeResponse(BaseModel):
    risk_score: float
    risk_level: str
    ai_summary: str
    flagged_clauses: list[ClauseFlag]
    model_loaded: bool
    model_note: str | None = None


app = FastAPI(title="Anchor Contract Analyst API", version="1.0.0")
_model: Any = None
_model_error: str | None = None


def _is_lfs_pointer(path: Path) -> bool:
    try:
        with path.open("r", encoding="utf-8") as handle:
            first_line = handle.readline().strip()
        return first_line.startswith("version https://git-lfs.github.com/spec/v1")
    except UnicodeDecodeError:
        return False


def _load_model() -> tuple[Any | None, str | None]:
    if not MODEL_PATH.exists():
        return None, f"Model file missing: {MODEL_PATH.name}"

    if _is_lfs_pointer(MODEL_PATH):
        return None, (
            "Model file is a Git LFS pointer. Pull LFS assets first: "
            "git lfs pull --include='ai-services/Contract_Analyst_Model.pkl'"
        )

    try:
        with MODEL_PATH.open("rb") as handle:
            return pickle.load(handle), None
    except Exception as exc:  # pragma: no cover - defensive
        return None, f"Failed to load model: {exc}"


@app.on_event("startup")
def _startup() -> None:
    global _model, _model_error
    _model, _model_error = _load_model()


@app.get("/health")
def health() -> dict[str, Any]:
    return {
        "ok": True,
        "model_loaded": _model is not None,
        "model_error": _model_error,
    }


def _extract_flagged_clauses(text: str) -> list[ClauseFlag]:
    pattern_map: list[tuple[str, str]] = [
        (
            r"\b(passport|withhold passport|retain passport)\b",
            "Possible passport retention or withholding risk.",
        ),
        (
            r"\b(salary deduction|deduct salary|unpaid|no pay)\b",
            "Possible wage deduction or unpaid labor risk.",
        ),
        (
            r"\b(termination without notice|immediate termination|at-will)\b",
            "Potential unilateral termination clause.",
        ),
        (
            r"\b(recruitment fee|placement fee|processing fee)\b",
            "Possible excessive recruitment fee language.",
        ),
    ]

    lowered = text.lower()
    clauses: list[ClauseFlag] = []
    for regex, reason in pattern_map:
        match = re.search(regex, lowered)
        if match:
            phrase = match.group(0)
            clauses.append(ClauseFlag(clause=phrase, reason=reason))

    return clauses


def _predict_risk(text: str) -> tuple[float, str]:
    if not text.strip():
        return 0.5, "No extractable text provided. Using neutral baseline risk."

    if _model is None:
        flags = _extract_flagged_clauses(text)
        heuristic_score = min(0.2 + (0.2 * len(flags)), 0.95)
        return heuristic_score, "Model unavailable. Fallback heuristic scoring used."

    if hasattr(_model, "predict_proba"):
        proba = _model.predict_proba([text])[0]
        score = float(max(proba))

        if hasattr(_model, "classes_"):
            classes = [str(value).lower() for value in _model.classes_]
            predatory_index = next(
                (i for i, c in enumerate(classes) if c in {"predatory", "scam", "1", "true"}),
                None,
            )
            if predatory_index is not None:
                score = float(proba[predatory_index])
            else:
                predicted = str(_model.predict([text])[0]).lower()
                if predicted in {"safe", "0", "false"}:
                    score = 1 - score
        return score, "Model prediction generated using predict_proba."

    if hasattr(_model, "predict"):
        predicted = str(_model.predict([text])[0]).lower()
        score = 0.9 if predicted in {"predatory", "scam", "1", "true"} else 0.1
        return score, "Model prediction generated using predict."

    raise HTTPException(status_code=500, detail="Loaded model does not support prediction")


def _to_risk_level(score: float) -> str:
    if score >= 0.7:
        return "high"
    if score >= 0.4:
        return "medium"
    return "low"


@app.post("/analyze-contract", response_model=AnalyzeResponse)
def analyze_contract(payload: AnalyzeRequest) -> AnalyzeResponse:
    score, note = _predict_risk(payload.text)
    level = _to_risk_level(score)
    flags = _extract_flagged_clauses(payload.text)

    summary = (
        f"Contract risk is {level.upper()} ({score:.2f}). "
        f"Flagged {len(flags)} potential issue(s)."
    )

    return AnalyzeResponse(
        risk_score=round(score, 4),
        risk_level=level,
        ai_summary=summary,
        flagged_clauses=flags,
        model_loaded=_model is not None,
        model_note=note if _model is None else note,
    )
