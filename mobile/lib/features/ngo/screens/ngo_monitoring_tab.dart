import 'package:flutter/material.dart';
import '../models/ngo_models.dart';
import '../widgets/ngo_shared_widgets.dart';
import '../widgets/ngo_monitoring_card.dart';

class NgoMonitoringTab extends StatefulWidget {
  const NgoMonitoringTab({super.key});

  @override
  State<NgoMonitoringTab> createState() => _NgoMonitoringTabState();
}

class _NgoMonitoringTabState extends State<NgoMonitoringTab> {
  String _searchQuery = '';
  String _selectedCountry = 'All Countries';
  String _selectedIssue = 'All Issues';
  String _selectedStatus = 'All Status';

  List<NgoIncidentReport> get _filtered {
    return mockNgoReports.where((r) {
      final matchQuery = _searchQuery.isEmpty ||
          r.workerName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          r.reportId.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchCountry =
          _selectedCountry == 'All Countries' || r.country == _selectedCountry;
      final matchIssue =
          _selectedIssue == 'All Issues' || r.issue == _selectedIssue;
      final matchStatus = _selectedStatus == 'All Status' ||
          ngoCaseStatusLabel(r.status) == _selectedStatus;
      return matchQuery && matchCountry && matchIssue && matchStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          const Text(
            'Report Management',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 20),

          ngoSectionTitle('All Reports'),
          const SizedBox(height: 12),
          NgoSearchBar(onChanged: (v) => setState(() => _searchQuery = v)),
          const SizedBox(height: 12),
          NgoFilterChips(
            selectedCountry: _selectedCountry,
            selectedIssue: _selectedIssue,
            selectedStatus: _selectedStatus,
            onCountryChanged: (v) => setState(() => _selectedCountry = v),
            onIssueChanged: (v) => setState(() => _selectedIssue = v),
            onStatusChanged: (v) => setState(() => _selectedStatus = v),
          ),
          const SizedBox(height: 16),

          ..._filtered.map((r) => NgoMonitoringCard(report: r)),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
