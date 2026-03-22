import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firebase_constants.dart';
import '../../models/financial_shield_model.dart';
import '../../models/job_model.dart';
import '../../models/notification_model.dart';
import '../../models/post_model.dart';
import '../../models/report_model.dart';

class OfwBackendService {
  OfwBackendService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  // ── Community-based reports / posts ───────────────────────────────────────

  Stream<List<CommunityPostModel>> watchCommunityPosts({int limit = 50}) {
    return _firestore
        .collection(FirebaseConstants.communityPostsCollection)
        .orderBy('created_at', descending: true)
        .limit(limit)
        .snapshots()
        .map((s) => s.docs.map(CommunityPostModel.fromFirestore).toList());
  }

  Future<String> createCommunityPost({
    required String userId,
    required String company,
    required String description,
    required String location,
    required List<String> tags,
    int riskScore = 50,
    double? latitude,
    double? longitude,
  }) async {
    final doc =
        _firestore.collection(FirebaseConstants.communityPostsCollection).doc();

    await doc.set(
      CommunityPostModel(
        id: doc.id,
        userId: userId,
        company: company,
        description: description,
        tags: tags,
        location: location,
        upvotes: 0,
        comments: 0,
        latitude: latitude,
        longitude: longitude,
        riskScore: riskScore,
        createdAt: DateTime.now(),
      ).toFirestore(),
    );

    return doc.id;
  }

  Stream<List<RiskPoint>> watchRiskMapPoints({int limit = 200}) {
    return _firestore
        .collection(FirebaseConstants.communityPostsCollection)
        .orderBy('created_at', descending: true)
        .limit(limit)
        .snapshots()
        .map((s) => s.docs.map((d) {
              final post = CommunityPostModel.fromFirestore(d);
              return RiskPoint(
                id: post.id,
                location: post.location,
                score: post.riskScore,
                latitude: post.latitude,
                longitude: post.longitude,
                category: post.tags.isNotEmpty
                    ? post.tags.first.replaceAll('#', '').toLowerCase()
                    : 'other',
                createdAt: post.createdAt,
              );
            }).toList());
  }

