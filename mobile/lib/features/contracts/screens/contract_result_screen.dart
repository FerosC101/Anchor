import 'package:flutter/material.dart';

import '../../../models/scan_model.dart';
import '../../../shared/utils/risk_utils.dart';
import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/worker_drawer.dart';
import 'contract_scan_detail_screen.dart';

class ContractResultScreen extends StatelessWidget {
  const ContractResultScreen({super.key, required this.scan});

  final ScanModel scan;

  @override
  Widget build(BuildContext context) {
    final riskColor = RiskUtils.getRiskColor(scan.score);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const WorkerAppBar(showBackButton: true),
      endDrawer: const WorkerDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contract Analysis Result',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scan.fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${scan.subtitle} • ${scan.score}%',
                    style: TextStyle(
                      color: riskColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    scan.overviewSummary ??
                        'Analysis complete. Open full details for clause-by-clause guidance.',
                    style: const TextStyle(color: Color(0xFF334155)),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ContractScanDetailScreen(scan: scan),
                    ),
                  );
                },
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Open Full Analysis'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
