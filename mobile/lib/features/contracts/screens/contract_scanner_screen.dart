import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/utils/risk_utils.dart';
import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/worker_drawer.dart';
import '../../../models/contract_model.dart';
import '../../../models/scan_model.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/services/functions_service.dart';
import '../../../core/services/storage_service.dart';

class ContractScannerScreen extends StatefulWidget {
  const ContractScannerScreen({super.key});

  @override
  State<ContractScannerScreen> createState() => _ContractScannerScreenState();
}

class _ContractScannerScreenState extends State<ContractScannerScreen> {
  // ── Colors ──────────────────────────────────────────────────────────────────
  static const Color _blueMid = Color(0xFF003696);
  static const Color _blueLight = Color(0xFFDFEDFF);
  static const Color _bg = Color(0xFFF5F5F5);

  final _auth = FirebaseAuth.instance;
  final _firestoreService = FirestoreService();
  final _storageService = StorageService();
  final _functionsService = FunctionsService();

  // ── Data ───────────────────────────────────────────────────────────────────
  bool _isUploading = false;
  bool _showScans = true;

  final List<ScanModel> _recentScans = [];
  final List<ScanModel> _fallbackScans = const [
    ScanModel(
      id: 1001,
      name: 'Employment_Agreement.pdf',
      fullName: 'Employment_Agreement.pdf',
      subtitle: 'MEDIUM RISK',
      date: 'Mar 10',
      time: '2:35 PM',
      score: 58,
      issueCount: 3,
      criticalCount: 1,
    ),
    ScanModel(
      id: 1002,
      name: 'Work_Contract_Final.pdf',
      fullName: 'Work_Contract_Final.pdf',
      subtitle: 'LOW RISK',
      date: 'Mar 04',
      time: '10:12 AM',
      score: 24,
      issueCount: 1,
      criticalCount: 0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadRecentScans();
  }

  Future<void> _loadRecentScans() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    try {
      final scans = await _firestoreService.fetchRecentScans(userId: userId);
      if (!mounted || scans.isEmpty) return;
      setState(() {
        _recentScans
          ..clear()
          ..addAll(scans);
      });
    } catch (_) {
      // Ignore read failures in UI bootstrapping.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: const WorkerAppBar(),
      endDrawer: const WorkerDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
              child: Text(
                'Contract Reality Check',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
            _buildUploadArea(),
            const SizedBox(height: 24),
            _buildRecentScansSection(),
          ],
        ),
      ),
    );
  }

  // ── Upload Area ──────────────────────────────────────────────────────────────

  Widget _buildUploadArea() {
    return InkWell(
      onTap: _isUploading ? null : _uploadAndAnalyzeContract,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _blueMid.withValues(alpha: 0.3),
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
            if (_isUploading) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
            ],
            // Upload icon - larger
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _blueLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.upload_file_outlined,
                color: _blueMid,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _isUploading
                  ? 'Uploading and analyzing...'
                  : 'Tap to upload document',
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

  Future<void> _uploadAndAnalyzeContract() async {
    final user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in again to upload.')),
      );
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: kIsWeb ? FileType.any : FileType.custom,
      withData: true,
      allowedExtensions: kIsWeb ? null : ['pdf', 'jpg', 'jpeg', 'png', 'txt'],
    );

    if (result == null || result.files.isEmpty) return;

    final picked = result.files.first;
    final extension = picked.name.split('.').last.toLowerCase();
    const allowedExtensions = ['pdf', 'jpg', 'jpeg', 'png', 'txt'];
    if (!allowedExtensions.contains(extension)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Unsupported file type. Use PDF, JPG, PNG, or TXT.')),
      );
      return;
    }

    final size = picked.size;
    if (size > 10 * 1024 * 1024) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File too large. Maximum is 10MB.')),
      );
      return;
    }

    final path = picked.path;
    if (!kIsWeb && (path == null || path.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to read selected file path.')),
      );
      return;
    }

    if (kIsWeb && picked.bytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to read selected file data.')),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      final contractId = _firestoreService.newContractId();
      final fileName = picked.name;

      final fileUrl = await _storageService.uploadContractFile(
        userId: user.uid,
        contractId: contractId,
        filePath: path,
        fileBytes: picked.bytes,
        fileName: fileName,
      );

      await _firestoreService.createContractUpload(
        ContractUploadModel(
          contractId: contractId,
          userId: user.uid,
          fileName: fileName,
          fileUrl: fileUrl,
          uploadedAt: DateTime.now(),
        ),
      );

      final extractedText = (extension == 'txt' && picked.bytes != null)
          ? String.fromCharCodes(picked.bytes!)
          : '';

      final analysis = await _functionsService.analyzeContractUpload(
        contractId: contractId,
        fileUrl: fileUrl,
        fileName: fileName,
        extractedText: extractedText,
      );

      final now = DateTime.now();
      final score = (analysis.riskScore * 100).round().clamp(0, 100);

      final scan = ScanModel(
        id: now.millisecondsSinceEpoch,
        contractId: contractId,
        name: fileName,
        fullName: fileName,
        subtitle: analysis.riskLevel.toUpperCase(),
        date: _formatDate(now),
        time: _formatTime(now),
        score: score,
        issueCount: analysis.issueCount,
        criticalCount: analysis.criticalCount,
        overviewSummary: analysis.overviewSummary.isNotEmpty
            ? analysis.overviewSummary
            : analysis.aiSummary,
        comparisonItems: analysis.comparisonItems
            .map(
              (item) => ScanComparisonItem(
                category: item.category,
                status: item.status,
                yourContract: item.yourContract,
                standardPractice: item.standardPractice,
              ),
            )
            .toList(),
        recommendedActions: analysis.recommendedActions,
      );

      if (!mounted) return;
      setState(() {
        _recentScans.insert(0, scan);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            analysis.modelLoaded
                ? 'Contract analysis complete.'
                : 'Contract analysis complete (fallback scoring).',
          ),
        ),
      );

      context.push('/contracts/detail', extra: scan);
    } catch (error) {
      final raw = error.toString();
      final message = (kIsWeb &&
              (raw.contains('CORS') ||
                  raw.contains('XMLHttpRequest') ||
                  raw.contains('ERR_FAILED')))
          ? 'Upload blocked by Storage CORS. Apply bucket CORS config, then retry.'
          : 'Upload failed: $error';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  String _formatTime(DateTime date) {
    final hour12 = date.hour == 0
        ? 12
        : date.hour > 12
            ? date.hour - 12
            : date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final suffix = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour12:$minute $suffix';
  }

  // ── Recent Scans Section ─────────────────────────────────────────────────────

  Widget _buildRecentScansSection() {
    final scansToShow = _recentScans.isNotEmpty ? _recentScans : _fallbackScans;

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
                      color: _blueMid,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _showScans
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: _blueMid,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (_showScans) ...[
          const SizedBox(height: 12),
          ...scansToShow.map((scan) => Padding(
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
              color: const Color(0xFFDFEDFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.insert_drive_file_outlined,
              color: Color(0xFF003696),
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
