import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlng;

import '../../../models/report_model.dart';
import '../providers/community_provider.dart';

enum _SeverityFilter { all, high, medium, low }

enum _TimeFilter { all, day, week, month }

class RiskMapScreen extends ConsumerStatefulWidget {
  const RiskMapScreen({super.key});

  @override
  ConsumerState<RiskMapScreen> createState() => _RiskMapScreenState();
}

class _RiskMapScreenState extends ConsumerState<RiskMapScreen> {
  _SeverityFilter _severity = _SeverityFilter.all;
  _TimeFilter _time = _TimeFilter.all;
  String _category = 'all';

  @override
  Widget build(BuildContext context) {
    final pointsAsync = ref.watch(riskMapPointsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Risk Map'),
        actions: [
          IconButton(
            tooltip: 'Reset filters',
            onPressed: () {
              setState(() {
                _severity = _SeverityFilter.all;
                _time = _TimeFilter.all;
                _category = 'all';
              });
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: pointsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Failed to load map: $e')),
        data: (points) {
          final filtered = _applyFilters(points);
          final pointsWithCoords =
              filtered.where((p) => p.latitude != null && p.longitude != null);

          final initial = pointsWithCoords.isNotEmpty
              ? latlng.LatLng(pointsWithCoords.first.latitude!,
                  pointsWithCoords.first.longitude!)
              : latlng.LatLng(14.5995, 120.9842);

          return Column(
            children: [
              _buildFilters(points),
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: initial,
                    initialZoom: 6,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.anchor.app',
                    ),
                    MarkerLayer(markers: _buildMarkers(filtered)),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                color: Colors.white,
                child: Text(
                  '${filtered.length} reports shown • ${points.length} total',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilters(List<RiskPoint> points) {
    final categories = <String>{
      'all',
      ...points
          .map((e) => e.category.trim().isEmpty
              ? 'other'
              : e.category.trim().toLowerCase())
          .toSet(),
    }.toList()
      ..sort();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _SeverityFilter.values.map((s) {
              return ChoiceChip(
                label: Text(_severityLabel(s)),
                selected: _severity == s,
                onSelected: (_) => setState(() => _severity = s),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _TimeFilter.values.map((t) {
              return ChoiceChip(
                label: Text(_timeLabel(t)),
                selected: _time == t,
                onSelected: (_) => setState(() => _time = t),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final c = categories[i];
                return ChoiceChip(
                  label: Text(c == 'all' ? 'All Categories' : '#$c'),
                  selected: _category == c,
                  onSelected: (_) => setState(() => _category = c),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<RiskPoint> _applyFilters(List<RiskPoint> points) {
    final now = DateTime.now();

    return points.where((p) {
      final bySeverity = switch (_severity) {
        _SeverityFilter.all => true,
        _SeverityFilter.high => p.score >= 70,
        _SeverityFilter.medium => p.score >= 40 && p.score < 70,
        _SeverityFilter.low => p.score < 40,
      };

      final byTime = switch (_time) {
        _TimeFilter.all => true,
        _TimeFilter.day => now.difference(p.createdAt).inHours <= 24,
        _TimeFilter.week => now.difference(p.createdAt).inDays <= 7,
        _TimeFilter.month => now.difference(p.createdAt).inDays <= 30,
      };

      final normalized =
          p.category.trim().isEmpty ? 'other' : p.category.trim().toLowerCase();
      final byCategory = _category == 'all' || normalized == _category;

      return bySeverity && byTime && byCategory;
    }).toList();
  }

  List<Marker> _buildMarkers(List<RiskPoint> points) {
    return points
        .where((p) => p.latitude != null && p.longitude != null)
        .map(
          (p) => Marker(
            point: latlng.LatLng(p.latitude!, p.longitude!),
            width: 18,
            height: 18,
            child: Container(
              decoration: BoxDecoration(
                color: p.score >= 70
                    ? Colors.red
                    : p.score >= 40
                        ? Colors.orange
                        : Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  String _severityLabel(_SeverityFilter s) => switch (s) {
        _SeverityFilter.all => 'All Severity',
        _SeverityFilter.high => 'High',
        _SeverityFilter.medium => 'Medium',
        _SeverityFilter.low => 'Low',
      };

  String _timeLabel(_TimeFilter t) => switch (t) {
        _TimeFilter.all => 'All Time',
        _TimeFilter.day => '24h',
        _TimeFilter.week => '7d',
        _TimeFilter.month => '30d',
      };
}
