import 'package:flutter/material.dart';
import '../../../shared/widgets/government_drawer.dart';
import '../../../shared/widgets/government_app_bar.dart';
import '../utils/dashboard_theme.dart';
import 'home_tab.dart';
import 'monitoring_tab.dart';
import 'assistance_tab.dart';

class GovernmentDashboardScreen extends StatefulWidget {
  const GovernmentDashboardScreen({super.key});

  @override
  State<GovernmentDashboardScreen> createState() =>
      _GovernmentDashboardScreenState();
}

class _GovernmentDashboardScreenState extends State<GovernmentDashboardScreen> {
  int _selectedTab = 0;
  int? _forceMonitoringSubTab;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // ── Shared filter state ──────────────────────────────────────────────────────
  String _selectedCountry = 'All Countries';
  String _selectedStatus = 'All Status';
  String _selectedDate = 'All Date';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: DashboardTheme.bg,
      appBar: const GovernmentAppBar(),
      endDrawer: const GovernmentDrawer(),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          HomeTab(
            onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            onViewAllTap: () => setState(() {
              _selectedTab = 1;
              _forceMonitoringSubTab = 0;
            }),
          ),
          MonitoringTab(
            forceSubTab: _forceMonitoringSubTab,
            selectedCountry: _selectedCountry,
            selectedStatus: _selectedStatus,
            selectedDate: _selectedDate,
            onCountryChanged: (v) => setState(() => _selectedCountry = v),
            onStatusChanged: (v) => setState(() => _selectedStatus = v),
            onDateChanged: (v) => setState(() => _selectedDate = v),
          ),
          AssistanceTab(
            selectedCountry: _selectedCountry,
            selectedStatus: _selectedStatus,
            selectedDate: _selectedDate,
            onCountryChanged: (v) => setState(() => _selectedCountry = v),
            onStatusChanged: (v) => setState(() => _selectedStatus = v),
            onDateChanged: (v) => setState(() => _selectedDate = v),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Bottom navigation ─────────────────────────────────────────────────────────

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
        currentIndex: _selectedTab,
        onTap: (i) => setState(() {
          _selectedTab = i;
          if (i != 1) _forceMonitoringSubTab = null;
        }),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF003696),
        unselectedItemColor: const Color(0xFFCBD5E1),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Monitoring',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline_rounded),
            label: 'Assistance',
          ),
        ],
      ),
    );
  }
}
