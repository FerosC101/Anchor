import 'package:flutter/material.dart';
import '../../../shared/widgets/anchor_app_bar.dart';
import '../widgets/exit_simulation_dialog.dart';

class FinancialShieldScreen extends StatefulWidget {
  const FinancialShieldScreen({super.key});

  @override
  State<FinancialShieldScreen> createState() => _FinancialShieldScreenState();
}

class _FinancialShieldScreenState extends State<FinancialShieldScreen> {
  // ── Colors ──────────────────────────────────────────────────────────────────
  static const Color _primaryPurple = Color(0xFF8575B6);
  static const Color _deepPurple = Color(0xFF3D3790);
  static const Color _lightLavender = Color(0xFFD7D2E7);
  static const Color _bg = Color(0xFFF5F5F5);
  static const Color _debtAlertBg = Color(0xFFFFF8E1);
  static const Color _debtAlertText = Color(0xFFE07B00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: const AnchorAppBar(
        title: 'Financial Shield',
        subtitle: 'Build resilience against financial shocks.',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            _buildNetSafetyNetCard(),
            const SizedBox(height: 20),
            _buildDebtAlertCard(),
            const SizedBox(height: 20),
            _buildActionCardsRow(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ── Net Safety Net Card ──────────────────────────────────────────────────────

  Widget _buildNetSafetyNetCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9E9DCA), Color(0xFF3D3790)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NET SAFETY NET',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.8),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '\$1700', // TODO: replace with dynamic data
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetricBox(
                  'Total Savings',
                  '\$3200', // TODO: replace with dynamic data
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricBox(
                  'Outstanding Debt',
                  '\$1500', // TODO: replace with dynamic data
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ── Debt Alert Card ──────────────────────────────────────────────────────────

  Widget _buildDebtAlertCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _debtAlertBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _debtAlertText.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Debt Alert',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _debtAlertText,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Your last 3 payslips show a consistent 15-20% gap from your contract salary.',
            style: TextStyle(
              fontSize: 13,
              color: _debtAlertText,
            ),
          ),
        ],
      ),
    );
  }

  // ── Action Cards Row ─────────────────────────────────────────────────────────

  Widget _buildActionCardsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildActionCard(
              icon: Icons.flight_takeoff_outlined,
              title: 'Smart Exit\nPlanner',
              subtitle: 'Can I afford to leave today?',
              onTap: _showExitSimulationDialog,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionCard(
              icon: Icons.currency_exchange_outlined,
              title: 'Remittance\nCalculator',
              subtitle: 'Find the best exchange rates',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Coming soon')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _lightLavender,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: _deepPurple, size: 26),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Show Exit Simulation Dialog ──────────────────────────────────────────────

  void _showExitSimulationDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: const ExitSimulationDialog(),
      ),
    );
  }
}
