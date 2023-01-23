import 'package:flutter/material.dart';

abstract class Styles {
  static const secondaryColor = Colors.black;

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryTextTheme: const TextTheme(),
      primaryColor: isDarkTheme ? Colors.white : Colors.black,
      brightness: isDarkTheme ? Brightness.light : Brightness.dark,
      textTheme: TextTheme(
          headline4: isDarkTheme
              ? const TextStyle(color: Colors.black, fontSize: 22)
              : const TextStyle(color: Colors.white, fontSize: 22),
          headline5: isDarkTheme
              ? const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w800)
              : const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w800),
          headline6: isDarkTheme
              ? const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w800)
              : const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w800)),
      iconTheme: IconThemeData(
        color: isDarkTheme ? Colors.black : Colors.white,
      ),
      appBarTheme: AppBarTheme(
          actionsIconTheme:
              IconThemeData(color: isDarkTheme ? Colors.black : Colors.white),
          elevation: isDarkTheme ? 0 : 0,
          iconTheme:
              IconThemeData(color: isDarkTheme ? Colors.black : Colors.white),
          backgroundColor:
              isDarkTheme ? Colors.transparent : Colors.transparent),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
            TextStyle(color: isDarkTheme ? Colors.black54 : Colors.white60),
      ),
    );
  }
}
