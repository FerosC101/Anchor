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
    'name': 'Al Noor Recruitment Co.',
    'country': 'Saudi Arabia',
    'score': 50,
    'workers': '340',
    'reports': '12',
    'violations': '5',
    'lastIncident': 'Mar 18, 2026'
  },
  {
    'name': 'Gulf Horizon Manpower',
    'country': 'UAE',
    'score': 92,
    'workers': '220',
    'reports': '19',
    'violations': '8',
    'lastIncident': 'Mar 16, 2026'
  },
  {
    'name': 'Qatar Workforce Link',
    'country': 'Qatar',
    'score': 27,
    'workers': '410',
    'reports': '4',
    'violations': '1',
    'lastIncident': 'Mar 09, 2026'
  },
  {
    'name': 'Kuwait Prime Services',
    'country': 'Kuwait',
    'score': 84,
    'workers': '290',
    'reports': '14',
    'violations': '6',
    'lastIncident': 'Mar 12, 2026'
  },
  {
    'name': 'Bahrain Labor Connect',
    'country': 'Bahrain',
    'score': 84,
    'workers': '175',
    'reports': '9',
    'violations': '4',
    'lastIncident': 'Feb 25, 2026'
  },
];

// ── Abuse reports data ──────────────────────────────────────────────────────
const List<Map<String, String>> abuseReportsData = [
  {
    'name': 'Maria Santos',
    'country': 'Saudi Arabia',
    'employer': 'Al Noor Recruitment Co.',
    'reportId': 'RPT-2026-0342',
    'abuseType': 'Wage Withholding',
    'dateFiled': 'Mar 19, 2026',
    'status': 'Investigation'
  },
  {
    'name': 'Jose Ramirez',
    'country': 'UAE',
    'employer': 'Gulf Horizon Manpower',
    'reportId': 'RPT-2026-0343',
    'abuseType': 'Passport Confiscation',
    'dateFiled': 'Mar 17, 2026',
    'status': 'Investigation'
  },
  {
    'name': 'Lina Cruz',
    'country': 'Qatar',
    'employer': 'Qatar Workforce Link',
    'reportId': 'RPT-2026-0344',
    'abuseType': 'Contract Substitution',
    'dateFiled': 'Mar 10, 2026',
    'status': 'In Review'
  },
  {
    'name': 'Ramon Ortega',
    'country': 'Kuwait',
    'employer': 'Kuwait Prime Services',
    'reportId': 'RPT-2026-0345',
    'abuseType': 'Illegal Deductions',
    'dateFiled': 'Feb 26, 2026',
    'status': 'Resolved'
  },
  {
    'name': 'Ana Gutierrez',
    'country': 'Bahrain',
    'employer': 'Bahrain Labor Connect',
    'reportId': 'RPT-2026-0346',
    'abuseType': 'Threat of Deportation',
    'dateFiled': 'Feb 20, 2026',
    'status': 'Investigation'
  },
];

// ── Contract issues data ────────────────────────────────────────────────────
const List<Map<String, String>> contractIssuesData = [
  {
    'name': 'Fatima Noor',
    'country': 'Saudi Arabia',
    'employer': 'Al Noor Recruitment Co.',
    'contractId': 'CNT-2026-0089',
    'issueType': 'Salary Discrepancy',
    'dateFiled': 'Mar 15, 2026',
    'status': 'Legal Review'
  },
  {
    'name': 'Joan Mercado',
    'country': 'UAE',
    'employer': 'Gulf Horizon Manpower',
    'contractId': 'CNT-2026-0090',
    'issueType': 'Hours Mismatch',
    'dateFiled': 'Mar 11, 2026',
    'status': 'Mediation'
  },
  {
    'name': 'Nina Velasco',
    'country': 'Qatar',
    'employer': 'Qatar Workforce Link',
    'contractId': 'CNT-2026-0091',
    'issueType': 'Accommodation Clause',
    'dateFiled': 'Mar 07, 2026',
    'status': 'Mediation'
  },
  {
    'name': 'Carlo Dela Cruz',
    'country': 'Bahrain',
    'employer': 'Bahrain Labor Connect',
    'contractId': 'CNT-2026-0092',
    'issueType': 'Contract Duration',
    'dateFiled': 'Feb 22, 2026',
    'status': 'Resolved'
  },
];

// ── Assistance cases data ───────────────────────────────────────────────────
const List<Map<String, String>> assistanceCasesData = [
  {
    'name': 'Maria Santos',
    'country': 'Saudi Arabia',
    'employer': 'Al Noor Recruitment Co.',
    'issue': 'Contract Substitution',
    'date': 'Mar 19, 2026',
    'status': 'In review'
  },
  {
    'name': 'Jose Ramirez',
    'country': 'UAE',
    'employer': 'Gulf Horizon Manpower',
    'issue': 'Passport Retention',
    'date': 'Mar 16, 2026',
    'status': 'Resolved'
  },
  {
    'name': 'Lina Cruz',
    'country': 'Qatar',
    'employer': 'Qatar Workforce Link',
    'issue': 'Wage Delay',
    'date': 'Mar 10, 2026',
    'status': 'In review'
  },
  {
    'name': 'Ramon Ortega',
    'country': 'Kuwait',
    'employer': 'Kuwait Prime Services',
    'issue': 'Physical Threat',
    'date': 'Mar 08, 2026',
    'status': 'Critical'
  },
  {
    'name': 'Ana Gutierrez',
    'country': 'Bahrain',
    'employer': 'Bahrain Labor Connect',
    'issue': 'Contract Mismatch',
    'date': 'Feb 24, 2026',
    'status': 'Resolved'
  },
  {
    'name': 'Fatima Noor',
    'country': 'Saudi Arabia',
    'employer': 'Al Noor Recruitment Co.',
    'issue': 'Wage Withholding',
    'date': 'Feb 14, 2026',
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
