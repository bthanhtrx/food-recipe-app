import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/core/common/shared_pref.dart';

final appThemeProvider = StateProvider(
      (ref) {
    return ThemeMode.light;
  },
);

final isDarkMode = StateProvider((ref) {
  return ref.watch(appThemeProvider) == ThemeMode.dark;
});

final userNameProvider = StateNotifierProvider<UserNameNotifier, String>(
      (ref) {
    return UserNameNotifier(ref.read(sharedPrefsProvider));
  },
);

final unitMeasurementProvider =
StateNotifierProvider<UnitMeasurementNotifier, String>(
      (ref) {
    return UnitMeasurementNotifier(ref.read(sharedPrefsProvider));
  },
);

class UserNameNotifier extends StateNotifier<String> {
  final SharedPref sp;

  UserNameNotifier(this.sp) : super('') {
    _getUserName();
  }

  void _getUserName() async {
    state = await sp.userName;
  }

  void setUserName(String userName) {
    state = userName;
    sp.setUserName(userName);
  }
}

class UnitMeasurementNotifier extends StateNotifier<String> {
  final SharedPref sp;

  UnitMeasurementNotifier(this.sp) : super('') {
    _getUnitMeasurement();
  }

  void _getUnitMeasurement() async {
    state = await sp.unitMeasurement;
  }

  void setUnitMeasurement(String unit) async {
    state = unit;
    sp.setUnitMeasurement(unit);
  }
}

class IsVeganProvider extends StateNotifier<bool> {
  final SharedPref sp;

  IsVeganProvider(this.sp) : super(false) {
    _getIsVegan();
  }

  void _getIsVegan() async {
    state = await sp.isVegan;
  }

  void setIsVegan(bool value) async {
    state = value;
    sp.setIsVegan(value);
  }
}

final isVeganProvider = StateNotifierProvider<IsVeganProvider, bool>((ref) {
  return IsVeganProvider(ref.read(sharedPrefsProvider));
},);

class IsDairyFreeNotifier extends StateNotifier<bool> {
  final SharedPref sp;

  IsDairyFreeNotifier(this.sp) : super(false) {
    _getIsDairyFree();
  }

  void _getIsDairyFree() async {
    state = await sp.isDairyFree;
  }

  void setIsDairyFree(bool value) async {
    state = value;
    sp.setIsDairyFree(value);
  }
}

final isDairyFreeProvider = StateNotifierProvider<IsDairyFreeNotifier, bool>((
    ref) {
  return IsDairyFreeNotifier(ref.read(sharedPrefsProvider));
},);

class IsGlutenFreeNotifier extends StateNotifier<bool> {
  final SharedPref sp;

  IsGlutenFreeNotifier(this.sp) : super(false) {
    _getIsGlutenFree();
  }

  void _getIsGlutenFree() async {
    state = await sp.isGlutenFree;
  }

  void setIsGlutenFree(bool value) async {
    state = value;
    sp.setIsGlutenFree(value);
  }
}

final isGlutenFreeProvider = StateNotifierProvider<IsGlutenFreeNotifier, bool>((
    ref) {
  return IsGlutenFreeNotifier(ref.read(sharedPrefsProvider));
},);

final servingsProvider = StateProvider<int>((ref) {
  return 1;
},);

final cuisinesProvider = StateProvider<String>((ref) {
  return '';
},);
