import 'package:flutter/material.dart';
import '../../features/profile/screens/notifications_screen.dart';

/// WorkerAppBar - consistent AppBar for all Migrant Worker role screens
/// Do NOT use this in Government or NGO role screens
class WorkerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  
  const WorkerAppBar({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      
      // LEFT — back button OR notifications icon
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.grey),
              onPressed: () => Navigator.pop(context),
            )
          : IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.grey),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationsScreen(),
                ),
              ),
            ),
      
      // CENTER — app name only, no logo, no role label
      title: const Text(
        'Anchor',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xFF003696), // Deep Blue
        ),
      ),
      
      // RIGHT — opens WorkerDrawer (endDrawer)
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
