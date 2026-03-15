import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/widgets/worker_app_bar.dart';
import '../../../shared/widgets/worker_drawer.dart';
import '../../../models/wage_log_model.dart';
import '../providers/wage_provider.dart';

class WageMonitorScreen extends ConsumerStatefulWidget {
  const WageMonitorScreen({super.key});

  @override
  ConsumerState<WageMonitorScreen> createState() => _WageMonitorScreenState();
}

class _WageMonitorScreenState extends ConsumerState<WageMonitorScreen> {
  // ── Palette ──────────────────────────────────────────────────────────────
  static const Color _blue = Color(0xFF003696);
  static const Color _blueLight = Color(0xFFDFEDFF);
  static const Color _bg = Color(0xFFF5F5F5);
  static const Color _alertRed = Color(0xFF8E0012);
  static const Color _alertBg = Color(0xFFFFF3F3);
  static const Color _green = Color(0xFF1A7A4A);
  static const Color _greenBg = Color(0xFFEEF8F2);

  // ── Currency options ─────────────────────────────────────────────────────
  final List<String> _currencies = ['USD', 'SGD', 'HKD', 'AED', 'QAR', 'MYR'];

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(wageLogsProvider);
    final chartData = ref.watch(wageChartDataProvider);

    return Scaffold(
      backgroundColor: _bg,
      appBar: const WorkerAppBar(),
      endDrawer: const WorkerDrawer(),
      body: logsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Error loading wages: $e',
              style: const TextStyle(color: Colors.red)),
        ),
        data: (logs) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
                child: Text(
                  'Wage Monitor',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),

              // ── Summary cards ────────────────────────────────────────────
              if (logs.isNotEmpty) _buildSummaryRow(logs, chartData.latestGap),
              if (logs.isNotEmpty) const SizedBox(height: 16),

              // ── Chart ────────────────────────────────────────────────────
              _buildChartCard(
                  chartData.amounts, chartData.labels, chartData.maxY),
              const SizedBox(height: 20),

              // ── Recent Logs header ────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Logs',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  Text(
                    '${logs.length} entr${logs.length == 1 ? 'y' : 'ies'}',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ── Log list ─────────────────────────────────────────────────
              if (logs.isEmpty)
                _buildEmptyState()
              else
                ...logs.map((log) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildWageLogCard(log),
                    )),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'wages_fab',
        onPressed: () => _showLogDialog(context),
        backgroundColor: _blue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Log Salary',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }

  // ── Summary row ───────────────────────────────────────────────────────────

  Widget _buildSummaryRow(List<WageLog> logs, double? latestGap) {
    final latest = logs.first; // newest-first from stream
    final currency = latest.currency;
    final fmt = NumberFormat('#,##0.00', 'en_US');

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            icon: Icons.account_balance_wallet_rounded,
            label: 'Last Received',
            value: '$currency ${fmt.format(latest.amount)}',
            color: _blue,
            bg: _blueLight,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSummaryCard(
            icon: latestGap == null
                ? Icons.info_outline
                : latestGap < 0
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_upward_rounded,
            label: 'Wage Gap',
            value: latestGap == null
                ? 'N/A'
                : '${latestGap < 0 ? '-' : '+'}$currency ${fmt.format(latestGap.abs())}',
            color: latestGap == null
                ? Colors.grey
                : latestGap < 0
                    ? _alertRed
                    : _green,
            bg: latestGap == null
                ? Colors.grey[100]!
                : latestGap < 0
                    ? _alertBg
                    : _greenBg,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color bg,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: bg, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }

  // ── Chart ─────────────────────────────────────────────────────────────────

  Widget _buildChartCard(
      List<double> amounts, List<String> labels, double maxY) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Wage History',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E)),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: amounts.isEmpty
                ? Center(
                    child: Text('No data yet — log your first salary!',
                        style: TextStyle(color: Colors.grey[400])))
                : LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: maxY / 4,
                        getDrawingHorizontalLine: (v) =>
                            FlLine(color: Colors.grey[200]!, strokeWidth: 1),
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 46,
                            interval: maxY / 4,
                            getTitlesWidget: (v, m) => Text(
                              _formatAxisValue(v),
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 11),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (v, m) {
                              final i = v.toInt();
                              if (i < 0 || i >= labels.length) {
                                return const Text('');
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(labels[i],
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 11)),
                              );
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: (amounts.length - 1).toDouble(),
                      minY: 0,
                      maxY: maxY,
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (spots) => spots
                              .map((s) => LineTooltipItem(
                                    _formatAxisValue(s.y),
                                    const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ))
                              .toList(),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: amounts
                              .asMap()
                              .entries
                              .map((e) => FlSpot(e.key.toDouble(), e.value))
                              .toList(),
                          isCurved: true,
                          color: _blue,
                          barWidth: 3,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, pct, bar, idx) =>
                                FlDotCirclePainter(
                                    radius: 4,
                                    color: _blue,
                                    strokeWidth: 2,
                                    strokeColor: Colors.white),
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                _blueLight.withValues(alpha: 0.45),
                                _blueLight.withValues(alpha: 0.05),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String _formatAxisValue(double v) {
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}k';
    return v.toInt().toString();
  }

  // ── Wage log card ─────────────────────────────────────────────────────────

  Widget _buildWageLogCard(WageLog log) {
    final fmt = NumberFormat('#,##0.00', 'en_US');
    final monthFmt = DateFormat('MMM yyyy');
    final dateFmt = DateFormat("d MMM yyyy 'at' HH:mm");
    final gap = log.gap;
    final hasGap = gap != null;
    final underpaid = hasGap && gap < 0;

    return Dismissible(
      key: ValueKey(log.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: _alertRed,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline_rounded,
            color: Colors.white, size: 26),
      ),
      confirmDismiss: (_) => _confirmDelete(log),
      onDismissed: (_) =>
          ref.read(wageLogsNotifierProvider.notifier).deleteLog(log.id),
      child: GestureDetector(
        onTap: () => _showLogDialog(context, existing: log),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _blueLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.calendar_today_rounded,
                    color: _blue, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      monthFmt.format(log.period),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Logged ${dateFmt.format(log.loggedAt)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    if (log.notes != null && log.notes!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(log.notes!,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[500]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => _removeLogEntry(log),
                    tooltip: 'Remove entry',
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: _alertRed,
                      size: 20,
                    ),
                  ),
                  Text(
                    '${log.currency} ${fmt.format(log.amount)}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E)),
                  ),
                  if (hasGap) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: underpaid ? _alertBg : _greenBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${underpaid ? '-' : '+'}${log.currency} ${fmt.format(gap.abs())}',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: underpaid ? _alertRed : _green),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(WageLog log) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete log?'),
        content: Text(
            'Remove the wage entry for ${DateFormat('MMM yyyy').format(log.period)}?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: TextButton.styleFrom(foregroundColor: _alertRed),
              child: const Text('Delete')),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _removeLogEntry(WageLog log) async {
    final shouldDelete = await _confirmDelete(log);
    if (!shouldDelete) return;

    try {
      await ref.read(wageLogsNotifierProvider.notifier).deleteLog(log.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wage entry removed.'),
            backgroundColor: Color(0xFF1A7A4A),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to remove entry: $e')),
        );
      }
    }
  }

  // ── Empty state ───────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            Icon(Icons.bar_chart_rounded, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text('No wage logs yet',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[500])),
            const SizedBox(height: 8),
            Text('Tap + Log Salary to record your first entry.',
                style: TextStyle(fontSize: 13, color: Colors.grey[400])),
          ],
        ),
      ),
    );
  }

  // ── Log / Edit Dialog ─────────────────────────────────────────────────────

  void _showLogDialog(BuildContext context, {WageLog? existing}) {
    final amountCtrl =
        TextEditingController(text: existing?.amount.toStringAsFixed(2) ?? '');
    final expectedCtrl = TextEditingController(
        text: existing?.expectedAmount?.toStringAsFixed(2) ?? '');
    final notesCtrl = TextEditingController(text: existing?.notes ?? '');

    String selectedCurrency = existing?.currency ?? 'USD';

    // Build a list of the past 24 months.
    final now = DateTime.now();
    final periods = List.generate(24, (i) {
      return DateTime(now.year, now.month - i, 1);
    });
    DateTime selectedPeriod = existing?.period ?? periods.first;

    final isEditing = existing != null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModal) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),

                  Text(
                    isEditing ? 'Edit Salary Log' : 'Log New Salary',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E)),
                  ),
                  const SizedBox(height: 24),

                  // Period
                  _label('Period'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<DateTime>(
                    initialValue: selectedPeriod,
                    isExpanded: true,
                    decoration: _inputDecoration(),
                    items: periods
                        .map((d) => DropdownMenuItem(
                              value: d,
                              child: Text(DateFormat('MMMM yyyy').format(d)),
                            ))
                        .toList(),
                    onChanged: isEditing
                        ? null
                        : (v) {
                            if (v != null) setModal(() => selectedPeriod = v);
                          },
                  ),
                  const SizedBox(height: 16),

                  // Currency
                  _label('Currency'),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: selectedCurrency,
                    decoration: _inputDecoration(),
                    items: _currencies
                        .map((c) => DropdownMenuItem(
                              value: c,
                              child: Text(c),
                            ))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setModal(() => selectedCurrency = v);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Amount received
                  _label('Amount Received'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: amountCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: _inputDecoration(hint: '0.00'),
                  ),
                  const SizedBox(height: 16),

                  // Expected amount
                  _label('Expected Amount (optional)'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: expectedCtrl,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: _inputDecoration(
                        hint: 'From contract — leave blank if unknown'),
                  ),
                  const SizedBox(height: 16),

                  // Notes
                  _label('Notes (optional)'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: notesCtrl,
                    maxLines: 2,
                    decoration:
                        _inputDecoration(hint: 'e.g. overtime included'),
                  ),
                  const SizedBox(height: 28),

                  if (isEditing) ...[
                    SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: () async {
                          Navigator.pop(ctx);
                          await _removeLogEntry(existing);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: _alertRed,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: const Icon(Icons.delete_outline_rounded),
                        label: const Text(
                          'Remove this entry',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(ctx),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey[700],
                            side: BorderSide(color: Colors.grey[300]!),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Cancel',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _saveLog(
                              ctx,
                              isEditing,
                              existing,
                              amountCtrl,
                              expectedCtrl,
                              notesCtrl,
                              selectedCurrency,
                              selectedPeriod),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: Text(
                            isEditing ? 'Update' : 'Save Log',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveLog(
    BuildContext ctx,
    bool isEditing,
    WageLog? existing,
    TextEditingController amountCtrl,
    TextEditingController expectedCtrl,
    TextEditingController notesCtrl,
    String currency,
    DateTime period,
  ) async {
    final amount = double.tryParse(amountCtrl.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid received amount.')),
      );
      return;
    }

    final expectedRaw = expectedCtrl.text.trim();
    final expectedAmt =
        expectedRaw.isEmpty ? null : double.tryParse(expectedRaw);
    final notes = notesCtrl.text.trim();
    final notifier = ref.read(wageLogsNotifierProvider.notifier);

    Navigator.pop(ctx);

    try {
      if (isEditing && existing != null) {
        await notifier.updateLog(
          logId: existing.id,
          amount: amount,
          expectedAmount: expectedAmt,
          currency: currency,
          notes: notes,
        );
      } else {
        await notifier.addLog(
          amount: amount,
          expectedAmount: expectedAmt,
          currency: currency,
          period: period,
          notes: notes.isEmpty ? null : notes,
        );
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEditing
                ? 'Log updated successfully.'
                : 'Wage log saved successfully.'),
            backgroundColor: _green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: _alertRed),
        );
      }
    }
  }

  // ── Input helpers ─────────────────────────────────────────────────────────

  Widget _label(String text) => Text(
        text,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151)),
      );

  InputDecoration _inputDecoration({String? hint}) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _blue, width: 2),
        ),
      );
}
