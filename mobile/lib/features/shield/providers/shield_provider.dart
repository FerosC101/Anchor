import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/ofw_backend_service.dart';
import '../../../models/financial_shield_model.dart';

final shieldServiceProvider = Provider<OfwBackendService>(
  (ref) => OfwBackendService(),
);

final _uidProvider =
    Provider<String?>((ref) => FirebaseAuth.instance.currentUser?.uid);

final financialShieldProfileProvider =
    StreamProvider<FinancialShieldProfile>((ref) {
  final uid = ref.watch(_uidProvider);
  if (uid == null) return const Stream.empty();
  return ref.watch(shieldServiceProvider).watchFinancialProfile(uid);
});

final savingsGoalsProvider = StreamProvider<List<SavingsGoalModel>>((ref) {
  final uid = ref.watch(_uidProvider);
  if (uid == null) return const Stream.empty();
  return ref.watch(shieldServiceProvider).watchSavingsGoals(uid);
});

class ShieldActionNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  OfwBackendService get _service => ref.read(shieldServiceProvider);
  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  Future<void> saveFinancialProfile({
    required double totalSavings,
    required double outstandingDebt,
    required double monthlyLivingCost,
    required double estimatedFlightCost,
  }) async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.upsertFinancialProfile(
          userId: uid,
          totalSavings: totalSavings,
          outstandingDebt: outstandingDebt,
          monthlyLivingCost: monthlyLivingCost,
          estimatedFlightCost: estimatedFlightCost,
        ));
  }

  Future<void> createGoal({
    required String title,
    required double targetAmount,
    double currentAmount = 0,
    DateTime? dueDate,
  }) async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service
        .createSavingsGoal(
          userId: uid,
          title: title,
          targetAmount: targetAmount,
          currentAmount: currentAmount,
          dueDate: dueDate,
        )
        .then((_) {}));
  }
}

final shieldActionProvider = AsyncNotifierProvider<ShieldActionNotifier, void>(
  ShieldActionNotifier.new,
);

final smartExitSummaryProvider = Provider<
    ({
      double netSafetyNet,
      double runwayAmount,
      int survivalMonths,
    })?>((ref) {
  final profile = ref.watch(financialShieldProfileProvider).valueOrNull;
  if (profile == null) return null;
  return (
    netSafetyNet: profile.netSafetyNet,
    runwayAmount: profile.remainingRunwayAfterExit,
    survivalMonths: profile.survivalMonths,
  );
});
