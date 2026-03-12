import 'package:flutter/material.dart';
import '../core/ngo_theme.dart';
import '../models/ngo_models.dart';

// ── Avatar ───────────────────────────────────────────────────────────────────

Widget ngoAvatar(String name) {
  final initials = name.trim().split(' ').take(2).map((w) => w[0]).join('');
  return Container(
    width: 44,
    height: 44,
    decoration: const BoxDecoration(
      color: Color(0xFFE5E7EB),
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        initials.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Color(0xFF364153),
        ),
      ),
    ),
  );
}

// ── Status badge ─────────────────────────────────────────────────────────────

Widget ngoStatusBadge(NgoCaseStatus status) {
  Color bg;
  Color text;
  String label;
  switch (status) {
    case NgoCaseStatus.inReview:
      bg = const Color(0x332B7FFF);
      text = const Color(0xFF2B7FFF);
      label = 'In Review';
    case NgoCaseStatus.escalated:
      bg = NgoTheme.escalatedBg;
      text = NgoTheme.escalatedText;
      label = 'Escalated';
    case NgoCaseStatus.pending:
      bg = NgoTheme.pendingBg;
      text = NgoTheme.pendingText;
      label = 'Pending';
    case NgoCaseStatus.resolved:
      bg = NgoTheme.resolvedBg;
      text = NgoTheme.resolvedText;
      label = 'Resolved';
  }
  final bool isInReview = status == NgoCaseStatus.inReview;
  return Container(
    height: 24,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
      border: isInReview
          ? Border.all(color: const Color(0xFF2B7FFF), width: 1)
          : null,
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: text,
      ),
    ),
  );
}

// ── Detail row ───────────────────────────────────────────────────────────────

Widget ngoDetailRow(String label, String value, {Color? valueColor}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 80,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: valueColor ?? const Color(0xFF0F172A),
          ),
        ),
      ),
    ],
  );
}

// ── Section title ─────────────────────────────────────────────────────────────

Widget ngoSectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Color(0xFF0F172A),
    ),
  );
}

// ── Search bar ────────────────────────────────────────────────────────────────

class NgoSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const NgoSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2030),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14),
        decoration: const InputDecoration(
          hintText: 'Search worker by name or case ID',
          hintStyle: TextStyle(color: Color(0xFFADB5BD), fontSize: 14),
          prefixIcon:
              Icon(Icons.search_rounded, color: Color(0xFFADB5BD), size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 13),
        ),
      ),
    );
  }
}

// ── Filter chips ──────────────────────────────────────────────────────────────

class NgoFilterChips extends StatelessWidget {
  final String selectedCountry;
  final String selectedIssue;
  final String selectedStatus;
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onIssueChanged;
  final ValueChanged<String> onStatusChanged;

  const NgoFilterChips({
    super.key,
    required this.selectedCountry,
    required this.selectedIssue,
    required this.selectedStatus,
    required this.onCountryChanged,
    required this.onIssueChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _chip(
            context,
            icon: Icons.location_on_outlined,
            current: selectedCountry,
            options: [
              'All Countries',
              'Saudi Arabia',
              'UAE',
              'Qatar',
              'Kuwait',
              'Bahrain',
            ],
            onChanged: onCountryChanged,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _chip(
            context,
            icon: Icons.flag_outlined,
            current: selectedIssue,
            options: [
              'All Issues',
              'Wage Theft',
              'Document Confiscation',
              'Physical Abuse',
              'Overwork / Rest Day Denial',
            ],
            onChanged: onIssueChanged,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _chip(
            context,
            icon: Icons.tune_rounded,
            current: selectedStatus,
            options: [
              'All Status',
              'In Review',
              'Escalated',
              'Pending',
              'Resolved',
            ],
            onChanged: onStatusChanged,
          ),
        ),
      ],
    );
  }

  Widget _chip(
    BuildContext context, {
    required IconData icon,
    required String current,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return GestureDetector(
      onTap: () => _showFilterSheet(context, current, options, onChanged),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: const Color(0xFF64748B)),
            const SizedBox(width: 4),
            Text(
              current,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down_rounded,
                size: 14, color: Color(0xFF64748B)),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(
    BuildContext context,
    String current,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ...options.map(
              (o) => ListTile(
                title: Text(o),
                trailing: o == current
                    ? const Icon(Icons.check_rounded, color: NgoTheme.purple)
                    : null,
                onTap: () {
                  onChanged(o);
                  Navigator.pop(sheetCtx);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
