import 'package:flutter/material.dart';
import '../models/ngo_models.dart';
import '../widgets/ngo_shared_widgets.dart';
import '../widgets/ngo_alert_card.dart';

class NgoAlertTab extends StatefulWidget {
  const NgoAlertTab({super.key});

  @override
  State<NgoAlertTab> createState() => _NgoAlertTabState();
}

class _NgoAlertTabState extends State<NgoAlertTab> {
  String _searchQuery = '';
  String _selectedCountry = 'All Countries';
  String _selectedIssue = 'All Issues';
  String _selectedStatus = 'All Status';

  List<NgoAlert> get _filtered {
    return mockNgoAlerts.where((a) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        if (!a.employerName.toLowerCase().contains(q) &&
            !a.alertId.toLowerCase().contains(q)) {
          return false;
        }
      }
      if (_selectedCountry != 'All Countries' &&
          a.country != _selectedCountry) return false;
      if (_selectedIssue != 'All Issues' &&
          a.alertType != _selectedIssue) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final alerts = _filtered;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // ── Title ──
          const Text(
            'Alert Generation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),

          // ── "All Reports" label ──
          const Text(
            'All Reports',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),

          // ── Search bar ──
          NgoSearchBar(
            onChanged: (q) => setState(() => _searchQuery = q),
          ),
          const SizedBox(height: 10),

          // ── Filter chips ──
          NgoFilterChips(
            selectedCountry: _selectedCountry,
            selectedIssue: _selectedIssue,
            selectedStatus: _selectedStatus,
            onCountryChanged: (v) =>
                setState(() => _selectedCountry = v),
            onIssueChanged: (v) =>
                setState(() => _selectedIssue = v),
            onStatusChanged: (v) =>
                setState(() => _selectedStatus = v),
          ),
          const SizedBox(height: 16),

          // ── Alert cards ──
          ...alerts.map((alert) => NgoAlertCard(alert: alert)),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
