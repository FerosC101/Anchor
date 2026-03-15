import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a single monthly wage entry logged by an OFW.
class WageLog {
  final String id;
  final String userId;

  /// The actual amount received by the worker.
  final double amount;

  /// The expected / contracted amount (used to compute the gap).
  final double? expectedAmount;

  /// ISO 4217 currency code, e.g. "SGD", "HKD", "USD".
  final String currency;

  /// The billing period this wage covers (stored as the 1st of the month).
  final DateTime period;

  /// Wall-clock timestamp when the log was created.
  final DateTime loggedAt;

  final String? notes;

  const WageLog({
    required this.id,
    required this.userId,
    required this.amount,
    this.expectedAmount,
    required this.currency,
    required this.period,
    required this.loggedAt,
    this.notes,
  });

  // ── Computed helpers ──────────────────────────────────────────────────────

  /// Returns the gap (received − expected). Negative means underpaid.
  double? get gap => expectedAmount != null ? amount - expectedAmount! : null;

  bool get isUnderpaid => gap != null && gap! < 0;

  // ── Firestore serialisation ───────────────────────────────────────────────

  factory WageLog.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return WageLog(
      id: doc.id,
      userId: d['user_id'] as String? ?? '',
      amount: (d['amount'] as num?)?.toDouble() ?? 0,
      expectedAmount: (d['expected_amount'] as num?)?.toDouble(),
      currency: d['currency'] as String? ?? 'USD',
      period: (d['period'] as Timestamp).toDate(),
      loggedAt: (d['logged_at'] as Timestamp).toDate(),
      notes: d['notes'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'user_id': userId,
        'amount': amount,
        if (expectedAmount != null) 'expected_amount': expectedAmount,
        'currency': currency,
        'period': Timestamp.fromDate(period),
        'logged_at': FieldValue.serverTimestamp(),
        if (notes != null && notes!.isNotEmpty) 'notes': notes,
      };

  WageLog copyWith({
    String? id,
    String? userId,
    double? amount,
    double? expectedAmount,
    String? currency,
    DateTime? period,
    DateTime? loggedAt,
    String? notes,
  }) =>
      WageLog(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        amount: amount ?? this.amount,
        expectedAmount: expectedAmount ?? this.expectedAmount,
        currency: currency ?? this.currency,
        period: period ?? this.period,
        loggedAt: loggedAt ?? this.loggedAt,
        notes: notes ?? this.notes,
      );
}
