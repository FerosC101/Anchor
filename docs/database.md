# Anchor — Database Schema

> **Last updated:** March 10, 2026  
> This document is the single source of truth for all Firestore collection structures.  
> All teammates should reference this before creating or modifying any data models.

---

## Overview

```
users
 ├── ofw_profiles
 ├── verifier_profiles
 └── (role field links to agencies)

contracts
 ├── contract_analysis
 └── contract_reviews

agencies
 └── job_offers

community_posts
 └── post_comments

ai_usage_logs
notifications
reports
```

---

## Users

Central identity table for all system users.

**Collection:** `users`

| Field                 | Type            | Description                                |
| --------------------- | --------------- | ------------------------------------------ |
| `id`                  | `string` (UUID) | Primary key / Firebase Auth UID            |
| `email`               | `string`        | User login email                           |
| `password_hash`       | `string`        | Auth credential (managed by Firebase Auth) |
| `full_name`           | `string`        | User full name                             |
| `role`                | `enum`          | `ofw` · `government` · `ngo` · `admin`     |
| `phone_number`        | `string`        | Contact number                             |
| `country`             | `string`        | Current country of residence               |
| `profile_photo_url`   | `string`        | Profile picture URL                        |
| `verification_status` | `enum`          | `pending` · `verified` · `rejected`        |
| `created_at`          | `timestamp`     | Account creation time                      |
| `updated_at`          | `timestamp`     | Last update time                           |

---

## OFW Module

### OFW Profiles

Additional information for migrant workers.

**Collection:** `ofw_profiles`

| Field                 | Type             | Description                          |
| --------------------- | ---------------- | ------------------------------------ |
| `id`                  | `string` (UUID)  | Primary key                          |
| `user_id`             | `FK users.id`    | Owning user                          |
| `passport_number`     | `string`         | Passport identifier                  |
| `destination_country` | `string`         | Country of work                      |
| `job_title`           | `string`         | Current/target job title             |
| `experience_years`    | `integer`        | Years of work experience             |
| `agency_id`           | `FK agencies.id` | Linked recruitment agency (optional) |
| `contract_status`     | `enum`           | `none` · `uploaded` · `analyzed`     |
| `created_at`          | `timestamp`      | Profile creation time                |

### Contracts

Stores employment contracts uploaded by workers.

**Collection:** `contracts`

| Field                      | Type             | Description                              |
| -------------------------- | ---------------- | ---------------------------------------- |
| `id`                       | `string` (UUID)  | Primary key                              |
| `user_id`                  | `FK users.id`    | Uploading OFW                            |
| `agency_id`                | `FK agencies.id` | Associated agency (optional)             |
| `contract_file_url`        | `string`         | Storage URL of the uploaded file         |
| `contract_type`            | `string`         | e.g. `employment`, `service`, `seafarer` |
| `job_title`                | `string`         | Position in the contract                 |
| `salary`                   | `decimal`        | Monthly salary (in contract currency)    |
| `contract_duration_months` | `integer`        | Duration in months                       |
| `country_destination`      | `string`         | Destination country                      |
| `uploaded_at`              | `timestamp`      | Upload timestamp                         |
| `ai_analysis_status`       | `enum`           | `pending` · `completed` · `failed`       |

### AI Analysis Results

Stores the output from the AI contract analysis engine.

**Collection:** `contract_analysis`

| Field                   | Type              | Description                            |
| ----------------------- | ----------------- | -------------------------------------- |
| `id`                    | `string` (UUID)   | Primary key                            |
| `contract_id`           | `FK contracts.id` | Analysed contract                      |
| `risk_score`            | `float`           | 0.0 – 1.0 risk score                   |
| `risk_level`            | `enum`            | `low` · `medium` · `high`              |
| `ai_summary`            | `text`            | Plain-language contract summary        |
| `flagged_clauses`       | `json`            | Array of flagged clause objects        |
| `salary_deduction_flag` | `boolean`         | True if suspicious deductions detected |
| `unusual_terms_flag`    | `boolean`         | True if non-standard terms detected    |
| `created_at`            | `timestamp`       | Analysis completion time               |

---

## Recruitment Agency Module

### Agencies

**Collection:** `agencies`

| Field                 | Type            | Description                          |
| --------------------- | --------------- | ------------------------------------ |
| `id`                  | `string` (UUID) | Primary key                          |
| `agency_name`         | `string`        | Registered agency name               |
| `license_number`      | `string`        | Government license number            |
| `country`             | `string`        | Country of registration              |
| `address`             | `string`        | Physical address                     |
| `contact_email`       | `string`        | Official email                       |
| `contact_phone`       | `string`        | Official phone                       |
| `verification_status` | `enum`          | `pending` · `verified` · `suspended` |
| `created_at`          | `timestamp`     | Record creation time                 |

### Job Offers

Job postings uploaded by agencies.

**Collection:** `job_offers`

| Field                   | Type             | Description                      |
| ----------------------- | ---------------- | -------------------------------- |
| `id`                    | `string` (UUID)  | Primary key                      |
| `agency_id`             | `FK agencies.id` | Posting agency                   |
| `job_title`             | `string`         | Position title                   |
| `salary_range`          | `string`         | e.g. `HKD 4,000 – 5,000/month`   |
| `destination_country`   | `string`         | Country of employment            |
| `job_description`       | `text`           | Full job description             |
| `contract_template_url` | `string`         | Storage URL of contract template |
| `created_at`            | `timestamp`      | Posting time                     |
| `status`                | `enum`           | `active` · `inactive`            |

