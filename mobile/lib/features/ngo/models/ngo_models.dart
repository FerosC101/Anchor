// ── Enums ────────────────────────────────────────────────────────────────────

enum NgoCaseStatus { inReview, resolved, escalated, pending }

// ── Models ───────────────────────────────────────────────────────────────────

class NgoIncidentReport {
  final String id;
  final String workerName;
  final String country;
  final String employer;
  final String issue;
  final String reportId;
  final NgoCaseStatus status;
  final String severity;
  final double credibility;
  final String description;
  final String date;

  const NgoIncidentReport({
    required this.id,
    required this.workerName,
    required this.country,
    required this.employer,
    required this.issue,
    required this.reportId,
    required this.status,
    this.severity = 'High',
    this.credibility = 0.85,
    this.description = 'No description available.',
    this.date = '3/5/2026',
  });
}

class NgoHighRiskEmployer {
  final String name;
  final String type;
  final String country;
  final int reportCount;

  const NgoHighRiskEmployer({
    required this.name,
    required this.type,
    required this.country,
    required this.reportCount,
  });
}

// ── Helpers ──────────────────────────────────────────────────────────────────

String ngoCaseStatusLabel(NgoCaseStatus s) {
  switch (s) {
    case NgoCaseStatus.inReview:
      return 'In Review';
    case NgoCaseStatus.escalated:
      return 'Escalated';
    case NgoCaseStatus.pending:
      return 'Pending';
    case NgoCaseStatus.resolved:
      return 'Resolved';
  }
}

// ── Mock data ────────────────────────────────────────────────────────────────

const mockNgoReports = [
  NgoIncidentReport(
    id: '1',
    workerName: 'Maria Santos',
    country: 'Saudi Arabia',
    employer: 'Al-Rashid Household Services',
    issue: 'Wage Theft',
    reportId: 'RPT-001',
    status: NgoCaseStatus.inReview,
    severity: 'High',
    credibility: 0.85,
    description:
        'Employer has not paid salary for 3 months. Contract promised \$400/month but received nothing since December 2025.',
    date: '3/5/2026',
  ),
  NgoIncidentReport(
    id: '2',
    workerName: 'Maria Santos',
    country: 'Saudi Arabia',
    employer: 'Al-Rashid Household Services',
    issue: 'Wage Theft',
    reportId: 'RPT-001',
    status: NgoCaseStatus.inReview,
  ),
  NgoIncidentReport(
    id: '3',
    workerName: 'Maria Santos',
    country: 'Saudi Arabia',
    employer: 'Al-Rashid Household Services',
    issue: 'Wage Theft',
    reportId: 'RPT-001',
    status: NgoCaseStatus.inReview,
  ),
  NgoIncidentReport(
    id: '4',
    workerName: 'Maria Santos',
    country: 'Saudi Arabia',
    employer: 'Al-Rashid Household Services',
    issue: 'Wage Theft',
    reportId: 'RPT-001',
    status: NgoCaseStatus.inReview,
  ),
  NgoIncidentReport(
    id: '5',
    workerName: 'Maria Santos',
    country: 'Saudi Arabia',
    employer: 'Al-Rashid Household Services',
    issue: 'Wage Theft',
    reportId: 'RPT-001',
    status: NgoCaseStatus.inReview,
  ),
];

const mockNgoEmployers = [
  NgoHighRiskEmployer(
    name: 'Al-Rashid Household Services',
    type: 'Domestic Worker',
    country: 'Saudi Arabia',
    reportCount: 12,
  ),
  NgoHighRiskEmployer(
    name: 'Al-Rashid Household Services',
    type: 'Domestic Worker',
    country: 'Saudi Arabia',
    reportCount: 12,
  ),
  NgoHighRiskEmployer(
    name: 'Al-Rashid Household Services',
    type: 'Domestic Worker',
    country: 'Saudi Arabia',
    reportCount: 12,
  ),
  NgoHighRiskEmployer(
    name: 'Al-Rashid Household Services',
    type: 'Domestic Worker',
    country: 'Saudi Arabia',
    reportCount: 12,
  ),
];

// ── Alert model ──────────────────────────────────────────────────────────────

class NgoAlert {
  final String id;
  final String alertId;
  final String title;
  final String employerName;
  final String alertType;
  final String severity;
  final String target;
  final String country;
  final String createdDate;
  final String createdBy;
  final String description;

  const NgoAlert({
    required this.id,
    required this.alertId,
    required this.title,
    required this.employerName,
    required this.alertType,
    this.severity = 'High',
    required this.target,
    required this.country,
    required this.createdDate,
    required this.createdBy,
    required this.description,
  });
}

const mockNgoAlerts = [
  NgoAlert(
    id: '1',
    alertId: 'ALT-001',
    title: 'High Risk Employer Alert:',
    employerName: 'Al-Rashid Household Services',
    alertType: 'Employer Warning',
    severity: 'High',
    target: 'Al-Rashid Household Services',
    country: 'Saudi Arabia',
    createdDate: 'Mar 6, 2026',
    createdBy: 'Admin User',
    description:
        'Multiple reports of wage theft and contract violations. 12 verified incidents in the past 6 months. Workers advised to avoid employment with this organization.',
  ),
  NgoAlert(
    id: '2',
    alertId: 'ALT-001',
    title: 'High Risk Employer Alert:',
    employerName: 'Al-Rashid Household Services',
    alertType: 'Employer Warning',
    severity: 'High',
    target: 'Al-Rashid Household Services',
    country: 'Saudi Arabia',
    createdDate: 'Mar 6, 2026',
    createdBy: 'Admin User',
    description:
        'Multiple reports of wage theft and contract violations. 12 verified incidents in the past 6 months. Workers advised to avoid employment with this organization.',
  ),
  NgoAlert(
    id: '3',
    alertId: 'ALT-001',
    title: 'High Risk Employer Alert:',
    employerName: 'Al-Rashid Household Services',
    alertType: 'Employer Warning',
    severity: 'High',
    target: 'Al-Rashid Household Services',
    country: 'Saudi Arabia',
    createdDate: 'Mar 6, 2026',
    createdBy: 'Admin User',
    description:
        'Multiple reports of wage theft and contract violations. 12 verified incidents in the past 6 months. Workers advised to avoid employment with this organization.',
  ),
];
