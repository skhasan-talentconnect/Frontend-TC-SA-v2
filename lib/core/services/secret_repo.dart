import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecretRepo {
  static final _storage = const FlutterSecureStorage();

  /// Save a value
  static Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read a value
  static Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  /// Remove a single key
  static Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }

  /// Clear all stored data
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
