import 'package:flutter/material.dart';
import '../widgets/index.dart';

class GovernmentDashboardScreen extends StatefulWidget {
  const GovernmentDashboardScreen({super.key});

  @override
  State<GovernmentDashboardScreen> createState() =>
      _GovernmentDashboardScreenState();
}

class _GovernmentDashboardScreenState extends State<GovernmentDashboardScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            DashboardHeader(
              onNotificationTapped: () {
                // Handle notification tap
              },
              onMenuTapped: () {
                // Handle menu tap
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const DashboardTitleSection(),
                    const SizedBox(height: 24),
                    const SystemOverviewCard(),
                    const SizedBox(height: 32),
                    const AbuseReportsChart(),
                    const SizedBox(height: 32),
                    RecentAlertsFeed(
                      onViewAllTapped: () {
                        // Handle view all alerts
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DashboardBottomNav(
        selectedIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
      ),
    );
  }
}
