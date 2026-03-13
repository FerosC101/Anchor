import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Color _bg = Color(0xFFF4F4F8);

const BoxShadow _subtleBoxShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.04),
  blurRadius: 6,
  offset: Offset(0, 2),
);

class SystemMonitoringScreen extends ConsumerStatefulWidget {
  const SystemMonitoringScreen({super.key});

  @override
  ConsumerState<SystemMonitoringScreen> createState() =>
      _SystemMonitoringScreenState();
}

class _SystemMonitoringScreenState
    extends ConsumerState<SystemMonitoringScreen> {
  int _selectedTab =
      0; // 0 = AI Activity, 1 = Usage Metrics, 2 = Risk Alerts, 3 = Error Logs

  late List<RiskAlertData> _riskAlerts = [
    RiskAlertData(
      id: 'RA001',
      severity: 'High',
      title: 'Unusual Login Pattern',
      description:
          'Multiple failed login attempts from different geographic locations for user U003',
      timestamp: '2024-03-08 09:45',
      status: 'Active',
    ),
    RiskAlertData(
      id: 'RA003',
      severity: 'Average',
      title: 'Content Spike',
      description: 'Unusual increase in flagged content (300% above baseline)',
      timestamp: '2024-03-06 14:00',
      status: 'Acknowledged',
    ),
    RiskAlertData(
      id: 'RA002',
      severity: 'Critical',
      title: 'Fraudulent Job Posting',
      description:
          'Multiple job postings from unverified employer with suspicious payment terms',
      timestamp: '2024-03-05 10:30',
      status: 'Escalated',
    ),
    RiskAlertData(
      id: 'RA004',
      severity: 'Critical',
      title: 'Data Breach Attempt',
      description: 'SQL injection attempt detected and blocked',
      timestamp: '2024-03-04 22:15',
      status: 'Resolved',
    ),
    RiskAlertData(
      id: 'RA005',
      severity: 'Low',
      title: 'API Rate Limit Exceeded',
      description: 'Single IP address exceeded API rate limit by 250%',
      timestamp: '2024-03-03 16:20',
      status: 'Acknowledged',
    ),
  ];

  void _updateAlertStatus(String alertId, String newStatus) {
    setState(() {
      final index = _riskAlerts.indexWhere((alert) => alert.id == alertId);
      if (index != -1) {
        _riskAlerts[index] = RiskAlertData(
          id: _riskAlerts[index].id,
          severity: _riskAlerts[index].severity,
          title: _riskAlerts[index].title,
          description: _riskAlerts[index].description,
          timestamp: _riskAlerts[index].timestamp,
          status: newStatus,
        );
      }
    });
  }

  void _removeAlert(String alertId) {
    setState(() {
      _riskAlerts.removeWhere((alert) => alert.id == alertId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Text(
              'System Monitoring',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _TabSelector(
              selectedTab: _selectedTab,
              onTabChanged: (index) {
                setState(() => _selectedTab = index);
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: IndexedStack(
                  index: _selectedTab,
                  children: [
                    _AIActivityTab(),
                    _UsageMetricsTab(),
                    _RiskAlertsTab(
                      alerts: _riskAlerts,
                      onStatusChanged: _updateAlertStatus,
                      onRemove: _removeAlert,
                    ),
                    _ErrorLogsTab(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab Selector ──────────────────────────────────────────────────────────────

class _TabSelector extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;

  const _TabSelector({
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _TabButton(
            label: 'AI Activity',
            isSelected: selectedTab == 0,
            onTap: () => onTabChanged(0),
          ),
          const SizedBox(width: 8),
          _TabButton(
            label: 'Usage Metrics',
            isSelected: selectedTab == 1,
            onTap: () => onTabChanged(1),
          ),
          const SizedBox(width: 8),
          _TabButton(
            label: 'Risk Alerts',
            isSelected: selectedTab == 2,
            onTap: () => onTabChanged(2),
          ),
          const SizedBox(width: 8),
          _TabButton(
            label: 'Error Logs',
            isSelected: selectedTab == 3,
            onTap: () => onTabChanged(3),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

// ─── Tab Button ────────────────────────────────────────────────────────────────

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0052CC) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF0052CC)
                  : const Color(0xFFE5E7EB),
              width: 1,
            ),
            boxShadow: const [_subtleBoxShadow],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF374151),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// ─── AI Activity Tab ───────────────────────────────────────────────────────────

class _AIActivityTab extends StatelessWidget {
  const _AIActivityTab();

  @override
  Widget build(BuildContext context) {
    final activities = [
      (
        icon: Icons.assessment_outlined,
        title: 'Content Analysis',
        itemId: 'Post: P002',
        description: 'Flagged as high-risk scam (confidence 54%)',
        time: '2024-03-08 15:22'
      ),
      (
        icon: Icons.trending_up_outlined,
        title: 'Pattern Detection',
        itemId: 'Job: J002',
        description: 'Suspicious salary pattern detected',
        time: '2024-03-08 15:22'
      ),
      (
        icon: Icons.verified_user_outlined,
        title: 'User Behavior Analysis',
        itemId: 'User: U003',
        description: 'Normal activity pattern confirmed',
        time: '2024-03-08 15:22'
      ),
      (
        icon: Icons.assessment_outlined,
        title: 'Content Analysis',
        itemId: 'Post: P004',
        description: 'Promotional content detected (confidence 70%)',
        time: '2024-03-08 15:22'
      ),
      (
        icon: Icons.trending_up_outlined,
        title: 'Risk Score Update',
        itemId: 'User: U005',
        description: 'Risk score increased to 8.5/10',
        time: '2024-03-08 15:22'
      ),
      (
        icon: Icons.warning_outlined,
        title: 'Auto-moderation',
        itemId: 'Post: P004',
        description: 'Content auto-removed for illegal activity',
        time: '2024-03-08 15:22'
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'AI Activity Log',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final activity = activities[index];
              return _ActivityCard(
                icon: activity.icon,
                title: activity.title,
                itemId: activity.itemId,
                description: activity.description,
                time: activity.time,
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String itemId;
  final String description;
  final String time;

  const _ActivityCard({
    required this.icon,
    required this.title,
    required this.itemId,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: const [_subtleBoxShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F0FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF6B46C1),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3B3FA6),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    itemId,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Usage Metrics Tab ─────────────────────────────────────────────────────────

class _UsageMetricsTab extends StatelessWidget {
  const _UsageMetricsTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Usage Metrics',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  label: 'Active Sessions',
                  value: '342',
                  change: '+12% from yesterday',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  label: 'API Call Volume',
                  value: '15,678',
                  change: '+8% from yesterday',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  label: 'Records Processed Today',
                  value: '4,521',
                  change: '+15% from yesterday',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'System Performance',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE5E7EB),
                width: 1,
              ),
              boxShadow: const [_subtleBoxShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 250,
                    child: _PerformanceChart(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Resource Usage',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE5E7EB),
                width: 1,
              ),
              boxShadow: const [_subtleBoxShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _ResourceBar(label: 'CPU Usage', percentage: 42),
                  const SizedBox(height: 16),
                  _ResourceBar(label: 'Memory Usage', percentage: 67),
                  const SizedBox(height: 16),
                  _ResourceBar(label: 'Database Load', percentage: 55),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String change;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: const [_subtleBoxShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3B3FA6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              change,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF10B981),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PerformanceChart extends StatelessWidget {
  const _PerformanceChart();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Row(
                children: [
                  Icon(Icons.circle, color: Color(0xFF5B7EFF), size: 8),
                  SizedBox(width: 6),
                  Text(
                    'Requests',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5B7EFF),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 24),
              Row(
                children: [
                  Icon(Icons.circle, color: Color(0xFFFF6B6B), size: 8),
                  SizedBox(width: 6),
                  Text(
                    'Errors',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFF6B6B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        CustomPaint(
          size: const Size(double.infinity, 200),
          painter: _ChartPainter(),
        ),
      ],
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final points = [
      Offset(0, 150),
      Offset(60, 130),
      Offset(120, 90),
      Offset(180, 50),
      Offset(240, 60),
      Offset(300, 90),
      Offset(size.width, 120),
    ];

    final paint = Paint()
      ..color = const Color(0xFFFF6B6B)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }

    for (final point in points) {
      canvas.drawCircle(point, 4, paint..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(_ChartPainter oldDelegate) => false;
}

class _ResourceBar extends StatelessWidget {
  final String label;
  final int percentage;

  const _ResourceBar({
    required this.label,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D2D2D),
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 8,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF3B3FA6)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 40,
          child: Text(
            '$percentage%',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3B3FA6),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Risk Alerts Tab ───────────────────────────────────────────────────────────

class _RiskAlertsTab extends StatelessWidget {
  final List<RiskAlertData> alerts;
  final Function(String, String) onStatusChanged;
  final Function(String) onRemove;

  const _RiskAlertsTab({
    required this.alerts,
    required this.onStatusChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Active Risk Alerts',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: alerts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final alert = alerts[index];
              return _RiskAlertCard(
                alert: alert,
                onStatusChanged: (newStatus) =>
                    onStatusChanged(alert.id, newStatus),
                onRemove: () => onRemove(alert.id),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _RiskAlertCard extends StatelessWidget {
  final RiskAlertData alert;
  final Function(String) onStatusChanged;
  final VoidCallback onRemove;

  const _RiskAlertCard({
    required this.alert,
    required this.onStatusChanged,
    required this.onRemove,
  });

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'Critical':
        return const Color(0xFFDC2626);
      case 'High':
        return const Color(0xFFDC2626);
      case 'Average':
        return const Color(0xFFD97706);
      default:
        return const Color(0xFF3B82F6);
    }
  }

  Color _getSeverityBgColor(String severity) {
    switch (severity) {
      case 'Critical':
        return const Color(0xFFFEE2E2);
      case 'High':
        return const Color(0xFFFEE2E2);
      case 'Average':
        return const Color(0xFFFEF3C7);
      default:
        return const Color(0xFFDEBEFE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: const [_subtleBoxShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  alert.id,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7280),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getSeverityBgColor(alert.severity),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        alert.severity,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getSeverityColor(alert.severity),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusBgColor(alert.status),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        alert.status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(alert.status),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              alert.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3B3FA6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              alert.description,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Triggered: ${alert.timestamp}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(height: 12),
            _getActionButtons(alert.status),
          ],
        ),
      ),
    );
  }

  Widget _getActionButtons(String status) {
    switch (status) {
      case 'Active':
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => onStatusChanged('Acknowledged'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B3FA6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Acknowledge',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: () => onStatusChanged('Escalated'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF3B3FA6),
                  side: const BorderSide(
                    color: Color(0xFF3B3FA6),
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Escalate',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: () => onStatusChanged('Resolved'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF3B3FA6),
                  side: const BorderSide(
                    color: Color(0xFF3B3FA6),
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Mark Resolved',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      case 'Acknowledged':
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => onStatusChanged('Escalated'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B3FA6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Escalate',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: () => onStatusChanged('Resolved'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF3B3FA6),
                  side: const BorderSide(
                    color: Color(0xFF3B3FA6),
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Resolve',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      case 'Escalated':
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => onStatusChanged('Resolved'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B3FA6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Mark Resolved',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      case 'Resolved':
        return SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onRemove,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF3B3FA6),
              side: const BorderSide(
                color: Color(0xFF3B3FA6),
                width: 1.5,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Remove',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return const Color(0xFF10B981);
      case 'Acknowledged':
        return const Color(0xFF6B46C1);
      case 'Escalated':
        return const Color(0xFF7C3AED);
      case 'Resolved':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF6B7280);
    }
  }

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'Active':
        return const Color(0xFFD1FAE5);
      case 'Acknowledged':
        return const Color(0xFFEDE9FE);
      case 'Escalated':
        return const Color(0xFFEDE9FE);
      case 'Resolved':
        return const Color(0xFFD1FAE5);
      default:
        return const Color(0xFFE5E7EB);
    }
  }
}

// ─── Error Logs Tab ───────────────────────────────────────────────────────────

class _ErrorLogsTab extends StatelessWidget {
  const _ErrorLogsTab();

  @override
  Widget build(BuildContext context) {
    final errorLogs = [
      (
        title: 'Database Connection Timeout',
        module: 'User Management',
        status: 'Investigating',
        description: 'Connection pool exhausted during peak traffic',
        timestamp: '2024-03-08 16:30'
      ),
      (
        title: 'Image Upload Failure',
        module: 'Content Upload',
        status: 'Resolved',
        description:
            'S3 bucket permissions issue - fixed by updating IAM policy',
        timestamp: '2024-03-08 16:30'
      ),
      (
        title: 'Email Service Error',
        module: 'Notifications',
        status: 'Resolved',
        description: 'SMTP server temporarily unavailable',
        timestamp: '2024-03-08 16:30'
      ),
      (
        title: 'Payment Gateway Error',
        module: 'Job Posting Payment',
        status: 'New',
        description: 'Transaction declined - insufficient error handling',
        timestamp: '2024-03-08 16:30'
      ),
      (
        title: 'Cache Invalidation Error',
        module: 'Content Moderation',
        status: 'New',
        description: 'Redis cache key mismatch causing stale data',
        timestamp: '2024-03-08 16:30'
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Active Risk Alerts',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D2D2D),
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: errorLogs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final error = errorLogs[index];
              return _ErrorLogCard(
                title: error.title,
                module: error.module,
                status: error.status,
                description: error.description,
                timestamp: error.timestamp,
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ErrorLogCard extends StatelessWidget {
  final String title;
  final String module;
  final String status;
  final String description;
  final String timestamp;

  const _ErrorLogCard({
    required this.title,
    required this.module,
    required this.status,
    required this.description,
    required this.timestamp,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Investigating':
        return const Color(0xFFFEF3C7);
      case 'Resolved':
        return const Color(0xFFD1FAE5);
      case 'New':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFE5E7EB);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Investigating':
        return const Color(0xFFB45309);
      case 'Resolved':
        return const Color(0xFF065F46);
      case 'New':
        return const Color(0xFF7F1D1D);
      default:
        return const Color(0xFF374151);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: const [_subtleBoxShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3B3FA6),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _getStatusTextColor(status),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              module,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4B5563),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              timestamp,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Data Models ──────────────────────────────────────────────────────────────

class RiskAlertData {
  final String id;
  final String severity;
  final String title;
  final String description;
  final String timestamp;
  final String status;

  RiskAlertData({
    required this.id,
    required this.severity,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.status,
  });
}
