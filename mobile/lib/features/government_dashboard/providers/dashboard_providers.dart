import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/dashboard_models.dart';

/// Provider for system overview stats
final systemOverviewStatsProvider = Provider<SystemOverviewStats>((ref) {
  return SystemOverviewStats(
    abuseReports: 47,
    supportRequests: 8,
    highRiskEmployers: 23,
    contractIssues: 12,
  );
});

/// Provider for abuse reports by country
final abuseReportsByCountryProvider =
    Provider<List<AbuseReportByCountry>>((ref) {
  return [
    AbuseReportByCountry(
      country: 'Saudi Arabia',
      reportCount: 95,
      maxReports: 100,
    ),
    AbuseReportByCountry(
      country: 'UAE',
      reportCount: 75,
      maxReports: 100,
    ),
    AbuseReportByCountry(
      country: 'Kuwait',
      reportCount: 60,
      maxReports: 100,
    ),
    AbuseReportByCountry(
      country: 'Qatar',
      reportCount: 45,
      maxReports: 100,
    ),
    AbuseReportByCountry(
      country: 'Oman',
      reportCount: 35,
      maxReports: 100,
    ),
    AbuseReportByCountry(
      country: 'Bahrain',
      reportCount: 25,
      maxReports: 100,
    ),
  ];
});

/// Provider for recent alerts feed
final recentAlertsFeedProvider = Provider<List<DashboardAlert>>((ref) {
  return List.generate(
    5,
    (index) => DashboardAlert(
      id: 'alert_$index',
      workerName: 'Worker Name',
      country: 'Country',
      employerName: 'Employer Name',
      date: DateTime(2026, 3, 5),
      riskLevel: 'High',
      status: 'In review',
    ),
  );
});

/// Provider for current bottom navigation index
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

/// Combined dashboard data provider
final dashboardDataProvider =
    Provider<({SystemOverviewStats stats, List<DashboardAlert> alerts})>(
  (ref) {
    final stats = ref.watch(systemOverviewStatsProvider);
    final alerts = ref.watch(recentAlertsFeedProvider);
    return (stats: stats, alerts: alerts);
  },
);
