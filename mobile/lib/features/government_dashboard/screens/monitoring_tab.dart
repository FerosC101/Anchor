import 'dart:math';
import 'package:flutter/material.dart';
import '../components/dashboard_filter_chips.dart';
import '../components/dashboard_shared_widgets.dart';
import '../data/dashboard_data.dart';
import '../utils/dashboard_theme.dart';

class MonitoringTab extends StatefulWidget {
  final String selectedCountry;
  final String selectedStatus;
  final String selectedDate;
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onDateChanged;

  const MonitoringTab({
    super.key,
    required this.selectedCountry,
    required this.selectedStatus,
    required this.selectedDate,
    required this.onCountryChanged,
    required this.onStatusChanged,
    required this.onDateChanged,
  });

  @override
  State<MonitoringTab> createState() => _MonitoringTabState();
}

class _MonitoringTabState extends State<MonitoringTab> {
  int _monitoringSubTab = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Risk Monitoring',
              style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMonitoringTabs(),
                  const SizedBox(height: 12),
                  _buildFilterChips(),
                  const SizedBox(height: 20),
                  if (_monitoringSubTab == 0) ..._buildEmployersContent(),
                  if (_monitoringSubTab == 1) ..._buildAbuseReportsContent(),
                  if (_monitoringSubTab == 2) ..._buildContractIssuesContent(),
                ],
              ),
            );
  }

  // ── Sub-tabs ──────────────────────────────────────────────────────────────

  Widget _buildMonitoringTabs() {
    return Container(
      decoration: const BoxDecoration(
        color: DashboardTheme.bg,
        border: Border(
          bottom: BorderSide(color: Color(0xFFD1D5DB), width: 1),
        ),
      ),
      child: DefaultTabController(
        length: 3,
        initialIndex: _monitoringSubTab,
        child: TabBar(
          isScrollable: false,
          onTap: (index) => setState(() => _monitoringSubTab = index),
          labelColor: DashboardTheme.blueDark,
          unselectedLabelColor: Color(0xFF888888),
          indicatorColor: DashboardTheme.blueDark,
          indicatorWeight: 3,
          labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          labelPadding: EdgeInsets.zero,
          tabs: const [
            Tab(text: 'Employers'),
            Tab(text: 'Abuse Reports'),
            Tab(text: 'Contract Issues'),
          ],
        ),
      ),
    );
  }

  // ── Filter chips ──────────────────────────────────────────────────────────

  Widget _buildFilterChips() {
    final isAbuseTab = _monitoringSubTab == 1;
    final isContractTab = _monitoringSubTab == 2;
    final statusLabel = (isAbuseTab || isContractTab) ? 'Status' : 'Risk Level';
    final statusOpts =
        (isAbuseTab || isContractTab) ? statusOptions : riskLevelOptions;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: DashboardFilterChip(
              icon: Icons.location_on_outlined,
              label: widget.selectedCountry,
              onTap: () => showFilterModal(
                context: context,
                title: 'Country',
                options: countryOptions,
                selected: widget.selectedCountry,
                onSelect: widget.onCountryChanged,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DashboardFilterChip(
              icon: Icons.info_outline,
              label: widget.selectedStatus == 'All Status'
                  ? statusLabel
                  : widget.selectedStatus,
              onTap: () => showFilterModal(
                context: context,
                title: statusLabel,
                options: statusOpts,
                selected: widget.selectedStatus,
                onSelect: widget.onStatusChanged,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DashboardFilterChip(
              icon: Icons.filter_alt_outlined,
              label: widget.selectedDate,
              onTap: () => showFilterModal(
                context: context,
                title: 'Date',
                options: dateOptions,
                selected: widget.selectedDate,
                onSelect: widget.onDateChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Employers content ─────────────────────────────────────────────────────

  List<Widget> _buildEmployersContent() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'High-Risk Employers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Showing 5 of 103 employers',
              style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      ...List.generate(employersData.length, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: _buildEmployerCard(employersData[i]),
        );
      }),
      const SizedBox(height: 16),
      const DashboardPagination(),
      const SizedBox(height: 24),
    ];
  }

  Color _scoreBg(int score) {
    if (score >= 70) return DashboardTheme.redBg;
    if (score >= 40) return DashboardTheme.yellowBg;
    return DashboardTheme.greenBg;
  }

  Color _scoreFg(int score) {
    if (score >= 70) return DashboardTheme.red;
    if (score >= 40) return DashboardTheme.yellow;
    return DashboardTheme.green;
  }

  Widget _buildEmployerCard(Map<String, dynamic> employer) {
    final score = employer['score'] as int;
    final bg = _scoreBg(score);
    final fg = _scoreFg(score);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: Column(
        children: [
          // ── Header row ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: DashboardTheme.blueDark,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employer['name'] as String,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: DashboardTheme.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      employer['country'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        color: DashboardTheme.textSecondary,
                        height: 1.3,
                      ),
                    ),
                    Text(
                      'Last updated: ${employer['lastIncident'] as String}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: DashboardTheme.textSecondary,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // ── Score tile ──
              Container(
                width: 62,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      score.toString(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: fg,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SCORE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: fg,
                        letterSpacing: 0.5,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // ── Stats row – 3 bordered boxes ──
          Row(
            children: [
              _statBox('Active Workers', employer['workers'] as String),
              const SizedBox(width: 8),
              _statBox('Open Reports', employer['reports'] as String),
              const SizedBox(width: 8),
              _statBox('Violations', employer['violations'] as String),
            ],
          ),
          const SizedBox(height: 16),
          // ── View Case button ──
          GestureDetector(
            onTap: () => _showReviewModal(context, employer),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: DashboardTheme.blueDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'View Case',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD1D5DB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: DashboardTheme.blueDark,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: DashboardTheme.blueDark,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReviewModal(BuildContext ctx, Map<String, dynamic> employer) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.92,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: DashboardTheme.blueDark,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Icon(Icons.person_rounded,
                          color: Colors.white, size: 26),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employer['name'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            employer['country'] as String,
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xFF64748B)),
                          ),
                          const Text(
                            'Last Updated: Feb 25, 2026',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close,
                          size: 24, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Risk Overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DashboardTheme.blueDark,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 140,
                    child: CustomPaint(
                      painter: _RiskGaugePainter(
                          (employer['score'] as int).toDouble()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),
                          Text(
                            employer['score'].toString(),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const Text(
                            'Risk Score',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                text: 'Open Reports:  ',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0F172A)),
                              ),
                              TextSpan(
                                text: '7',
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xFF64748B)),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                text: 'Flagged Workers:  ',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0F172A)),
                              ),
                              TextSpan(
                                text: '45',
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xFF64748B)),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Row(children: [
                          Text('View All Reports',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: DashboardTheme.blueDark)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward,
                              size: 12, color: DashboardTheme.blueDark),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text('View Workers',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: DashboardTheme.blueDark)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward,
                              size: 12, color: DashboardTheme.blueDark),
                        ]),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Violations and Actions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DashboardTheme.blueDark,
                  ),
                ),
                const SizedBox(height: 12),
                _buildViolationBar('Wage Withholding'),
                const SizedBox(height: 8),
                _buildViolationBar('Passport Confiscation'),
                const SizedBox(height: 8),
                _buildViolationBar('Contract Substitution'),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Embassy Notes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DashboardTheme.blueDark,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: const TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Add internal notes...',
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: DashboardTheme.blueDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Mark as Reviewed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViolationBar(String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: DashboardTheme.blueLight,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: DashboardTheme.blueDark.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: DashboardTheme.blueDark,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: DashboardTheme.blueDark,
            ),
          ),
        ],
      ),
    );
  }

  // ── Abuse Reports content ─────────────────────────────────────────────────

  List<Widget> _buildAbuseReportsContent() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Abuse Reports',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Showing 5 out of 67 reports',
              style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      ...List.generate(abuseReportsData.length, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: _buildAbuseReportCard(abuseReportsData[i]),
        );
      }),
      const SizedBox(height: 16),
      const DashboardPagination(),
      const SizedBox(height: 24),
    ];
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Investigation':
        return DashboardTheme.yellow;
      case 'In Review':
        return DashboardTheme.blueDark;
      case 'Resolved':
        return DashboardTheme.green;
      default:
        return DashboardTheme.blueDark;
    }
  }

  Color _statusBgColor(String status) {
    switch (status) {
      case 'Investigation':
        return DashboardTheme.yellowBg;
      case 'In Review':
        return DashboardTheme.blueLight;
      case 'Resolved':
        return DashboardTheme.greenBg;
      default:
        return DashboardTheme.blueLight;
    }
  }

  Widget _buildAbuseReportCard(Map<String, String> report) {
    final status = report['status']!;
    final statusBg = _statusBgColor(status);
    final statusFg = _statusColor(status);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: DashboardTheme.blueDark,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report['name']!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: DashboardTheme.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      report['employer']!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: DashboardTheme.textSecondary,
                        height: 1.3,
                      ),
                    ),
                    Text(
                      report['dateFiled']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: DashboardTheme.textSecondary,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // ── Status chip ──
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusFg,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // ── Two stat boxes ──
          Row(
            children: [
              _abuseStatBox('Report ID', report['reportId']!),
              const SizedBox(width: 10),
              _abuseStatBox('Abuse type', report['abuseType']!),
            ],
          ),
          const SizedBox(height: 16),
          // ── View Case button ──
          GestureDetector(
            onTap: () => _showAbuseReportModal(context, report),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: DashboardTheme.blueDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'View Case',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _abuseStatBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD1D5DB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: DashboardTheme.blueDark,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: DashboardTheme.blueDark,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAbuseReportModal(BuildContext ctx, Map<String, String> report) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.78,
        maxChildSize: 0.92,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            report['reportId']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            report['abuseType']!,
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close,
                          size: 24, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Worker Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                const ProfileRow(label: 'Name:', value: 'Maria Santos'),
                const ProfileRow(label: 'Age:', value: '32'),
                const ProfileRow(label: 'Nationality:', value: 'Filipino'),
                const ProfileRow(
                    label: 'Employer:', value: 'Al Noor Recruitment Co.'),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Incident Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Worker reports 3 months of unpaid wages. Passport confiscated upon arrival. Employer threatening deportation.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Text(
                      'Incident Date: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      'Feb 15, 2026',
                      style: TextStyle(fontSize: 12, color: Color(0xFF3730A3)),
                    ),
                    SizedBox(width: 24),
                    Text(
                      'Filed: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      'Mar 4, 2026',
                      style: TextStyle(fontSize: 12, color: Color(0xFF3730A3)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Case Timeline',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 16),
                const TimelineItem(
                    date: 'Feb 15, 2026', description: 'Incident occurred'),
                const TimelineItem(
                    date: 'Mar 4, 2026',
                    description: 'Report filed with embassy'),
                const TimelineItem(
                    date: 'Mar 5, 2026',
                    description: 'Case assigned to officer'),
                const TimelineItem(
                    date: 'Mar 5, 2026',
                    description: 'Initial assessment completed',
                    showLine: false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Contract Issues content ───────────────────────────────────────────────

  List<Widget> _buildContractIssuesContent() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Contract Issue Reports',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Showing 4 flagged contracts',
              style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      ...List.generate(contractIssuesData.length, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: _buildContractCard(contractIssuesData[i]),
        );
      }),
      const SizedBox(height: 16),
      const DashboardPagination(),
      const SizedBox(height: 24),
    ];
  }

  Color _contractStatusColor(String status) {
    switch (status) {
      case 'Legal Review':
        return DashboardTheme.red;
      case 'Mediation':
        return DashboardTheme.yellow;
      case 'Resolved':
        return DashboardTheme.green;
      default:
        return DashboardTheme.blueDark;
    }
  }

  Color _contractStatusBgColor(String status) {
    switch (status) {
      case 'Legal Review':
        return DashboardTheme.redBg;
      case 'Mediation':
        return DashboardTheme.yellowBg;
      case 'Resolved':
        return DashboardTheme.greenBg;
      default:
        return DashboardTheme.blueLight;
    }
  }

  Widget _buildContractCard(Map<String, String> contract) {
    final status = contract['status']!;
    final statusBg = _contractStatusBgColor(status);
    final statusFg = _contractStatusColor(status);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: DashboardTheme.blueDark,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contract['name']!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: DashboardTheme.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      contract['employer']!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: DashboardTheme.textSecondary,
                        height: 1.3,
                      ),
                    ),
                    Text(
                      contract['dateFiled']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: DashboardTheme.textSecondary,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // ── Status chip ──
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusFg,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // ── Two stat boxes ──
          Row(
            children: [
              _abuseStatBox('Contract ID', contract['contractId']!),
              const SizedBox(width: 10),
              _abuseStatBox('Issue Type', contract['issueType']!),
            ],
          ),
          const SizedBox(height: 16),
          // ── View Case button ──
          GestureDetector(
            onTap: () => _showContractModal(context, contract),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: DashboardTheme.blueDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'View Case',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showContractModal(BuildContext ctx, Map<String, String> contract) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.72,
        maxChildSize: 0.92,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: DashboardTheme.blueDark,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Icon(Icons.person_rounded,
                          color: Colors.white, size: 26),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contract['name']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: DashboardTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            contract['contractId']!,
                            style: const TextStyle(
                                fontSize: 13, color: DashboardTheme.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close,
                          size: 24, color: DashboardTheme.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Contract Comparison',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DashboardTheme.blueDark,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: const BoxDecoration(
                          color: DashboardTheme.blueDark,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        child: Row(
                          children: const [
                            Expanded(
                                flex: 2,
                                child: Text('Field',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white))),
                            Expanded(
                                flex: 3,
                                child: Text('Original Terms',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white))),
                            Expanded(
                                flex: 3,
                                child: Text('Actual Reports',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white))),
                          ],
                        ),
                      ),
                      _comparisonRow('Position', 'Administrative Assistant',
                          'Domestic Helper'),
                      _comparisonRow(
                          'Salary', '2500 AED/month1', '1200 AED/month1'),
                      _comparisonRow('Work Time', '8 hours/day, 5 days/week',
                          '14 hours/day, 6 days/week'),
                      _comparisonRow('Housing', 'Housing Provided by employer',
                          'One room, 6 occupants'),
                      _comparisonRow('Benefits',
                          'Health insurance, annual leave', 'None provided'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Official Notes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DashboardTheme.blueDark,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: const TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Add notes about this contract issue...',
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: DashboardTheme.blueDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Send to Labor Officer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _comparisonRow(String field, String original, String actual) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              field,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF334155),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              original,
              style: const TextStyle(
                fontSize: 11,
                color: DashboardTheme.blueDark,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              actual,
              style: const TextStyle(
                fontSize: 11,
                color: DashboardTheme.blueDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Risk gauge painter ─────────────────────────────────────────────────────

class _RiskGaugePainter extends CustomPainter {
  final double score;
  _RiskGaugePainter(this.score);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.75);
    final radius = size.width * 0.38;
    const startAngle = 0.8 * pi;
    const totalSweep = 1.4 * pi;
    const strokeW = 14.0;

    final bgPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      totalSweep,
      false,
      bgPaint,
    );

    final scoreSweep = totalSweep * (score / 100).clamp(0.0, 1.0);
    final fgPaint = Paint()
      ..color = const Color(0xFFE8552D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      scoreSweep,
      false,
      fgPaint,
    );

    final endAngle = startAngle + scoreSweep;
    final dotX = center.dx + radius * cos(endAngle);
    final dotY = center.dy + radius * sin(endAngle);
    canvas.drawCircle(
      Offset(dotX, dotY),
      strokeW / 2 + 2,
      Paint()..color = const Color(0xFFE8552D),
    );
  }

  @override
  bool shouldRepaint(covariant _RiskGaugePainter oldDelegate) =>
      oldDelegate.score != score;
}
