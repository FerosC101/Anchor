class ScanModel {
  final int id;
  final String name; // truncated display name
  final String fullName; // full document name
  final String subtitle;
  final String date;
  final String time;
  final int score;

  const ScanModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.score,
  });
}
