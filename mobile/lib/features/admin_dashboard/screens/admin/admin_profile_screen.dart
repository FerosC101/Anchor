import 'package:flutter/material.dart';

import '../../widgets/admin/admin_app_bar.dart';
import '../../widgets/admin/admin_drawer.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const AdminAppBar(),
      endDrawer: const AdminDrawer(),
      body: const Center(
        child: Text(
          'Admin Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
    );
  }
}
