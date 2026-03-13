import 'package:flutter/material.dart';

class AdminBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AdminBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF003696),
        unselectedItemColor: const Color(0xFF888888),
        selectedLabelStyle:
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined, size: 24),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined, size: 24),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag_outlined, size: 24),
            label: 'Moderation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline, size: 24),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart_outlined, size: 24),
            label: 'Monitoring',
          ),
        ],
      ),
    );
  }
}
