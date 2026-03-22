# Phase 4 Smoke Test Checklist (OFW)

## Environment

- [ ] User can sign in as OFW account.
- [ ] Firestore rules and indexes deployed.

## Alerts & Notifications

- [ ] Alerts screen loads from Firestore with no permission errors.
- [ ] Opening an alert marks it read.
- [ ] Notifications list loads from backend and supports archive swipe.

## Community

- [ ] Community feed loads posts from backend.
- [ ] Creating a post saves to `community_posts`.
- [ ] Post detail loads comments from `post_comments`.
- [ ] Adding a comment increments `comments` count on the post.
- [ ] Risk map loads and displays markers with filters.

## Contracts

- [ ] Contracts list loads user scans from `contracts`.
- [ ] Contract detail opens for selected scan.
- [ ] “Download Report” action copies report payload to clipboard.
- [ ] “Contact Help” action opens Help screen contact tab.

## Jobs & Reports

- [ ] Jobs list loads active jobs from `job_offers`.
- [ ] Job detail opens for selected item.
- [ ] Reporting a job writes to `reports` with `reporter_id` bound to signed-in user.

## Profile & Financial Shield

- [ ] Profile header/info shows signed-in user data.
- [ ] Profile edit saves updates to `users/{uid}`.
- [ ] Profile stats counters (contracts/wage logs/reports) update from backend.
- [ ] Financial Shield net safety card loads from `users/{uid}/financial_shield/profile`.
- [ ] Exit simulation uses dynamic flight/debt values.

## Remittance

- [ ] Remittance screen attempts to load rates from `remittance_rates`.
- [ ] Remittance screen attempts to load providers from `remittance_providers`.
- [ ] UI falls back gracefully to local defaults if no docs exist.

## Release Gate

- [ ] `flutter analyze` passes.
- [ ] Targeted tests pass.
- [ ] No remaining OFW TODO/mock placeholders in production paths.
