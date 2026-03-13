import 'package:flutter/material.dart';
import '../core/ngo_theme.dart';
import '../models/ngo_models.dart';
import 'ngo_edit_alert_sheet.dart';
import 'ngo_shared_widgets.dart';

class NgoAlertCard extends StatelessWidget {
  final NgoAlert alert;
  const NgoAlertCard({super.key, required this.alert});

  Color _severityBg(String severity) {
    final value = severity.toLowerCase();
    if (value == 'high') return NgoTheme.escalatedBg;
    if (value == 'medium') return NgoTheme.pendingBg;
    return NgoTheme.resolvedBg;
  }

  Color _severityText(String severity) {
    final value = severity.toLowerCase();
    if (value == 'high') return NgoTheme.escalatedText;
    if (value == 'medium') return NgoTheme.pendingText;
    return NgoTheme.resolvedText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title ──
          Text(
            alert.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),

          // ── Employer row: icon + name/type + severity badge ──
          Row(
            children: [
              ngoGovProfileIconBadge(size: 42),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert.employerName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      alert.alertType,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              // HIGH severity badge
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _severityBg(alert.severity),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  alert.severity,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _severityText(alert.severity),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── Detail rows ──
          _detailRow('Target:', alert.target),
          const SizedBox(height: 6),
          _detailRow('Country:', alert.country),
          const SizedBox(height: 6),
          _detailRowRich('Alert ID:', alert.alertId, NgoTheme.navy),
          const SizedBox(height: 6),
          _detailRow('Created:', '${alert.createdDate} by ${alert.createdBy}'),
          const SizedBox(height: 12),

          // ── Description ──
          Text(
            alert.description,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF374151),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // ── Action buttons ──
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () =>
                        showEditAlertSheet(context, alert),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: NgoTheme.navy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Edit Alert',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 40,
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
                      'Delete',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13),
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

  Widget _detailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
          ),
        ),
      ],
    );
  }

  Widget _detailRowRich(String label, String value, Color valueColor) {
    return Row(
      children: [
        Text(
          '$label ',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
