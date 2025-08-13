import 'package:counter_app/model/user.dart';
import 'package:counter_app/services/prefs_service.dart';

class AuthService {
  final PrefsService _prefs;
  AuthService(this._prefs);

  // SIGNUP: If username exists -> false; else save and true
  Future<bool> signup(String username, String password) async {
    final users = await _prefs.getUsers();
    if (users.containsKey(username)) return false;
    users[username] = password;
    await _prefs.saveUsers(users);
    return true;
  }

  // LOGIN: Verify from stored users, save session if ok
  Future<bool> login(String username, String password) async {
    final users = await _prefs.getUsers();
    if (users[username] == password) {
      await _prefs.setCurrentUsername(username);
      return true;
    }
    return false;
  }

  // LOGOUT: clear session
  Future<void> logout() async {
    await _prefs.clearCurrentUser();
  }

  // Load current user (for Splash auto-login)
  Future<User?> currentUser() async {
    final username = await _prefs.getCurrentUsername();
    if (username == null) return null;
    final users = await _prefs.getUsers();
    final pwd = users[username];
    if (pwd == null) return null;
    return User(username: username, password: pwd);
  }
}
