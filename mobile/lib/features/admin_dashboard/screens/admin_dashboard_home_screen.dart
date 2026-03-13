import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'content_moderation/content_moderation_screen.dart';
import 'job_listing/job_listing_screen.dart';
import 'system_monitoring/system_monitoring_screen.dart';
import 'user_management/user_management_screen.dart';

const Color _bg = Color(0xFFF4F4F8);

const BoxShadow _subtleBoxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.04),
  blurRadius: 6,
  offset: Offset(0, 2),
);

class AdminDashboardHomeScreen extends ConsumerStatefulWidget {
  const AdminDashboardHomeScreen({super.key});

  @override
  ConsumerState<AdminDashboardHomeScreen> createState() =>
      _AdminDashboardHomeScreenState();
}

class _AdminDashboardHomeScreenState
    extends ConsumerState<AdminDashboardHomeScreen> {
  int _selectedBottomTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: _AdminAppBar(
        onMenuTap: () {
          // TODO: Implement drawer or menu
        },
      ),
      body: IndexedStack(
        index: _selectedBottomTab,
        children: [
          const _AdminDashboardBody(),
          const UserManagementScreen(),
          const ContentModerationScreen(),
          const JobListingScreen(),
          const SystemMonitoringScreen(),
        ],
      ),
      bottomNavigationBar: _AdminBottomNavBar(
        currentIndex: _selectedBottomTab,
        onTabChanged: (index) {
          setState(() => _selectedBottomTab = index);
        },
      ),
    );
  }
}

// ─── App Bar ──────────────────────────────────────────────────────────────────

