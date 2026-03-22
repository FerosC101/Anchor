import 'package:flutter/material.dart';

class ExitSimulationDialog extends StatelessWidget {
  const ExitSimulationDialog({
    super.key,
    this.netSafetyNet,
    this.remainingRunway,
    this.survivalMonths,
    this.estimatedFlightCost,
    this.outstandingDebt,
  });

  final double? netSafetyNet;
  final double? remainingRunway;
  final int? survivalMonths;
  final double? estimatedFlightCost;
  final double? outstandingDebt;

  // ── Colors ──────────────────────────────────────────────────────────────────
  static const Color _blue = Color(0xFF003696);
  static const Color _blueMid = Color(0xFF003696);
  static const Color _blueLight = Color(0xFFDFEDFF);
  static const Color _successGreen = Color(0xFF00AA28);
  static const Color _dangerRed = Color(0xFF8E0012);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildLineItems(),
          const SizedBox(height: 16),
          const Divider(color: _blueLight, thickness: 1),
          const SizedBox(height: 12),
          _buildRemainingRunway(),
          const SizedBox(height: 16),
          _buildSurvivalEstimate(),
          const SizedBox(height: 20),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Exit Simulation',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Based on your current savings and debt.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  // ── Line Items ───────────────────────────────────────────────────────────────

  Widget _buildLineItems() {
    final savingsValue = netSafetyNet ?? 0;
    final flightValue = estimatedFlightCost ?? 0;
    final debtValue = outstandingDebt ?? 0;
    return Column(
      children: [
        _SimulationRow(
          label: 'Current Savings',
          value: '\$${savingsValue.toStringAsFixed(0)}',
          valueColor: _successGreen,
        ),
        const SizedBox(height: 12),
        _SimulationRow(
          label: 'Flight Home (Est.)',
          value: '-\$${flightValue.toStringAsFixed(0)}',
          valueColor: _dangerRed,
        ),
        const SizedBox(height: 12),
        _SimulationRow(
          label: 'Debt Payoff (Required)',
          value: '-\$${debtValue.toStringAsFixed(0)}',
          valueColor: _dangerRed,
        ),
      ],
    );
  }

  // ── Remaining Runway ─────────────────────────────────────────────────────────

  Widget _buildRemainingRunway() {
    final runway = remainingRunway ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Remaining Runway',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        Text(
          '\$${runway.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: _successGreen,
          ),
        ),
      ],
    );
  }

  // ── Survival Estimate ────────────────────────────────────────────────────────

  Widget _buildSurvivalEstimate() {
    final months = survivalMonths ?? 1;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _blueLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Survival Estimate',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Based on your monthly living cost, you will have $months month${months == 1 ? '' : 's'} of runway',
            style: const TextStyle(
              fontSize: 13,
              color: _blueMid,
            ),
          ),
        ],
      ),
    );
  }

  // ── Action Buttons ───────────────────────────────────────────────────────────

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: _blueLight),
              backgroundColor: _blueLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'Close',
              style: TextStyle(
                color: _blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: _blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'Rerun simulation',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Reusable Simulation Row Widget ──────────────────────────────────────────

class _SimulationRow extends StatelessWidget {
  const _SimulationRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF1A1A1A),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
