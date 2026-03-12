import 'package:flutter/material.dart';

class DashboardTheme {
  DashboardTheme._();

  // Blue color palette matching migrant worker role
  static const Color blueDark = Color(0xFF003696);
  static const Color blueMid = Color(0xFF4F90F0);
  static const Color blueLight = Color(0xFF95D6F5);
  static const Color blueLightest = Color(0xFFCAEBFA);
  
  // Legacy colors for backwards compatibility
  static const Color purple = Color(0xFF003696); // Changed to blue
  static const Color bg = Color(0xFFF4F5F7);
  static const Color green = Color(0xFF10B981);
  static const Color red = Color(0xFFEF4444);
  static const Color blue = Color(0xFF4F90F0);
  static const Color indigo = Color(0xFF003696);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color border = Color(0xFFE2E8F0);
  static const Color cardBg = Colors.white;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF95D6F5), Color(0xFF003696)],
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
