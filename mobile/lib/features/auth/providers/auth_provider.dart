import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/auth_service.dart';
import '../../../models/user_model.dart';

// ─── Service provider ─────────────────────────────────────────────────────────

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(),
);

// ─── Firebase auth-state stream (bool: isAuthenticated) ──────────────────────

final authStateProvider = StreamProvider<User?>(
  (ref) => ref.watch(authServiceProvider).authStateChanges,
);

// ─── Auth Notifier state ──────────────────────────────────────────────────────

class AuthState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
    bool clearError = false,
    bool clearUser = false,
  }) {
    return AuthState(
      user: clearUser ? null : user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

// ─── Auth Notifier ────────────────────────────────────────────────────────────

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _service;

  AuthNotifier(this._service) : super(const AuthState()) {
    _loadCurrentUser();
  }

  // ── Load on cold start ────────────────────────────────────────────────────

  Future<void> _loadCurrentUser() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _service.loadCurrentUser();
      state = state.copyWith(user: user, isLoading: false);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  // ── Sign In ────────────────────────────────────────────────────────────────

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _service.signIn(email: email, password: password);
      state = state.copyWith(user: user, isLoading: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred. Please try again.',
      );
      return false;
    }
  }

  // ── Register ───────────────────────────────────────────────────────────────

  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
    required String phoneNumber,
    required String country,
    Map<String, dynamic>? roleData,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _service.register(
        email: email,
        password: password,
        fullName: fullName,
        role: role,
        phoneNumber: phoneNumber,
        country: country,
        roleData: roleData,
      );
      state = state.copyWith(user: user, isLoading: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred. Please try again.',
      );
      return false;
    }
  }

  // ── Sign Out ───────────────────────────────────────────────────────────────

  Future<void> signOut() async {
    await _service.signOut();
    state = const AuthState();
  }

  /// Clears any displayed error message.
  void clearError() => state = state.copyWith(clearError: true);
}

// ─── Provider ─────────────────────────────────────────────────────────────────

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authServiceProvider));
});
