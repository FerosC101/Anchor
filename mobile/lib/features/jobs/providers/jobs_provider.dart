import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/ofw_backend_service.dart';
import '../../../models/job_model.dart';

final jobsServiceProvider = Provider<OfwBackendService>(
  (ref) => OfwBackendService(),
);

final jobsProvider = StreamProvider<List<JobModel>>((ref) {
  return ref.watch(jobsServiceProvider).watchJobListings();
});