class _AdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuTap;

  const _AdminAppBar({
    required this.onMenuTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Anchor Logo',
        style: TextStyle(
          color: Color(0xFF2D2D2D),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: SizedBox.expand(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onMenuTap,
            child: const Icon(
              Icons.menu_rounded,
              color: Color(0xFF2D2D2D),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Body ──────────────────────────────────────────────────────────────────────

class _AdminDashboardBody extends StatelessWidget {
  const _AdminDashboardBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
            const _SystemOverviewSection(),
            const SizedBox(height: 24),
            const _PendingActionsSection(),
            const SizedBox(height: 24),
            const _RecentActivitySection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ─── System Overview Section ──────────────────────────────────────────────────

class _SystemOverviewSection extends StatelessWidget {
  const _SystemOverviewSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System overview',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.85,
          children: [
            _MetricCard(
              icon: Icons.people_rounded,
              value: '1,247',
              label: 'Total\nUsers',
              isDarkTheme: true,
            ),
            _MetricCard(
              icon: Icons.block_rounded,
              value: '23',
              label: 'Suspended\nAccounts',
              isDarkTheme: true,
            ),
            _MetricCard(
              icon: Icons.verified_user_rounded,
              value: '8',
              label: 'Pending NGO\nVerifications',
              isDarkTheme: true,
            ),
            _MetricCard(
              icon: Icons.flag_rounded,
              value: '15',
              label: 'Flagged\nPosts',
              isDarkTheme: false,
            ),
            _MetricCard(
              icon: Icons.assignment_rounded,
              value: '42',
              label: 'Pending Job\nApprovals',
              isDarkTheme: false,
            ),
            _MetricCard(
              icon: Icons.warning_amber_rounded,
              value: '5',
              label: 'Active Risk\nAlerts',
              isDarkTheme: false,
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Metric Card ──────────────────────────────────────────────────────────────

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final bool isDarkTheme;

  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? const Color(0xFF6B46C1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isDarkTheme
            ? null
            : Border.all(
                color: const Color(0xFFE5E7EB),
                width: 1,
              ),
        boxShadow: const [_subtleBoxShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isDarkTheme ? Colors.white : const Color(0xFF4C1D95),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDarkTheme ? Colors.white : const Color(0xFF4C1D95),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isDarkTheme ? Colors.white70 : const Color(0xFF6B7280),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Pending Actions Section ──────────────────────────────────────────────────

class _PendingActionsSection extends StatelessWidget {
  const _PendingActionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pending Actions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D2D2D),
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to view all pending actions
              },
              child: const Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B46C1),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: Color(0xFF6B46C1),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _ActionCard(
          icon: Icons.flag_rounded,
          title: 'Flagged Content Pending\nReview',
          subtitle: '2 items',
          count: 2,
          actionLabel: 'Review',
          onTap: () {
            // TODO: Handle tap
          },
        ),
        const SizedBox(height: 12),
        _ActionCard(
          icon: Icons.assignment_rounded,
          title: 'Job Listings Awaiting\nApproval',
          subtitle: '2 items',
          count: 2,
          actionLabel: 'Review',
          onTap: () {
            // TODO: Handle tap
          },
        ),
        const SizedBox(height: 12),
        _ActionCard(
          icon: Icons.people_rounded,
          title: 'Unverified NGO Accounts',
          subtitle: '2 items',
          count: 2,
          actionLabel: 'Verify',
          onTap: () {
            // TODO: Handle tap
          },
        ),
        const SizedBox(height: 12),
        _ActionCard(
          icon: Icons.warning_amber_rounded,
          title: 'Active Risk Alerts',
          subtitle: '3 active',
          count: 3,
          actionLabel: 'View',
          onTap: () {
            // TODO: Handle tap
          },
        ),
      ],
    );
  }
}

// ─── Action Card ──────────────────────────────────────────────────────────────

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int count;
  final String actionLabel;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.count,
    required this.actionLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: const [_subtleBoxShadow],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF6B46C1),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4C1D95),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B46C1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        count.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: onTap,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              actionLabel,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Recent Activity Section ──────────────────────────────────────────────────

class _RecentActivitySection extends StatelessWidget {
  const _RecentActivitySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D2D2D),
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to view all activity
              },
              child: const Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B46C1),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: Color(0xFF6B46C1),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _ActivityCard(
          icon: Icons.flag_rounded,
          title: 'Post Flagged',
          subtitle: '"Urgent: Employer...',
          timestamp: '2024-03-08 14:30',
          actionLabel: 'Review',
          onActionTap: () {
            // TODO: Handle action
          },
        ),
        const SizedBox(height: 12),
        _ActivityCard(
          icon: Icons.person_add_rounded,
          title: 'User Registered',
          subtitle: 'Fatima Al-Mansoori',
          timestamp: '2024-03-08 10:15',
          actionLabel: 'View',
          onActionTap: () {
            // TODO: Handle action
          },
        ),
        const SizedBox(height: 12),
        _ActivityCard(
          icon: Icons.warning_amber_rounded,
          title: 'Risk Alert',
          subtitle: 'Unusual login pattern',
          timestamp: '2024-03-08 09:45',
          actionLabel: 'Review',
          onActionTap: () {
            // TODO: Handle action
          },
        ),
        const SizedBox(height: 12),
        _ActivityCard(
          icon: Icons.business_rounded,
          title: 'Job Listing Submitted',
          subtitle: 'Construction Worker',
          timestamp: '2024-03-07 15:20',
          actionLabel: 'Review',
          onActionTap: () {
            // TODO: Handle action
          },
        ),
        const SizedBox(height: 12),
        _ActivityCard(
          icon: Icons.flag_rounded,
          title: 'Post Flagged',
          subtitle: '"Make \$5000/week...',
          timestamp: '2024-03-07 09:15',
          actionLabel: 'Review',
          onActionTap: () {
            // TODO: Handle action
          },
        ),
      ],
    );
  }
}

// ─── Activity Card ────────────────────────────────────────────────────────────

class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String timestamp;
  final String actionLabel;
  final VoidCallback onActionTap;

  const _ActivityCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.actionLabel,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: const [_subtleBoxShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF6B46C1),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6B7280),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: onActionTap,
                  child: Text(
                    actionLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B46C1),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              timestamp,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Bottom Navigation Bar ────────────────────────────────────────────────────

class _AdminBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const _AdminBottomNavBar({
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.people_rounded, 'label': 'Users'},
      {'icon': Icons.image_rounded, 'label': 'Content'},
      {'icon': Icons.work_rounded, 'label': 'Job List'},
      {'icon': Icons.settings_rounded, 'label': 'System'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
            (index) {
              final item = items[index];
              final isSelected = currentIndex == index;

              return GestureDetector(
                onTap: () => onTabChanged(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        color: isSelected
                            ? const Color(0xFF6B46C1)
                            : const Color(0xFFC4B5FD),
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFF6B46C1)
                              : const Color(0xFFC4B5FD),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
