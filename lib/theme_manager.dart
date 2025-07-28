import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_canvas/storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  final lightTheme = ThemeData(
    primaryColor: const Color(0xFF53A53F),
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: Colors.white,
    dividerColor: Colors.white54,
    disabledColor: Colors.purple[300],
    textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        //Headline 1
        displayMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        //Headline 2
        displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        //Headline 3
        headlineMedium: TextStyle(fontSize: 18),
        //Headline 4
        headlineSmall: TextStyle(fontSize: 16),
        //Headline 5
        titleLarge: TextStyle(fontSize: 14),
        //Headline 6
        titleMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        titleSmall: TextStyle(fontSize: 10)), dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
  );

  final darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Poppins',
      disabledColor: Colors.purple[300],
      textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          //Headline 1
          displayMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          //Headline 2
          displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          //Headline 3
          headlineMedium: TextStyle(fontSize: 18),
          //Headline 4
          headlineSmall: TextStyle(fontSize: 16),
          //Headline 5
          titleLarge: TextStyle(fontSize: 14),
          //Headline 6
          titleMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          titleSmall: TextStyle(fontSize: 10)),
      scaffoldBackgroundColor: const Color(0xFF111111));

  ThemeData? _themeData;

  ThemeData? get getTheme => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      if (kDebugMode) {
        print('value read from storage: $value');
      }
      var themeMode = value ?? 'dark';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        if (kDebugMode) {
          print('setting dark theme');
        }
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
