import 'package:flutter/material.dart';
import '../core/ngo_theme.dart';
import '../models/ngo_models.dart';
import 'ngo_shared_widgets.dart';
import 'ngo_report_detail_sheet.dart';

class NgoMonitoringCard extends StatelessWidget {
  final NgoIncidentReport report;
  const NgoMonitoringCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final severityColor = report.severity == 'High'
      ? NgoTheme.escalatedText
      : report.severity == 'Medium'
        ? NgoTheme.pendingText
        : NgoTheme.resolvedText;
    final credibilityPct = (report.credibility * 100).round();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NgoTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Worker header row
          Row(
            children: [
              ngoAvatar(report.workerName),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.workerName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded,
                            size: 13, color: Color(0xFF94A3B8)),
                        const SizedBox(width: 2),
                        Text(
                          report.country,
                          style: const TextStyle(
                              fontSize: 12, color: NgoTheme.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ngoStatusBadge(report.status),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),

          // Detail rows
          ngoDetailRow('Employer:', report.employer),
          const SizedBox(height: 4),
          ngoDetailRow('Issue:', report.issue),
          const SizedBox(height: 4),
          ngoDetailRow('Report ID:', report.reportId,
              valueColor: NgoTheme.navy),
          const SizedBox(height: 4),

          // Severity row
          Row(
            children: [
              const SizedBox(
                width: 80,
                child: Text(
                  'Severity:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    color: severityColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(
                report.severity,
                style:
                    const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Credibility label + percentage
          Row(
            children: [
              const Text(
                'Credibility:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const Spacer(),
              Text(
                '$credibilityPct%',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: NgoTheme.resolvedText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: report.credibility,
              minHeight: 6,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(NgoTheme.navy),
            ),
          ),
          const SizedBox(height: 14),

          // Action buttons
          Row(
            children: [
              Expanded(
                flex: 6,
                child: SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () =>
                        showNgoReportDetailSheet(context, report),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NgoTheme.navy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'View Case',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NgoTheme.blueLight,
                      foregroundColor: NgoTheme.blueDark,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
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
}
