# Model Uses: Contract Scam Clause Detector

This document outlines the functionality, purpose, and usage of the fine-tuned LegalBERT model for identifying potentially predatory or scam clauses in legal contracts.

## How the Model Works

This model is built upon **LegalBERT**, a specialized version of the BERT (Bidirectional Encoder Representations from Transformers) language model. LegalBERT has been pre-trained on a vast corpus of legal texts, giving it a strong understanding of legal language, context, and nuances.

**The process involves the following steps:**

1.  **Text Extraction (PyMuPDF):** The input PDF contract is first processed by PyMuPDF, which extracts raw text content page by page. This raw text is then cleaned to remove formatting artifacts.

2.  **Clause Chunking:** The cleaned text is broken down into individual clauses or paragraphs. This is crucial because analyzing an entire contract at once would be computationally intensive and might dilute the focus on specific problematic sentences.

3.  **Tokenization (Hugging Face Transformers):** Each extracted clause is then tokenized using LegalBERT's pre-trained tokenizer. Tokenization converts human-readable text into numerical IDs that the model can understand. This process includes adding special tokens (like `[CLS]` and `[SEP]`), padding shorter sentences, and truncating longer ones to a fixed maximum length (e.g., 128 tokens).

4.  **Fine-tuning:** The pre-trained LegalBERT model is then fine-tuned on a small, labeled dataset of example clauses categorized as either 'Safe' (0) or 'Scam/Predatory' (1). During fine-tuning, the model learns to identify patterns and features in the text that distinguish safe clauses from predatory ones. The training process uses an AdamW optimizer and aims to minimize the loss (difference between predicted and actual labels).

5.  **Inference (Prediction):** When a new clause is fed to the model, it undergoes the same tokenization process. The tokenized input is then passed through the fine-tuned LegalBERT model. The model outputs 'logits' (raw scores), which are then converted into probabilities (between 0 and 1) using a Softmax function. A probability above a certain `threshold` (default 0.50) for the 'Scam' class indicates that the clause is likely predatory.

## Purpose of the Model

The primary purpose of this model is to act as an **early warning system** for individuals reviewing legal contracts, especially employment offers, vendor agreements, or similar documents. It helps to:

- **Flag Potentially Predatory Language:** Automatically identify clauses that exhibit characteristics commonly found in scams or financially exploitative terms (e.g., demanding upfront payments from employees, requiring personal banking passwords, transferring funds to unknown third parties).
- **Reduce Manual Review Burden:** Assist users in quickly pinpointing high-risk sections of a contract that warrant closer human scrutiny.
- **Increase Awareness:** Highlight clauses that might otherwise be overlooked by an untrained eye.
- **Enhance Due Diligence:** Provide an additional layer of review to ensure contractual terms are fair and transparent.

**Important Note:** This model is an aid for review and **should not replace professional legal advice**. It is designed to flag potential issues, not to provide definitive legal interpretations.

## How to Use the Model

The main function for using the model is `generate_contract_risk_report(pdf_path, threshold=0.50)`.

**Steps to use:**

1.  **Upload Your Contract:** First, you need to upload the PDF file of the contract you wish to analyze to your Colab environment. A common location for uploaded files is `/content/`.
    - Click on the folder icon in the left sidebar.
    - Click on the "Upload to session storage" icon (a file with an arrow pointing up) and select your PDF file.
    - Make a note of the uploaded file's path (e.g., `/content/your_contract_name.pdf`).

2.  **Run the Analysis Function:** Call the `generate_contract_risk_report` function with the path to your uploaded PDF. You can also specify an optional `threshold` (default is 0.50). A higher threshold means the model needs to be more confident to flag a clause as predatory.

    ```python
    generate_contract_risk_report('/content/your_contract_name.pdf', threshold=0.65) # Example with a higher threshold
    ```

    - **Understanding the `threshold` parameter:** The `threshold` determines how confident the model needs to be to classify a clause as 'Scam/Predatory'. It's a value between 0 and 1.
      - A **lower threshold** (e.g., 0.3 or 0.4) will make the model more sensitive, flagging more clauses as potentially predatory. This is useful if you want to be very cautious and prefer to review more clauses manually, minimizing the risk of missing a scam.
      - A **higher threshold** (e.g., 0.6 or 0.7) will make the model more selective, flagging fewer clauses. This is useful if you want to reduce the number of false positives and only focus on clauses where the model has high confidence, but it carries a higher risk of overlooking subtle predatory clauses.
      - The default value of `0.50` is a balanced starting point, indicating that any clause with a 50% or higher probability of being predatory will be flagged.

3.  **Review the Report:** The function will print a detailed report to the console, listing any clauses identified as potentially predatory, along with the model's confidence level. It will also provide a 'FINAL VERDICT' indicating whether the contract appears 'Clean' or 'HIGH RISK'.
    - **Interpretation:** Clauses marked as 'HIGH RISK' or 'PREDATORY' warrant careful human review. Consult with a legal professional for definitive advice on these clauses.

This model serves as an initial screening tool to help you focus your attention on critical sections of a contract more efficiently.
