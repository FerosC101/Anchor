import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firebase_constants.dart';
import '../../models/wage_log_model.dart';

/// Provides all Firestore operations for the wage-monitoring feature.
///
/// Wage logs are stored as a sub-collection of the user document:
///   users/{userId}/wage_logs/{logId}
class WageService {
  WageService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  // ── Collection reference ───────────────────────────────────────────────────

  CollectionReference<Map<String, dynamic>> _logsRef(String userId) =>
      _firestore
          .collection(FirebaseConstants.usersCollection)
          .doc(userId)
          .collection(FirebaseConstants.wageLogsSubcollection);

  // ── Real-time stream ───────────────────────────────────────────────────────

  /// Streams all wage logs for [userId], ordered by period (newest first).
  Stream<List<WageLog>> watchWageLogs(String userId) {
    return _logsRef(userId)
        .orderBy('period', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(WageLog.fromFirestore).toList());
  }

  // ── Create ─────────────────────────────────────────────────────────────────

  /// Adds a new wage log for the given [userId].
  /// Returns the new document's ID.
  Future<String> addWageLog({
    required String userId,
    required double amount,
    double? expectedAmount,
    required String currency,
    required DateTime period,
    String? notes,
  }) async {
    // Normalise period to the first of the month so duplicates are easy to detect.
    final normalisedPeriod = DateTime(period.year, period.month, 1);

    final doc = _logsRef(userId).doc();
    await doc.set(
      WageLog(
        id: doc.id,
        userId: userId,
        amount: amount,
        expectedAmount: expectedAmount,
        currency: currency,
        period: normalisedPeriod,
        loggedAt: DateTime.now(),
        notes: notes,
      ).toFirestore(),
    );
    return doc.id;
  }

  // ── Update ─────────────────────────────────────────────────────────────────

  /// Updates the mutable fields of an existing wage log.
  Future<void> updateWageLog({
    required String userId,
    required String logId,
    double? amount,
    double? expectedAmount,
    String? currency,
    String? notes,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': FieldValue.serverTimestamp(),
      if (amount != null) 'amount': amount,
      if (expectedAmount != null) 'expected_amount': expectedAmount,
      if (currency != null) 'currency': currency,
      if (notes != null) 'notes': notes,
    };
    await _logsRef(userId).doc(logId).update(updates);
  }

  // ── Delete ─────────────────────────────────────────────────────────────────

  Future<void> deleteWageLog({
    required String userId,
    required String logId,
  }) =>
      _logsRef(userId).doc(logId).delete();

  // ── Aggregate helpers ──────────────────────────────────────────────────────

  /// Fetches the last [limit] wage logs (one-time read, newest-period first).
  Future<List<WageLog>> fetchRecentWageLogs({
    required String userId,
    int limit = 12,
  }) async {
    final snap = await _logsRef(userId)
        .orderBy('period', descending: true)
        .limit(limit)
        .get();
    return snap.docs.map(WageLog.fromFirestore).toList();
  }
}
