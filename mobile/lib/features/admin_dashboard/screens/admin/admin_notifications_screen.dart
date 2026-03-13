import 'package:flutter/material.dart';

import '../../widgets/admin/admin_app_bar.dart';
import '../../widgets/admin/admin_drawer.dart';

class AdminNotificationsScreen extends StatelessWidget {
  const AdminNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const AdminAppBar(),
      endDrawer: const AdminDrawer(),
      body: const Center(
        child: Text(
          'No new notifications',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
    );
  }
}
