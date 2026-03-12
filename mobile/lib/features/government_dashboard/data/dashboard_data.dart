import 'package:flutter/material.dart';

// ── Stats data ──────────────────────────────────────────────────────────────
const List<Map<String, dynamic>> statsData = [
  {
    'number': '47',
    'label': 'Abuse Report',
    'sublabel': 'vs last month',
    'change': '+12%',
    'icon': Icons.warning_rounded,
  },
  {
    'number': '8',
    'label': 'Support Request',
    'sublabel': 'vs last month',
    'change': '+8%',
    'icon': Icons.trending_up_rounded,
  },
  {
    'number': '23',
    'label': 'High Risk Employers',
    'sublabel': 'vs last month',
    'change': '+3',
    'icon': Icons.people_rounded,
  },
  {
    'number': '12',
    'label': 'Countries Monitored',
    'sublabel': 'no change',
    'change': 'Stable',
    'icon': Icons.location_on_rounded,
  },
];

// ── Chart data ──────────────────────────────────────────────────────────────
const List<Map<String, dynamic>> chartData = [
  {'label': 'Qatar', 'value': 65},
  {'label': 'UAE', 'value': 57},
  {'label': 'Saudi\nArabia', 'value': 45},
  {'label': 'Kuwait', 'value': 33},
  {'label': 'Bahrain', 'value': 29},
  {'label': 'Oman', 'value': 18},
];
const int chartMax = 75;
const List<int> gridLines = [75, 60, 45, 30, 15, 0];

// ── Alerts data ─────────────────────────────────────────────────────────────
const List<Map<String, String>> alertsData = [
  {
    'workerName': 'Worker Name',
    'country': 'Country',
    'employer': 'Employer Name',
    'date': '2026-03-05',
    'riskLevel': 'High',
  },
  {
    'workerName': 'Worker Name',
    'country': 'Country',
    'employer': 'Employer Name',
    'date': '2026-03-05',
    'riskLevel': 'High',
  },
  {
    'workerName': 'Worker Name',
    'country': 'Country',
    'employer': 'Employer Name',
    'date': '2026-03-05',
    'riskLevel': 'High',
  },
  {
    'workerName': 'Worker Name',
    'country': 'Country',
    'employer': 'Employer Name',
    'date': '2026-03-05',
    'riskLevel': 'High',
  },
  {
    'workerName': 'Worker Name',
    'country': 'Country',
    'employer': 'Employer Name',
    'date': '2026-03-05',
    'riskLevel': 'High',
  },
];

// ── Employer data ───────────────────────────────────────────────────────────
const List<Map<String, dynamic>> employersData = [
  {
    'name': 'Employer Name',
    'country': 'Country',
    'score': 50,
    'workers': '340',
    'reports': '12',
    'violations': '5',
    'lastIncident': 'Feb 14, 2026'
  },
  {
    'name': 'Employer Name',
    'country': 'Country',
    'score': 92,
    'workers': '340',
    'reports': '12',
    'violations': '5',
    'lastIncident': 'Feb 14, 2026'
  },
  {
    'name': 'Employer Name',
    'country': 'Country',
    'score': 27,
    'workers': '340',
    'reports': '12',
    'violations': '5',
    'lastIncident': 'Feb 14, 2026'
  },
  {
    'name': 'Employer Name',
    'country': 'Country',
    'score': 84,
    'workers': '340',
    'reports': '12',
    'violations': '5',
    'lastIncident': 'Feb 14, 2026'
  },
  {
    'name': 'Employer Name',
    'country': 'Country',
    'score': 84,
    'workers': '340',
    'reports': '12',
    'violations': '5',
    'lastIncident': 'Feb 14, 2026'
  },
];

