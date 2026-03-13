import 'package:flutter/material.dart';

class AdminTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final ValueChanged<int>? onTap;
  final bool isScrollable;

  const AdminTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFD1D5DB), width: 1),
        ),
      ),
      child: TabBar(
        controller: controller,
        onTap: onTap,
        isScrollable: isScrollable,
        labelColor: const Color(0xFF003696),
        unselectedLabelColor: const Color(0xFF888888),
        indicatorColor: const Color(0xFF003696),
        indicatorWeight: 2.5,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        labelPadding: EdgeInsets.zero,
        tabs: tabs,
      ),
    );
  }
}
