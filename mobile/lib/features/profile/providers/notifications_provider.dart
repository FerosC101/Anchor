import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/ofw_backend_service.dart';
import '../../../models/notification_model.dart';

final notificationsServiceProvider = Provider<OfwBackendService>(
  (ref) => OfwBackendService(),
);

final userNotificationsProvider =
    StreamProvider<List<AppNotificationModel>>((ref) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return const Stream.empty();
  return ref.watch(notificationsServiceProvider).watchUserNotifications(uid);
});

class NotificationsActionNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  OfwBackendService get _service => ref.read(notificationsServiceProvider);

  Future<void> markAsRead(String notificationId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _service.markNotificationAsRead(notificationId),
    );
  }

  Future<void> archive(String notificationId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _service.archiveNotification(notificationId),
    );
  }
}

final notificationsActionProvider =
    AsyncNotifierProvider<NotificationsActionNotifier, void>(
  NotificationsActionNotifier.new,
);
