import 'package:flutter/material.dart';

import '../../../models/notification_model.dart';
import '../../../shared/widgets/worker_app_bar.dart';

class AlertDetailScreen extends StatelessWidget {
  const AlertDetailScreen({super.key, required this.alert});

  final AppNotificationModel alert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WorkerAppBar(showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3F3),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Severity: ${alert.severity.name.toUpperCase()}',
                style: const TextStyle(
                  color: Color(0xFF8E0012),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              alert.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              alert.message,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF334155),
                height: 1.55,
              ),
            ),
            const SizedBox(height: 20),
            if (alert.targetRoute != null && alert.targetRoute!.isNotEmpty)
              SelectableText(
                'Suggested route: ${alert.targetRoute}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
          ],
        ),
      ),
    );
  }
}
