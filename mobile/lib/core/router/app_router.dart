import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/government_dashboard/screens/government_dashboard_screen.dart';
import '../../features/admin_dashboard/screens/admin_dashboard_home_screen.dart';
import '../../features/alerts/screens/alerts_screen.dart';
import '../../features/community/screens/create_post_screen.dart';
import '../../features/community/screens/feed_screen.dart';
import '../../features/community/screens/my_reports_screen.dart';
import '../../features/community/screens/post_detail_screen.dart';
import '../../features/community/screens/risk_map_screen.dart';
import '../../features/contracts/screens/contracts_screen.dart';
import '../../features/contracts/screens/contract_scan_detail_screen.dart';
import '../../features/jobs/screens/jobs_screen.dart';
import '../../features/ngo/screens/ngo_home_screen.dart';
import '../../models/user_model.dart';
import '../../models/scan_model.dart';

// ─── GoRouter refresh listenable ──────────────────────────────────────────────

class _AuthListenable extends ChangeNotifier {
  late final StreamSubscription<dynamic> _sub;

  _AuthListenable(Stream<dynamic> stream) {
    _sub = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

// ─── Router provider ──────────────────────────────────────────────────────────

final routerProvider = Provider<GoRouter>((ref) {
  final authService = ref.watch(authServiceProvider);
  final notifier = _AuthListenable(authService.authStateChanges);
  ref.onDispose(notifier.dispose);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: notifier,
    redirect: (context, state) {
      final isAuthenticated = authService.currentUser != null;
      final loc = state.matchedLocation;
      final isAuthRoute = loc == '/login' || loc == '/register';

      if (!isAuthenticated && !isAuthRoute) return '/login';
      if (isAuthenticated && isAuthRoute) return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (_, __) => const RegisterScreen(),
      ),
      // /home is the OFW home — other roles are dispatched by _RoleDispatcher
      GoRoute(
        path: '/home',
        builder: (_, __) => const _RoleDispatcher(),
      ),
      GoRoute(
        path: '/community/feed',
        builder: (_, __) => const FeedScreen(),
      ),
      GoRoute(
        path: '/community/create-post',
        builder: (_, __) => const CreatePostScreen(),
      ),
      GoRoute(
        path: '/community/post-detail/:postId',
        builder: (_, state) {
          final postId = state.pathParameters['postId'] ?? '';
          return PostDetailScreen(postId: postId);
        },
      ),
      GoRoute(
        path: '/community/my-reports',
        builder: (_, __) => const MyReportsScreen(),
      ),
      GoRoute(
        path: '/community/risk-map',
        builder: (_, __) => const RiskMapScreen(),
      ),
      GoRoute(
        path: '/contracts/detail',
        builder: (_, state) {
          final scan = state.extra as ScanModel;
          return ContractScanDetailScreen(scan: scan);
        },
      ),
      GoRoute(
        path: '/contracts',
        builder: (_, __) => const ContractsScreen(),
      ),
      GoRoute(
        path: '/jobs',
        builder: (_, __) => const JobsScreen(),
      ),
      GoRoute(
        path: '/alerts',
        builder: (_, __) => const AlertsScreen(),
      ),
    ],
  );
});

// ─── Role dispatcher ──────────────────────────────────────────────────────────
// Reads the signed-in user's role and shows the correct dashboard.
// OFW → HomeScreen (implemented)
// Government / NGO / Admin → placeholder until those dashboards are built.

class _RoleDispatcher extends ConsumerWidget {
  const _RoleDispatcher();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.user;

    // Still loading user from Firestore
    if (authState.isLoading || user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    switch (user.role) {
      case UserRole.ofw:
        return const HomeScreen();
      case UserRole.government:
        return const GovernmentDashboardScreen();
      case UserRole.ngo:
        return const NgoHomeScreen();
      case UserRole.admin:
        return const AdminDashboardHomeScreen();
    }
  }
}
