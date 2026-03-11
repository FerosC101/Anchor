import 'package:flutter/material.dart';
import '../../../models/scan_model.dart';
import '../../../shared/utils/risk_utils.dart';
import '../../../shared/widgets/anchor_app_bar.dart';

class ContractScanDetailScreen extends StatelessWidget {
  const ContractScanDetailScreen({super.key, required this.scan});

  final ScanModel scan;

  @override
  Widget build(BuildContext context) {
    // TODO: replace with dynamic data
    final int issueCount = 3;
    final int criticalCount = 5;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: const AnchorAppBar(
          showBackButton: true,
          title: 'Contract Analysis',
          subtitle: 'Detailed risk assessment',
        ),
        body: Column(
          children: [
            _buildFileHeaderCard(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  _buildOverviewTab(issueCount, criticalCount),
                  _buildComparisonTab(),
                  _buildActionsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── File Header Card ─────────────────────────────────────────────────────────

  Widget _buildFileHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFD7D2E7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.insert_drive_file_outlined,
              color: Color(0xFF3D3790),
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${scan.name}.pdf',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                Text(
                  'Analyzed on ${scan.date}, 2026',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── TabBar ───────────────────────────────────────────────────────────────────

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: const TabBar(
        labelColor: Color(0xFF3D3790),
        unselectedLabelColor: Color(0xFF888888),
        indicatorColor: Color(0xFF3D3790),
        indicatorWeight: 2.5,
        tabs: [
          Tab(text: 'Overview'),
          Tab(text: 'Comparison'),
          Tab(text: 'Actions'),
        ],
      ),
    );
  }

  // ━━━ TAB 1: Overview ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Widget _buildOverviewTab(int issueCount, int criticalCount) {
    final riskColor = RiskUtils.getRiskColor(scan.score);
    final riskBgColor = RiskUtils.getRiskBgColor(scan.score);
    final riskHeadline = RiskUtils.getRiskHeadline(scan.score);
    final riskSubtitle = RiskUtils.getRiskSubtitle(scan.score);
    final explanation = RiskUtils.getExplanation(scan.score);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Risk Banner Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: riskBgColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // LEFT: label + headline + subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI ANALYSIS COMPLETE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: riskColor,
                              letterSpacing: 1.4,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            riskHeadline,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: riskColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            riskSubtitle,
                            style: TextStyle(
                              fontSize: 13,
                              color: riskColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // RIGHT: score badge
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: riskColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            scan.score.toString(),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'SCORE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Issues row — two white sub-cards side by side
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Issues found',
                              style: TextStyle(
                                fontSize: 13,
                                color: riskColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              issueCount.toString(),
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: riskColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Critical',
                              style: TextStyle(
                                fontSize: 13,
                                color: riskColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              criticalCount.toString(),
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: riskColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // What this means card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBE8),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFAD4B00).withValues(alpha: 0.25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What this means',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFAD4B00),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  explanation,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFAD4B00),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Bottom action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: implement download
                  },
                  icon: const Icon(Icons.download_outlined,
                      color: Color(0xFF3D3790)),
                  label: const Text(
                    'Download Report',
                    style: TextStyle(
                      color: Color(0xFF3D3790),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFD7D2E7)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: implement contact help
                  },
                  icon: const Icon(Icons.phone_outlined,
                      color: Color(0xFF3D3790)),
                  label: const Text(
                    'Contact Help',
                    style: TextStyle(
                      color: Color(0xFF3D3790),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFD7D2E7)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ━━━ TAB 2: Comparison ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Widget _buildComparisonTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header info card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFD7D2E7).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Side by side comparison',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3D3790),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'See how your contract compares to international labor standards and typical Singapore/Malaysia contracts.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8575B6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Comparison cards
          const _ComparisonCard(
            icon: Icons.attach_money,
            category: 'Salary & Payment',
            status: 'REVIEW',
            yourContract: 'SGD \$1,200/month with unclear deductions',
            standardPractice: 'SGD \$1,800/month, itemized deductions',
          ),
          const SizedBox(height: 12),
          const _ComparisonCard(
            icon: Icons.access_time_outlined,
            category: 'Working Hours',
            status: 'RED FLAG',
            yourContract: '10-12 hours/day, 6 days/week',
            standardPractice: '8 hours/day, overtime at 1.5x pay',
          ),
          const SizedBox(height: 12),
          const _ComparisonCard(
            icon: Icons.home_outlined,
            category: 'Accommodation',
            status: 'RED FLAG',
            yourContract: '"Reasonable fees" — amount not specified',
            standardPractice: 'Capped accommodation fees, itemized billing',
          ),
        ],
      ),
    );
  }

  // ━━━ TAB 3: Actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Widget _buildActionsTab() {
    final riskBgColor = RiskUtils.getRiskBgColor(scan.score);
    final riskColor = RiskUtils.getRiskColor(scan.score);

