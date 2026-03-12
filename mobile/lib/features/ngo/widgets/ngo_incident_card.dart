import 'package:flutter/material.dart';
import '../core/ngo_theme.dart';
import '../models/ngo_models.dart';
import 'ngo_shared_widgets.dart';

class NgoIncidentCard extends StatelessWidget {
  final NgoIncidentReport report;
  const NgoIncidentCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
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
          // Worker info row
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
          ngoDetailRow('Employer:', report.employer),
          const SizedBox(height: 4),
          ngoDetailRow('Issue:', report.issue),
          const SizedBox(height: 4),
          ngoDetailRow('Report ID:', report.reportId,
              valueColor: const Color(0xFF9500FF)),
          const SizedBox(height: 14),
          // View Case button
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D3790),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text(
                'View Case',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
