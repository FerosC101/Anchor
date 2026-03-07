import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../models/user_model.dart';

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
      GoRoute(
        path: '/home',
        builder: (_, state) => const _HomeRedirect(),
      ),
    ],
  );
});

// ─── Placeholder home that redirects to the role-specific dashboard ───────────

class _HomeRedirect extends ConsumerWidget {
  const _HomeRedirect();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.user;

    String title;
    Color color;
    IconData icon;

    switch (user?.role) {
      case UserRole.agency:
        title = 'Agency Dashboard';
        color = const Color(0xFF8B5CF6);
        icon = Icons.business_rounded;
      case UserRole.verifier:
        title = 'Verifier Dashboard';
        color = const Color(0xFF10B981);
        icon = Icons.verified_user_rounded;
      default:
        title = 'OFW Dashboard';
        color = const Color(0xFF0EA5E9);
        icon = Icons.flight_takeoff_rounded;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color, color.withOpacity(0.7)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 72, color: Colors.white),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Welcome, ${user?.fullName ?? ''}!',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Status: ${user?.verificationStatus.name ?? ''}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(height: 48),
              TextButton.icon(
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).signOut();
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
