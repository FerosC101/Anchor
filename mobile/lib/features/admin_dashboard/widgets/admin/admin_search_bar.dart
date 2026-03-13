import 'package:flutter/material.dart';

class AdminSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const AdminSearchBar({
    super.key,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: Color(0xFFADB5BD), fontSize: 15),
          prefixIcon: Icon(Icons.search_rounded, color: Color(0xFFADB5BD), size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ).copyWith(hintText: hintText),
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF0F172A),
        ),
      ),
    );
  }
}
