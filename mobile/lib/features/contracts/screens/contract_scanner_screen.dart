import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/utils/risk_utils.dart';
import '../../../shared/widgets/anchor_app_bar.dart';
import '../../../shared/widgets/anchor_drawer.dart';
import '../../../models/scan_model.dart';

class ContractScannerScreen extends StatefulWidget {
  const ContractScannerScreen({super.key});

  @override
  State<ContractScannerScreen> createState() => _ContractScannerScreenState();
}

class _ContractScannerScreenState extends State<ContractScannerScreen> {
  // ── Colors ──────────────────────────────────────────────────────────────────
  static const Color _purple = Color(0xFF8575B6);
  static const Color _purpleLight = Color(0xFFD7D2E7);
  static const Color _bg = Color(0xFFF5F5F5);

  // ── Sample data ─────────────────────────────────────────────────────────────
  bool _showScans = true;

  final List<ScanModel> _recentScans = [
    ScanModel(
      id: 1,
      name: 'TechSafe Build',
      fullName: 'TechSafe Build Contract',
      subtitle: 'Savings Goal (Return Home)',
      date: 'March 1',
      time: '10:14 AM',
      score: 74,
    ),
    ScanModel(
      id: 2,
      name: 'TechSafe Build',
      fullName: 'TechSafe Build Contract',
      subtitle: 'Savings Goal (Return Home)',
      date: 'March 1',
      time: '12:27 PM',
      score: 22,
    ),
    ScanModel(
      id: 3,
      name: 'TechSafe Build',
      fullName: 'TechSafe Build Contract',
      subtitle: 'Savings Goal (Return Home)',
      date: 'March 1',
      time: '09:03 AM',
      score: 38,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: const AnchorAppBar(
        title: 'Contract Reality Check',
        subtitle: 'Upload your contract or salary slip to detect hidden risks.',
      ),
      endDrawer: const AnchorDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPageHeader(),
            const SizedBox(height: 24),
            _buildUploadArea(),
            const SizedBox(height: 24),
            _buildRecentScansSection(),
          ],
        ),
      ),
    );
  }

  // ── Page Header ──────────────────────────────────────────────────────────────

  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contract Reality Check',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Upload your contract or salary slip to detect hidden risks.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  // ── Upload Area ──────────────────────────────────────────────────────────────

  Widget _buildUploadArea() {
    return InkWell(
      onTap: () {
        // Handle file upload
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File picker would open here')),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _purple.withValues(alpha: 0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Upload icon - larger
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _purpleLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.upload_file_outlined,
                color: _purple,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tap to upload document',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Supports PDF, JPG, PNG (Max 10MB)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Recent Scans Section ─────────────────────────────────────────────────────

  Widget _buildRecentScansSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Previous Scans',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() => _showScans = !_showScans);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _showScans ? 'Hide' : 'Show',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: _purple,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _showScans
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: _purple,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (_showScans) ...[
          const SizedBox(height: 12),
          ..._recentScans.map((scan) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    context.push('/contracts/detail', extra: scan);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: _buildScanResultCard(scan),
                ),
              )),
        ],
      ],
    );
  }

  // ── Scan Result Card ─────────────────────────────────────────────────────────

  Widget _buildScanResultCard(ScanModel scan) {
    final score = scan.score;
    final riskColor = RiskUtils.getRiskColor(score);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // LEFT: document icon square
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFD7D2E7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.insert_drive_file_outlined,
              color: Color(0xFF3D3790),
              size: 26,
            ),
          ),
          const SizedBox(width: 12),
          // CENTER
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scan.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  scan.subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  scan.date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          // RIGHT: score badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                score.toString(),
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: riskColor,
                ),
              ),
              Text(
                'SCORE',
                style: TextStyle(
                  fontSize: 10,
                  color: riskColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
