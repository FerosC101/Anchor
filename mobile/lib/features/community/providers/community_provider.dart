import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/ofw_backend_service.dart';
import '../../../models/post_model.dart';
import '../../../models/report_model.dart';

final communityServiceProvider = Provider<OfwBackendService>(
  (ref) => OfwBackendService(),
);

final _uidProvider =
    Provider<String?>((ref) => FirebaseAuth.instance.currentUser?.uid);

final communityPostsProvider = StreamProvider<List<CommunityPostModel>>((ref) {
  return ref.watch(communityServiceProvider).watchCommunityPosts();
});

final riskMapPointsProvider = StreamProvider<List<RiskPoint>>((ref) {
  return ref.watch(communityServiceProvider).watchRiskMapPoints();
});

final myReportsProvider = StreamProvider<List<UserReportModel>>((ref) {
  final uid = ref.watch(_uidProvider);
  if (uid == null) return const Stream.empty();
  return ref.watch(communityServiceProvider).watchMyReports(uid);
});

final communityPostByIdProvider =
    StreamProvider.family<CommunityPostModel?, String>((ref, postId) {
  return ref.watch(communityServiceProvider).watchCommunityPostById(postId);
});

final postCommentsProvider =
    StreamProvider.family<List<CommunityCommentModel>, String>((ref, postId) {
  return ref.watch(communityServiceProvider).watchPostComments(postId);
});

class CommunityActionNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  OfwBackendService get _service => ref.read(communityServiceProvider);
  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  Future<void> submitCommunityReport({
    required String company,
    required String description,
    required String location,
    required List<String> tags,
  }) async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service
        .createCommunityPost(
          userId: uid,
          company: company,
          description: description,
          location: location,
          tags: tags,
        )
        .then((_) {}));
  }

  Future<void> submitUserReport({
    required String title,
    required String description,
    required String location,
    required ReportCategory category,
    bool anonymous = false,
  }) async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service
        .createUserReport(
          reporterId: uid,
          title: title,
          description: description,
          location: location,
          category: category,
          anonymous: anonymous,
        )
        .then((_) {}));
  }

  Future<void> addComment({
    required String postId,
    required String content,
    bool anonymous = true,
  }) async {
    final uid = _uid;
    if (uid == null) throw Exception('User not authenticated');
    final trimmed = content.trim();
    if (trimmed.isEmpty) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service
        .createPostComment(
          postId: postId,
          userId: uid,
          content: trimmed,
          anonymous: anonymous,
        )
        .then((_) {}));
  }
}

final communityActionProvider =
    AsyncNotifierProvider<CommunityActionNotifier, void>(
  CommunityActionNotifier.new,
);
