import 'package:flutter/material.dart';

class DashboardTheme {
  DashboardTheme._();

  static const Color purple = Color(0xFF7C5CBF);
  static const Color bg = Color(0xFFF4F5F7);
  static const Color green = Color(0xFF10B981);
  static const Color red = Color(0xFFEF4444);
  static const Color blue = Color(0xFF3B82F6);
  static const Color blueLight = Color(0xFFEBF5FF);
  static const Color indigo = Color(0xFF3730A3);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color border = Color(0xFFE2E8F0);
  static const Color cardBg = Colors.white;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7B6FCC), Color(0xFF2E2B6E)],
  );

  static BoxDecoration get cardDecoration => BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      );
}
