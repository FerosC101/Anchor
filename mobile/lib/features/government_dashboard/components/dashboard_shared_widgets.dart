import 'package:flutter/material.dart';
import '../utils/dashboard_theme.dart';

/// Pagination row used by Monitoring and Assistance tabs.
class DashboardPagination extends StatelessWidget {
  const DashboardPagination({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.chevron_left, size: 18, color: Color(0xFF64748B)),
        SizedBox(width: 4),
        Text('Previous',
            style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
        SizedBox(width: 16),
        Text('Page 1 of 8',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A))),
        SizedBox(width: 16),
        Text('Next', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
        SizedBox(width: 4),
        Icon(Icons.chevron_right, size: 18, color: Color(0xFF64748B)),
      ],
    );
  }
}

/// Profile key-value row used in modals.
class ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

/// Timeline dot + line item used in modals.
class TimelineItem extends StatelessWidget {
  final String date;
  final String description;
  final bool showLine;

  const TimelineItem({
    super.key,
    required this.date,
    required this.description,
    this.showLine = true,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: DashboardTheme.blueDark,
                  shape: BoxShape.circle,
                ),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    color: DashboardTheme.blueDark,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Stat column used in employer/report cards (e.g. "Active Workers  340").
class StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const StatColumn({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}

/// Read-only field used in the Send Guidance modal.
class ReadOnlyField extends StatelessWidget {
  final String text;

  const ReadOnlyField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF0F172A),
        ),
      ),
    );
  }
}

/// Document row used in View Case modal.
class DocumentRow extends StatelessWidget {
  final String label;

  const DocumentRow({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: DashboardTheme.blueLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: DashboardTheme.blueDark,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'View',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: DashboardTheme.blueDark,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, size: 14, color: DashboardTheme.blueDark),
            ],
          ),
        ],
      ),
    );
  }
}
