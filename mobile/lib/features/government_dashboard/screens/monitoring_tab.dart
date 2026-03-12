import 'dart:math';
import 'package:flutter/material.dart';
import '../components/dashboard_filter_chips.dart';
import '../components/dashboard_header.dart';
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
    return SafeArea(
      child: Column(
        children: [
          const DashboardHeader(),
          Expanded(
            child: SingleChildScrollView(
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
            ),
          ),
        ],
      ),
    );
  }

  // ── Sub-tabs ──────────────────────────────────────────────────────────────

  Widget _buildMonitoringTabs() {
    const tabs = ['Employers', 'Abuse Reports', 'Contract Issues'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: List.generate(tabs.length, (i) {
            final selected = _monitoringSubTab == i;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _monitoringSubTab = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color:
                        selected ? DashboardTheme.purple : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    tabs[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                ),
              ),
            );
          }),
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

  Color _scoreColor(int score) {
    if (score >= 90) return const Color(0xFFEF4444);
    if (score >= 40 && score <= 60) return const Color(0xFF3730A3);
    return const Color(0xFF10B981);
  }

  Widget _buildEmployerCard(Map<String, dynamic> employer) {
    final score = employer['score'] as int;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: DashboardTheme.cardDecoration,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF94A3B8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employer['name'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      employer['country'] as String,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _scoreColor(score),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  score.toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              StatColumn(
                  label: 'Active Workers',
                  value: employer['workers'] as String),
              StatColumn(
                  label: 'Open Reports', value: employer['reports'] as String),
              StatColumn(
                  label: 'Violations', value: employer['violations'] as String),
              StatColumn(
                  label: 'Last Incident',
                  value: employer['lastIncident'] as String),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => _showReviewModal(context, employer),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: DashboardTheme.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Review',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
                      decoration: const BoxDecoration(
                        color: Color(0xFF334155),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_rounded,
                          color: Colors.white, size: 28),
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
                    color: Color(0xFF3730A3),
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
                                  color: Color(0xFF3730A3))),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward,
                              size: 12, color: Color(0xFF3730A3)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text('View Workers',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF3730A3))),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward,
                              size: 12, color: Color(0xFF3730A3)),
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
                    color: Color(0xFF3730A3),
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
                    color: Color(0xFF3730A3),
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
                      color: const Color(0xFF3730A3),
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
        gradient: const LinearGradient(
          colors: [Color(0xFF7B6FCC), Color(0xFF3730A3)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
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
        return const Color(0xFF3730A3);
      case 'In Review':
        return DashboardTheme.red;
      case 'Resolved':
        return DashboardTheme.green;
      default:
        return const Color(0xFF64748B);
    }
  }

  Color _statusBgColor(String status) {
    switch (status) {
      case 'Investigation':
        return const Color(0xFFEEF2FF);
      case 'In Review':
        return const Color(0xFFFEF2F2);
      case 'Resolved':
        return const Color(0xFFECFDF5);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Widget _buildAbuseReportCard(Map<String, String> report) {
    final status = report['status']!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: DashboardTheme.cardDecoration,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF94A3B8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report['name']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      report['employer']!,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusBgColor(status),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _statusColor(status), width: 1),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _statusColor(status),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              StatColumn(label: 'Report ID', value: report['reportId']!),
              StatColumn(label: 'Abuse Type', value: report['abuseType']!),
              StatColumn(label: 'Date Filed', value: report['dateFiled']!),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => _showAbuseReportModal(context, report),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: DashboardTheme.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'View Report',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
        return const Color(0xFF3730A3);
      case 'Resolved':
        return DashboardTheme.green;
      default:
        return const Color(0xFF64748B);
    }
  }

  Color _contractStatusBgColor(String status) {
    switch (status) {
      case 'Legal Review':
        return const Color(0xFFFEF2F2);
      case 'Mediation':
        return const Color(0xFFEEF2FF);
      case 'Resolved':
        return const Color(0xFFECFDF5);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Widget _buildContractCard(Map<String, String> contract) {
    final status = contract['status']!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: DashboardTheme.cardDecoration,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF94A3B8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contract['name']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      contract['employer']!,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _contractStatusBgColor(status),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: _contractStatusColor(status), width: 1),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _contractStatusColor(status),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              StatColumn(label: 'Contract ID', value: contract['contractId']!),
              StatColumn(label: 'Issue Type', value: contract['issueType']!),
              StatColumn(label: 'Date Filed', value: contract['dateFiled']!),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => _showContractModal(context, contract),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: DashboardTheme.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'View Contract',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contract['contractId']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Carlos Rivera',
                            style: TextStyle(
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
                  'Contract Comparison',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
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
                          color: Color(0xFF3730A3),
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
                    color: Color(0xFF3730A3),
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
                      color: const Color(0xFF3730A3),
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
                color: Color(0xFF3730A3),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              actual,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF3730A3),
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
