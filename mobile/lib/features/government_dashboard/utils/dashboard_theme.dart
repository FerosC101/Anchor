import 'package:flutter/material.dart';

class DashboardTheme {
  DashboardTheme._();

  // Blue palette
  static const Color blueDark = Color(0xFF003696);
  static const Color blueMid = Color(0xFF003696);
  static const Color blueLight = Color(0xFFDFEDFF);
  static const Color blueLightest = Color(0xFFDFEDFF);

  // Semantic palette
  static const Color red = Color(0xFF8E0012);
  static const Color redBg = Color(0xFFFFF3F3);
  static const Color yellow = Color(0xFFAD4B00);
  static const Color yellowBg = Color(0xFFFFFBE8);
  static const Color green = Color(0xFF00AA28);
  static const Color greenBg = Color(0xFFEEFDF3);

  // Legacy aliases
  static const Color purple = blueDark;
  static const Color bg = Color(0xFFF4F5F7);
  static const Color blue = blueDark;
  static const Color indigo = Color(0xFF003696);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color border = Color(0xFFE2E8F0);
  static const Color cardBg = Colors.white;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFDFEDFF), Color(0xFF003696)],
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