    // Determine actions based on score
    List<_ActionItemData> actions;
    if (scan.score >= 70) {
      // High risk
      actions = [
        _ActionItemData(
          1,
          Icons.block_outlined,
          'DO NOT SIGN YET',
          'This contract has serious issues. Contact your embassy or a labor lawyer immediately.',
          isUrgent: true,
        ),
        _ActionItemData(
          2,
          Icons.account_balance_outlined,
          'Contact Your Embassy',
          'Report the high-risk clauses to your country\'s embassy or consulate for assistance.',
          isUrgent: false,
        ),
        _ActionItemData(
          3,
          Icons.edit_document,
          'Request Contract Revisions',
          'Ask the employer to amend the problematic clauses. Use this report as evidence.',
          isUrgent: false,
        ),
        _ActionItemData(
          4,
          Icons.download_outlined,
          'Save This Report',
          'Download and keep this analysis with your important documents for future reference.',
          isUrgent: false,
        ),
        _ActionItemData(
          5,
          Icons.group_outlined,
          'Share with Community',
          'Post this employer\'s contract practices to Community Safety to warn other workers.',
          isUrgent: false,
        ),
        _ActionItemData(
          6,
          Icons.gavel_outlined,
          'Get Legal Help',
          'Contact free legal aid services or NGOs',
          isUrgent: false,
        ),
      ];
    } else if (scan.score >= 40) {
      // Medium risk
      actions = [
        _ActionItemData(
          1,
          Icons.search_outlined,
          'Review Flagged Clauses',
          'Read each flagged section carefully before agreeing to any terms.',
          isUrgent: false,
        ),
        _ActionItemData(
          2,
          Icons.account_balance_outlined,
          'Contact Your Embassy',
          'Report the high-risk clauses to your country\'s embassy or consulate for assistance.',
          isUrgent: false,
        ),
        _ActionItemData(
          3,
          Icons.edit_document,
          'Request Contract Revisions',
          'Ask the employer to amend the problematic clauses. Use this report as evidence.',
          isUrgent: false,
        ),
        _ActionItemData(
          4,
          Icons.download_outlined,
          'Save This Report',
          'Download and keep this analysis with your important documents for future reference.',
          isUrgent: false,
        ),
        _ActionItemData(
          5,
          Icons.group_outlined,
          'Share with Community',
          'Post this employer\'s contract practices to Community Safety to warn other workers.',
          isUrgent: false,
        ),
        _ActionItemData(
          6,
          Icons.gavel_outlined,
          'Get Legal Help',
          'Contact free legal aid services or NGOs',
          isUrgent: false,
        ),
      ];
    } else {
      // Low risk
      actions = [
        _ActionItemData(
          1,
          Icons.check_circle_outline,
          'Contract Looks Good',
          'This contract meets standard requirements. Keep a copy for your records.',
          isUrgent: false,
        ),
        _ActionItemData(
          2,
          Icons.account_balance_outlined,
          'Contact Your Embassy',
          'Report the high-risk clauses to your country\'s embassy or consulate for assistance.',
          isUrgent: false,
        ),
        _ActionItemData(
          3,
          Icons.edit_document,
          'Request Contract Revisions',
          'Ask the employer to amend the problematic clauses. Use this report as evidence.',
          isUrgent: false,
        ),
        _ActionItemData(
          4,
          Icons.download_outlined,
          'Save This Report',
          'Download and keep this analysis with your important documents for future reference.',
          isUrgent: false,
        ),
        _ActionItemData(
          5,
          Icons.group_outlined,
          'Share with Community',
          'Post this employer\'s contract practices to Community Safety to warn other workers.',
          isUrgent: false,
        ),
        _ActionItemData(
          6,
          Icons.gavel_outlined,
          'Get Legal Help',
          'Contact free legal aid services or NGOs',
          isUrgent: false,
        ),
      ];
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: riskBgColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: riskColor.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      color: Color(0xFF3D3790),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Next Steps: Your Action Plan',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3D3790),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  scan.score >= 70
                      ? 'Based on the high risk level, here\'s what we recommend:'
                      : 'Based on your contract analysis, here\'s what we recommend:',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8575B6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Action items
          ...actions.map((action) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ActionItem(
                  index: action.index,
                  icon: action.icon,
                  title: action.title,
                  description: action.description,
                  isUrgent: action.isUrgent,
                ),
              )),
        ],
      ),
    );
  }
}

// ─── Helper Widgets ──────────────────────────────────────────────────────────

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({
    required this.icon,
    required this.category,
    required this.status,
    required this.yourContract,
    required this.standardPractice,
  });

  final IconData icon;
  final String category;
  final String status;
  final String yourContract;
  final String standardPractice;

  @override
  Widget build(BuildContext context) {
    Color statusBgColor;
    Color statusTextColor;

    if (status == 'RED FLAG') {
      statusBgColor = const Color(0xFFFFF3F3);
      statusTextColor = const Color(0xFF8E0012);
    } else if (status == 'REVIEW') {
      statusBgColor = const Color(0xFFFFFBE8);
      statusTextColor = const Color(0xFFAD4B00);
    } else {
      statusBgColor = const Color(0xFFEEFDF3);
      statusTextColor = const Color(0xFF00AA28);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: const Color(0xFF8575B6), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: statusTextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Your contract row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.cancel_outlined,
                color: Color(0xFF8E0012),
                size: 16,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'YOUR CONTRACT',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8E0012),
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      yourContract,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Standard practice row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Color(0xFF00AA28),
                size: 16,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'STANDARD PRACTICE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00AA28),
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      standardPractice,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.index,
    required this.icon,
    required this.title,
    required this.description,
    required this.isUrgent,
  });

  final int index;
  final IconData icon;
  final String title;
  final String description;
  final bool isUrgent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isUrgent ? const Color(0xFFFFF3F3) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: isUrgent
            ? Border.all(
                color: const Color(0xFF8E0012).withValues(alpha: 0.3),
              )
            : null,
        boxShadow: isUrgent
            ? null
            : const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number circle
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isUrgent ? const Color(0xFF8E0012) : const Color(0xFF3D3790),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 16,
                      color: isUrgent
                          ? const Color(0xFF8E0012)
                          : const Color(0xFF3D3790),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isUrgent
                              ? const Color(0xFF8E0012)
                              : const Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: isUrgent
                        ? const Color(0xFF8E0012)
                        : const Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionItemData {
  final int index;
  final IconData icon;
  final String title;
  final String description;
  final bool isUrgent;

  _ActionItemData(
    this.index,
    this.icon,
    this.title,
    this.description, {
    required this.isUrgent,
  });
}
