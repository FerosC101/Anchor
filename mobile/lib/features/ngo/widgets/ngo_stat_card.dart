import 'package:flutter/material.dart';
import '../core/ngo_theme.dart';

// ── Stat card ─────────────────────────────────────────────────────────────────

class NgoStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;
  final String change;
  final String changeLabel;
  final bool positive;
  final bool isStable;

  const NgoStatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
    required this.change,
    required this.changeLabel,
    required this.positive,
    this.isStable = false,
  });

  @override
  Widget build(BuildContext context) {
    final trendColor = isStable || positive
        ? NgoTheme.resolvedText
        : NgoTheme.escalatedText;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: NgoTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
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
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Icon(icon, size: 18, color: iconColor)),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.north_east_rounded, size: 12, color: trendColor),
                  const SizedBox(width: 2),
                  Text(
                    change,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: trendColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4A5565),
              fontFamily: 'Inter',
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            changeLabel,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4A5565),
              fontFamily: 'Inter',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ── Stat card grid ────────────────────────────────────────────────────────────

class NgoStatCardGrid extends StatelessWidget {
  const NgoStatCardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.15,
      children: const [
        NgoStatCard(
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.white,
          iconBg: NgoTheme.navy,
          label: 'Total Reports',
          value: '8',
          change: '+12%',
          changeLabel: 'vs last month',
          positive: true,
        ),
        NgoStatCard(
          icon: Icons.analytics_rounded,
          iconColor: Colors.white,
          iconBg: NgoTheme.navy,
          label: 'Active Cases',
          value: '5',
          change: '+8%',
          changeLabel: 'vs last month',
          positive: true,
        ),
        NgoStatCard(
          icon: Icons.group_rounded,
          iconColor: Colors.white,
          iconBg: NgoTheme.navy,
          label: 'High Risk Employers',
          value: '4',
          change: '+3',
          changeLabel: 'vs last month',
          positive: false,
        ),
        NgoStatCard(
          icon: Icons.location_on_rounded,
          iconColor: Colors.white,
          iconBg: NgoTheme.navy,
          label: 'Countries Monitored',
          value: '10',
          change: 'Stable',
          changeLabel: 'no change',
          positive: true,
          isStable: true,
        ),
      ],
    );
  }
}
