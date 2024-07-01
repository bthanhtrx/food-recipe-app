import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._privateConstructor();

  static final SharedPref instance = SharedPref._privateConstructor();

  static SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> get sharedPref async {
    if (_sharedPreferences != null) return _sharedPreferences!;

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

  Future<String> get unitMeasurement async {
    final sp = await instance.sharedPref;
    return sp.getString('unit_measurement') ?? 'us';
  }

  Future<bool> setUnitMeasurement(String unit) async {
    final sp = await instance.sharedPref;
    return sp.setString('unit_measurement', unit);
  }

  Future<bool> get isVegan async {
    final sp = await instance.sharedPref;
    return sp.getBool('is_vegan') ?? false;
  }

  Future<bool> setIsVegan(bool isVegan) async {
    final sp = await instance.sharedPref;
    return sp.setBool('is_vegan', isVegan);
  }

  Future<bool> get isGlutenFree async {
    final sp = await instance.sharedPref;
    return sp.getBool('is_gluten_free') ?? false;
  }

  Future<bool> setIsGlutenFree(bool isGlutenFree) async {
    final sp = await instance.sharedPref;
    return sp.setBool('is_gluten_free', isGlutenFree);
  }

  Future<bool> get isDairyFree async {
    final sp = await instance.sharedPref;
    return sp.getBool('is_dairy_free') ?? false;
  }

  Future<bool> setIsDairyFree(bool isDairyFree) async {
    final sp = await instance.sharedPref;
    return sp.setBool('is_dairy_free', isDairyFree);
  }
}

final sharedPrefsProvider = Provider((ref) {
  return SharedPref.instance;
});
