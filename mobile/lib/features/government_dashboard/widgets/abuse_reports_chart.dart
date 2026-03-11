import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AbuseReportsChart extends StatelessWidget {
  const AbuseReportsChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chartData = [
      {'label': 'Saudi\nArabia', 'value': 95, 'maxValue': 100},
      {'label': 'UAE', 'value': 75, 'maxValue': 100},
      {'label': 'Kuwait', 'value': 60, 'maxValue': 100},
      {'label': 'Qatar', 'value': 45, 'maxValue': 100},
      {'label': 'Oman', 'value': 35, 'maxValue': 100},
      {'label': 'Bahrain', 'value': 25, 'maxValue': 100},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Abuse Reports Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Reports by country',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: chartData.map((data) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 32,
                            height: (data['value'] as int) * 1.5,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data['label'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                              height: 1.2,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 1,
                  color: const Color(0xFFE2E8F0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
