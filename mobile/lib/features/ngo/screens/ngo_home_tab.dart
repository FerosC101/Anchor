import 'package:flutter/material.dart';
import '../models/ngo_models.dart';
import '../widgets/ngo_shared_widgets.dart';
import '../widgets/ngo_stat_card.dart';
import '../widgets/ngo_incident_card.dart';
import '../widgets/ngo_employer_card.dart';

class NgoHomeTab extends StatefulWidget {
  const NgoHomeTab({super.key});

  @override
  State<NgoHomeTab> createState() => _NgoHomeTabState();
}

class _NgoHomeTabState extends State<NgoHomeTab> {
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

          // Dashboard header
          const Text(
            'Dashboard Overview',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 20),

          const NgoStatCardGrid(),
          const SizedBox(height: 24),

          ngoSectionTitle('Recent Incident Reports'),
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

          ..._filtered.map((r) => NgoIncidentCard(report: r)),

          const SizedBox(height: 24),
          ngoSectionTitle('High Risk Employers'),
          const SizedBox(height: 12),
          ...mockNgoEmployers.map((e) => NgoEmployerCard(employer: e)),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
