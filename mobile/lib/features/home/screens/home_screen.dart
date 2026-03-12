import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../wages/screens/wage_monitor_screen.dart';
import '../../contracts/screens/contract_scanner_screen.dart';
import '../../community/screens/community_safety_screen.dart';
import '../../shield/screens/financial_shield_screen.dart';
import '../../../shared/widgets/community_post_card.dart';
import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/worker_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  static const Color _blue = Color(0xFF003696); // Deep Blue
  static const Color _blueLight = Color(0xFFCAEBFA); // Light Teal
  static const Color _blueDark = Color(0xFF003696); // Deep Blue
  static const Color _bg = Color(0xFFF4F4F8);
  static const Color _textSecondary = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    // Different screens for each tab
    final screens = [
      _buildHomeContent(),
      const WageMonitorScreen(),
      const ContractScannerScreen(),
      const CommunitySafetyScreen(),
      const FinancialShieldScreen(),
    ];

    return Scaffold(
      backgroundColor: _bg,
      body: IndexedStack(
        index: _selectedTab,
        children: screens,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── Home Content ─────────────────────────────────────────────────────────────

  Widget _buildHomeContent() {
    return Scaffold(
      backgroundColor: _bg,
      appBar: const WorkerAppBar(),
      endDrawer: const WorkerDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildSafetyCard(),
            const SizedBox(height: 16),
            _buildQuickActions(),
            const SizedBox(height: 16),
            _buildFinancialHealthCard(),
            const SizedBox(height: 20),
            _buildCommunitySection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ── Placeholder for other tabs ───────────────────────────────────────────────

  Widget _buildPlaceholder(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction_rounded, size: 64, color: _blue),
          const SizedBox(height: 16),
          Text(
            '$title Screen',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF003696), // Deep Blue
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // ── Search bar ───────────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        children: [
          SizedBox(width: 16),
          Icon(Icons.search_rounded, color: Color(0xFFADB5BD), size: 20),
          SizedBox(width: 10),
          Text(
            'Search',
            style: TextStyle(
              color: Color(0xFFADB5BD),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  // ── Safety status card ───────────────────────────────────────────────────────

  Widget _buildSafetyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFCAEBFA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CURRENT SAFETY STATUS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: Color(0xFF5B4FCF),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Good',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: _blueDark,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 14),
          _buildSafetyPill(
              Icons.verified_outlined, 'Contract Verified (92% match)'),
          const SizedBox(height: 8),
          _buildSafetyPill(Icons.trending_up_rounded, 'Wages trending normal'),
        ],
      ),
    );
  }

  Widget _buildSafetyPill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: _blue),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: _blueDark,
            ),
          ),
        ],
      ),
    );
  }

  // ── Quick actions ────────────────────────────────────────────────────────────

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedTab = 2);
            },
            child: _buildActionCard(
              icon: Icons.description_outlined,
              title: 'Check Contract',
              subtitle: 'Scan for hidden clauses',
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedTab = 1);
            },
            child: _buildActionCard(
              icon: Icons.show_chart_rounded,
              title: 'Log Wages',
              subtitle: 'Track earnings & deductions',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _blueLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: _blue, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: _textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // ── Financial health ─────────────────────────────────────────────────────────

  Widget _buildFinancialHealthCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Financial Health',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              Text(
                'Last updated: Today',
                style: TextStyle(
                  fontSize: 12,
                  color: _textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Savings goal row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Savings Goal (Return Home)',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF374151),
                ),
              ),
              Text(
                '45%',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.45,
              minHeight: 7,
              backgroundColor: _blueLight,
              valueColor: const AlwaysStoppedAnimation<Color>(_blue),
            ),
          ),
          const SizedBox(height: 14),
          // Bottom row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Next expected salary',
                    style: TextStyle(
                      fontSize: 12,
                      color: _textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '\$2,400 SGD',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() => _selectedTab = 4);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: _textSecondary,
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: const Text('View Analysis'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Community posts ──────────────────────────────────────────────────────────

  Widget _buildCommunitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Community Posts',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() => _selectedTab = 3); // Navigate to Community tab
              },
              icon: const Text(
                'View more',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _textSecondary,
                ),
              ),
              label: const Icon(Icons.arrow_forward_rounded,
                  size: 16, color: _textSecondary),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CommunityPostCard(
          company: 'BuildRite Construction',
          description:
              'Salary delayed for 2 months. Dormitory has no clean water supply...',
          tags: const ['#Delayed Salary', '#Unsafe Dorm'],
          time: '17 hours ago',
          location: 'Location',
          upvotes: 45,
          comments: 12,
          onTap: () {
            context.push('/community/post-detail');
          },
        ),
        const SizedBox(height: 10),
        CommunityPostCard(
          company: 'BuildRite Construction',
          description:
              'Salary delayed for 2 months. Dormitory has no clean water supply...',
          tags: const ['#Delayed Salary', '#Unsafe Dorm'],
          time: '17 hours ago',
          location: 'Location',
          upvotes: 45,
          comments: 12,
          onTap: () {
            context.push('/community/post-detail');
          },
        ),
      ],
    );
  }

  // ── Bottom navigation ────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    final items = [
      _NavItem(icon: Icons.home_rounded, label: 'Home'),
      _NavItem(icon: Icons.attach_money_rounded, label: 'Wages'),
      _NavItem(icon: Icons.description_outlined, label: 'Contracts'),
      _NavItem(icon: Icons.people_alt_outlined, label: 'Community'),
      _NavItem(icon: Icons.security_rounded, label: 'Shield'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final selected = i == _selectedTab;
              return GestureDetector(
                onTap: () => setState(() => _selectedTab = i),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 64,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[i].icon,
                        size: 24,
                        color: selected ? _blue : const Color(0xFFADB5BD),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        items[i].label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight:
                              selected ? FontWeight.w600 : FontWeight.w400,
                          color: selected ? _blue : const Color(0xFFADB5BD),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