// ── Abuse reports data ──────────────────────────────────────────────────────
const List<Map<String, String>> abuseReportsData = [
  {
    'name': 'User Name',
    'employer': 'Employer Name',
    'reportId': 'RPT-2026-0342',
    'abuseType': 'Wage Withholding',
    'dateFiled': 'Feb 14, 2026',
    'status': 'Investigation'
  },
  {
    'name': 'User Name',
    'employer': 'Employer Name',
    'reportId': 'RPT-2026-0342',
    'abuseType': 'Wage Withholding',
    'dateFiled': 'Feb 14, 2026',
    'status': 'Investigation'
  },
  {
    'name': 'User Name',
    'employer': 'Employer Name',
    'reportId': 'RPT-2026-0342',
    'abuseType': 'Wage Withholding',
    'dateFiled': 'Feb 14, 2026',
    'status': 'In Review'
  },
  {
    'name': 'User Name',
    'employer': 'Employer Name',
    'reportId': 'RPT-2026-0342',
    'abuseType': 'Wage Withholding',
    'dateFiled': 'Feb 14, 2026',
    'status': 'Resolved'
  },
  {
    'name': 'User Name',
    'employer': 'Employer Name',
    'reportId': 'RPT-2026-0342',
    'abuseType': 'Wage Withholding',
    'dateFiled': 'Feb 14, 2026',
    'status': 'Investigation'
  },
];

// ── Contract issues data ────────────────────────────────────────────────────
const List<Map<String, String>> contractIssuesData = [
  {
    'name': 'User Name',
    'employer': 'Employer Name',
    'contractId': 'CNT-2026-0089',
    'issueType': 'Salary Discrepancy',
    'dateFiled': 'Feb 14, 2026',
    'status': 'Legal Review'
  },
  {
    'name': 'User Name',
    'employer': 'Employer Name',
    'contractId': 'CNT-2026-0089',
    'issueType': 'Salary Discrepancy',
    'dateFiled': 'Feb 14, 2026',
    'status': 'Mediation'
  },
  {
    'name': 'User Name',
    'employer': 'Employer Name',
    'contractId': 'CNT-2026-0089',
    'issueType': 'Salary Discrepancy',
    'dateFiled': 'Feb 14, 2026',
    'status': 'Mediation'
  },
  {
    'name': 'User Name',
    'employer': 'Employer Name',
    'contractId': 'CNT-2026-0089',
    'issueType': 'Salary Discrepancy',
    'dateFiled': 'Feb 14, 2026',
    'status': 'Resolved'
  },
];

// ── Assistance cases data ───────────────────────────────────────────────────
const List<Map<String, String>> assistanceCasesData = [
  {
    'name': 'User Name',
    'country': 'Country',
    'employer': 'Loren Ipsum',
    'issue': 'Loren Ipsum',
    'status': 'In review'
  },
  {
    'name': 'User Name',
    'country': 'Country',
    'employer': 'Loren Ipsum',
    'issue': 'Loren Ipsum',
    'status': 'Resolved'
  },
  {
    'name': 'User Name',
    'country': 'Country',
    'employer': 'Loren Ipsum',
    'issue': 'Loren Ipsum',
    'status': 'In review'
  },
  {
    'name': 'User Name',
    'country': 'Country',
    'employer': 'Loren Ipsum',
    'issue': 'Loren Ipsum',
    'status': 'Critical'
  },
  {
    'name': 'User Name',
    'country': 'Country',
    'employer': 'Loren Ipsum',
    'issue': 'Loren Ipsum',
    'status': 'Resolved'
  },
  {
    'name': 'User Name',
    'country': 'Country',
    'employer': 'Loren Ipsum',
    'issue': 'Loren Ipsum',
    'status': 'In review'
  },
];

// ── Filter options ──────────────────────────────────────────────────────────
const List<String> countryOptions = [
  'All Countries',
  'Saudi Arabia',
  'UAE',
  'Qatar',
  'Kuwait',
  'Bahrain',
];

const List<String> statusOptions = [
  'All Status',
  'In review',
  'Resolved',
  'Critical',
];

const List<String> riskLevelOptions = [
  'Risk Level',
  'High',
  'Medium',
  'Low',
];

const List<String> dateOptions = [
  'All Date',
  'Today',
  'This Week',
  'This Month',
  'This Year',
];
