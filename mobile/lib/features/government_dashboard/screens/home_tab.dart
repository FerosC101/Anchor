import 'package:flutter/material.dart';
import '../data/dashboard_data.dart';
import '../utils/dashboard_theme.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final VoidCallback? onViewAllTap;

  const HomeTab({super.key, this.onMenuTap, this.onViewAllTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitleSection(),
          const SizedBox(height: 22),
          _buildStatsGrid(),
          const SizedBox(height: 24),
          _buildChartSection(),
          const SizedBox(height: 24),
          _buildAlertsSection(),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Government Dashboard',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: DashboardTheme.textPrimary,
          height: 1.1,
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: DashboardTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.12,
          ),
          itemCount: statsData.length,
          itemBuilder: (_, i) => _buildStatCard(statsData[i]),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    final change = (stat['change'] as String?) ?? '';
    final isNegative = (stat['label'] as String?)
            ?.toLowerCase()
            .contains('high risk') ==
        true;
    final trendColor = isNegative ? DashboardTheme.red : DashboardTheme.green;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: DashboardTheme.blueDark,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  stat['icon'] as IconData,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.north_east_rounded, size: 16, color: trendColor),
                  const SizedBox(width: 2),
                  Text(
                    change,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: trendColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            stat['number'] as String,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: DashboardTheme.textPrimary,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat['label'] as String,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: DashboardTheme.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            stat['sublabel'] as String,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: DashboardTheme.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Abuse Reports Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: DashboardTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(8, 14, 14, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 14,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 215,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: gridLines
                      .map(
                        (v) => Text(
                          v.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFFB7BDC6),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 215,
                  child: Stack(
                    children: [
                      ...List.generate(gridLines.length, (i) {
                        final top = i * (215 / (gridLines.length - 1));
                        return Positioned(
                          top: top,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 1,
                            color: const Color(0xFFE5E7EB),
                          ),
                        );
                      }),
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: chartData.map((d) {
                            final barH = (d['value'] as int) / chartMax * 198;
                            return Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 34,
                                    height: barH,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFC7D5EB),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    (d['label'] as String).replaceAll('\n', ' '),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF6B7280),
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAlertsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Alerts Feed',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: DashboardTheme.textPrimary,
              ),
            ),
            TextButton(
              onPressed: onViewAllTap,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                minimumSize: const Size(0, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'View all  →',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF888888),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...alertsData.take(4).map(_buildAlertCard),
      ],
    );
  }

  Widget _buildAlertCard(Map<String, String> alert) {
    final risk = alert['riskLevel']?.toLowerCase() ?? 'high';
    final dateText = _formatDate(alert['date'] ?? '2026-03-06');

    String riskLabel;
    Color riskDotColor;
    if (risk.contains('critical') || risk.contains('high')) {
      riskLabel = 'HIGH';
      riskDotColor = DashboardTheme.red;
    } else if (risk.contains('review') || risk.contains('medium')) {
      riskLabel = 'MED';
      riskDotColor = DashboardTheme.yellow;
    } else {
      riskLabel = 'LOW';
      riskDotColor = DashboardTheme.green;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 10,
              offset: Offset(0, 3),
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
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: DashboardTheme.blueLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: DashboardTheme.blueDark,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert['workerName'] ?? 'Worker Name',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: DashboardTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 16, color: DashboardTheme.textSecondary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              alert['country'] ?? 'Country',
                              style: const TextStyle(
                                fontSize: 13,
                                color: DashboardTheme.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: DashboardTheme.blueLight,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'In Review',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: DashboardTheme.blueDark,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Employer: ',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: DashboardTheme.textPrimary,
                  ),
                ),
                Expanded(
                  child: Text(
                    alert['employer'] ?? 'Employer Name',
                    style: const TextStyle(
                      fontSize: 13,
                      color: DashboardTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text(
                  'Date: ',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: DashboardTheme.textPrimary,
                  ),
                ),
                Expanded(
                  child: Text(
                    dateText,
                    style: const TextStyle(
                      fontSize: 13,
                      color: DashboardTheme.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text(
                  'Risk Level: ',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: DashboardTheme.textPrimary,
                  ),
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: riskDotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  riskLabel,
                  style: const TextStyle(
                    fontSize: 13,
                    color: DashboardTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String rawDate) {
    try {
      final parts = rawDate.split('-');
      if (parts.length != 3) return rawDate;
      const months = [
        '',
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);
      final year = parts[0];
      return '${months[month]} $day, $year';
    } catch (_) {
      return rawDate;
    }
  }
}
