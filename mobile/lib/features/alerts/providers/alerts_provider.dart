import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/ofw_backend_service.dart';
import '../../../models/notification_model.dart';

final alertsServiceProvider = Provider<OfwBackendService>(
  (ref) => OfwBackendService(),
);

final alertsProvider = StreamProvider<List<AppNotificationModel>>((ref) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return const Stream.empty();
  return ref.watch(alertsServiceProvider).watchUserNotifications(
        uid,
        alertsOnly: true,
      );
});

class AlertsActionNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  OfwBackendService get _service => ref.read(alertsServiceProvider);

  Future<void> markAsRead(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.markNotificationAsRead(id));
  }

  Future<void> archive(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.archiveNotification(id));
  }
}

final alertsActionProvider = AsyncNotifierProvider<AlertsActionNotifier, void>(
  AlertsActionNotifier.new,
);
