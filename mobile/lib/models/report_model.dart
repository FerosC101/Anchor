import 'package:cloud_firestore/cloud_firestore.dart';

enum ReportCategory { safety, abuse, salary, fraud, other }

class UserReportModel {
  final String id;
  final String reporterId;
  final String title;
  final String description;
  final ReportCategory category;
  final String location;
  final bool anonymous;
  final DateTime createdAt;

  const UserReportModel({
    required this.id,
    required this.reporterId,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.anonymous,
    required this.createdAt,
  });

  factory UserReportModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return UserReportModel(
      id: doc.id,
      reporterId: (d['reporter_id'] ?? '').toString(),
      title: (d['title'] ?? 'Report').toString(),
      description: (d['description'] ?? '').toString(),
      category: ReportCategory.values.firstWhere(
        (e) => e.name == (d['category'] ?? '').toString(),
        orElse: () => ReportCategory.other,
      ),
      location: (d['location'] ?? 'Unknown').toString(),
      anonymous: (d['anonymous'] as bool?) ?? false,
      createdAt: (d['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'reporter_id': reporterId,
        'title': title,
        'description': description,
        'category': category.name,
        'location': location,
        'anonymous': anonymous,
        'created_at': FieldValue.serverTimestamp(),
      };
}

class RiskPoint {
  final String id;
  final String location;
  final int score;
  final double? latitude;
  final double? longitude;
  final String category;
  final DateTime createdAt;

  const RiskPoint({
    required this.id,
    required this.location,
    required this.score,
    this.latitude,
    this.longitude,
    this.category = 'other',
    required this.createdAt,
  });
}
