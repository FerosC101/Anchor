import 'dart:math';
import 'package:flutter/material.dart';

class GovernmentDashboardScreen extends StatefulWidget {
  const GovernmentDashboardScreen({super.key});

  @override
  State<GovernmentDashboardScreen> createState() =>
      _GovernmentDashboardScreenState();
}

class _GovernmentDashboardScreenState extends State<GovernmentDashboardScreen> {
  int _selectedTab = 0;
  int _monitoringSubTab = 0;

  // ── Filter state ─────────────────────────────────────────────────────────────
  String _selectedCountry = 'All Countries';
  String _selectedStatus = 'All Status';
  String _selectedDate = 'All Date';

  static const List<String> _countryOptions = [
    'All Countries',
    'Saudi Arabia',
    'UAE',
    'Qatar',
    'Kuwait',
    'Bahrain',
  ];

  static const List<String> _statusOptions = [
    'All Status',
    'In review',
    'Resolved',
    'Critical',
  ];

  static const List<String> _riskLevelOptions = [
    'Risk Level',
    'High',
    'Medium',
    'Low',
  ];

  static const List<String> _dateOptions = [
    'All Date',
    'Today',
    'This Week',
    'This Month',
    'This Year',
  ];

  // ── Design tokens ────────────────────────────────────────────────────────────
  static const Color _purple = Color(0xFF7C5CBF);
  static const Color _bg = Color(0xFFF4F5F7);
  static const Color _green = Color(0xFF10B981);
  static const Color _red = Color(0xFFEF4444);
  static const Color _blue = Color(0xFF3B82F6);
  static const Color _blueLight = Color(0xFFEBF5FF);

  // ── Stats data ───────────────────────────────────────────────────────────────
  static const List<Map<String, dynamic>> _stats = [
    {
      'number': '47',
      'label': 'Abuse Report',
      'sublabel': 'vs last month',
      'change': '+12%',
      'icon': Icons.warning_rounded,
    },
    {
      'number': '8',
      'label': 'Support Request',
      'sublabel': 'vs last month',
      'change': '+8%',
      'icon': Icons.trending_up_rounded,
    },
    {
      'number': '23',
      'label': 'High Risk Employers',
      'sublabel': 'vs last month',
      'change': '+3',
      'icon': Icons.people_rounded,
    },
    {
      'number': '12',
      'label': 'Countries Monitored',
      'sublabel': 'no change',
      'change': 'Stable',
      'icon': Icons.location_on_rounded,
    },
  ];

  // ── Chart data ───────────────────────────────────────────────────────────────
  static const List<Map<String, dynamic>> _chartData = [
    {'label': 'Qatar', 'value': 65},
    {'label': 'UAE', 'value': 57},
    {'label': 'Saudi\nArabia', 'value': 45},
    {'label': 'Kuwait', 'value': 33},
    {'label': 'Bahrain', 'value': 29},
    {'label': 'Oman', 'value': 18},
  ];
  static const int _chartMax = 75;
  static const List<int> _gridLines = [75, 60, 45, 30, 15, 0];

  // ── Alerts data ───────────────────────────────────────────────────────────────
  static const List<Map<String, String>> _alerts = [
    {
      'workerName': 'Worker Name',
      'country': 'Country',
      'employer': 'Employer Name',
      'date': '2026-03-05',
      'riskLevel': 'High',
    },
    {
      'workerName': 'Worker Name',
      'country': 'Country',
      'employer': 'Employer Name',
      'date': '2026-03-05',
      'riskLevel': 'High',
    },
    {
      'workerName': 'Worker Name',
      'country': 'Country',
      'employer': 'Employer Name',
      'date': '2026-03-05',
      'riskLevel': 'High',
    },
    {
      'workerName': 'Worker Name',
      'country': 'Country',
      'employer': 'Employer Name',
      'date': '2026-03-05',
      'riskLevel': 'High',
    },
    {
      'workerName': 'Worker Name',
      'country': 'Country',
      'employer': 'Employer Name',
      'date': '2026-03-05',
      'riskLevel': 'High',
    },
  ];

