# Anchor — End User Roles and Functionalities

> Last updated: March 22, 2026

This document defines what each user type does in the Anchor platform (mobile + backend), based on the current Firebase architecture.

---

## 1) OFW (Primary End User)

### Main job

Use the app for safety, contract checking, reporting, and financial protection.

### Functionalities

- Account registration and sign-in
- Maintain personal profile (`users`, `ofw_profiles`)
- Upload contract files for AI analysis
- View contract risk score, flagged clauses, and recommendations
- Browse verified job listings
- Post community warnings and comments
- Submit incident/user reports
- Receive and manage alerts/notifications
- Track wages and detect wage gaps
- Manage financial shield profile and savings goals

### Typical data touched

- `users`
- `ofw_profiles`
- `contracts`
- `contract_analysis` (read own + authorized reviewers)
- `community_posts`, `post_comments`
- `reports`
- `notifications`
- `users/{uid}/wage_logs`
- `users/{uid}/financial_shield/profile`
- `users/{uid}/savings_goals`
- `users/{uid}/smart_exit_plans`

---

## 2) NGO User (Organization Staff)

### Main job

Assist OFWs, review risks/cases, and provide interventions.

### Functionalities

- Sign in with NGO role account
- Manage organization profile (`organization_profiles`)
- Read OFW profiles and contract analysis needed for assistance
- Create/update contract reviews
- Publish or update job offers (if authorized)
- Send support notifications/alerts to OFWs (through backend pathways)
- Track and respond to reports requiring NGO action

### Typical data touched

- `users` (role = `ngo`)
- `organization_profiles`
- `ofw_profiles` (read)
- `contracts` (read)
- `contract_analysis` (read)
- `contract_reviews` (create/update)
- `job_offers` (create/update)
- `notifications` (operational)
- `reports` (operational)

---

## 3) Government User (Government Officer)

### Main job

Oversee compliance, verify contract concerns, and support formal interventions.

### Functionalities

- Sign in with government role account
- Manage organization profile (`organization_profiles`)
- Access OFW contract and analysis records for review
- Create/update formal contract reviews
- Publish official job-related and safety updates (if authorized)
- Monitor reports and prioritize high-risk incidents
- Coordinate with NGO and admin for escalations

### Typical data touched

- `users` (role = `government`)
- `organization_profiles`
- `ofw_profiles` (read)
- `contracts` (read)
- `contract_analysis` (read)
- `contract_reviews` (create/update)
- `job_offers` (create/update)
- `notifications` (operational)
- `reports` (operational)

---

## 4) Admin (Platform Administrator)

### Main job

Operate the platform securely, enforce governance, and manage all roles.

### Functionalities

- Create/seed/administer privileged accounts
- Full oversight of users and role verification
- Moderate abuse, fraud, and data misuse reports
- Manage policy-level notifications and system-wide records
- Maintain configuration, rules, and backend operations
- Audit and troubleshoot backend workflows

### Typical data touched

- Full access across protected collections by rule policy
- `users` (including role/verification oversight)
- `reports`, `notifications`, operational datasets
- Rule-managed collections and backend-generated records

---

## 5) Shared cross-role rules

- Authentication is required for all protected operations.
- Access is role-based (`ofw`, `ngo`, `government`, `admin`).
- Ownership checks apply for OFW personal records.
- Sensitive writes are restricted by Firestore and Storage rules.
- Cloud Functions handle trusted server-side operations (e.g., contract analysis).

---

## 6) Quick responsibility matrix

| Capability                     |     OFW | NGO | Government | Admin |
| ------------------------------ | ------: | --: | ---------: | ----: |
| Manage own profile             |      ✅ |  ✅ |         ✅ |    ✅ |
| Upload own contract            |      ✅ |  ❌ |         ❌ |  ✅\* |
| View own contract analysis     |      ✅ |  ❌ |         ❌ |    ✅ |
| Review OFW contracts           |      ❌ |  ✅ |         ✅ |    ✅ |
| Create/update contract reviews |      ❌ |  ✅ |         ✅ |    ✅ |
| Publish job offers             |      ❌ |  ✅ |         ✅ |    ✅ |
| Submit reports                 |      ✅ |  ✅ |         ✅ |    ✅ |
| Moderate reports system-wide   |      ❌ |  ❌ |         ❌ |    ✅ |
| Send operational notifications | Limited |  ✅ |         ✅ |    ✅ |
| Full platform governance       |      ❌ |  ❌ |         ❌ |    ✅ |

`✅*` Admin actions depend on policy and implementation path.
