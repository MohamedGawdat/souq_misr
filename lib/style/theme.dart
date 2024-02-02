import 'package:flutter/material.dart';
import 'app_colors.dart';

ColorScheme myColorScheme = ColorScheme(
  primary: AppColors.primaryGreen,
  primaryContainer: AppColors.primaryGreen.darker(),
  secondary: AppColors.primaryGreen.lighter(),
  surface: Colors.white,
  background: AppColors.surfaceLight, // A light grey for the background
  error: Colors.red, // Standard error color
  onPrimary: Colors.white, // Text color on primary color, assuming primary is dark enough for white text
  onSecondary: Colors.black, // Text color on secondary color
  onSurface: Colors.black, // Text color on surface color
  onBackground: Colors.black, // Text color on background color
  onError: Colors.white, // Text color on error color
  brightness: Brightness.light,
  // Overall theme brightness
);

extension ColorExtension on Color {
  Color darker([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount should be between 0 and 1');
    HSLColor hsl = HSLColor.fromColor(this);
    double lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  Color lighter([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount should be between 0 and 1');
    HSLColor hsl = HSLColor.fromColor(this);
    double lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
}

class AppTheme {
  static mainTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.surfaceLight,
      colorScheme: myColorScheme,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        // backgroundColor: AppColors.mainAppColor,
        // elevation: 0,
        // actionsIconTheme: IconThemeData(color: Colors.white, opacity: 1, size: 24),
        // iconTheme: IconThemeData(color: Colors.white, opacity: 1, size: 24),
      ),

      // tabBarTheme: const TabBarTheme(
      //   labelColor: AppColors.baseWhite,
      //   unselectedLabelColor: Colors.black,
      //   indicator: BoxDecoration(
      //     border: Border(
      //       bottom: BorderSide(
      //         color: AppColors.baseWhite,
      //         width: 2,
      //         style: BorderStyle.solid,
      //       ),
      //     ),
      //   ),
      // ),
      // colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.kPrimaryColor).copyWith(background: AppColors.mainBackGroundColor),
      // textTheme: const TextTheme()
      // primaryIconTheme: IconThemeData(color: AppColors.mainAppColor),
    );
  }
}
