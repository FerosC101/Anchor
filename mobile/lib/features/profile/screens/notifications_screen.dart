import 'package:flutter/material.dart';
import '../../../shared/widgets/anchor_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const AnchorAppBar(
        showBackButton: true,
        title: 'Notifications',
        subtitle: '',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationTile(
            icon: Icons.attach_money_outlined,
            iconColor: const Color(0xFF00AA28),
            iconBgColor: const Color(0xFFEEFDF3),
            title: 'Wage Discrepancy Detected',
            message: 'Your last wage payment was 15% lower than expected',
            time: '2 hours ago',
            isUnread: true,
          ),
          _buildNotificationTile(
            icon: Icons.description_outlined,
            iconColor: const Color(0xFF3D3790),
            iconBgColor: const Color(0xFFD7D2E7),
            title: 'Contract Scan Complete',
            message: 'Review results for "Employment Agreement 2026"',
            time: '5 hours ago',
            isUnread: true,
          ),
          _buildNotificationTile(
            icon: Icons.group_outlined,
            iconColor: const Color(0xFFAD4B00),
            iconBgColor: const Color(0xFFFFFBE8),
            title: 'New Community Post',
            message: 'Someone posted about a similar contract issue',
            time: '1 day ago',
            isUnread: false,
          ),
          _buildNotificationTile(
            icon: Icons.warning_outlined,
            iconColor: const Color(0xFF8E0012),
            iconBgColor: const Color(0xFFFFF3F3),
            title: 'Safety Alert',
            message: 'High risk agency reported in your destination country',
            time: '2 days ago',
            isUnread: false,
          ),
          _buildNotificationTile(
            icon: Icons.trending_up_outlined,
            iconColor: const Color(0xFF00AA28),
            iconBgColor: const Color(0xFFEEFDF3),
            title: 'Exit Plan Updated',
            message: 'You\'re now 75% ready to transition home',
            time: '3 days ago',
            isUnread: false,
          ),
          _buildNotificationTile(
            icon: Icons.shield_outlined,
            iconColor: const Color(0xFF3D3790),
            iconBgColor: const Color(0xFFD7D2E7),
            title: 'Emergency Contact Added',
            message: 'Philippine Embassy contact saved to your profile',
            time: '1 week ago',
            isUnread: false,
          ),
          _buildNotificationTile(
            icon: Icons.verified_outlined,
            iconColor: const Color(0xFF00AA28),
            iconBgColor: const Color(0xFFEEFDF3),
            title: 'Identity Verified',
            message: 'Your account verification is now complete',
            time: '2 weeks ago',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isUnread
            ? Border.all(color: const Color(0xFF3D3790).withValues(alpha: 0.3))
            : null,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isUnread ? FontWeight.w700 : FontWeight.w500,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3D3790),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF888888),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: Color(0xFF888888),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF888888),
                      ),
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
