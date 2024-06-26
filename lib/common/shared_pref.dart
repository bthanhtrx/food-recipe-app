import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._privateConstructor();
  static final SharedPref instance = SharedPref._privateConstructor();

  static SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> get sharedPref async {
    if(_sharedPreferences != null) return _sharedPreferences!;

    _sharedPreferences = await _initSharedPref();
    return _sharedPreferences!;

  }

  Future<SharedPreferences> _initSharedPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  Future<bool> get isDarkMode async {
    final sp = await instance.sharedPref;
    return sp.getBool('is_dark_mode') ?? false;
  }

  Future<bool> setDarkMode(bool isDark) async {
    final sp = await instance.sharedPref;
    return sp.setBool('is_dark_mode', isDark);
  }

  Future<String> get userName async {
    final sp = await instance.sharedPref;
    return sp.getString('user_name') ?? 'User';
  }

  Future<bool> setUserName(String userName) async {
    final sp = await instance.sharedPref;
    return sp.setString('user_name', userName);
  }
}

final sharedPrefsProvider = Provider((ref) {
  return SharedPref.instance;
});