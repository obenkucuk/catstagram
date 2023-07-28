import 'package:catstagram/constants/app_constants.dart';
import 'package:catstagram/theme/app_colors.dart';
import 'package:flutter/material.dart';

@immutable
final class AppTheme {
  AppTheme()
      : _lightTheme = ThemeData.light(),
        _darkTheme = ThemeData.dark();

  late final ThemeData _lightTheme;
  late final ThemeData _darkTheme;

  ThemeData get lightTheme => _lightTheme.copyWith(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColorsX.backgroundLight,
        primaryIconTheme: const IconThemeData(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.black),
        cardColor: AppColorsX.cardLight,
        dividerColor: AppColorsX.dividerLight,
        shadowColor: Colors.black26,
        primaryColor: Colors.red,
        colorScheme: const ColorScheme(
          primary: AppColorsX.primary,
          onPrimary: AppColorsX.textLightTheme,
          primaryContainer: AppColorsX.primaryContainerLight,
          secondary: AppColorsX.secondary,
          onSecondary: Colors.white,
          secondaryContainer: AppColorsX.secondaryContainer,
          surface: Colors.white,
          onSurface: AppColorsX.textLightTheme,
          background: AppColorsX.backgroundLight,
          onBackground: AppColorsX.textLightTheme,
          error: AppColorsX.secondary,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppColorsX.backgroundLight,
          margin: EdgeInsets.zero,
        ),

        /// where "light" is FontWeight.w300, "regular" is FontWeight.w400 and "medium" is FontWeight.w500.
        textTheme: const TextTheme(
          /// Label TextTheme
          labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),

          /// Body TextTheme
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),

          /// Title TextTheme
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),

          /// Headline TextTheme
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),

          /// Display TextTheme
          displaySmall: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          displayMedium: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          displayLarge: TextStyle(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textLightTheme,
            fontFamily: AppConstants.fontFamily,
          ),
        ),

        /// Button TextTheme
        buttonTheme: const ButtonThemeData(),

        /// Button

        /// ElevatedButton TextTheme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all<Color>(AppColorsX.blue),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 5)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey.shade400,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          filled: true,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textLightTheme,
          ),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColorsX.primary,
          selectionColor: Colors.amber,
          selectionHandleColor: AppColorsX.primary,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            foregroundColor: MaterialStateProperty.all<Color>(AppColorsX.primary),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: AppColorsX.primary,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: AppColorsX.primary)),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: AppColorsX.textLightTheme,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all<Color?>(AppColorsX.primary),
          checkColor: MaterialStateProperty.all<Color?>(Colors.white),
          side: const BorderSide(width: 0.7, color: AppColorsX.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all<Color>(AppColorsX.primary),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColorsX.dividerLight,
          thickness: 1,
          space: 0,
        ),
        appBarTheme: const AppBarTheme(
          titleSpacing: 0,
          elevation: 0,
          color: AppColorsX.backgroundLight,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColorsX.darkBoldText,
          ),
          centerTitle: true,
          actionsIconTheme: IconThemeData(color: AppColorsX.textLightTheme),
          iconTheme: IconThemeData(color: AppColorsX.textLightTheme),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: AppColorsX.textLightTheme,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColorsX.primary,
          ),
          unselectedLabelColor: AppColorsX.unSelectedColor,
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColorsX.unSelectedColor,
          ),
        ),
        indicatorColor: AppColorsX.indicatorLightColor,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
          shape: CircleBorder(),
        ),
      );

  ThemeData get darkTheme => _darkTheme.copyWith(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColorsX.backgroundDark,
        primaryIconTheme: const IconThemeData(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.black),
        cardColor: AppColorsX.primaryContainerDark,
        dividerColor: AppColorsX.dividerDark,
        shadowColor: Colors.black26,
        primaryColor: Colors.greenAccent,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColorsX.primary,
          onPrimary: AppColorsX.textDarkTheme,
          primaryContainer: AppColorsX.primaryContainerDark,
          onPrimaryContainer: AppColorsX.primaryContainerDark,
          secondary: AppColorsX.secondary,
          onSecondary: Colors.white,
          secondaryContainer: AppColorsX.secondaryContainer,
          onSecondaryContainer: AppColorsX.secondaryContainer,
          surface: Colors.white,
          onSurface: AppColorsX.textDarkTheme,
          background: AppColorsX.backgroundDark,
          onBackground: AppColorsX.textDarkTheme,
          error: AppColorsX.secondary,
          onError: Colors.white,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppColorsX.backgroundDark,
          margin: EdgeInsets.zero,
        ),
        textTheme: const TextTheme(
          /// Label TextTheme
          labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),

          /// Body TextTheme
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),

          /// Title TextTheme
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),

          /// Headline TextTheme
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),

          /// Display TextTheme
          displaySmall: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          displayMedium: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),
          displayLarge: TextStyle(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textDarkTheme,
            fontFamily: AppConstants.fontFamily,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all<Color>(AppColorsX.blue),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 5)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColorsX.inputDecorationDark,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColorsX.textDarkTheme,
          ),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColorsX.paleTextDarkTheme,
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColorsX.primary,
          selectionColor: AppColorsX.primaryContainerLight,
          selectionHandleColor: AppColorsX.primaryContainerLight.withOpacity(0.2),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            foregroundColor: MaterialStateProperty.all<Color>(AppColorsX.primary),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: AppColorsX.primary,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: AppColorsX.primary)),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                color: AppColorsX.textDarkTheme,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all<Color?>(AppColorsX.primary),
          checkColor: MaterialStateProperty.all<Color?>(Colors.white),
          side: const BorderSide(width: 0.7, color: AppColorsX.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        radioTheme: RadioThemeData(fillColor: MaterialStateProperty.all<Color>(AppColorsX.primary)),
        dividerTheme: const DividerThemeData(color: AppColorsX.dividerDark, thickness: 1, space: 0),
        appBarTheme: const AppBarTheme(
          titleSpacing: 0,
          elevation: 0,
          color: AppColorsX.backgroundDark,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          centerTitle: true,
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: AppColorsX.textDarkTheme,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColorsX.primary,
          ),
          unselectedLabelColor: AppColorsX.unSelectedColor,
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColorsX.unSelectedColor,
          ),
        ),
        indicatorColor: AppColorsX.indicatorDarkColor,
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white, elevation: 0),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(),
      );
}
