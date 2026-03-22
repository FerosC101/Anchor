import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityPostModel {
  final String id;
  final String userId;
  final String company;
  final String description;
  final List<String> tags;
  final String location;
  final int upvotes;
  final int comments;
  final double? latitude;
  final double? longitude;
  final int riskScore;
  final DateTime createdAt;

  const CommunityPostModel({
    required this.id,
    required this.userId,
    required this.company,
    required this.description,
    required this.tags,
    required this.location,
    required this.upvotes,
    required this.comments,
    this.latitude,
    this.longitude,
    required this.riskScore,
    required this.createdAt,
  });

  factory CommunityPostModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return CommunityPostModel(
      id: doc.id,
      userId: (d['user_id'] ?? '').toString(),
      company: (d['company'] ?? 'Unknown company').toString(),
      description: (d['description'] ?? '').toString(),
      tags: (d['tags'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      location: (d['location'] ?? 'Unknown').toString(),
      upvotes: (d['upvotes'] as num?)?.toInt() ?? 0,
      comments: (d['comments'] as num?)?.toInt() ?? 0,
      latitude: (d['latitude'] as num?)?.toDouble(),
      longitude: (d['longitude'] as num?)?.toDouble(),
      riskScore: (d['risk_score'] as num?)?.toInt() ?? 50,
      createdAt: (d['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'user_id': userId,
        'company': company,
        'description': description,
        'tags': tags,
        'location': location,
        'upvotes': upvotes,
        'comments': comments,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        'risk_score': riskScore,
        'created_at': FieldValue.serverTimestamp(),
      };
}

class CommunityCommentModel {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final bool anonymous;
  final DateTime createdAt;

  const CommunityCommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.anonymous,
    required this.createdAt,
  });

  factory CommunityCommentModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return CommunityCommentModel(
      id: doc.id,
      postId: (d['post_id'] ?? '').toString(),
      userId: (d['user_id'] ?? '').toString(),
      content: (d['content'] ?? '').toString(),
      anonymous: (d['anonymous'] as bool?) ?? true,
      createdAt: (d['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'post_id': postId,
        'user_id': userId,
        'content': content,
        'anonymous': anonymous,
        'created_at': FieldValue.serverTimestamp(),
      };
}
