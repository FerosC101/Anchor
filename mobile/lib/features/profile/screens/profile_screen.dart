import 'package:flutter/material.dart';
import '../../../shared/widgets/anchor_app_bar.dart';
import '../../../shared/widgets/info_row.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/settings_toggle.dart';
import '../../../shared/widgets/drawer_menu_item.dart';
import 'privacy_screen.dart';
import 'safety_resources_screen.dart';
import 'help_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: initialTab,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: const AnchorAppBar(
          showBackButton: true,
          title: 'Profile',
          subtitle: '',
        ),
        body: Column(
          children: [
            _buildProfileHeader(),
            const TabBar(
              labelColor: Color(0xFF3D3790),
              unselectedLabelColor: Color(0xFF888888),
              indicatorColor: Color(0xFF3D3790),
              tabs: [
                Tab(text: 'Profile'),
                Tab(text: 'Settings'),
                Tab(text: 'Help'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildProfileTab(context),
                  _buildSettingsTab(context),
                  _buildHelpTab(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9E9DCA), Color(0xFF3D3790)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Guest User',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'guest@demo.com',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '👑  Migrant Worker',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit profile coming soon')),
                );
              },
              icon: const Icon(Icons.edit_outlined, color: Color(0xFF3D3790)),
              label: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Color(0xFF3D3790),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SectionTitle('Personal Information'),
          const InfoRow(
            icon: Icons.person_outline,
            label: 'Full Name',
            value: 'Guest Worker',
          ),
          const InfoRow(
            icon: Icons.mail_outline,
            label: 'Email',
            value: 'guest@demo.com',
          ),
          const InfoRow(
            icon: Icons.phone_outlined,
            label: 'Phone Number',
            value: 'Not set',
          ),
          const SectionTitle('Work Information'),
          const InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Country of Origin',
            value: 'Philippines',
          ),
          const InfoRow(
            icon: Icons.language_outlined,
            label: 'Destination Country',
            value: 'Malaysia',
          ),
          const InfoRow(
            icon: Icons.work_outline,
            label: 'Occupation',
            value: 'Worker',
          ),
          const SectionTitle('Account Statistics'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard('5', 'Contracts', const Color(0xFF3D3790)),
              _buildStatCard('12', 'Wage Logs', const Color(0xFF00AA28)),
              _buildStatCard('8', 'Reports', const Color(0xFFAD4B00)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFF8575B6),
                  size: 18,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Member since',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF888888),
                      ),
                    ),
                    Text(
                      'January 2026',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF888888),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Preferences'),
          const SettingsToggle(
            label: 'Push Notifications',
            icon: Icons.notifications_none,
            defaultValue: true,
          ),
          const SettingsToggle(
            label: 'Email Alerts',
            icon: Icons.mail_outline,
            defaultValue: false,
          ),
          const SettingsToggle(
            label: 'Dark Mode',
            icon: Icons.dark_mode_outlined,
            defaultValue: false,
          ),
          const SectionTitle('Data & Privacy'),
          DrawerMenuItem(
            icon: Icons.lock_outline,
            label: 'Privacy & Security',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyScreen(),
                ),
              );
            },
          ),
          DrawerMenuItem(
            icon: Icons.delete_outline,
            label: 'Delete Account',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Account'),
                  content: const Text(
                    'Are you sure you want to delete your account? This action cannot be undone.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Account deletion coming soon'),
                          ),
                        );
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Color(0xFF8E0012)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHelpTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Quick Help'),
          DrawerMenuItem(
            icon: Icons.help_outline,
            label: 'FAQs',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpScreen(),
                ),
              );
            },
          ),
          DrawerMenuItem(
            icon: Icons.menu_book_outlined,
            label: 'User Guide',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HelpScreen(initialTab: 1),
                ),
              );
            },
          ),
          DrawerMenuItem(
            icon: Icons.shield_outlined,
            label: 'Safety Resources',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SafetyResourcesScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3F3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF8E0012).withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.error_outline, color: Color(0xFF8E0012)),
                    SizedBox(width: 8),
                    Text(
                      'Emergency Contacts',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8E0012),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildEmergencyContact(
                  '🇵🇭',
                  'Philippine Embassy (Malaysia)',
                  '+60 3-2148 5888',
                ),
                _buildEmergencyContact(
                  '🇵🇭',
                  'Philippine Embassy (Thailand)',
                  '+66 2-259 0139',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(String flag, String label, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '$flag  $label',
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF8E0012),
            ),
          ),
          const Spacer(),
          Text(
            number,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF8E0012),
            ),
          ),
        ],
      ),
    );
  }
}
