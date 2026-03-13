import 'package:flutter/material.dart';
import '../components/dashboard_filter_chips.dart';
import '../components/dashboard_shared_widgets.dart';
import '../data/dashboard_data.dart';
import '../utils/dashboard_theme.dart';

class AssistanceTab extends StatelessWidget {
  final String selectedCountry;
  final String selectedStatus;
  final String selectedDate;
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStatusChanged;
  final ValueChanged<String> onDateChanged;

  const AssistanceTab({
    super.key,
    required this.selectedCountry,
    required this.selectedStatus,
    required this.selectedDate,
    required this.onCountryChanged,
    required this.onStatusChanged,
    required this.onDateChanged,
  });

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
              'Work Assistance',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search,
                              size: 20, color: Color(0xFF94A3B8)),
                          SizedBox(width: 10),
                          Text(
                            'Search worker by name or case ID',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAssistanceFilterChips(context),
                  const SizedBox(height: 16),
                  ...List.generate(assistanceCasesData.length, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      child:
                          _buildAssistanceCard(context, assistanceCasesData[i]),
                    );
                  }),
                  const SizedBox(height: 16),
                  const DashboardPagination(),
                  const SizedBox(height: 24),
                ],
              ),
            );
  }

  Widget _buildAssistanceFilterChips(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: DashboardFilterChip(
              icon: Icons.location_on_outlined,
              label: selectedCountry,
              onTap: () => showFilterModal(
                context: context,
                title: 'Country',
                options: countryOptions,
                selected: selectedCountry,
                onSelect: onCountryChanged,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DashboardFilterChip(
              icon: Icons.info_outline,
              label: selectedStatus == 'All Status'
                  ? 'All Issues'
                  : selectedStatus,
              onTap: () => showFilterModal(
                context: context,
                title: 'Issues',
                options: statusOptions,
                selected: selectedStatus,
                onSelect: onStatusChanged,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: DashboardFilterChip(
              icon: Icons.filter_alt_outlined,
              label: selectedDate == 'All Date' ? 'All Status' : selectedDate,
              onTap: () => showFilterModal(
                context: context,
                title: 'Status',
                options: dateOptions,
                selected: selectedDate,
                onSelect: onDateChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _assistanceStatusBg(String status) {
    switch (status) {
      case 'In review':
        return DashboardTheme.red;
      case 'Resolved':
        return DashboardTheme.green;
      case 'Critical':
        return DashboardTheme.red;
      default:
        return DashboardTheme.blueDark;
    }
  }

  Widget _buildAssistanceCard(BuildContext context, Map<String, String> c) {
    final status = c['status']!;
    final isResolved = status == 'Resolved';
    final issueTitle = isResolved ? 'Passport Retention' : 'Contract Substitution';
    final issueBg = isResolved ? DashboardTheme.redBg : DashboardTheme.yellowBg;
    final issueText = isResolved ? DashboardTheme.red : DashboardTheme.yellow;

    final statusLabel = switch (status) {
      'Critical' => 'HIGH',
      'Resolved' => 'RESOLVED',
      'In review' => 'HIGH',
      _ => status.toUpperCase(),
    };

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
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 17,
                          color: Color(0xFF111827),
                          height: 1.2,
                        ),
                        children: [
                          TextSpan(
                            text: c['name']!,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: '  ${c['country']!}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF8A8A8A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      c['employer']!,
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF8A8A8A), height: 1.25),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  color: _assistanceStatusBg(status),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  statusLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, thickness: 1, color: Color(0xFFE6E6E6)),
          const SizedBox(height: 14),
          Row(
            children: [
              const Text(
                'March 6, 2026',
                style: TextStyle(fontSize: 12, color: Color(0xFF8A8A8A)),
              ),
              const SizedBox(width: 14),
              const Icon(Icons.location_on, size: 17, color: Color(0xFFA3A3A3)),
              const SizedBox(width: 5),
              const Expanded(
                child: Text(
                  'Bangkok, Thailand',
                  style: TextStyle(fontSize: 12, color: Color(0xFF8A8A8A)),
                ),
              ),
              if (!isResolved)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: DashboardTheme.blueLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'In Review',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: DashboardTheme.blueDark,
                      height: 1,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              color: issueBg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  issueTitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: issueText,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Contract signed in home country differs from actual '
                  'employment terms. Salary reduced by 30% and impacted ${c['name']!}.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.35,
                    color: issueText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _showViewCaseModal(context, c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC7D5EB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'View Case',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF172B4D),
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
              if (!isResolved) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showSendGuidanceModal(context, c),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: DashboardTheme.blueDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Send Guidance',
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
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // ── View Case modal ───────────────────────────────────────────────────────

  void _showViewCaseModal(BuildContext ctx, Map<String, String> c) {
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
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c['name']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const Text(
                            'Case ID: WKR-2026-1342',
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
                  'Worker Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DashboardTheme.blueDark,
                  ),
                ),
                const SizedBox(height: 12),
                const ProfileRow(label: 'Name:', value: 'Maria Santos'),
                const ProfileRow(label: 'Nationality:', value: 'Filipino'),
                const ProfileRow(label: 'Passport Number:', value: 'P1234***'),
                const ProfileRow(
                    label: 'Employer:', value: 'Al Noor Recruitment Co.'),
                const ProfileRow(label: 'Job Title:', value: 'Domestic Helper'),
                const ProfileRow(
                    label: 'Contract Start:', value: 'Jan 15, 2025'),
                const ProfileRow(label: 'Contract End:', value: 'Jan 14, 2027'),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Case Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DashboardTheme.blueDark,
                  ),
                ),
                const SizedBox(height: 12),
                const ProfileRow(label: 'Case ID:', value: 'WKR-2026-1342'),
                const ProfileRow(label: 'Date Reported:', value: 'Mar 4, 2026'),
                const ProfileRow(
                    label: 'Issue Type:', value: 'Wage Withholding'),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Case Timeline',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DashboardTheme.blueDark,
                  ),
                ),
                const SizedBox(height: 16),
                const TimelineItem(
                    date: 'Mar 4, 2026',
                    description: 'Worker contacted embassy hotline'),
                const TimelineItem(
                    date: 'Mar 5, 2026',
                    description: 'Case assigned to officer Martinez'),
                const TimelineItem(
                    date: 'Mar 6, 2026',
                    description: 'Initial consultation conducted'),
                const TimelineItem(
                    date: 'Mar 7, 2026',
                    description: 'Legal rights guidance sent to worker',
                    showLine: false),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Linked Documents',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: DashboardTheme.blueDark,
                  ),
                ),
                const SizedBox(height: 12),
                const DocumentRow(label: 'Employment Contract'),
                const SizedBox(height: 8),
                const DocumentRow(label: 'Job Offer Letter'),
                const SizedBox(height: 8),
                const DocumentRow(label: 'Passport Copy'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Send Guidance modal ───────────────────────────────────────────────────

  void _showSendGuidanceModal(BuildContext ctx, Map<String, String> c) {
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
                          const Text(
                            'Send Official Guidance',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: DashboardTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'to ${c['name']!}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: DashboardTheme.textSecondary,
                            ),
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
                  'Worker Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                ReadOnlyField(text: c['name']!),
                const SizedBox(height: 16),
                const Text(
                  'Case ID',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                const ReadOnlyField(text: 'WKR-2026-1342'),
                const SizedBox(height: 16),
                const Text(
                  'Guidance Type *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Select Guidance Type...',
                        style:
                            TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                      ),
                      Icon(Icons.keyboard_arrow_down,
                          size: 20, color: Color(0xFF94A3B8)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Guidance Message *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: const TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Type your message here...',
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: 'Note: ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A)),
                    ),
                    TextSpan(
                      text:
                          'This will be sent directly to the worker via their registered contact method.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ]),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xFFE2E8F0), width: 1.5),
                          ),
                          child: const Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: DashboardTheme.blueDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Send Guidance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
