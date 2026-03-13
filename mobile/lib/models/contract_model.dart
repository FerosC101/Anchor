class FlaggedClause {
  final String clause;
  final String reason;

  const FlaggedClause({
    required this.clause,
    required this.reason,
  });

  factory FlaggedClause.fromMap(Map<String, dynamic> map) {
    return FlaggedClause(
      clause: (map['clause'] ?? '').toString(),
      reason: (map['reason'] ?? '').toString(),
    );
  }
}

class ComparisonItem {
  final String category;
  final String status;
  final String yourContract;
  final String standardPractice;

  const ComparisonItem({
    required this.category,
    required this.status,
    required this.yourContract,
    required this.standardPractice,
  });

  factory ComparisonItem.fromMap(Map<String, dynamic> map) {
    return ComparisonItem(
      category: (map['category'] ?? 'General').toString(),
      status: (map['status'] ?? 'review').toString(),
      yourContract:
          (map['your_contract'] ?? map['yourContract'] ?? '').toString(),
      standardPractice:
          (map['standard_practice'] ?? map['standardPractice'] ?? '')
              .toString(),
    );
  }
}

class ContractUploadModel {
  final String contractId;
  final String userId;
  final String fileName;
  final String fileUrl;
  final DateTime uploadedAt;
  final String aiAnalysisStatus;

  const ContractUploadModel({
    required this.contractId,
    required this.userId,
    required this.fileName,
    required this.fileUrl,
    required this.uploadedAt,
    this.aiAnalysisStatus = 'pending',
  });

  Map<String, dynamic> toFirestore() {
    return {
      'user_id': userId,
      'file_name': fileName,
      'contract_file_url': fileUrl,
      'contract_type': 'employment',
      'uploaded_at': uploadedAt,
      'updated_at': uploadedAt,
      'ai_analysis_status': aiAnalysisStatus,
    };
  }
}

class ContractAnalysisResult {
  final String contractId;
  final double riskScore;
  final String riskLevel;
  final String aiSummary;
  final String overviewSummary;
  final List<FlaggedClause> flaggedClauses;
  final List<ComparisonItem> comparisonItems;
  final List<String> recommendedActions;
  final int issueCount;
  final int criticalCount;
  final bool modelLoaded;
  final String? modelNote;

  const ContractAnalysisResult({
    required this.contractId,
    required this.riskScore,
    required this.riskLevel,
    required this.aiSummary,
    required this.overviewSummary,
    required this.flaggedClauses,
    required this.comparisonItems,
    required this.recommendedActions,
    required this.issueCount,
    required this.criticalCount,
    required this.modelLoaded,
    this.modelNote,
  });

  factory ContractAnalysisResult.fromMap(Map<String, dynamic> map) {
    final clausesRaw = map['flaggedClauses'];
    final clauses = clausesRaw is List
        ? clausesRaw
            .whereType<Map>()
            .map((item) => FlaggedClause.fromMap(item.cast<String, dynamic>()))
            .toList()
        : <FlaggedClause>[];

    final comparisonRaw = map['comparisonItems'] ?? map['comparison_items'];
    final comparisons = comparisonRaw is List
        ? comparisonRaw
            .whereType<Map>()
            .map((item) => ComparisonItem.fromMap(item.cast<String, dynamic>()))
            .toList()
        : <ComparisonItem>[];

    final actionsRaw = map['recommendedActions'] ?? map['recommended_actions'];
    final actions = actionsRaw is List
        ? actionsRaw.map((item) => item.toString()).toList()
        : <String>[];

    final issueCountRaw = map['issueCount'] ?? map['issue_count'];
    final criticalCountRaw = map['criticalCount'] ?? map['critical_count'];

    final summary =
        (map['overviewSummary'] ?? map['overview_summary'] ?? '').toString();

    return ContractAnalysisResult(
      contractId: (map['contractId'] ?? map['contract_id'] ?? '').toString(),
      riskScore: (map['riskScore'] is num)
          ? (map['riskScore'] as num).toDouble()
          : (map['risk_score'] is num)
              ? (map['risk_score'] as num).toDouble()
              : 0,
      riskLevel: (map['riskLevel'] ?? map['risk_level'] ?? 'low').toString(),
      aiSummary: (map['aiSummary'] ?? map['ai_summary'] ?? '').toString(),
      overviewSummary: summary,
      flaggedClauses: clauses,
      comparisonItems: comparisons,
      recommendedActions: actions,
      issueCount: issueCountRaw is num ? issueCountRaw.toInt() : clauses.length,
      criticalCount: criticalCountRaw is num ? criticalCountRaw.toInt() : 0,
      modelLoaded: map['modelLoaded'] == true,
      modelNote: (map['modelNote'] ?? map['model_note'])?.toString(),
    );
  }
}
