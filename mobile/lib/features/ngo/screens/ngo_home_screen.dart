import 'package:flutter/material.dart';
import '../../../shared/widgets/anchor_drawer.dart';
import '../core/ngo_theme.dart';
import '../widgets/ngo_top_bar.dart';
import 'ngo_alert_tab.dart';
import 'ngo_home_tab.dart';
import 'ngo_monitoring_tab.dart';

class NgoHomeScreen extends StatefulWidget {
  const NgoHomeScreen({super.key});

  @override
  State<NgoHomeScreen> createState() => _NgoHomeScreenState();
}

class _NgoHomeScreenState extends State<NgoHomeScreen> {
  int _selectedNav = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  static const _navItems = [
    (Icons.home_rounded, Icons.home_outlined, 'Home'),
    (Icons.bar_chart_rounded, Icons.bar_chart_outlined, 'Monitoring'),
    (Icons.notifications_rounded, Icons.notifications_outlined, 'Alert'),
    (Icons.person_rounded, Icons.person_outlined, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: NgoTheme.bg,
      drawer: const AnchorDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            NgoTopBar(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedNav.clamp(0, 2),
                children: const [
                  NgoHomeTab(),
                  NgoMonitoringTab(),
                  NgoAlertTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: List.generate(_navItems.length, (i) {
              final (activeIcon, inactiveIcon, label) = _navItems[i];
              final isActive = _selectedNav == i;
              final activeColor = i == 2
                  ? const Color(0xFFF4A261)
                  : NgoTheme.navy;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedNav = i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isActive ? activeIcon : inactiveIcon,
                        size: 24,
                        color: isActive
                            ? activeColor
                            : const Color(0xFF94A3B8),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isActive
                              ? activeColor
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
