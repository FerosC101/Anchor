## Contract Analyst Service

`Contract_Analyst_Model.pkl` is used to classify contractual language as `safe` vs `predatory/scam`.

### 1) Pull the actual model binary (Git LFS)

The repository currently stores this file through Git LFS. If you only have the pointer file, run:

```bash
git lfs pull --include="ai-services/Contract_Analyst_Model.pkl"
```

### 2) Install service dependencies

```bash
cd ai-services
python -m pip install -r requirements.txt
```

### 3) Start the local model API

```bash
cd ai-services
python -m uvicorn api:app --host 0.0.0.0 --port 8000 --reload
```

### 4) Firebase Functions integration

The cloud function `analyzeContractUpload` calls this API endpoint:

- default: `http://127.0.0.1:8000/analyze-contract`
- override with env var: `CONTRACT_ANALYZER_URL`

If the `.pkl` is unavailable, the API falls back to heuristic scoring and returns a `model_note` in the response.
