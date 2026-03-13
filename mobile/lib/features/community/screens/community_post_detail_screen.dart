import 'package:flutter/material.dart';
import '../../../shared/widgets/worker_app_bar.dart';

class CommunityPostDetailScreen extends StatefulWidget {
  const CommunityPostDetailScreen({super.key});

  @override
  State<CommunityPostDetailScreen> createState() =>
      _CommunityPostDetailScreenState();
}

class _CommunityPostDetailScreenState extends State<CommunityPostDetailScreen> {
  // ── Colors ──────────────────────────────────────────────────────────────────
  static const Color _blueMid = Color(0xFF003696);
  static const Color _blueLight = Color(0xFFDFEDFF);
  static const Color _bg = Color(0xFFF5F5F5);

  // ── Sample data ─────────────────────────────────────────────────────────────
  final List<Map<String, dynamic>> _comments = [
    {
      'user': 'Anonymous User 1',
      'time': '5 hours ago',
      'body':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'upvotes': 45,
    },
    {
      'user': 'Anonymous User 1',
      'time': '5 hours ago',
      'body':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'upvotes': 45,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: const WorkerAppBar(showBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'Community Concerns',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildPostBody(),
            const SizedBox(height: 20),
            _buildCommentInput(),
            const SizedBox(height: 16),
            _buildCommentsList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────────────────

  // ── Post Body ────────────────────────────────────────────────────────────────

  Widget _buildPostBody() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
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
          // Company name and menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'BuildRite Construction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              Icon(Icons.more_vert_rounded, color: Colors.grey[600]),
            ],
          ),
          const SizedBox(height: 12),
          // Full body text
          Text(
            'Salary delayed for 2 months. Dormitory has no clean water supply. '
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor '
            'incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud '
            'exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
            'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu '
            'fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in '
            'culpa qui officia deserunt.',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF555555),
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _buildTag('#DelayedSalary'),
              _buildTag('#UnsafeDorm'),
            ],
          ),
          const SizedBox(height: 16),
          // Footer metadata
          Row(
            children: [
              Text(
                '17 hours ago',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(width: 12),
              Icon(Icons.location_on_outlined,
                  size: 14, color: Colors.grey[600]),
              Text(
                ' Location',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const Spacer(),
              Icon(Icons.arrow_upward_rounded, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 3),
              Text('45', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              const SizedBox(width: 10),
              Icon(Icons.chat_bubble_outline_rounded,
                  size: 15, color: Colors.grey[600]),
              const SizedBox(width: 3),
              Text('12', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _blueLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _blueMid,
        ),
      ),
    );
  }

  // ── Comment Input ────────────────────────────────────────────────────────────

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _blueLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Join the conversation...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send_rounded, color: _blueMid),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  // ── Comments List ────────────────────────────────────────────────────────────

  Widget _buildCommentsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _comments.map((comment) => _buildCommentTile(comment)).toList(),
      ),
    );
  }

  Widget _buildCommentTile(Map<String, dynamic> comment) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[600], size: 20),
          ),
          const SizedBox(width: 12),
          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username and menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment['user'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    Icon(Icons.more_vert_rounded,
                        size: 18, color: Colors.grey[600]),
                  ],
                ),
                const SizedBox(height: 2),
                // Timestamp
                Text(
                  comment['time'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                // Comment body
                Text(
                  comment['body'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                // Actions row
                Row(
                  children: [
                    Icon(Icons.arrow_upward_rounded,
                        size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '${comment['upvotes']}',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.reply_rounded, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      'reply',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
