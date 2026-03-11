import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/community_post_card.dart';
import '../../../shared/widgets/anchor_app_bar.dart';
import '../../../shared/widgets/anchor_drawer.dart';

class CommunitySafetyScreen extends StatefulWidget {
  const CommunitySafetyScreen({super.key});

  @override
  State<CommunitySafetyScreen> createState() => _CommunitySafetyScreenState();
}

class _CommunitySafetyScreenState extends State<CommunitySafetyScreen> {
  // ── Colors ──────────────────────────────────────────────────────────────────
  static const Color _purple = Color(0xFF8575B6);
  static const Color _purpleDark = Color(0xFF3D3790);
  static const Color _bg = Color(0xFFF5F5F5);
  static const Color _alertRed = Color(0xFFD32F2F);

  // ── Sample data ─────────────────────────────────────────────────────────────
  final List<Map<String, dynamic>> _posts = [
    {
      'company': 'BuildRite Construction',
      'description':
          'Salary delayed for 2 months. Dormitory has no clean water supply...',
      'tags': ['#DelayedSalary', '#UnsafeDorm'],
      'time': '17 hours ago',
      'location': 'Location',
      'upvotes': 45,
      'comments': 12,
    },
    {
      'company': 'BuildRite Construction',
      'description':
          'Salary delayed for 2 months. Dormitory has no clean water supply...',
      'tags': ['#DelayedSalary', '#UnsafeDorm'],
      'time': '17 hours ago',
      'location': 'Location',
      'upvotes': 45,
      'comments': 12,
    },
    {
      'company': 'BuildRite Construction',
      'description':
          'Salary delayed for 2 months. Dormitory has no clean water supply...',
      'tags': ['#DelayedSalary', '#UnsafeDorm'],
      'time': '17 hours ago',
      'location': 'Location',
      'upvotes': 45,
      'comments': 12,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: const AnchorAppBar(
        title: 'Community Safety',
        subtitle: 'Anonymous intel from fellow workers.',
      ),
      endDrawer: const AnchorDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMapCard(),
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
          ..._posts.map((post) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CommunityPostCard(
                  company: post['company'],
                  description: post['description'],
                  tags: List<String>.from(post['tags']),
                  time: post['time'],
                  location: post['location'],
                  upvotes: post['upvotes'],
                  comments: post['comments'],
                  onTap: () {
                    context.push('/community/post-detail');
                  },
                ),
              )),
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

  Widget _buildMapCard() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFC5CAE9),
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
          // Map placeholder with subtle pattern
          Center(
            child: Icon(
              Icons.map_outlined,
              size: 80,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
          // View Risk Map button
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    color: _purpleDark,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'View Risk Map',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _purpleDark,
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

  // ── Submit Report Modal ──────────────────────────────────────────────────────

  void _showSubmitReportModal() {
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
                    borderSide: const BorderSide(color: _purple, width: 2),
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
                decoration: InputDecoration(
                  hintText: 'City or Area',
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
                    borderSide: const BorderSide(color: _purple, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Risk Level
              const Text(
                'Risk Level',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: 'Medium',
                decoration: InputDecoration(
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
                    borderSide: const BorderSide(color: _purple, width: 2),
                  ),
                ),
                items: ['Low', 'Medium', 'High']
                    .map((level) => DropdownMenuItem(
                          value: level,
                          child: Text(level),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              // Description
              const Text(
                'Description*',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe the situation...',
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
                    borderSide: const BorderSide(color: _purple, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Tags
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
                    borderSide: const BorderSide(color: _purple, width: 2),
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
                        side: const BorderSide(color: Color(0xFFD7D2E7)),
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
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Report submitted successfully'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _purpleDark,
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
