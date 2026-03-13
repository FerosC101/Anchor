import 'package:flutter/material.dart';
import '../../../shared/widgets/anchor_drawer.dart';
import '../../../shared/widgets/government_app_bar.dart';
import '../core/ngo_theme.dart';
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
    (Icons.home_rounded, 'Home'),
    (Icons.bar_chart_rounded, 'Monitoring'),
    (Icons.notifications_rounded, 'Alert'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: NgoTheme.bg,
      appBar: const GovernmentAppBar(),
      endDrawer: const AnchorDrawer(),
      body: IndexedStack(
        index: _selectedNav,
        children: const [
          NgoHomeTab(),
          NgoMonitoringTab(),
          NgoAlertTab(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedNav,
        onTap: (i) => setState(() => _selectedNav = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF003696),
        unselectedItemColor: const Color(0xFFCBD5E1),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: _navItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.$1),
                label: item.$2,
              ),
            )
            .toList(),
      ),
    );
  }
}
