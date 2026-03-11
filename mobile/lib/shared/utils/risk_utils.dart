import 'package:flutter/material.dart';

class RiskUtils {
  RiskUtils._();

  /// Returns the appropriate color based on the risk score
  /// - 0-39: Green (Low Risk)
  /// - 40-69: Orange (Medium Risk)
  /// - 70-100: Red (High Risk)
  static Color getRiskColor(int score) {
    if (score < 40) {
      return const Color(0xFF3D8B5E); // Green
    } else if (score < 70) {
      return const Color(0xFFE07B00); // Orange
    } else {
      return const Color(0xFFC62828); // Red
    }
  }

  /// Returns the background color for the risk indicator
  static Color getRiskBackgroundColor(int score) {
    if (score < 40) {
      return const Color(0xFFEAF4EC); // Light green tint
    } else if (score < 70) {
      return const Color(0xFFFFF4E5); // Light amber tint
    } else {
      return const Color(0xFFFDECEA); // Light red tint
    }
  }

  /// Returns the background color for the risk card
  static Color getRiskBgColor(int score) {
    return getRiskBackgroundColor(score);
  }

  /// Returns the icon background color
  static Color getRiskIconBg(int score) {
    return getRiskColor(score);
  }

  /// Returns the appropriate icon based on the risk score
  static IconData getRiskIcon(int score) {
    if (score < 40) {
      return Icons.check_circle_outline;
    } else if (score < 70) {
      return Icons.warning_amber_rounded;
    } else {
      return Icons.dangerous_outlined;
    }
  }

  /// Returns the appropriate label based on the risk score
  static String getRiskLabel(int score) {
    if (score < 40) {
      return 'Low Risk';
    } else if (score < 70) {
      return 'Medium Risk';
    } else {
      return 'High Risk';
    }
  }

  /// Returns the title for the risk summary card
  static String getRiskTitle(int score) {
    if (score < 40) {
      return 'Contract Looks Acceptable';
    } else if (score < 70) {
      return 'Some Concerns Found';
    } else {
      return 'High Risk Contract';
    }
  }

  /// Returns the description for the risk summary card
  static String getRiskDescription(int score) {
    if (score < 40) {
      return 'Contract appears fair with clear terms';
    } else if (score < 70) {
      return 'Review highlighted clauses before signing';
    } else {
      return 'This contract contains potentially unfair clauses';
    }
  }

  /// Returns recommended actions based on the risk score
  static List<String> getRiskActions(int score) {
    if (score < 40) {
      return [
        'Save this analysis and keep it with your important documents',
        'Share concerns with the Community Safety network for collective intelligence',
        'Consider requesting contract revisions before signing',
      ];
    } else if (score < 70) {
      return [
        'Review the flagged clauses carefully before agreeing',
        'Consult a legal advisor or worker support hotline',
        'Request written clarification from your employer',
      ];
    } else {
      return [
        'Do NOT sign this contract without seeking legal advice',
        'Contact a worker protection organization immediately',
        'Document all communications with your employer',
      ];
    }
  }

  /// Returns the risk headline for the Overview tab
  static String getRiskHeadline(int score) {
    if (score < 40) {
      return 'CONTRACT\nLOOKS GOOD';
    } else if (score < 70) {
      return 'MODERATE RISK\nDETECTED';
    } else {
      return 'HIGH RISK\nDETECTED';
    }
  }

  /// Returns the risk subtitle for the Overview tab
  static String getRiskSubtitle(int score) {
    if (score < 40) {
      return 'We found no major red flags in your contract.';
    } else if (score < 70) {
      return 'Some clauses need clarification before signing.';
    } else {
      return 'Critical issues found. Do not sign without legal help.';
    }
  }

  /// Returns the detailed explanation for the "What this means" section
  static String getExplanation(int score) {
    if (score < 40) {
      return 'Your contract generally meets international labor standards. We recommend keeping a copy of this analysis and your contract for reference. If anything changes during your employment, use Anchor to report issues or seek help from community resources.';
    } else if (score < 70) {
      return 'We found several clauses that may be unfavorable or unclear. Before signing, request written clarification from your employer about the flagged sections. Consider speaking with a labor lawyer or your embassy for guidance on negotiating better terms.';
    } else {
      return 'This contract contains several clauses that violate international labor standards or are exploitative. Do NOT sign this contract until you consult with a lawyer, your embassy, or a worker rights organization. Signing may put you at risk of wage theft, excessive fees, or unsafe working conditions.';
    }
  }
}
