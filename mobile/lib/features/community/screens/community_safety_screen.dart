import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../providers/community_provider.dart';
import '../../../models/post_model.dart';
import '../../../models/report_model.dart';
import '../../../shared/widgets/community_post_card.dart';
import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/worker_drawer.dart';

class CommunitySafetyScreen extends ConsumerStatefulWidget {
  const CommunitySafetyScreen({super.key});

  @override
  ConsumerState<CommunitySafetyScreen> createState() =>
      _CommunitySafetyScreenState();
}

class _CommunitySafetyScreenState extends ConsumerState<CommunitySafetyScreen> {
  // ── Colors ──────────────────────────────────────────────────────────────────
  static const Color _blueMid = Color(0xFF003696);
  static const Color _blue = Color(0xFF003696);
  static const Color _bg = Color(0xFFF5F5F5);
  static const Color _alertRed = Color(0xFF8E0012);

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(communityPostsProvider);
    final List<RiskPoint> riskPoints =
        ref.watch(riskMapPointsProvider).valueOrNull ?? <RiskPoint>[];
    final highRiskCount = riskPoints.where((p) => p.score >= 70).length;

    return Scaffold(
      backgroundColor: _bg,
      appBar: const WorkerAppBar(),
      endDrawer: const WorkerDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Community Safety',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () => context.push('/community/my-reports'),
                  icon: const Icon(Icons.receipt_long_outlined, size: 16),
                  label: const Text('My Reports'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
          _buildMapCard(
            totalReports: riskPoints.length,
            highRiskReports: highRiskCount,
            riskPoints: riskPoints,
          ),
          const SizedBox(height: 24),
          const Text(
            'Recent Reports',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 12),
          ...postsAsync.when(
            loading: () => [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
            error: (e, _) => [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Failed to load community reports: $e',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
            data: (posts) {
              if (posts.isEmpty) {
                return [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('No reports yet. Be the first to submit one.'),
                  ),
                ];
              }
              return posts
                  .map(
                    (post) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildPostCard(post),
                    ),
                  )
                  .toList();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'community_fab',
        onPressed: _showSubmitReportModal,
        backgroundColor: _alertRed,
        child: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────────

  // ── Map Card ─────────────────────────────────────────────────────────────────

  Widget _buildMapCard({
    required int totalReports,
    required int highRiskReports,
    required List<RiskPoint> riskPoints,
  }) {
    final pointsWithCoords = riskPoints
        .where((p) => p.latitude != null && p.longitude != null)
        .toList();

    final topLocations = riskPoints
        .where((p) => p.location.trim().isNotEmpty)
        .map((p) => p.location.trim())
        .toSet()
        .take(3)
        .toList();

    return GestureDetector(
      onTap: () => context.push('/community/risk-map'),
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          color: const Color(0xFFDFEDFF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _buildMapPreview(pointsWithCoords),
              ),
            ),
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.65),
                      Colors.white.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.22),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.public_outlined,
                            color: Color(0xFF003696), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Risk Map Overview',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF003696),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$highRiskReports high-risk reports detected',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      totalReports == 0
                          ? 'No reports yet. Tap to open map and start reporting.'
                          : 'Tap to open the full risk map with live report markers.',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const Spacer(),
                    if (topLocations.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: topLocations
                            .map(
                              (loc) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  loc,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF003696),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$highRiskReports high-risk • $totalReports total',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF003696),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Open full map',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapPreview(List<RiskPoint> pointsWithCoords) {
    if (pointsWithCoords.isEmpty) {
      return Container(
        color: const Color(0xFFDFEDFF),
      );
    }

    final first = pointsWithCoords.first;
    final target = latlng.LatLng(first.latitude!, first.longitude!);

    final markers = pointsWithCoords.take(30).map((point) {
      final color = point.score >= 70
          ? Colors.red
          : point.score >= 40
              ? Colors.orange
              : Colors.green;

      return Marker(
        point: latlng.LatLng(point.latitude!, point.longitude!),
        width: 14,
        height: 14,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
          ),
        ),
      );
    }).toList();

    return IgnorePointer(
      child: FlutterMap(
        options: MapOptions(initialCenter: target, initialZoom: 5.8),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.anchor.app',
          ),
          MarkerLayer(markers: markers),
        ],
      ),
    );
  }

  Widget _buildPostCard(CommunityPostModel post) {
    return CommunityPostCard(
      company: post.company,
      description: post.description,
      tags: post.tags,
      time: _timeAgo(post.createdAt),
      location: post.location,
      upvotes: post.upvotes,
      comments: post.comments,
      onTap: () {
        context.push('/community/post-detail/${post.id}');
      },
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(date);
  }

  // ── Submit Report Modal ──────────────────────────────────────────────────────

  void _showSubmitReportModal() {
    final companyController = TextEditingController();
    final locationController = TextEditingController();
    final descriptionController = TextEditingController();
    final tagsController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Submit Safety Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Report workplace safety concerns anonymously',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              // Employer Name
              const Text(
                'Employer Name*',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: companyController,
                decoration: InputDecoration(
                  hintText: 'Company Name',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: _blueMid, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Location
              const Text(
                'Location*',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'e.g. Dubai, UAE',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: _blueMid, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Issue Description*',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe what happened',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: _blueMid, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tags (comma-separated)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: tagsController,
                decoration: InputDecoration(
                  hintText: 'e.g. Delayed Salary, Unsafe Dorm',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: _blueMid, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        side: const BorderSide(color: Color(0xFFDFEDFF)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final company = companyController.text.trim();
                        final location = locationController.text.trim();
                        final description = descriptionController.text.trim();
                        final tags = tagsController.text
                            .split(',')
                            .map((e) => e.trim())
                            .where((e) => e.isNotEmpty)
                            .map((e) => e.startsWith('#') ? e : '#$e')
                            .toList();

                        if (company.isEmpty ||
                            location.isEmpty ||
                            description.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all required fields.'),
                            ),
                          );
                          return;
                        }

                        Navigator.pop(context);
                        try {
                          final actions =
                              ref.read(communityActionProvider.notifier);
                          await actions.submitCommunityReport(
                            company: company,
                            description: description,
                            location: location,
                            tags: tags,
                          );
                          await actions.submitUserReport(
                            title: 'Safety report: $company',
                            description: description,
                            location: location,
                            category: ReportCategory.safety,
                            anonymous: true,
                          );
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Report submitted successfully.'),
                              ),
                            );
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to submit report: $e'),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Submit Report',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
