import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firebase_constants.dart';
import '../../models/contract_model.dart';
import '../../models/scan_model.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  String newContractId() {
    return _firestore
        .collection(FirebaseConstants.contractsCollection)
        .doc()
        .id;
  }

  Future<void> createContractUpload(ContractUploadModel upload) async {
    await _firestore
        .collection(FirebaseConstants.contractsCollection)
        .doc(upload.contractId)
        .set(upload.toFirestore(), SetOptions(merge: true));

    final profileQuery = await _firestore
        .collection(FirebaseConstants.ofwProfilesCollection)
        .where('user_id', isEqualTo: upload.userId)
        .limit(1)
        .get();

    if (profileQuery.docs.isNotEmpty) {
      await profileQuery.docs.first.reference.set(
        {'contract_status': 'uploaded'},
        SetOptions(merge: true),
      );
    }
  }

  Future<void> updateContractAnalysisStatus({
    required String contractId,
    required String status,
  }) {
    return _firestore
        .collection(FirebaseConstants.contractsCollection)
        .doc(contractId)
        .set(
      {
        'ai_analysis_status': status,
        'updated_at': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  Future<List<ScanModel>> fetchRecentScans({
    required String userId,
    int limit = 10,
  }) async {
    final snapshot = await _firestore
        .collection(FirebaseConstants.contractsCollection)
        .where('user_id', isEqualTo: userId)
        .orderBy('uploaded_at', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.asMap().entries.map((entry) {
      final index = entry.key;
      final doc = entry.value;
      final data = doc.data();
      final fileName = (data['file_name'] ?? 'Contract').toString();
      final uploadedAt = (data['uploaded_at'] as Timestamp?)?.toDate();
      final riskRaw = data['risk_score'];
      final riskScore = riskRaw is num ? (riskRaw * 100).round() : 0;
      final riskLevel = (data['risk_level'] ?? '').toString();
      final overviewSummary = (data['overview_summary'] ?? '').toString();
      final issueCount = data['issue_count'] is num
          ? (data['issue_count'] as num).toInt()
          : null;
      final criticalCount = data['critical_count'] is num
          ? (data['critical_count'] as num).toInt()
          : null;

      final comparisonRaw = data['comparison_items'];
      final comparisonItems = comparisonRaw is List
          ? comparisonRaw.whereType<Map>().map((item) {
              final map = item.cast<String, dynamic>();
              return ScanComparisonItem(
                category: (map['category'] ?? 'General').toString(),
                status: (map['status'] ?? 'review').toString(),
                yourContract: (map['your_contract'] ?? '').toString(),
                standardPractice: (map['standard_practice'] ?? '').toString(),
              );
            }).toList()
          : <ScanComparisonItem>[];

      final actionsRaw = data['recommended_actions'];
      final recommendedActions = actionsRaw is List
          ? actionsRaw.map((item) => item.toString()).toList()
          : <String>[];

      final when = uploadedAt ?? DateTime.now();

      return ScanModel(
        id: index + 1,
        contractId: doc.id,
        name: fileName,
        fullName: fileName,
        subtitle: riskLevel.isNotEmpty
            ? riskLevel.toUpperCase()
            : 'Uploaded contract',
        date: _formatDate(when),
        time: _formatTime(when),
        score: riskScore.clamp(0, 100),
        issueCount: issueCount,
        criticalCount: criticalCount,
        overviewSummary: overviewSummary.isNotEmpty ? overviewSummary : null,
        comparisonItems: comparisonItems,
        recommendedActions: recommendedActions,
      );
    }).toList();
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  String _formatTime(DateTime date) {
    final hour12 = date.hour == 0
        ? 12
        : date.hour > 12
            ? date.hour - 12
            : date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final suffix = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour12:$minute $suffix';
  }
}