  Stream<CommunityPostModel?> watchCommunityPostById(String postId) {
    return _firestore
        .collection(FirebaseConstants.communityPostsCollection)
        .doc(postId)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      return CommunityPostModel.fromFirestore(doc);
    });
  }

  Stream<List<CommunityCommentModel>> watchPostComments(String postId) {
    return _firestore
        .collection(FirebaseConstants.postCommentsCollection)
        .where('post_id', isEqualTo: postId)
        .orderBy('created_at', descending: false)
        .snapshots()
        .map((s) => s.docs.map(CommunityCommentModel.fromFirestore).toList());
  }

  Future<void> createPostComment({
    required String postId,
    required String userId,
    required String content,
    bool anonymous = true,
  }) async {
    final commentDoc =
        _firestore.collection(FirebaseConstants.postCommentsCollection).doc();

    await commentDoc.set(
      CommunityCommentModel(
        id: commentDoc.id,
        postId: postId,
        userId: userId,
        content: content,
        anonymous: anonymous,
        createdAt: DateTime.now(),
      ).toFirestore(),
    );

    // Best effort only: if rules reject non-owner updates, comment creation
    // should still succeed so posting does not fail.
    try {
      await _firestore
          .collection(FirebaseConstants.communityPostsCollection)
          .doc(postId)
          .update({'comments': FieldValue.increment(1)});
    } catch (_) {
      // Ignore counter update failure.
    }
  }

  // ── User Reports ───────────────────────────────────────────────────────────

  Future<String> createUserReport({
    required String reporterId,
    required String title,
    required String description,
    required String location,
    required ReportCategory category,
    bool anonymous = false,
  }) async {
    final doc =
        _firestore.collection(FirebaseConstants.reportsCollection).doc();
    await doc.set(
      UserReportModel(
        id: doc.id,
        reporterId: reporterId,
        title: title,
        description: description,
        category: category,
        location: location,
        anonymous: anonymous,
        createdAt: DateTime.now(),
      ).toFirestore(),
    );
    return doc.id;
  }

  Stream<List<UserReportModel>> watchMyReports(String userId) {
    return _firestore
        .collection(FirebaseConstants.reportsCollection)
        .where('reporter_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((s) => s.docs.map(UserReportModel.fromFirestore).toList());
  }

  // ── Notifications / Alerts ────────────────────────────────────────────────

  Stream<List<AppNotificationModel>> watchUserNotifications(
    String userId, {
    bool alertsOnly = false,
  }) {
    Query<Map<String, dynamic>> query = _firestore
        .collection(FirebaseConstants.notificationsCollection)
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true);

    if (alertsOnly) {
      query = query.where('kind', isEqualTo: AppNotificationKind.alert.name);
    }

    return query
        .snapshots()
        .map((s) => s.docs.map(AppNotificationModel.fromFirestore).toList());
  }

  Future<void> markNotificationAsRead(String notificationId) {
    return _firestore
        .collection(FirebaseConstants.notificationsCollection)
        .doc(notificationId)
        .set(
      {
        'read': true,
        'read_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  Future<void> archiveNotification(String notificationId) {
    return _firestore
        .collection(FirebaseConstants.notificationsCollection)
        .doc(notificationId)
        .set(
      {
        'archived': true,
        'updated_at': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  // ── Job Listings ───────────────────────────────────────────────────────────

  Stream<List<JobModel>> watchJobListings({String? country, int limit = 100}) {
    Query<Map<String, dynamic>> query = _firestore
        .collection(FirebaseConstants.jobOffersCollection)
        .where('status', isEqualTo: 'active')
        .orderBy('created_at', descending: true)
        .limit(limit);

    if (country != null && country.isNotEmpty) {
      query = query.where('country', isEqualTo: country);
    }

    return query
        .snapshots()
        .map((s) => s.docs.map(JobModel.fromFirestore).toList());
  }

  // ── Financial Shield / Smart Exit Planner ─────────────────────────────────

  DocumentReference<Map<String, dynamic>> _financialProfileRef(String userId) {
    return _firestore
        .collection(FirebaseConstants.usersCollection)
        .doc(userId)
        .collection(FirebaseConstants.financialShieldSubcollection)
        .doc(FirebaseConstants.financialShieldProfileDoc);
  }

  Stream<FinancialShieldProfile> watchFinancialProfile(String userId) {
    return _financialProfileRef(userId).snapshots().map(
          FinancialShieldProfile.fromFirestore,
        );
  }

  Future<void> upsertFinancialProfile({
    required String userId,
    required double totalSavings,
    required double outstandingDebt,
    required double monthlyLivingCost,
    required double estimatedFlightCost,
  }) async {
    await _financialProfileRef(userId).set(
      FinancialShieldProfile(
        totalSavings: totalSavings,
        outstandingDebt: outstandingDebt,
        monthlyLivingCost: monthlyLivingCost,
        estimatedFlightCost: estimatedFlightCost,
        updatedAt: DateTime.now(),
      ).toFirestore(),
      SetOptions(merge: true),
    );
  }

  CollectionReference<Map<String, dynamic>> _goalsRef(String userId) {
    return _firestore
        .collection(FirebaseConstants.usersCollection)
        .doc(userId)
        .collection(FirebaseConstants.savingsGoalsSubcollection);
  }

  Stream<List<SavingsGoalModel>> watchSavingsGoals(String userId) {
    return _goalsRef(userId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((s) => s.docs.map(SavingsGoalModel.fromFirestore).toList());
  }

  Future<String> createSavingsGoal({
    required String userId,
    required String title,
    required double targetAmount,
    double currentAmount = 0,
    DateTime? dueDate,
  }) async {
    final doc = _goalsRef(userId).doc();
    await doc.set(
      SavingsGoalModel(
        id: doc.id,
        userId: userId,
        title: title,
        targetAmount: targetAmount,
        currentAmount: currentAmount,
        dueDate: dueDate,
        createdAt: DateTime.now(),
      ).toFirestore(),
    );
    return doc.id;
  }

  Future<void> updateSavingsGoalProgress({
    required String userId,
    required String goalId,
    required double currentAmount,
  }) async {
    await _goalsRef(userId).doc(goalId).update({
      'current_amount': currentAmount,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }
}
