import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/financial_shield_model.dart';
import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/worker_drawer.dart';
import '../../remittance/screens/remittance_calculator_screen.dart';
import '../providers/shield_provider.dart';
import '../widgets/exit_simulation_dialog.dart';

class FinancialShieldScreen extends ConsumerWidget {
  const FinancialShieldScreen({super.key});

  static const Color _blue = Color(0xFF003696);
  static const Color _bg = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(financialShieldProfileProvider);

    return Scaffold(
      backgroundColor: _bg,
      appBar: const WorkerAppBar(),
      endDrawer: const WorkerDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'Financial Shield',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => _showEditProfileDialog(context, ref),
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Update figures'),
                ),
              ),
            ),
            profileAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(24),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Failed to load financial data: $e'),
              ),
              data: (profile) => _buildNetSafetyNetCard(profile),
            ),
            const SizedBox(height: 20),
            _buildActionCardsRow(context, ref),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildNetSafetyNetCard(FinancialShieldProfile profile) {
    String money(double v) => '\$${v.toStringAsFixed(0)}';
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFDFEDFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NET SAFETY NET',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF003696),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            money(profile.netSafetyNet),
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              color: Color(0xFF003696),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetricBox(
                    'Total Savings', money(profile.totalSavings)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricBox(
                  'Outstanding Debt',
                  money(profile.outstandingDebt),
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
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: _blue)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCardsRow(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildActionCard(
              icon: Icons.flight_takeoff_outlined,
              title: 'Smart Exit\nPlanner',
              subtitle: 'Can I afford to leave today?',
              onTap: () => _showExitSimulationDialog(context, ref),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionCard(
              icon: Icons.currency_exchange_outlined,
              title: 'Remittance\nCalculator',
              subtitle: 'Find the best exchange rates',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RemittanceCalculatorScreen(),
                  ),
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
                color: const Color(0xFFDFEDFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF003696), size: 26),
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
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitSimulationDialog(BuildContext context, WidgetRef ref) {
    final summary = ref.read(smartExitSummaryProvider);
    final profile = ref.read(financialShieldProfileProvider).valueOrNull;
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: ExitSimulationDialog(
          remainingRunway: summary?.runwayAmount,
          survivalMonths: summary?.survivalMonths,
          netSafetyNet: summary?.netSafetyNet,
          estimatedFlightCost: profile?.estimatedFlightCost,
          outstandingDebt: profile?.outstandingDebt,
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, WidgetRef ref) {
    final profile = ref.read(financialShieldProfileProvider).valueOrNull;
    final savings =
        TextEditingController(text: (profile?.totalSavings ?? 0).toString());
    final debt =
        TextEditingController(text: (profile?.outstandingDebt ?? 0).toString());
    final monthly = TextEditingController(
        text: (profile?.monthlyLivingCost ?? 800).toString());
    final flight = TextEditingController(
        text: (profile?.estimatedFlightCost ?? 450).toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update Financial Data'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: savings,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Total Savings')),
              TextField(
                  controller: debt,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Outstanding Debt')),
              TextField(
                  controller: monthly,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Monthly Living Cost')),
              TextField(
                  controller: flight,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Estimated Flight Cost')),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final s = double.tryParse(savings.text.trim()) ?? 0;
              final d = double.tryParse(debt.text.trim()) ?? 0;
              final m = double.tryParse(monthly.text.trim()) ?? 0;
              final f = double.tryParse(flight.text.trim()) ?? 0;
              await ref
                  .read(shieldActionProvider.notifier)
                  .saveFinancialProfile(
                    totalSavings: s,
                    outstandingDebt: d,
                    monthlyLivingCost: m,
                    estimatedFlightCost: f,
                  );
              if (context.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
