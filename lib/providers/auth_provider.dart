import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:counter_app/model/user.dart';
import 'package:counter_app/repositories/auth_service.dart';
import 'package:counter_app/services/prefs_service.dart';

// Services
final prefsServiceProvider = Provider<PrefsService>((ref) => PrefsService());
final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(ref.read(prefsServiceProvider)),
);

// AuthController with SharedPreferences backing
class AuthController extends StateNotifier<User?> {
  final AuthService _service;
  AuthController(this._service) : super(null);

  // Splash will call this once
  Future<void> loadSession() async {
    state = await _service.currentUser();
  }

  Future<bool> signup(String username, String password) async {
    final ok = await _service.signup(username, password);
    return ok; // state not set here; ask user to login after sign up
  }

  Future<bool> login(String username, String password) async {
    final ok = await _service.login(username, password);
    if (ok) {
      state = await _service.currentUser();
    }
    return ok;
  }

  Future<void> logout() async {
    await _service.logout();
    state = null;
  }
}

final authProvider =
    StateNotifierProvider<AuthController, User?>((ref) {
  final service = ref.read(authServiceProvider);
  return AuthController(service);
});
