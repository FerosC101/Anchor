import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback? onMenuTap;
  
  const DashboardHeader({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
            color: const Color(0xFF1E293B),
            iconSize: 24,
          ),
          const Expanded(
            child: Text(
              'Anchor Logo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: onMenuTap,
            color: const Color(0xFF1E293B),
            iconSize: 24,
          ),
        ],
      ),
    );
  }
}
