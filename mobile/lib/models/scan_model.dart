class ScanComparisonItem {
  final String category;
  final String status;
  final String yourContract;
  final String standardPractice;

  const ScanComparisonItem({
    required this.category,
    required this.status,
    required this.yourContract,
    required this.standardPractice,
  });
}

class ScanModel {
  final int id;
  final String? contractId;
  final String name; // truncated display name
  final String fullName; // full document name
  final String subtitle;
  final String date;
  final String time;
  final int score;
  final int? issueCount;
  final int? criticalCount;
  final String? overviewSummary;
  final List<ScanComparisonItem> comparisonItems;
  final List<String> recommendedActions;

  const ScanModel({
    required this.id,
    this.contractId,
    required this.name,
    required this.fullName,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.score,
    this.issueCount,
    this.criticalCount,
    this.overviewSummary,
    this.comparisonItems = const [],
    this.recommendedActions = const [],
  });
}
