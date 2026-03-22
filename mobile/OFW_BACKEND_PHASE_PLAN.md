# OFW Backend Implementation Plan (Phased)

## Goal

Ship all remaining OFW mobile backend work in controlled phases, with clear scope, files, and acceptance criteria.

---

## Phase 0 — Baseline & Safety (Done)

### Scope

- Keep existing working backend stable.
- Confirm routing + providers compile and analyze clean.

### Completed Items

- Wage Monitoring backend + real chart + CRUD/delete.
- Community Safety backend foundations.
- Risk Map screen + filters.
- My Reports screen + route.
- Jobs listing/detail backend stream.
- Financial Shield profile/goals/plan backend foundations.

### Acceptance

- `flutter analyze` passes for OFW modules.
- Firestore rules deployed for used collections/subcollections.

---

## Phase 1 — Critical Empty Modules (Build First)

### 1. Alerts module (new full flow)

**Status:** Missing (empty files)

**Create/Implement**

- `lib/features/alerts/providers/alerts_provider.dart`
- `lib/features/alerts/screens/alerts_screen.dart`
- `lib/features/alerts/screens/alert_detail_screen.dart`

**Tasks**

- Create alert model + Firestore mapping.
- Add stream provider for user/global alerts.
- Build list UI (read/unread, severity badge, category).
- Build detail UI (full content, source, actions).
- Add mark-as-read + dismiss/archive actions.

**Acceptance**

- Alerts list renders from Firestore.
- Tapping alert opens detail from backend data.
- Read state persists in Firestore.

---

### 2. Contracts module list/provider

**Status:** Missing (empty files)

**Create/Implement**

- `lib/features/contracts/providers/contracts_provider.dart`
- `lib/features/contracts/screens/contracts_screen.dart`

**Tasks**

- Add contract stream for signed-in user.
- Build contracts list screen (status, risk score, scan date).
- Wire navigation to existing `contract_scan_detail_screen.dart`.
- Add filtering (risk level/status).

**Acceptance**

- Contracts list is fully backend-driven.
- Selecting contract opens detail with correct `ScanModel`.

---

### 3. Community feed/create flow

**Status:** Missing (empty files)

**Create/Implement**

- `lib/features/community/screens/feed_screen.dart`
- `lib/features/community/screens/create_post_screen.dart`
- Fill `lib/features/community/screens/post_detail_screen.dart`

**Tasks**

- Stream community posts from Firestore.
- Create post form (text/tags/location optional/anonymous toggle).
- Implement post detail with real comments stream.
- Add comment create action.

**Acceptance**

- Feed, create, detail, and comments are all backend-connected.
- No sample data in community detail screens.

---

## Phase 2 — Replace Placeholder Screens

### 4. Job reporting flow

**Status:** Placeholder text only

**Implement**

- `lib/features/jobs/screens/report_job_screen.dart`

**Tasks**

- Build form (job id, issue category, details, optional proof URL/image).
- Submit through existing backend service (`createUserReport`).
- Success/error state handling.

**Acceptance**

- Real report submission saved in Firestore `reports`.

---

### 5. Notifications backend

**Status:** Static hardcoded list

**Implement**

- `lib/features/profile/screens/notifications_screen.dart`
- Add provider/service if needed

**Tasks**

- Stream user notifications from Firestore.
- Mark-as-read and clear action.
- Deep link route handling by notification type.

**Acceptance**

- No hardcoded notifications remain.

---

### 6. Profile backend binding

**Status:** Static user/stats fields

**Implement**

- `lib/features/profile/screens/profile_screen.dart`

**Tasks**

- Load real auth user + profile document.
- Update profile edit dialog to persist changes.
- Replace static counters with computed backend stats (contracts/logs/reports).

**Acceptance**

- Header and info cards reflect signed-in user data.

---

## Phase 3 — Feature Completion & Data Integrity

### 7. Remittance real data

**Status:** Hardcoded rates/providers

**Implement**

- `lib/features/remittance/screens/remittance_calculator_screen.dart`

**Tasks**

- Replace local rates map with backend/API-fed rates.
- Replace duplicated provider cards with dynamic provider list.
- Sort/filter by speed, fee, best value.

**Acceptance**

- Rates and providers are fetched dynamically.

---

### 8. Contract detail pending actions

**Status:** TODO actions

**Implement**

- `lib/features/contracts/screens/contract_scan_detail_screen.dart`

**Tasks**

- Implement download action for scan/analysis.
- Implement contact-help action (route or submit assistance request).

**Acceptance**

- No TODO action placeholders remain in detail screen.

---

### 9. Smart Exit simulation dynamic values

**Status:** Partial hardcoded values

**Implement**

- `lib/features/shield/widgets/exit_simulation_dialog.dart`

**Tasks**

- Replace hardcoded flight/debt values with provider/service values.
- Recompute readiness and deficits from live profile/goals/plan data.

**Acceptance**

- Dialog values are fully computed from backend data.

---

## Phase 4 — Security, Rules, and Production Readiness

### 10. Firestore rules hardening

**Tasks**

- Add/verify rules for any new collections from Phases 1–3.
- Verify owner-only reads/writes for user-bound docs.
- Add indexes required by queries.

### 11. Quality gates

**Tasks**

- `flutter analyze` on `lib/features/**`.
- Widget tests for key providers/screens.
- Manual smoke test matrix (create/read/update/delete per module).

### 12. Release checklist

**Tasks**

- Remove all mock/sample text and TODO placeholders.
- Validate app navigation to all new screens.
- Prepare deployment notes and rollback plan.

---

## Implementation Order (Recommended)

1. Alerts
2. Contracts list/provider
3. Community feed/create/detail
4. Job report form
5. Notifications + Profile
6. Remittance dynamic data
7. Contract detail TODO actions
8. Exit simulation dynamic values
9. Rules hardening + QA pass

---

## Tracking Checklist

- [x] Phase 1 complete
- [x] Phase 2 complete
- [x] Phase 3 complete
- [x] Phase 4 complete

## Current Implementation Status

- ✅ Implemented now: Alerts, Contracts list/provider, Community feed/create/detail comments,
  Job reporting form, Notifications backend stream/actions, Profile dynamic binding,
  Remittance dynamic Firestore fetch, Contract detail actions, Exit simulation dynamic values.
- ✅ Firestore rules and indexes deployed to `anchor-81b45`.
- ✅ Targeted Phase 4 widget tests passed.
- ✅ Analyzer clean on OFW modules and Phase 4 test file.

---

## Notes

- Keep existing architecture style: Riverpod providers + Firestore services.
- Prefer typed models for every new collection document.
- No UI-only hardcoded data in production paths.
