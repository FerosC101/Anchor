import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/community/screens/community_post_detail_screen.dart';
import '../../features/contracts/screens/contract_scan_detail_screen.dart';
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
        path: '/community/post-detail',
        builder: (_, __) => const CommunityPostDetailScreen(),
      ),
      GoRoute(
        path: '/contracts/detail',
        builder: (_, state) {
          final scan = state.extra as ScanModel;
          return ContractScanDetailScreen(scan: scan);
        },
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
        return _ComingSoonScaffold(
          title: 'Government Dashboard',
          icon: Icons.account_balance_rounded,
          color: const Color(0xFF8B5CF6),
          ref: ref,
        );
      case UserRole.ngo:
        return _ComingSoonScaffold(
          title: 'NGO Dashboard',
          icon: Icons.volunteer_activism_rounded,
          color: const Color(0xFF10B981),
          ref: ref,
        );
      default:
        return _ComingSoonScaffold(
          title: 'Admin Dashboard',
          icon: Icons.admin_panel_settings_rounded,
          color: const Color(0xFFF59E0B),
          ref: ref,
        );
    }
  }
}

class _ComingSoonScaffold extends StatelessWidget {
  const _ComingSoonScaffold({
    required this.title,
    required this.icon,
    required this.color,
    required this.ref,
  });

  final String title;
  final IconData icon;
  final Color color;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color, color.withValues(alpha: 0.7)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 72, color: Colors.white),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Coming soon',
                  style: TextStyle(fontSize: 15, color: Colors.white70),
                ),
                const SizedBox(height: 48),
                TextButton.icon(
                  onPressed: () =>
                      ref.read(authNotifierProvider.notifier).signOut(),
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
