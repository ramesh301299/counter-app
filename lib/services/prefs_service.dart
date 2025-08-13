import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _usersKey = 'users_map_json';      // map {username: password}
  static const _currentUserKey = 'current_user';  // username only

  Future<SharedPreferences> _prefs() => SharedPreferences.getInstance();

  // Get all users (username->password)
  Future<Map<String, String>> getUsers() async {
    final p = await _prefs();
    final raw = p.getString(_usersKey);
    if (raw == null) return {};
    final Map<String, dynamic> decoded = jsonDecode(raw);
    return decoded.map((k, v) => MapEntry(k, v.toString()));
  }

  // Save all users
  Future<void> saveUsers(Map<String, String> users) async {
    final p = await _prefs();
    await p.setString(_usersKey, jsonEncode(users));
  }

  // Session
  Future<String?> getCurrentUsername() async {
    final p = await _prefs();
    return p.getString(_currentUserKey);
  }

  Future<void> setCurrentUsername(String username) async {
    final p = await _prefs();
    await p.setString(_currentUserKey, username);
  }

  Future<void> clearCurrentUser() async {
    final p = await _prefs();
    await p.remove(_currentUserKey);
  }

  // Optional: clear all (for testing)
  Future<void> clearAll() async {
    final p = await _prefs();
    await p.remove(_usersKey);
    await p.remove(_currentUserKey);
  }
}
