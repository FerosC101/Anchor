import 'package:flutter/material.dart';

class CommunityPostCard extends StatelessWidget {
  final String company;
  final String description;
  final List<String> tags;
  final String time;
  final String location;
  final int upvotes;
  final int comments;
  final VoidCallback? onTap;

  const CommunityPostCard({
    super.key,
    required this.company,
    required this.description,
    required this.tags,
    required this.time,
    required this.location,
    required this.upvotes,
    required this.comments,
    this.onTap,
  });

  static const Color _blueMid = Color(0xFF003696);
  static const Color _blueLight = Color(0xFFDFEDFF);
  static const Color _textSecondary = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
            // Title row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  company,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const Icon(Icons.more_vert_rounded,
                    size: 20, color: _textSecondary),
              ],
            ),
            const SizedBox(height: 6),
            // Body
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF374151),
                  height: 1.45,
                ),
                children: [
                  TextSpan(text: description),
                  const TextSpan(
                    text: 'read more',
                    style: TextStyle(color: _blueMid, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: tags.map((tag) => _buildTag(tag)).toList(),
            ),
            const SizedBox(height: 12),
            // Footer row
            Row(
              children: [
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: _textSecondary),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.location_on_outlined,
                    size: 14, color: _textSecondary),
                Text(
                  ' $location',
                  style: const TextStyle(fontSize: 12, color: _textSecondary),
                ),
                const Spacer(),
                const Icon(Icons.arrow_upward_rounded,
                    size: 16, color: _textSecondary),
                const SizedBox(width: 3),
                Text('$upvotes',
                    style: const TextStyle(fontSize: 12, color: _textSecondary)),
                const SizedBox(width: 10),
                const Icon(Icons.chat_bubble_outline_rounded,
                    size: 15, color: _textSecondary),
                const SizedBox(width: 3),
                Text('$comments',
                    style: const TextStyle(fontSize: 12, color: _textSecondary)),
              ],
            ),
          ],
        ),
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
}
