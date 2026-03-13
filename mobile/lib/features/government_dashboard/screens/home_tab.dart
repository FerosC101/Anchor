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
            childAspectRatio: 0.96,
          ),
          itemCount: statsData.length,
          itemBuilder: (_, i) => _buildStatCard(statsData[i]),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: DashboardTheme.blueDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              stat['icon'] as IconData,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stat['number'] as String,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: DashboardTheme.textPrimary,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat['label'] as String,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: DashboardTheme.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            stat['sublabel'] as String,
            style: const TextStyle(
              fontSize: 10,
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
            border: Border.all(color: const Color(0xFFD1D5DB)),
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

    Color riskBg;
    Color riskText;
    String riskLabel;
    if (risk.contains('critical') || risk.contains('high')) {
      riskBg = DashboardTheme.red;
      riskText = Colors.white;
      riskLabel = 'HIGH';
    } else if (risk.contains('review') || risk.contains('medium')) {
      riskBg = DashboardTheme.yellowBg;
      riskText = DashboardTheme.yellow;
      riskLabel = 'MED';
    } else {
      riskBg = DashboardTheme.greenBg;
      riskText = DashboardTheme.green;
      riskLabel = 'LOW';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFD1D5DB)),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: DashboardTheme.blueDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: DashboardTheme.textPrimary,
                          ),
                          children: [
                            TextSpan(
                              text: alert['workerName'] ?? 'Worker Name',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: '  ${alert['country'] ?? 'Country'}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF7A7A7A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        alert['employer'] ?? 'Employer Name',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7A7A7A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                    color: riskBg,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    riskLabel,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: riskText,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, thickness: 1, color: Color(0xFFE6E6E6)),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  dateText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7A7A7A),
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: Color(0xFF9A9A9A),
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7A7A7A),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: DashboardTheme.blueLight,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'In Review',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: DashboardTheme.blueDark,
                    ),
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
