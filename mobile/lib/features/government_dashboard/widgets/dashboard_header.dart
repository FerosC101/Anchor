import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback? onNotificationTapped;
  final VoidCallback? onMenuTapped;

  const DashboardHeader({
    super.key,
    this.onNotificationTapped,
    this.onMenuTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Anchor',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: onNotificationTapped,
            color: const Color(0xFF94A3B8),
          ),
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: onMenuTapped,
            color: const Color(0xFF94A3B8),
          ),
        ],
      ),
    );
  }
}
