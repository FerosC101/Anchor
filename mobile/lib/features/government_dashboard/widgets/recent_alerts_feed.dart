import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'alert_item_card.dart';

class RecentAlertsFeed extends StatelessWidget {
  final VoidCallback? onViewAllTapped;

  const RecentAlertsFeed({
    super.key,
    this.onViewAllTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Alerts Feed',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: onViewAllTapped,
                child: const Row(
                  children: [
                    Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Showing 5 of 67 alerts',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(5, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: index < 4 ? 12 : 0),
              child: AlertItemCard(
                workerName: 'Worker Name',
                country: 'Country',
                employerName: 'Employer Name',
                date: '2026-03-05',
                riskLevel: 'High',
                onTapped: () {
                  // Handle alert tap
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
