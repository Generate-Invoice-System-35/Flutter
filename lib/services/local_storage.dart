import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<SharedPreferences>? _sharedPreferences;

  LocalStorage._internal() {
    // ignore: prefer_conditional_assignment
    if (_sharedPreferences == null) {
      _sharedPreferences = SharedPreferences.getInstance();
    }
  }
  factory LocalStorage() {
    return LocalStorage._internal();
  }

  Future<String?> get({required String spKey}) async {
    final res = await _sharedPreferences;
    return Future.value(res?.getString(spKey));
  }

  Future<void> set({required String spKey, required String data}) async {
    final res = await _sharedPreferences;
    await res?.setString(spKey, data);
  }

  Future<void> remove({required String spKey}) async {
    final res = await _sharedPreferences;
    await res?.remove(spKey);
  }
}
