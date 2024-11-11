import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xFFffbd59);
  static Color primaryAccent = const Color(0xFFc6e9ed);
  static Color secondaryColor = const Color(0xFF1a2029);
  static Color secondaryAccent = const Color(0xFF28303c);
  static Color titleColor = const Color.fromRGBO(200, 200, 200, 1);
  static Color textColor = const Color.fromARGB(255, 239, 239, 239);
  static Color successColor = const Color.fromRGBO(9, 149, 110, 1);
  static Color highlightColor = const Color.fromRGBO(212, 172, 13, 1);
}

ThemeData primaryTheme = ThemeData(

   // seed color theme
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
  ),

  scaffoldBackgroundColor: AppColors.secondaryColor,

  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 27, 33, 41),
    foregroundColor: AppColors.textColor,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),

  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.textColor,
      fontSize: 16,
      letterSpacing: 1,
    ),
    headlineMedium: TextStyle(
      color: AppColors.titleColor, 
      fontSize: 16,
      fontWeight: FontWeight.bold, 
      letterSpacing: 1,
    ),
    titleMedium: TextStyle(
      color: AppColors.titleColor, 
      fontSize: 18, 
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
    ),
  ),
);