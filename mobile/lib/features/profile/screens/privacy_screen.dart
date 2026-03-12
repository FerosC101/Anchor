import 'package:flutter/material.dart';
import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/settings_toggle.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const WorkerAppBar(showBackButton: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
            child: Text(
              'Privacy & Security',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          _buildInfoCard(
            icon: Icons.shield_outlined,
            title: 'Your Data is Protected',
            description:
                'We use end-to-end encryption to keep your personal information, contracts, and financial data secure.',
            color: const Color(0xFF003696),
          ),
          const SectionTitle('Data Protection'),
          const SettingsToggle(
            label: 'Two-Factor Authentication',
            icon: Icons.security_outlined,
            defaultValue: true,
          ),
          const SettingsToggle(
            label: 'Biometric Login',
            icon: Icons.fingerprint_outlined,
            defaultValue: false,
          ),
          const SettingsToggle(
            label: 'Auto-Lock App',
            icon: Icons.lock_clock_outlined,
            defaultValue: true,
          ),
          const SectionTitle('Privacy Settings'),
          const SettingsToggle(
            label: 'Anonymous Community Posts',
            icon: Icons.visibility_off_outlined,
            defaultValue: true,
          ),
          const SettingsToggle(
            label: 'Share Usage Analytics',
            icon: Icons.analytics_outlined,
            defaultValue: false,
          ),
          const SettingsToggle(
            label: 'Location Services',
            icon: Icons.location_on_outlined,
            defaultValue: false,
          ),
          const SectionTitle('Data Management'),
          _buildActionTile(
            icon: Icons.download_outlined,
            label: 'Download My Data',
            description: 'Export all your data in a portable format',
            onTap: (context) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Download coming soon')),
              );
            },
          ),
          _buildActionTile(
            icon: Icons.delete_sweep_outlined,
            label: 'Clear Cache',
            description: 'Free up space by clearing temporary data',
            onTap: (context) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear Cache'),
                  content: const Text(
                    'Are you sure you want to clear cached data?',
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
                          const SnackBar(content: Text('Cache cleared')),
                        );
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),
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
                    Icon(Icons.warning_outlined, color: Color(0xFF8E0012)),
                    SizedBox(width: 8),
                    Text(
                      'Danger Zone',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8E0012),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildDangerActionTile(
                  icon: Icons.person_off_outlined,
                  label: 'Deactivate Account',
                  description: 'Temporarily disable your account',
                  onTap: (context) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Deactivate Account'),
                        content: const Text(
                          'Your account will be hidden and you won\'t be able to sign in. You can reactivate it anytime.',
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
                                  content: Text('Deactivation coming soon'),
                                ),
                              );
                            },
                            child: const Text(
                              'Deactivate',
                              style: TextStyle(color: Color(0xFF8E0012)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                _buildDangerActionTile(
                  icon: Icons.delete_forever_outlined,
                  label: 'Delete Account',
                  description: 'Permanently delete your account and all data',
                  onTap: (context) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Account'),
                        content: const Text(
                          'This action cannot be undone. All your data will be permanently deleted.',
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
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: color.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String label,
    required String description,
    required void Function(BuildContext) onTap,
  }) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () => onTap(context),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF003696).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF003696),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF888888),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDangerActionTile({
    required IconData icon,
    required String label,
    required String description,
    required void Function(BuildContext) onTap,
  }) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () => onTap(context),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF8E0012), size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Color(0xFF8E0012),
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF8E0012),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF8E0012),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
