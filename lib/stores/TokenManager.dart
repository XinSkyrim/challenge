import 'package:flutter_challenge/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  // Initialize token
  // Returns the instance of persistent storage
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = '';

  Future<void> init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  // Set token
  Future<void> setToken(String val) async {
    // 1. Get persistent storage instance
    final prefs = await _getInstance();
    prefs.setString(
      GlobalConstants.TOKEN_KEY,
      val,
    ); // Persist token to disk
    _token = val;
  }

  // Get token
  String getToken() {
    return _token;
  }

  // Remove token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY); // Remove from disk
    _token = ""; // Clear from memory
  }
}

final tokenManager = TokenManager();
