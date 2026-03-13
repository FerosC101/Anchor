import 'package:flutter/material.dart';
import '../../../shared/widgets/info_row.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/worker_drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WorkerAppBar(showBackButton: true),
      endDrawer: const WorkerDrawer(),
      body: Column(
        children: [
          _buildProfileHeader(),
          Expanded(
            child: _buildProfileContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      decoration: const BoxDecoration(
        color: Color(0xFFDFEDFF),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(width: 20),
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Guest User',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'migrant@gmail.com',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF003696),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Migrant Worker',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF003696),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Edit Profile Button
          Align(
            alignment: Alignment.centerRight,
            child: Builder(
              builder: (context) => OutlinedButton.icon(
                onPressed: () {
                  _showEditProfileDialog(context);
                },
                icon: const Icon(
                  Icons.edit,
                  size: 18,
                  color: Color(0xFF003696),
                ),
                label: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF003696),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF003696), width: 1.5),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('5', 'Contracts', const Color(0xFF003696)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('12', 'Wage Logs', const Color(0xFF003696)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('4', 'Reports', const Color(0xFF003696)),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Personal Information Section
            const SectionTitle('Personal Information'),
            const SizedBox(height: 12),
            _buildInfoCard([
              const InfoRow(
                icon: Icons.person_outline,
                label: 'Full Name',
                value: 'Guest User',
              ),
              const InfoRow(
                icon: Icons.mail_outline,
                label: 'Email',
                value: 'migrant@gmail.com',
              ),
              const InfoRow(
                icon: Icons.phone_outlined,
                label: 'Phone Number',
                value: '+63 912 345 6789',
              ),
              const InfoRow(
                icon: Icons.cake_outlined,
                label: 'Date of Birth',
                value: 'January 15, 1990',
              ),
            ]),
            const SizedBox(height: 24),
            
            // Work Information Section
            const SectionTitle('Work Information'),
            const SizedBox(height: 12),
            _buildInfoCard([
              const InfoRow(
                icon: Icons.location_on_outlined,
                label: 'Country of Origin',
                value: 'Philippines',
              ),
              const InfoRow(
                icon: Icons.language_outlined,
                label: 'Destination Country',
                value: 'Singapore',
              ),
              const InfoRow(
                icon: Icons.work_outline,
                label: 'Occupation',
                value: 'Domestic Helper',
              ),
              const InfoRow(
                icon: Icons.business_outlined,
                label: 'Employer',
                value: 'Private Household',
              ),
            ]),
            const SizedBox(height: 24),
            
            // Account Information
            const SectionTitle('Account Information'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDFEDFF), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFEDFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.calendar_today_outlined,
                          color: Color(0xFF003696),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Member since',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'January 2026',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFFDFEDFF)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFEDFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.verified_user_outlined,
                          color: Color(0xFF003696),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Status',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Color(0xFF00AA28),
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Verified',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF00AA28),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDFEDFF), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFDFEDFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final nameController = TextEditingController(text: 'Guest User');
    final emailController = TextEditingController(text: 'migrant@gmail.com');
    final phoneController = TextEditingController(text: '+63 912 345 6789');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline, color: Color(0xFF003696)),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.mail_outline, color: Color(0xFF003696)),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_outlined, color: Color(0xFF003696)),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF64748B)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Save profile changes
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: Color(0xFF00AA28),
                ),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003696),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