---

## Government / NGO Verification Module

### Verifier Profiles

Users representing partner government agencies, NGOs, or embassies.

**Collection:** `verifier_profiles`

| Field                | Type            | Description                           |
| -------------------- | --------------- | ------------------------------------- |
| `id`                 | `string` (UUID) | Primary key                           |
| `user_id`            | `FK users.id`   | Linked user account                   |
| `organization_name`  | `string`        | Name of the organisation              |
| `organization_type`  | `enum`          | `government` · `ngo` · `embassy`      |
| `role_title`         | `string`        | e.g. `Labour Attaché`, `Case Officer` |
| `verification_level` | `integer`       | Access level (1 = basic, 3 = full)    |
| `created_at`         | `timestamp`     | Profile creation time                 |

### Contract Reviews

Manual reviews performed by verifiers.

**Collection:** `contract_reviews`

| Field           | Type                      | Description                        |
| --------------- | ------------------------- | ---------------------------------- |
| `id`            | `string` (UUID)           | Primary key                        |
| `contract_id`   | `FK contracts.id`         | Reviewed contract                  |
| `verifier_id`   | `FK verifier_profiles.id` | Reviewer                           |
| `review_status` | `enum`                    | `approved` · `flagged` · `pending` |
| `notes`         | `text`                    | Reviewer notes                     |
| `created_at`    | `timestamp`               | Review submission time             |

---

## Community Module

Supports daily engagement and peer support between OFWs.

### Community Posts

**Collection:** `community_posts`

| Field         | Type            | Description                                      |
| ------------- | --------------- | ------------------------------------------------ |
| `id`          | `string` (UUID) | Primary key                                      |
| `user_id`     | `FK users.id`   | Author                                           |
| `title`       | `string`        | Post title                                       |
| `content`     | `text`          | Post body                                        |
| `country_tag` | `string`        | Country context tag                              |
| `created_at`  | `timestamp`     | Post time                                        |
| `post_type`   | `enum`          | `question` · `advice` · `warning` · `experience` |

### Post Comments

**Collection:** `post_comments`

| Field          | Type                    | Description  |
| -------------- | ----------------------- | ------------ |
| `id`           | `string` (UUID)         | Primary key  |
| `post_id`      | `FK community_posts.id` | Parent post  |
| `user_id`      | `FK users.id`           | Commenter    |
| `comment_text` | `text`                  | Comment body |
| `created_at`   | `timestamp`             | Comment time |

---

## AI Usage Tracking

For analytics and traction metrics.

**Collection:** `ai_usage_logs`

| Field              | Type              | Description                  |
| ------------------ | ----------------- | ---------------------------- |
| `id`               | `string` (UUID)   | Primary key                  |
| `user_id`          | `FK users.id`     | Requesting user              |
| `contract_id`      | `FK contracts.id` | Analysed contract (nullable) |
| `ai_model_used`    | `string`          | e.g. `gemini-1.5-pro`        |
| `tokens_used`      | `integer`         | Total tokens consumed        |
| `analysis_time_ms` | `integer`         | Latency in milliseconds      |
| `created_at`       | `timestamp`       | Log time                     |

---

## Notifications

**Collection:** `notifications`

| Field               | Type            | Description                                                 |
| ------------------- | --------------- | ----------------------------------------------------------- |
| `id`                | `string` (UUID) | Primary key                                                 |
| `user_id`           | `FK users.id`   | Recipient                                                   |
| `title`             | `string`        | Notification title                                          |
| `message`           | `text`          | Notification body                                           |
| `notification_type` | `enum`          | `contract_alert` · `review_update` · `community` · `system` |
| `is_read`           | `boolean`       | Read status                                                 |
| `created_at`        | `timestamp`     | Send time                                                   |

---

## Admin Moderation

**Collection:** `reports`

| Field              | Type            | Description                          |
| ------------------ | --------------- | ------------------------------------ |
| `id`               | `string` (UUID) | Primary key                          |
| `reporter_id`      | `FK users.id`   | Reporting user                       |
| `reported_user_id` | `FK users.id`   | Reported user                        |
| `report_reason`    | `text`          | Description of the issue             |
| `report_status`    | `enum`          | `pending` · `resolved` · `dismissed` |
| `created_at`       | `timestamp`     | Report time                          |

---

## AI Integration Points

The AI service reads/writes to these collections:

| Collection          | AI Role                            |
| ------------------- | ---------------------------------- |
| `contracts`         | Source document for analysis       |
| `contract_analysis` | Output destination for LLM results |
| `ai_usage_logs`     | Usage and latency tracking         |

**AI Tasks:**

- Contract summarisation
- Risk detection & scoring
- Clause extraction and flagging
- Salary anomaly detection
- Plain-language explanation generation

---

## Firestore Collection Reference

| Collection          | Description                      |
| ------------------- | -------------------------------- |
| `users`             | All user accounts                |
| `ofw_profiles`      | OFW-specific profiles            |
| `agencies`          | Recruitment agency records       |
| `verifier_profiles` | Government/NGO verifier profiles |
| `contracts`         | Uploaded employment contracts    |
| `contract_analysis` | AI analysis results              |
| `contract_reviews`  | Manual verifier reviews          |
| `job_offers`        | Agency job postings              |
| `community_posts`   | Community forum posts            |
| `post_comments`     | Comments on community posts      |
| `ai_usage_logs`     | AI call tracking                 |
| `notifications`     | User notifications               |
| `reports`           | Abuse/moderation reports         |
