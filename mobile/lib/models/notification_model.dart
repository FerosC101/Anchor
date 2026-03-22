import 'package:cloud_firestore/cloud_firestore.dart';

enum AppNotificationKind { alert, info, reminder, system }

enum AlertSeverity { low, medium, high, critical }

class AppNotificationModel {
  final String id;
  final String userId;
  final String title;
  final String message;
  final AppNotificationKind kind;
  final AlertSeverity severity;
  final bool read;
  final bool archived;
  final String? targetRoute;
  final DateTime createdAt;

  const AppNotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.kind,
    required this.severity,
    required this.read,
    required this.archived,
    this.targetRoute,
    required this.createdAt,
  });

  factory AppNotificationModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;

    final kindRaw = (d['kind'] ?? '').toString();
    final severityRaw = (d['severity'] ?? '').toString();

    return AppNotificationModel(
      id: doc.id,
      userId: (d['user_id'] ?? '').toString(),
      title: (d['title'] ?? 'Notification').toString(),
      message: (d['message'] ?? '').toString(),
      kind: AppNotificationKind.values.firstWhere(
        (k) => k.name == kindRaw,
        orElse: () => AppNotificationKind.info,
      ),
      severity: AlertSeverity.values.firstWhere(
        (s) => s.name == severityRaw,
        orElse: () => AlertSeverity.medium,
      ),
      read: (d['read'] as bool?) ?? false,
      archived: (d['archived'] as bool?) ?? false,
      targetRoute: d['target_route']?.toString(),
      createdAt: (d['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'user_id': userId,
        'title': title,
        'message': message,
        'kind': kind.name,
        'severity': severity.name,
        'read': read,
        'archived': archived,
        'target_route': targetRoute,
        'created_at': FieldValue.serverTimestamp(),
      };
}
