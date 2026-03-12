import 'package:flutter/material.dart';
import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/section_title.dart';

class SafetyResourcesScreen extends StatelessWidget {
  const SafetyResourcesScreen({super.key});

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
              'Safety Resources',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
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
                      'Emergency Hotlines',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8E0012),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Call these numbers immediately if you are in danger',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF8E0012),
                  ),
                ),
                const SizedBox(height: 14),
                _buildEmergencyContact(
                  '🚨',
                  'Local Emergency',
                  '911',
                ),
                _buildEmergencyContact(
                  '🇵🇭',
                  'PH Embassy Malaysia',
                  '+60 3-2148 5888',
                ),
                _buildEmergencyContact(
                  '🇵🇭',
                  'PH Embassy Thailand',
                  '+66 2-259 0139',
                ),
                _buildEmergencyContact(
                  '🇵🇭',
                  'PH Embassy Singapore',
                  '+65 6737 3977',
                ),
              ],
            ),
          ),
          const SectionTitle('Legal Aid Organizations'),
          _buildResourceCard(
            icon: Icons.gavel_outlined,
            title: 'Migrant Workers Centre',
            description: 'Free legal consultation and support for migrant workers',
            contact: '+60 3-2698 4703',
            website: 'www.mwc.org.my',
            color: const Color(0xFF003696),
          ),
          _buildResourceCard(
            icon: Icons.account_balance_outlined,
            title: 'Legal Aid Centre',
            description: 'Pro bono legal services for employment disputes',
            contact: '+66 2-222 1333',
            website: 'www.legalaidcenter.org',
            color: const Color(0xFF003696),
          ),
          const SectionTitle('Labor Rights Organizations'),
          _buildResourceCard(
            icon: Icons.groups_outlined,
            title: 'ILO Migrant Support',
            description: 'International Labour Organization assistance programs',
            contact: '+41 22 799 6111',
            website: 'www.ilo.org/migrant',
            color: const Color(0xFF00AA28),
          ),
          _buildResourceCard(
            icon: Icons.handshake_outlined,
            title: 'Workers Rights Network',
            description: 'Advocacy and support for fair employment practices',
            contact: '+60 3-2274 3009',
            website: 'www.workersrights.org',
            color: const Color(0xFF00AA28),
          ),
          const SectionTitle('Health & Welfare Services'),
          _buildResourceCard(
            icon: Icons.local_hospital_outlined,
            title: 'Migrant Health Clinic',
            description: 'Free healthcare services for migrant workers',
            contact: '+60 3-2691 5293',
            website: 'www.migranthealthclinic.org',
            color: const Color(0xFFAD4B00),
          ),
          _buildResourceCard(
            icon: Icons.psychology_outlined,
            title: 'Mental Health Support Line',
            description: '24/7 counseling in multiple languages',
            contact: '+60 3-7956 8145',
            website: 'www.mentalhelpline.org',
            color: const Color(0xFFAD4B00),
          ),
          const SectionTitle('Financial Assistance'),
          _buildResourceCard(
            icon: Icons.savings_outlined,
            title: 'Migrant Workers Fund',
            description: 'Emergency financial assistance for workers in crisis',
            contact: '+60 3-2272 4404',
            website: 'www.migrantfund.org',
            color: const Color(0xFF4F90F0),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(String emoji, String label, String number) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8E0012),
              ),
            ),
          ),
          Text(
            number,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8E0012),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard({
    required IconData icon,
    required String title,
    required String description,
    required String contact,
    required String website,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.phone_outlined,
                size: 16,
                color: Color(0xFF888888),
              ),
              const SizedBox(width: 6),
              Text(
                contact,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF1A1A1A),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(
                Icons.language_outlined,
                size: 16,
                color: Color(0xFF888888),
              ),
              const SizedBox(width: 6),
              Text(
                website,
                style: TextStyle(
                  fontSize: 13,
                  color: color,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
