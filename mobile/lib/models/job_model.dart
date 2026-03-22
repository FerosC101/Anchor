import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  final String id;
  final String title;
  final String company;
  final String country;
  final String city;
  final String description;
  final double salaryMin;
  final double salaryMax;
  final String currency;
  final String status;
  final DateTime createdAt;

  const JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.country,
    required this.city,
    required this.description,
    required this.salaryMin,
    required this.salaryMax,
    required this.currency,
    required this.status,
    required this.createdAt,
  });

  factory JobModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return JobModel(
      id: doc.id,
      title: (d['title'] ?? 'Untitled job').toString(),
      company: (d['company'] ?? 'Unknown company').toString(),
      country: (d['country'] ?? '').toString(),
      city: (d['city'] ?? '').toString(),
      description: (d['description'] ?? '').toString(),
      salaryMin: (d['salary_min'] as num?)?.toDouble() ?? 0,
      salaryMax: (d['salary_max'] as num?)?.toDouble() ?? 0,
      currency: (d['currency'] ?? 'USD').toString(),
      status: (d['status'] ?? 'active').toString(),
      createdAt: (d['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
