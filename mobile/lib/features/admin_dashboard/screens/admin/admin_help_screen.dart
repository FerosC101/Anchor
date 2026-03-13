import 'package:flutter/material.dart';

import '../../widgets/admin/admin_app_bar.dart';
import '../../widgets/admin/admin_drawer.dart';
import '../../widgets/admin/admin_tab_bar.dart';

class AdminHelpScreen extends StatefulWidget {
  final int initialTab;

  const AdminHelpScreen({
    super.key,
    this.initialTab = 0,
  });

  @override
  State<AdminHelpScreen> createState() => _AdminHelpScreenState();
}

class _AdminHelpScreenState extends State<AdminHelpScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab.clamp(0, 1),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const AdminAppBar(),
      endDrawer: const AdminDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AdminTabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Help & FAQs'),
                Tab(text: 'Documentation'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(child: Text('Help content goes here')),
                Center(child: Text('Documentation goes here')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
