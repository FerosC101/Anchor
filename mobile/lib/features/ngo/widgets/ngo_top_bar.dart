import 'package:flutter/material.dart';
import '../core/ngo_theme.dart';

class NgoTopBar extends StatelessWidget {
  const NgoTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: Color(0xFF6B7280), size: 24),
            onPressed: () {},
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Anchor Logo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: NgoTheme.navy,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu_rounded,
                color: Color(0xFF6B7280), size: 24),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
