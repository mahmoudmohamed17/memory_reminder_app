import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPrefsHelper {
  final SharedPreferences _prefs;

  SharedPrefsHelper(this._prefs);

  /// Setters
  Future<void> setInt({required String key, required int value}) async {
    await _prefs.setInt(key, value);
  }

  Future<void> setBool({required String key, required bool value}) async {
    await _prefs.setBool(key, value);
  }

  Future<void> setString({required String key, required String value}) async {
    await _prefs.setString(key, value);
  }

  Future<void> setDouble({required String key, required double value}) async {
    await _prefs.setDouble(key, value);
  }

  /// Getters
  int getInt(String key) {
    return _prefs.getInt(key) ?? 0;
  }

  bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  String getString(String key) {
    return _prefs.getString(key) ?? '';
  }

  double getDouble(String key) {
    return _prefs.getDouble(key) ?? 0.0;
  }
}
