import 'package:flutter/material.dart';

abstract class Styles {
  static const secondaryColor = Colors.black;

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryTextTheme: const TextTheme(),
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      textTheme: TextTheme(
          headline4: isDarkTheme
              ? const TextStyle(color: Colors.white, fontSize: 22)
              : const TextStyle(color: Colors.black, fontSize: 22),
          headline5: isDarkTheme
              ? const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w800)
              : const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w800),
          headline6: isDarkTheme
              ? const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)
              : const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w600)),
      iconTheme: IconThemeData(
        color: isDarkTheme ? Colors.white : Colors.black,
      ),
      appBarTheme: AppBarTheme(
          actionsIconTheme:
              IconThemeData(color: isDarkTheme ? Colors.white : Colors.amber),
          elevation: isDarkTheme ? 0 : 0,
          iconTheme:
              IconThemeData(color: isDarkTheme ? Colors.white : Colors.black),
          backgroundColor:
              isDarkTheme ? Colors.transparent : Colors.transparent),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
            TextStyle(color: isDarkTheme ? Colors.white60 : Colors.black54),
      ),
    );
  }
}
