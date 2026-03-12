import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GovernmentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const GovernmentAppBar({
    super.key,
    this.showBackButton = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF003696),
                size: 20,
              ),
              onPressed: () => context.pop(),
            )
          : IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Color(0xFF003696),
                size: 24,
              ),
              onPressed: () {
                // TODO: Navigate to government notifications
              },
            ),
      centerTitle: true,
      title: const Text(
        'Anchor',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF003696),
        ),
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Color(0xFF003696),
              size: 24,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ],
    );
  }
}
