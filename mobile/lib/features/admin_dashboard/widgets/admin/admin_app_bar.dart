import 'package:flutter/material.dart';

import '../../screens/admin/admin_notifications_screen.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.notifications_none, color: Colors.grey),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AdminNotificationsScreen(),
          ),
        ),
      ),
      title: const Text(
        'Anchor',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xFF003696),
        ),
      ),
      actions: [
        Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.grey),
            onPressed: () => Scaffold.of(ctx).openEndDrawer(),
          ),
        ),
      ],
    );
  }
}
