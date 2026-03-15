import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/wage_service.dart';
import '../../../models/wage_log_model.dart';

// ── Service provider ──────────────────────────────────────────────────────────

final wageServiceProvider = Provider<WageService>(
  (ref) => WageService(),
);

// ── Current-user helper ───────────────────────────────────────────────────────

final _currentUserIdProvider = Provider<String?>((ref) {
  return FirebaseAuth.instance.currentUser?.uid;
});

// ── Stream: live wage logs ────────────────────────────────────────────────────

/// Streams the authenticated user's wage logs in real time.
final wageLogsProvider = StreamProvider<List<WageLog>>((ref) {
  final uid = ref.watch(_currentUserIdProvider);
  if (uid == null) return const Stream.empty();
  return ref.watch(wageServiceProvider).watchWageLogs(uid);
});

// ── Notifier: add / update / delete ──────────────────────────────────────────

class WageLogsNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  WageService get _service => ref.read(wageServiceProvider);

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  Future<void> addLog({
    required double amount,
    double? expectedAmount,
    required String currency,
    required DateTime period,
    String? notes,
  }) async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.addWageLog(
          userId: uid,
          amount: amount,
          expectedAmount: expectedAmount,
          currency: currency,
          period: period,
          notes: notes,
        ).then((_) {}));
  }

  Future<void> updateLog({
    required String logId,
    double? amount,
    double? expectedAmount,
    String? currency,
    String? notes,
  }) async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.updateWageLog(
          userId: uid,
          logId: logId,
          amount: amount,
          expectedAmount: expectedAmount,
          currency: currency,
          notes: notes,
        ));
  }

  Future<void> deleteLog(String logId) async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _service.deleteWageLog(userId: uid, logId: logId),
    );
  }
}

final wageLogsNotifierProvider =
    AsyncNotifierProvider<WageLogsNotifier, void>(WageLogsNotifier.new);

// ── Derived: chart spots ──────────────────────────────────────────────────────

/// Returns the last 12 months of wage amounts sorted chronologically (oldest→newest)
/// ready to be consumed by fl_chart.
final wageChartDataProvider = Provider<({
  List<double> amounts,
  List<String> labels,
  double maxY,
  double? latestGap,
})>((ref) {
  final logsAsync = ref.watch(wageLogsProvider);
  final logs = logsAsync.valueOrNull ?? [];

  // Sort oldest → newest (for chart X-axis order).
  final sorted = [...logs]
    ..sort((a, b) => a.period.compareTo(b.period));

  // Take the last 12 data points for the chart.
  final chartLogs = sorted.length > 12 ? sorted.sublist(sorted.length - 12) : sorted;

  final months = <String>['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  final amounts = chartLogs.map((l) => l.amount).toList();
  final labels = chartLogs
      .map((l) => months[l.period.month - 1])
      .toList();

  final maxY = amounts.isEmpty
      ? 400.0
      : (amounts.reduce((a, b) => a > b ? a : b) * 1.3).ceilToDouble();

  final latestGap = sorted.isNotEmpty ? sorted.last.gap : null;

  return (amounts: amounts, labels: labels, maxY: maxY, latestGap: latestGap);
});