  // ── Employer data ────────────────────────────────────────────────────────────
  static const List<Map<String, dynamic>> _employers = [
    {
      'name': 'Employer Name',
      'country': 'Country',
      'score': 50,
      'workers': '340',
      'reports': '12',
      'violations': '5',
      'lastIncident': 'Feb 14, 2026'
    },
    {
      'name': 'Employer Name',
      'country': 'Country',
      'score': 92,
      'workers': '340',
      'reports': '12',
      'violations': '5',
      'lastIncident': 'Feb 14, 2026'
    },
    {
      'name': 'Employer Name',
      'country': 'Country',
      'score': 27,
      'workers': '340',
      'reports': '12',
      'violations': '5',
      'lastIncident': 'Feb 14, 2026'
    },
    {
      'name': 'Employer Name',
      'country': 'Country',
      'score': 84,
      'workers': '340',
      'reports': '12',
      'violations': '5',
      'lastIncident': 'Feb 14, 2026'
    },
    {
      'name': 'Employer Name',
      'country': 'Country',
      'score': 84,
      'workers': '340',
      'reports': '12',
      'violations': '5',
      'lastIncident': 'Feb 14, 2026'
    },
  ];

  // ── Abuse reports data ────────────────────────────────────────────────────────
  static const List<Map<String, String>> _abuseReports = [
    {
      'name': 'User Name',
      'employer': 'Employer Name',
      'reportId': 'RPT-2026-0342',
      'abuseType': 'Wage Withholding',
      'dateFiled': 'Feb 14, 2026',
      'status': 'Investigation'
    },
    {
      'name': 'User Name',
      'employer': 'Employer Name',
      'reportId': 'RPT-2026-0342',
      'abuseType': 'Wage Withholding',
      'dateFiled': 'Feb 14, 2026',
      'status': 'Investigation'
    },
    {
      'name': 'User Name',
      'employer': 'Employer Name',
      'reportId': 'RPT-2026-0342',
      'abuseType': 'Wage Withholding',
      'dateFiled': 'Feb 14, 2026',
      'status': 'In Review'
    },
    {
      'name': 'User Name',
      'employer': 'Employer Name',
      'reportId': 'RPT-2026-0342',
      'abuseType': 'Wage Withholding',
      'dateFiled': 'Feb 14, 2026',
      'status': 'Resolved'
    },
    {
      'name': 'User Name',
      'employer': 'Employer Name',
      'reportId': 'RPT-2026-0342',
      'abuseType': 'Wage Withholding',
      'dateFiled': 'Feb 14, 2026',
      'status': 'Investigation'
    },
  ];

  // ── Contract issues data ──────────────────────────────────────────────────────
  static const List<Map<String, String>> _contractIssues = [
    {
      'name': 'User Name',
      'employer': 'Employer Name',
      'contractId': 'CNT-2026-0089',
      'issueType': 'Salary Discrepancy',
      'dateFiled': 'Feb 14, 2026',
      'status': 'Legal Review'
    },
    {
      'name': 'User Name',
      'employer': 'Employer Name',
      'contractId': 'CNT-2026-0089',
      'issueType': 'Salary Discrepancy',
      'dateFiled': 'Feb 14, 2026',
      'status': 'Mediation'
    },
    {
      'name': 'User Name',
      'employer': 'Employer Name',
      'contractId': 'CNT-2026-0089',
      'issueType': 'Salary Discrepancy',
      'dateFiled': 'Feb 14, 2026',
      'status': 'Mediation'
    },
    {
      'name': 'User Name',
      'employer': 'Employer Name',
      'contractId': 'CNT-2026-0089',
      'issueType': 'Salary Discrepancy',
      'dateFiled': 'Feb 14, 2026',
      'status': 'Resolved'
    },
  ];

