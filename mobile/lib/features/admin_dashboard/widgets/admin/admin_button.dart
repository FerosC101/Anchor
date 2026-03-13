import 'package:flutter/material.dart';

class AdminButtonStyles {
  static final ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF003696),
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    minimumSize: const Size(0, 44),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1),
  );

  static final ButtonStyle secondary = OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF003696),
    backgroundColor: const Color(0xFFDFEDFF),
    side: BorderSide.none,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    minimumSize: const Size(0, 44),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1),
  );

  static final ButtonStyle danger = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF8E0012),
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    minimumSize: const Size(0, 44),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1),
  );
}
