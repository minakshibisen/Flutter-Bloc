import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

double getScreenWidth(BuildContext context) {
      return MediaQuery.of(context).size.width;
}

ThemeData lightMode(BuildContext context) => ThemeData(
      fontFamily: GoogleFonts.workSans().fontFamily,
      colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            seedColor: AppColors.primaryColor,
            primary: AppColors.primaryColor,
            surface: AppColors.primaryColorDark,
            onPrimary: AppColors.textOnPrimary,
            secondary: AppColors.titleColor,
            onSecondary: AppColors.textColor,
            primaryContainer: AppColors.boxBgColor,
            secondaryContainer: AppColors.boxBgColorLight,
            onPrimaryContainer: AppColors.iconColor,
            onTertiary: AppColors.unselectedColor,
            tertiary: AppColors.titleLightColor,
      ),
      textTheme: TextTheme(
            headlineLarge: TextStyle(
                color: AppColors.primaryColor,
                fontSize: getScreenWidth(context) * .055,
                fontWeight: FontWeight.w700),
            headlineMedium: TextStyle(
                color: AppColors.primaryText,
                fontSize: getScreenWidth(context) * .045,
                fontWeight: FontWeight.w600),
            headlineSmall: TextStyle(
                color: AppColors.primaryText,
                fontSize: getScreenWidth(context) * .035,
                fontWeight: FontWeight.w500),
            bodyLarge: TextStyle(
                color: AppColors.textOnPrimary,
                fontSize: getScreenWidth(context) * .04,
                fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(
                color: AppColors.textColor,
                fontSize: getScreenWidth(context) * .035,
                fontWeight: FontWeight.w400),
            bodySmall: TextStyle(
                color: AppColors.textColor,
                fontSize: getScreenWidth(context) * .03,
                fontWeight: FontWeight.w400),
      ),
      scaffoldBackgroundColor: AppColors.textOnPrimary,
      useMaterial3: true,
);

ThemeData darkMode(BuildContext context) => ThemeData(
      fontFamily: GoogleFonts.workSans().fontFamily,
      primaryColor: AppColorsDark.primaryColor,
      primaryColorDark: AppColorsDark.primaryColorDark,
      colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: AppColorsDark.primaryColor,
            primary: AppColorsDark.primaryColor,
            surface: AppColorsDark.primaryColorDark,
            onPrimary: AppColorsDark.textOnPrimary,
            secondary: AppColorsDark.titleColor,
            onSecondary: AppColorsDark.textColor,
            primaryContainer: AppColorsDark.boxBgColor,
            secondaryContainer: AppColorsDark.boxBgColorLight,
            onPrimaryContainer: AppColorsDark.iconColor,
            onTertiary: AppColorsDark.unselectedColor,
            tertiary: AppColorsDark.titleLightColor,
      ),
      textTheme: TextTheme(
            headlineLarge: TextStyle(
                color: AppColorsDark.textOnPrimary,
                fontSize: getScreenWidth(context) * .055,
                fontWeight: FontWeight.w700),
            headlineMedium: TextStyle(
                color: AppColorsDark.primaryText,
                fontSize: getScreenWidth(context) * .045,
                fontWeight: FontWeight.w600),
            headlineSmall: TextStyle(
                color: AppColorsDark.primaryText,
                fontSize: getScreenWidth(context) * .035,
                fontWeight: FontWeight.w500),
            bodyLarge: TextStyle(
                color: AppColorsDark.textColor,
                fontSize: getScreenWidth(context) * .04,
                fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(
                color: AppColorsDark.textColor,
                fontSize: getScreenWidth(context) * .035,
                fontWeight: FontWeight.w400),
            bodySmall: TextStyle(
                color: AppColorsDark.textColor,
                fontSize: getScreenWidth(context) * .03,
                fontWeight: FontWeight.w400),
      ),
      scaffoldBackgroundColor: AppColorsDark.scaffold,
      useMaterial3: true,
);
