import 'package:cloud_firestore/cloud_firestore.dart';

class FinancialShieldProfile {
  final double totalSavings;
  final double outstandingDebt;
  final double monthlyLivingCost;
  final double estimatedFlightCost;
  final DateTime updatedAt;

  const FinancialShieldProfile({
    required this.totalSavings,
    required this.outstandingDebt,
    required this.monthlyLivingCost,
    required this.estimatedFlightCost,
    required this.updatedAt,
  });

  double get netSafetyNet => totalSavings - outstandingDebt;

  double get remainingRunwayAfterExit =>
      totalSavings - outstandingDebt - estimatedFlightCost;

  int get survivalMonths {
    if (monthlyLivingCost <= 0) return 0;
    final months = remainingRunwayAfterExit / monthlyLivingCost;
    return months.isFinite && months > 0 ? months.floor() : 0;
  }

  factory FinancialShieldProfile.fromFirestore(DocumentSnapshot doc) {
    final d = (doc.data() as Map<String, dynamic>? ?? <String, dynamic>{});
    return FinancialShieldProfile(
      totalSavings: (d['total_savings'] as num?)?.toDouble() ?? 0,
      outstandingDebt: (d['outstanding_debt'] as num?)?.toDouble() ?? 0,
      monthlyLivingCost: (d['monthly_living_cost'] as num?)?.toDouble() ?? 0,
      estimatedFlightCost:
          (d['estimated_flight_cost'] as num?)?.toDouble() ?? 0,
      updatedAt: (d['updated_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'total_savings': totalSavings,
        'outstanding_debt': outstandingDebt,
        'monthly_living_cost': monthlyLivingCost,
        'estimated_flight_cost': estimatedFlightCost,
        'updated_at': FieldValue.serverTimestamp(),
      };
}

class SavingsGoalModel {
  final String id;
  final String userId;
  final String title;
  final double targetAmount;
  final double currentAmount;
  final DateTime? dueDate;
  final DateTime createdAt;

  const SavingsGoalModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.targetAmount,
    required this.currentAmount,
    this.dueDate,
    required this.createdAt,
  });

  double get progress =>
      targetAmount <= 0 ? 0 : (currentAmount / targetAmount).clamp(0, 1);

  factory SavingsGoalModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return SavingsGoalModel(
      id: doc.id,
      userId: (d['user_id'] ?? '').toString(),
      title: (d['title'] ?? 'Savings Goal').toString(),
      targetAmount: (d['target_amount'] as num?)?.toDouble() ?? 0,
      currentAmount: (d['current_amount'] as num?)?.toDouble() ?? 0,
      dueDate: (d['due_date'] as Timestamp?)?.toDate(),
      createdAt: (d['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'user_id': userId,
        'title': title,
        'target_amount': targetAmount,
        'current_amount': currentAmount,
        if (dueDate != null) 'due_date': Timestamp.fromDate(dueDate!),
        'created_at': FieldValue.serverTimestamp(),
      };
}
