import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;
class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static const _keyUsername = 'username';
  // static const _keyPets = 'pets';
  // static const _keyBirthday = 'birthday';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences?.setString(_keyUsername, username);

  static String? getUsername() => _preferences!.getString(_keyUsername);
}