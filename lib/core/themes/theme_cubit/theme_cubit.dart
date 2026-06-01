import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/constants.dart';
import '../../services/prefs.dart';
import '../dark_theme.dart';
import '../light_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme);

  void getCurrentTheme() {
    bool isDark = Prefs.getBool(kIsDarkMode);
    if (isDark) {
      emit(darkTheme);
    } else {
      emit(lightTheme);
    }
  }

  void toggleTheme() {
    setTheme(!Prefs.getBool(kIsDarkMode));
  }

  void setTheme(bool isDark) {
    Prefs.setBool(kIsDarkMode, isDark);
    emit(isDark ? darkTheme : lightTheme);
  }
}
