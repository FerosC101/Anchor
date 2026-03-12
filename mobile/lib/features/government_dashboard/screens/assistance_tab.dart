import 'package:flutter/material.dart';
import '../components/dashboard_filter_chips.dart';
import '../components/dashboard_header.dart';
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
                            color: Colors.black.withOpacity(0.06),
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
            ),
          ),
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

  Color _assistanceStatusColor(String status) {
    switch (status) {
      case 'In review':
        return const Color(0xFF3730A3);
      case 'Resolved':
        return DashboardTheme.green;
      case 'Critical':
        return DashboardTheme.red;
      default:
        return const Color(0xFF64748B);
    }
  }

  Color _assistanceStatusBg(String status) {
    switch (status) {
      case 'In review':
        return const Color(0xFFEEF2FF);
      case 'Resolved':
        return const Color(0xFFECFDF5);
      case 'Critical':
        return const Color(0xFFFEF2F2);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Widget _buildAssistanceCard(BuildContext context, Map<String, String> c) {
    final status = c['status']!;
    final isResolved = status == 'Resolved';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: DashboardTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      c['name']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      c['country']!,
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
                  color: _assistanceStatusBg(status),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _assistanceStatusColor(status), width: 1),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _assistanceStatusColor(status),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                text: 'Employer: ',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A)),
              ),
              TextSpan(
                text: c['employer']!,
                style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
            ]),
          ),
          const SizedBox(height: 2),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                text: 'Issue: ',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A)),
              ),
              TextSpan(
                text: c['issue']!,
                style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
            ]),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _showViewCaseModal(context, c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      gradient: DashboardTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'View Case',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: isResolved
                      ? () => _showViewCaseModal(context, c)
                      : () => _showSendGuidanceModal(context, c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color(0xFF3730A3), width: 1.5),
                    ),
                    child: Text(
                      isResolved ? 'View Case' : 'Send Guidance',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3730A3),
                      ),
                    ),
                  ),
                ),
              ),
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
                    color: Color(0xFF3730A3),
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
                    color: Color(0xFF3730A3),
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
                    color: Color(0xFF3730A3),
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
                    color: Color(0xFF3730A3),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Send Official Guidance',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'to Maria Santos',
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
                  'Worker Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                const ReadOnlyField(text: 'Maria Santos'),
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
                            color: const Color(0xFF3730A3),
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
