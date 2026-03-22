import 'package:flutter/material.dart';

import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/worker_drawer.dart';
import 'contract_scanner_screen.dart';

class UploadContractScreen extends StatelessWidget {
  const UploadContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const WorkerAppBar(showBackButton: true),
      endDrawer: const WorkerDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 520),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFEDFF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.upload_file_outlined,
                    size: 34,
                    color: Color(0xFF003696),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Upload Contract',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Use the contract scanner to upload your file and run AI analysis.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ContractScannerScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.scanner_outlined),
                    label: const Text('Open Contract Scanner'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
