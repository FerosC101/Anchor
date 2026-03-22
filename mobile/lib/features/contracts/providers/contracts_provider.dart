import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/firestore_service.dart';
import '../../../models/scan_model.dart';

final contractsServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

final contractsProvider = StreamProvider<List<ScanModel>>((ref) {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return const Stream.empty();
  return ref.watch(contractsServiceProvider).watchRecentScans(userId: uid);
});
