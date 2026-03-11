import 'package:flutter/material.dart';

class AnchorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnchorAppBar({
    super.key,
    this.showBackButton = false,
    this.title,
    this.subtitle,
  });

  final bool showBackButton;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
              onPressed: () => Navigator.of(context).pop(),
            )
          : IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.grey[700]),
              onPressed: () {
                // TODO: Navigate to notifications screen
              },
            ),
      title: title == null
          ? const Text(
              'Anchor',
              style: TextStyle(
                color: Color(0xFF3D3790),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.menu, color: Colors.grey[700]),
          onPressed: () {
            // TODO: Open menu drawer or sheet
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