  // ── Assistance cases data ─────────────────────────────────────────────────────
  static const List<Map<String, String>> _assistanceCases = [
    {
      'name': 'User Name',
      'country': 'Country',
      'employer': 'Loren Ipsum',
      'issue': 'Loren Ipsum',
      'status': 'In review'
    },
    {
      'name': 'User Name',
      'country': 'Country',
      'employer': 'Loren Ipsum',
      'issue': 'Loren Ipsum',
      'status': 'Resolved'
    },
    {
      'name': 'User Name',
      'country': 'Country',
      'employer': 'Loren Ipsum',
      'issue': 'Loren Ipsum',
      'status': 'In review'
    },
    {
      'name': 'User Name',
      'country': 'Country',
      'employer': 'Loren Ipsum',
      'issue': 'Loren Ipsum',
      'status': 'Critical'
    },
    {
      'name': 'User Name',
      'country': 'Country',
      'employer': 'Loren Ipsum',
      'issue': 'Loren Ipsum',
      'status': 'Resolved'
    },
    {
      'name': 'User Name',
      'country': 'Country',
      'employer': 'Loren Ipsum',
      'issue': 'Loren Ipsum',
      'status': 'In review'
    },
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD
  // ═══════════════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _buildHomeTab(),
          _buildMonitoringTab(),
          _buildAssistanceTab(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HOME TAB
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildHomeTab() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  _buildTitleSection(),
                  const SizedBox(height: 20),
                  _buildStatsGrid(),
                  const SizedBox(height: 24),
                  _buildChartSection(),
                  const SizedBox(height: 24),
                  _buildAlertsSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
            color: const Color(0xFF1E293B),
            iconSize: 24,
          ),
          const Expanded(
            child: Text(
              'Anchor Logo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () {},
            color: const Color(0xFF1E293B),
            iconSize: 24,
          ),
        ],
      ),
    );
  }

  // ── Title section ─────────────────────────────────────────────────────────────

  Widget _buildTitleSection() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Government Dashboard',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
      ),
    );
  }

  // ── Stats 2×2 grid ────────────────────────────────────────────────────────────

  Widget _buildStatsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System overview',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: _stats.length,
          itemBuilder: (_, i) => _buildStatCard(_stats[i]),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: _purple,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  stat['icon'] as IconData,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.north_east_rounded,
                    size: 11,
                    color: _green,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    stat['change'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            stat['number'] as String,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat['label'] as String,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat['sublabel'] as String,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // ── Bar chart ─────────────────────────────────────────────────────────────────

  Widget _buildChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Abuse Reports Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Reports by country',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.fromLTRB(8, 16, 16, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Y-axis labels
              SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _gridLines
                      .map(
                        (v) => Text(
                          v.toString(),
                          style: const TextStyle(
                            fontSize: 9,
                            color: Color(0xFFCBD5E1),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(width: 8),
              // Chart area with grid lines + bars
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      // Horizontal grid lines
                      ...List.generate(_gridLines.length, (i) {
                        final top = i * (200 / (_gridLines.length - 1));
                        return Positioned(
                          top: top,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 1,
                            color: const Color(0xFFE2E8F0),
                          ),
                        );
                      }),
                      // Bars
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: _chartData.map((d) {
                            final barH = (d['value'] as int) / _chartMax * 185;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 28,
                                  height: barH,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF7B6FCC),
                                        Color(0xFF2E2B6E),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(6),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  d['label'] as String,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF94A3B8),
                                    height: 1.2,
                                  ),
                                ),
                              ],
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

  // ── Recent alerts feed ────────────────────────────────────────────────────────

  Widget _buildAlertsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Alerts Feed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Row(
                children: [
                  Text(
                    'View all  \u2192',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Showing 5 of 67 alerts',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: List.generate(_alerts.length, (i) {
              return Column(
                children: [
                  _buildAlertRow(_alerts[i]),
                  if (i < _alerts.length - 1)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFF1F5F9),
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildAlertRow(Map<String, String> alert) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: Color(0xFF94A3B8),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          // Name + country + badge
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert['workerName']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0A2463),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  alert['country']!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _blueLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'In review',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Employer / date / risk level
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailLine(
                  'Employer: ', alert['employer']!, const Color(0xFF64748B)),
              _detailLine('Date: ', alert['date']!, const Color(0xFF64748B)),
              _detailLine('Risk Level: ', alert['riskLevel']!, _red),
            ],
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF94A3B8),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _detailLine(String label, String value, Color valueColor) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0F172A),
              height: 1.7,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: valueColor,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  // ── Monitoring Tab ─────────────────────────────────────────────────────────────

  Widget _buildMonitoringTab() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Risk Monitoring',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMonitoringTabs(),
                  const SizedBox(height: 12),
                  _buildFilterChips(),
                  const SizedBox(height: 20),
                  if (_monitoringSubTab == 0) ..._buildEmployersContent(),
                  if (_monitoringSubTab == 1) ..._buildAbuseReportsContent(),
                  if (_monitoringSubTab == 2) ..._buildContractIssuesContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildEmployersContent() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'High-Risk Employers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Showing 5 of 103 employers',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      ...List.generate(_employers.length, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: _buildEmployerCard(_employers[i]),
        );
      }),
      const SizedBox(height: 16),
      _buildPagination(),
      const SizedBox(height: 24),
    ];
  }

  List<Widget> _buildAbuseReportsContent() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Abuse Reports',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Showing 5 out of 67 reports',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      ...List.generate(_abuseReports.length, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: _buildAbuseReportCard(_abuseReports[i]),
        );
      }),
      const SizedBox(height: 16),
      _buildPagination(),
      const SizedBox(height: 24),
    ];
  }

  List<Widget> _buildContractIssuesContent() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Contract Issue Reports',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Showing 4 flagged contracts',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      ...List.generate(_contractIssues.length, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: _buildContractCard(_contractIssues[i]),
        );
      }),
      const SizedBox(height: 16),
      _buildPagination(),
      const SizedBox(height: 24),
    ];
  }

  Widget _buildMonitoringTabs() {
    const tabs = ['Employers', 'Abuse Reports', 'Contract Issues'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: List.generate(tabs.length, (i) {
            final selected = _monitoringSubTab == i;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _monitoringSubTab = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? _purple : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    tabs[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final isAbuseTab = _monitoringSubTab == 1;
    final isContractTab = _monitoringSubTab == 2;
    final statusLabel = (isAbuseTab || isContractTab) ? 'Status' : 'Risk Level';
    final statusOpts =
        (isAbuseTab || isContractTab) ? _statusOptions : _riskLevelOptions;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterChip(
              Icons.location_on_outlined,
              _selectedCountry,
              () => _showFilterModal(
                title: 'Country',
                options: _countryOptions,
                selected: _selectedCountry,
                onSelect: (v) => setState(() => _selectedCountry = v),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildFilterChip(
              Icons.info_outline,
              _selectedStatus == 'All Status' ? statusLabel : _selectedStatus,
              () => _showFilterModal(
                title: statusLabel,
                options: statusOpts,
                selected: _selectedStatus,
                onSelect: (v) => setState(() => _selectedStatus = v),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildFilterChip(
              Icons.filter_alt_outlined,
              _selectedDate,
              () => _showFilterModal(
                title: 'Date',
                options: _dateOptions,
                selected: _selectedDate,
                onSelect: (v) => setState(() => _selectedDate = v),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: const Color(0xFF64748B)),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF334155),
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down,
                size: 16, color: Color(0xFF64748B)),
          ],
        ),
      ),
    );
  }

  void _showFilterModal({
    required String title,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              ...options.map((opt) {
                final isSelected = opt == selected;
                return InkWell(
                  onTap: () {
                    onSelect(opt);
                    Navigator.pop(ctx);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            opt,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(Icons.check,
                              size: 22, color: Color(0xFF3730A3)),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Color _scoreColor(int score) {
    if (score >= 90) return const Color(0xFFEF4444);
    if (score >= 40 && score <= 60) return const Color(0xFF3730A3);
    return const Color(0xFF10B981);
  }

  Widget _buildEmployerCard(Map<String, dynamic> employer) {
    final score = employer['score'] as int;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF94A3B8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employer['name'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      employer['country'] as String,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _scoreColor(score),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  score.toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _empStatCol('Active Workers', employer['workers'] as String),
              _empStatCol('Open Reports', employer['reports'] as String),
              _empStatCol('Violations', employer['violations'] as String),
              _empStatCol('Last Incident', employer['lastIncident'] as String),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => _showReviewModal(context, employer),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7B6FCC), Color(0xFF2E2B6E)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Review',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _empStatCol(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.chevron_left, size: 18, color: Color(0xFF64748B)),
        SizedBox(width: 4),
        Text('Previous',
            style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
        SizedBox(width: 16),
        Text('Page 1 of 8',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A))),
        SizedBox(width: 16),
        Text('Next', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
        SizedBox(width: 4),
        Icon(Icons.chevron_right, size: 18, color: Color(0xFF64748B)),
      ],
    );
  }

  void _showReviewModal(BuildContext ctx, Map<String, dynamic> employer) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.92,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFF334155),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_rounded,
                          color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employer['name'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            employer['country'] as String,
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xFF64748B)),
                          ),
                          const Text(
                            'Last Updated: Feb 25, 2026',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close,
                          size: 24, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Risk Overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 140,
                    child: CustomPaint(
                      painter: _RiskGaugePainter(
                          (employer['score'] as int).toDouble()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),
                          Text(
                            employer['score'].toString(),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const Text(
                            'Risk Score',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                text: 'Open Reports:  ',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0F172A)),
                              ),
                              TextSpan(
                                text: '7',
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xFF64748B)),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                text: 'Flagged Workers:  ',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0F172A)),
                              ),
                              TextSpan(
                                text: '45',
                                style: TextStyle(
                                    fontSize: 13, color: Color(0xFF64748B)),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Row(children: [
                          Text('View All Reports',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF3730A3))),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward,
                              size: 12, color: Color(0xFF3730A3)),
                        ]),
                        SizedBox(height: 6),
                        Row(children: [
                          Text('View Workers',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF3730A3))),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward,
                              size: 12, color: Color(0xFF3730A3)),
                        ]),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Violations and Actions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                _buildViolationBar('Wage Withholding'),
                const SizedBox(height: 8),
                _buildViolationBar('Passport Confiscation'),
                const SizedBox(height: 8),
                _buildViolationBar('Contract Substitution'),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),
                const Text(
                  'Embassy Notes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: const TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Add internal notes...',
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3730A3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Mark as Reviewed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViolationBar(String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7B6FCC), Color(0xFF3730A3)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ── Abuse report card ──────────────────────────────────────────────────────────

  Color _statusColor(String status) {
    switch (status) {
      case 'Investigation':
        return const Color(0xFF3730A3);
      case 'In Review':
        return _red;
      case 'Resolved':
        return _green;
      default:
        return const Color(0xFF64748B);
    }
  }

  Color _statusBgColor(String status) {
    switch (status) {
      case 'Investigation':
        return const Color(0xFFEEF2FF);
      case 'In Review':
        return const Color(0xFFFEF2F2);
      case 'Resolved':
        return const Color(0xFFECFDF5);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Widget _buildAbuseReportCard(Map<String, String> report) {
    final status = report['status']!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF94A3B8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report['name']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      report['employer']!,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusBgColor(status),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _statusColor(status), width: 1),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _statusColor(status),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _reportStatCol('Report ID', report['reportId']!),
              _reportStatCol('Abuse Type', report['abuseType']!),
              _reportStatCol('Date Filed', report['dateFiled']!),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => _showAbuseReportModal(context, report),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7B6FCC), Color(0xFF2E2B6E)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'View Report',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportStatCol(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ── Abuse report modal ─────────────────────────────────────────────────────────

  void _showAbuseReportModal(BuildContext ctx, Map<String, String> report) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.78,
        maxChildSize: 0.92,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── header ─────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            report['reportId']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            report['abuseType']!,
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close,
                          size: 24, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),

                // ── Worker Profile ─────────
                const Text(
                  'Worker Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                _profileRow('Name:', 'Maria Santos'),
                _profileRow('Age:', '32'),
                _profileRow('Nationality:', 'Filipino'),
                _profileRow('Employer:', 'Al Noor Recruitment Co.'),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),

                // ── Incident Description ─────────
                const Text(
                  'Incident Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Worker reports 3 months of unpaid wages. Passport confiscated upon arrival. Employer threatening deportation.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Text(
                      'Incident Date: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      'Feb 15, 2026',
                      style: TextStyle(fontSize: 12, color: Color(0xFF3730A3)),
                    ),
                    SizedBox(width: 24),
                    Text(
                      'Filed: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      'Mar 4, 2026',
                      style: TextStyle(fontSize: 12, color: Color(0xFF3730A3)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),

                // ── Case Timeline ─────────
                const Text(
                  'Case Timeline',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 16),
                _timelineItem('Feb 15, 2026', 'Incident occurred', true),
                _timelineItem('Mar 4, 2026', 'Report filed with embassy', true),
                _timelineItem('Mar 5, 2026', 'Case assigned to officer', true),
                _timelineItem(
                    'Mar 5, 2026', 'Initial assessment completed', false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timelineItem(String date, String desc, bool showLine) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF3730A3),
                  shape: BoxShape.circle,
                ),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFF3730A3),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    desc,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
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

  // ── Contract issue card ────────────────────────────────────────────────────────

  Color _contractStatusColor(String status) {
    switch (status) {
      case 'Legal Review':
        return _red;
      case 'Mediation':
        return const Color(0xFF3730A3);
      case 'Resolved':
        return _green;
      default:
        return const Color(0xFF64748B);
    }
  }

  Color _contractStatusBgColor(String status) {
    switch (status) {
      case 'Legal Review':
        return const Color(0xFFFEF2F2);
      case 'Mediation':
        return const Color(0xFFEEF2FF);
      case 'Resolved':
        return const Color(0xFFECFDF5);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Widget _buildContractCard(Map<String, String> contract) {
    final status = contract['status']!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF94A3B8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contract['name']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      contract['employer']!,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _contractStatusBgColor(status),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: _contractStatusColor(status), width: 1),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _contractStatusColor(status),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _reportStatCol('Contract ID', contract['contractId']!),
              _reportStatCol('Issue Type', contract['issueType']!),
              _reportStatCol('Date Filed', contract['dateFiled']!),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => _showContractModal(context, contract),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7B6FCC), Color(0xFF2E2B6E)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'View Contract',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Contract modal ─────────────────────────────────────────────────────────────

  void _showContractModal(BuildContext ctx, Map<String, String> contract) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.72,
        maxChildSize: 0.92,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── header ─────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contract['contractId']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Carlos Rivera',
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close,
                          size: 24, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),

                // ── Contract Comparison ─────────
                const Text(
                  'Contract Comparison',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      // table header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF3730A3),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        child: Row(
                          children: const [
                            Expanded(
                                flex: 2,
                                child: Text('Field',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white))),
                            Expanded(
                                flex: 3,
                                child: Text('Original Terms',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white))),
                            Expanded(
                                flex: 3,
                                child: Text('Actual Reports',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white))),
                          ],
                        ),
                      ),
                      _comparisonRow('Position', 'Administrative Assistant',
                          'Domestic Helper'),
                      _comparisonRow(
                          'Salary', '2500 AED/month1', '1200 AED/month1'),
                      _comparisonRow('Work Time', '8 hours/day, 5 days/week',
                          '14 hours/day, 6 days/week'),
                      _comparisonRow('Housing', 'Housing Provided by employer',
                          'One room, 6 occupants'),
                      _comparisonRow('Benefits',
                          'Health insurance, annual leave', 'None provided'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Official Notes ─────────
                const Text(
                  'Official Notes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: const TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Add notes about this contract issue...',
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3730A3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Send to Labor Officer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _comparisonRow(String field, String original, String actual) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              field,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF334155),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              original,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF3730A3),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              actual,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF3730A3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ASSISTANCE TAB
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildAssistanceTab() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Work Assistance',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search,
                              size: 20, color: Color(0xFF94A3B8)),
                          SizedBox(width: 10),
                          Text(
                            'Search worker by name or case ID',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAssistanceFilterChips(),
                  const SizedBox(height: 16),
                  ...List.generate(_assistanceCases.length, (i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      child: _buildAssistanceCard(_assistanceCases[i]),
                    );
                  }),
                  const SizedBox(height: 16),
                  _buildPagination(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssistanceFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterChip(
              Icons.location_on_outlined,
              _selectedCountry,
              () => _showFilterModal(
                title: 'Country',
                options: _countryOptions,
                selected: _selectedCountry,
                onSelect: (v) => setState(() => _selectedCountry = v),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildFilterChip(
              Icons.info_outline,
              _selectedStatus == 'All Status' ? 'All Issues' : _selectedStatus,
              () => _showFilterModal(
                title: 'Issues',
                options: _statusOptions,
                selected: _selectedStatus,
                onSelect: (v) => setState(() => _selectedStatus = v),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildFilterChip(
              Icons.filter_alt_outlined,
              _selectedDate == 'All Date' ? 'All Status' : _selectedDate,
              () => _showFilterModal(
                title: 'Status',
                options: _dateOptions,
                selected: _selectedDate,
                onSelect: (v) => setState(() => _selectedDate = v),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _assistanceStatusColor(String status) {
    switch (status) {
      case 'In review':
        return const Color(0xFF3730A3);
      case 'Resolved':
        return _green;
      case 'Critical':
        return _red;
      default:
        return const Color(0xFF64748B);
    }
  }

  Color _assistanceStatusBg(String status) {
    switch (status) {
      case 'In review':
        return const Color(0xFFEEF2FF);
      case 'Resolved':
        return const Color(0xFFECFDF5);
      case 'Critical':
        return const Color(0xFFFEF2F2);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Widget _buildAssistanceCard(Map<String, String> c) {
    final status = c['status']!;
    final isResolved = status == 'Resolved';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
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
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF94A3B8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['name']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      c['country']!,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _assistanceStatusBg(status),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: _assistanceStatusColor(status), width: 1),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _assistanceStatusColor(status),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                text: 'Employer: ',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A)),
              ),
              TextSpan(
                text: c['employer']!,
                style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
            ]),
          ),
          const SizedBox(height: 2),
          RichText(
            text: TextSpan(children: [
              const TextSpan(
                text: 'Issue: ',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A)),
              ),
              TextSpan(
                text: c['issue']!,
                style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
            ]),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _showViewCaseModal(context, c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7B6FCC), Color(0xFF2E2B6E)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'View Case',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: isResolved
                      ? () => _showViewCaseModal(context, c)
                      : () => _showSendGuidanceModal(context, c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color(0xFF3730A3), width: 1.5),
                    ),
                    child: Text(
                      isResolved ? 'View Case' : 'Send Guidance',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3730A3),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── View Case modal ──────────────────────────────────────────────────────────

  void _showViewCaseModal(BuildContext ctx, Map<String, String> c) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.92,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFF334155),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_rounded,
                          color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c['name']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const Text(
                            'Case ID: WKR-2026-1342',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close,
                          size: 24, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),

                // Worker Profile
                const Text(
                  'Worker Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                _profileRow('Name:', 'Maria Santos'),
                _profileRow('Nationality:', 'Filipino'),
                _profileRow('Passport Number:', 'P1234***'),
                _profileRow('Employer:', 'Al Noor Recruitment Co.'),
                _profileRow('Job Title:', 'Domestic Helper'),
                _profileRow('Contract Start:', 'Jan 15, 2025'),
                _profileRow('Contract End:', 'Jan 14, 2027'),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),

                // Case Information
                const Text(
                  'Case Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                _profileRow('Case ID:', 'WKR-2026-1342'),
                _profileRow('Date Reported:', 'Mar 4, 2026'),
                _profileRow('Issue Type:', 'Wage Withholding'),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),

                // Case Timeline
                const Text(
                  'Case Timeline',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 16),
                _timelineItem(
                    'Mar 4, 2026', 'Worker contacted embassy hotline', true),
                _timelineItem(
                    'Mar 5, 2026', 'Case assigned to officer Martinez', true),
                _timelineItem(
                    'Mar 6, 2026', 'Initial consultation conducted', true),
                _timelineItem('Mar 7, 2026',
                    'Legal rights guidance sent to worker', false),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),

                // Linked Documents
                const Text(
                  'Linked Documents',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3730A3),
                  ),
                ),
                const SizedBox(height: 12),
                _documentRow('Employment Contract'),
                const SizedBox(height: 8),
                _documentRow('Job Offer Letter'),
                const SizedBox(height: 8),
                _documentRow('Passport Copy'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _documentRow(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF3730A3),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'View',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3730A3),
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, size: 14, color: Color(0xFF3730A3)),
            ],
          ),
        ],
      ),
    );
  }

  // ── Send Guidance modal ──────────────────────────────────────────────────────

  void _showSendGuidanceModal(BuildContext ctx, Map<String, String> c) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.72,
        maxChildSize: 0.92,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Send Official Guidance',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'to Maria Santos',
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close,
                          size: 24, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE2E8F0)),
                const SizedBox(height: 16),

                // Worker Name
                const Text(
                  'Worker Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                _readOnlyField('Maria Santos'),
                const SizedBox(height: 16),

                // Case ID
                const Text(
                  'Case ID',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                _readOnlyField('WKR-2026-1342'),
                const SizedBox(height: 16),

                // Guidance Type
                const Text(
                  'Guidance Type *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Select Guidance Type...',
                        style:
                            TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                      ),
                      Icon(Icons.keyboard_arrow_down,
                          size: 20, color: Color(0xFF94A3B8)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Guidance Message
                const Text(
                  'Guidance Message *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: const TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Type your message here...',
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: 'Note: ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A)),
                    ),
                    TextSpan(
                      text:
                          'This will be sent directly to the worker via their registered contact method.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ]),
                ),
                const SizedBox(height: 24),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xFFE2E8F0), width: 1.5),
                          ),
                          child: const Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3730A3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Send Guidance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
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
    );
  }

  Widget _readOnlyField(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF0F172A),
        ),
      ),
    );
  }

  // ── Coming-soon placeholder ───────────────────────────────────────────────────

  Widget _buildComingSoon(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction_rounded, size: 64, color: _purple),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Coming Soon',
            style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  // ── Bottom navigation ─────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedTab,
        onTap: (i) => setState(() => _selectedTab = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0F172A),
        unselectedItemColor: const Color(0xFFCBD5E1),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Monitoring',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline_rounded),
            label: 'Assistance',
          ),
        ],
      ),
    );
  }
}

class _RiskGaugePainter extends CustomPainter {
  final double score;
  _RiskGaugePainter(this.score);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.75);
    final radius = size.width * 0.38;
    const startAngle = 0.8 * pi;
    const totalSweep = 1.4 * pi;
    const strokeW = 14.0;

    final bgPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      totalSweep,
      false,
      bgPaint,
    );

    final scoreSweep = totalSweep * (score / 100).clamp(0.0, 1.0);
    final fgPaint = Paint()
      ..color = const Color(0xFFE8552D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      scoreSweep,
      false,
      fgPaint,
    );

    final endAngle = startAngle + scoreSweep;
    final dotX = center.dx + radius * cos(endAngle);
    final dotY = center.dy + radius * sin(endAngle);
    canvas.drawCircle(
      Offset(dotX, dotY),
      strokeW / 2 + 2,
      Paint()..color = const Color(0xFFE8552D),
    );
  }

  @override
  bool shouldRepaint(covariant _RiskGaugePainter oldDelegate) =>
      oldDelegate.score != score;
}
