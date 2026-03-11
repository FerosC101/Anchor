import 'package:flutter/material.dart';
import '../../../shared/widgets/anchor_app_bar.dart';
import '../../../shared/widgets/section_title.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key, this.initialTab = 0});

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
          title: 'Help & Support',
          subtitle: '',
        ),
        body: Column(
          children: [
            const TabBar(
              labelColor: Color(0xFF3D3790),
              unselectedLabelColor: Color(0xFF888888),
              indicatorColor: Color(0xFF3D3790),
              tabs: [
                Tab(text: 'FAQs'),
                Tab(text: 'User Guide'),
                Tab(text: 'Contact'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildFaqTab(),
                  _buildGuideTab(),
                  _buildContactTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('General'),
        _buildFaqItem(
          'What is Anchor?',
          'Anchor is a comprehensive platform designed to protect migrant workers by helping them track wages, scan contracts for risks, access community support, and plan financial exits.',
        ),
        _buildFaqItem(
          'Is my data secure?',
          'Yes, all your data is encrypted and stored securely. We never share your personal information with third parties without your consent.',
        ),
        const SectionTitle('Wage Monitoring'),
        _buildFaqItem(
          'How do I log a wage payment?',
          'Go to the Wage Monitor tab, tap the + button, enter the payment amount and date, then save. The system will automatically track discrepancies.',
        ),
        _buildFaqItem(
          'What happens if a discrepancy is detected?',
          'You\'ll receive a notification and can view detailed reports. The app will suggest actions you can take, including contacting authorities or your embassy.',
        ),
        const SectionTitle('Contract Scanner'),
        _buildFaqItem(
          'What types of contracts can I scan?',
          'You can scan employment contracts, work permits, agency agreements, and any other work-related documents.',
        ),
        _buildFaqItem(
          'How accurate is the AI analysis?',
          'Our AI is trained on thousands of migrant worker contracts and has 95% accuracy. However, always consult with a legal expert for critical decisions.',
        ),
        const SectionTitle('Community & Safety'),
        _buildFaqItem(
          'Can I report anonymously?',
          'Yes, all community posts and reports can be made anonymously to protect your identity.',
        ),
      ],
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF1A1A1A),
            ),
          ),
          children: [
            Text(
              answer,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF888888),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('Getting Started'),
        _buildGuideCard(
          icon: Icons.person_add_outlined,
          title: 'Create Your Profile',
          description:
              'Set up your profile with personal and work information to get personalized recommendations.',
          color: const Color(0xFF3D3790),
        ),
        _buildGuideCard(
          icon: Icons.description_outlined,
          title: 'Upload Your Contract',
          description:
              'Scan your employment contract to detect potential risks and understand your rights.',
          color: const Color(0xFF8575B6),
        ),
        const SectionTitle('Core Features'),
        _buildGuideCard(
          icon: Icons.attach_money_outlined,
          title: 'Wage Monitoring',
          description:
              'Track your wage payments, set expected amounts, and detect discrepancies automatically.',
          color: const Color(0xFF00AA28),
        ),
        _buildGuideCard(
          icon: Icons.shield_outlined,
          title: 'Financial Shield',
          description:
              'Monitor savings, track debts, and plan your financial exit strategy with our tools.',
          color: const Color(0xFF9E9DCA),
        ),
        _buildGuideCard(
          icon: Icons.group_outlined,
          title: 'Community Safety',
          description:
              'Connect with other workers, share experiences, and report safety concerns.',
          color: const Color(0xFFAD4B00),
        ),
        const SectionTitle('Advanced Features'),
        _buildGuideCard(
          icon: Icons.analytics_outlined,
          title: 'Exit Simulation',
          description:
              'Run financial simulations to understand when you can safely return home.',
          color: const Color(0xFF3D3790),
        ),
      ],
    );
  }

  Widget _buildGuideCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF888888),
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

  Widget _buildContactTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('Get in Touch'),
        _buildContactCard(
          icon: Icons.mail_outline,
          title: 'Email Support',
          subtitle: 'support@anchor.app',
          description: 'Response time: 24-48 hours',
          color: const Color(0xFF3D3790),
        ),
        _buildContactCard(
          icon: Icons.chat_outlined,
          title: 'Live Chat',
          subtitle: 'Available 9 AM - 6 PM UTC',
          description: 'Get instant help from our team',
          color: const Color(0xFF00AA28),
        ),
        _buildContactCard(
          icon: Icons.phone_outlined,
          title: 'Hotline',
          subtitle: '+1 800 ANCHOR-1',
          description: 'Available 24/7 for emergencies',
          color: const Color(0xFF8E0012),
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
                  Icon(Icons.emergency_outlined, color: Color(0xFF8E0012)),
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
              const SizedBox(height: 12),
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
              _buildEmergencyContact(
                '🇵🇭',
                'Philippine Embassy (Singapore)',
                '+65 6737 3977',
              ),
              _buildEmergencyContact(
                '🌏',
                'IOM Migrant Helpline',
                '+41 22 717 9111',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
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
