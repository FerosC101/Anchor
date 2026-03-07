import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary – Deep Navy (trust, security)
  static const Color primary = Color(0xFF0A2463);
  static const Color primaryLight = Color(0xFF1E3A8A);
  static const Color primaryDark = Color(0xFF061540);

  // Secondary – Warm Amber (Filipino pride)
  static const Color secondary = Color(0xFFF4A261);
  static const Color secondaryLight = Color(0xFFF7C59F);
  static const Color secondaryDark = Color(0xFFE07B32);

  // Accent
  static const Color accent = Color(0xFF3A86FF);

  // Backgrounds & surfaces
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // Semantic
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Borders
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderFocus = Color(0xFF0A2463);

  // Role colours
  static const Color ofwColor = Color(0xFF0EA5E9);
  static const Color agencyColor = Color(0xFF8B5CF6);
  static const Color verifierColor = Color(0xFF10B981);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A2463), Color(0xFF1E3A8A)],
  );
}
