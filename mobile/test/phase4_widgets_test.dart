import 'package:anchor/features/alerts/screens/alert_detail_screen.dart';
import 'package:anchor/features/jobs/screens/report_job_screen.dart';
import 'package:anchor/features/shield/widgets/exit_simulation_dialog.dart';
import 'package:anchor/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ExitSimulationDialog renders dynamic values', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ExitSimulationDialog(
            netSafetyNet: 3200,
            estimatedFlightCost: 450,
            outstandingDebt: 1500,
            remainingRunway: 1250,
            survivalMonths: 1,
          ),
        ),
      ),
    );

    expect(find.text('Exit Simulation'), findsOneWidget);
    expect(find.text(r'$3200'), findsOneWidget);
    expect(find.text(r'-$450'), findsOneWidget);
    expect(find.text(r'-$1500'), findsOneWidget);
    expect(find.text(r'$1250'), findsOneWidget);
  });

  testWidgets('AlertDetailScreen shows alert content', (tester) async {
    final alert = AppNotificationModel(
      id: 'a1',
      userId: 'u1',
      title: 'Safety Alert',
      message: 'High risk employer reported nearby.',
      kind: AppNotificationKind.alert,
      severity: AlertSeverity.high,
      read: false,
      archived: false,
      targetRoute: '/community/risk-map',
      createdAt: DateTime(2026, 3, 15),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: AlertDetailScreen(alert: alert),
      ),
    );

    expect(find.text('Safety Alert'), findsOneWidget);
    expect(find.text('High risk employer reported nearby.'), findsOneWidget);
    expect(find.textContaining('Severity: HIGH'), findsOneWidget);
  });

  testWidgets('ReportJobScreen renders submission form', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: ReportJobScreen(jobTitle: 'Caregiver - Singapore'),
        ),
      ),
    );

    expect(find.text('Report Job Listing'), findsOneWidget);
    expect(find.text('Caregiver - Singapore'), findsOneWidget);
    expect(find.text('Submit Report'), findsOneWidget);
  });
}
