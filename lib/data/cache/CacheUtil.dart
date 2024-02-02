import 'package:shared_preferences/shared_preferences.dart';

class CacheUtil {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static void save(String key, dynamic value) {
    if (value is bool) {
      _sharedPreferences?.setBool(key, value);
    } else if (value is double) {
      _sharedPreferences?.setDouble(key, value);
    } else if (value is int) {
      _sharedPreferences?.setInt(key, value);
    } else {
      _sharedPreferences?.setString(key, value.toString());
    }
  }

  static T get<T>(String key, T defaultValue) {
    final dynamic value = _sharedPreferences?.get(key);
    if (value != null) {
      return value as T;
    }
    return defaultValue;
  }

  static void clearCache() {
    _sharedPreferences?.clear();
  }

  static void deleteAt(key) {
    _sharedPreferences?.remove(key);
  }

  static bool contains(String key) {
    final bool? contains = _sharedPreferences?.containsKey(key);
    return contains ?? false;
  }
}
