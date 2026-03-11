/// Alert model for the Government Dashboard
class DashboardAlert {
  final String id;
  final String workerName;
  final String country;
  final String employerName;
  final DateTime date;
  final String riskLevel;
  final String status;

  DashboardAlert({
    required this.id,
    required this.workerName,
    required this.country,
    required this.employerName,
    required this.date,
    required this.riskLevel,
    required this.status,
  });
}

/// System overview stats model
class SystemOverviewStats {
  final int abuseReports;
  final int supportRequests;
  final int highRiskEmployers;
  final int contractIssues;

  SystemOverviewStats({
    required this.abuseReports,
    required this.supportRequests,
    required this.highRiskEmployers,
    required this.contractIssues,
  });
}

/// Abuse report data by country
class AbuseReportByCountry {
  final String country;
  final int reportCount;
  final int maxReports;

  AbuseReportByCountry({
    required this.country,
    required this.reportCount,
    required this.maxReports,
  });
}
