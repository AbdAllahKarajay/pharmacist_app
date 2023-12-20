import 'package:flutter/material.dart';

import 'palette.dart';

part "text_theme.dart";

class ThemeConfig {
  static TextTheme _textTheme(bool isDarkMode) => TextTheme(
        displayLarge: TextThemeConfig.displayLarge(isDarkMode),
        displayMedium: TextThemeConfig.displayMedium(isDarkMode),
        displaySmall: TextThemeConfig.displaySmall(isDarkMode),
        headlineLarge: TextThemeConfig.headLineLarge(isDarkMode),
        headlineMedium: TextThemeConfig.headlineMedium(isDarkMode),
        headlineSmall: TextThemeConfig.headlineSmall(isDarkMode),
        titleLarge: TextThemeConfig.titleLarge(isDarkMode),
        titleMedium: TextThemeConfig.titleMedium(isDarkMode),
        titleSmall: TextThemeConfig.titleSmall(isDarkMode),
        bodyLarge: TextThemeConfig.bodyLarge(isDarkMode),
        bodyMedium: TextThemeConfig.bodyMedium(isDarkMode),
        bodySmall: TextThemeConfig.bodySmall(isDarkMode),
        labelLarge: TextThemeConfig.labelLarge(isDarkMode),
        labelSmall: TextThemeConfig.labelSmall(isDarkMode),
      );

  static ButtonThemeData _buttonTheme(bool isDarkMode) => const ButtonThemeData(
        padding: EdgeInsets.all(12),
        disabledColor: ColorConfig.DISABLED,
        // buttonColor: ColorConfig.
      );

  static IconThemeData _iconTheme(bool isDarkMode) =>
      IconThemeData(color: isDarkMode ? ColorConfig.WHITE : ColorConfig.BLACK);

  static ListTileThemeData _listTileTheme(bool isDarkMode) => ListTileThemeData(
        // selectedTileColor: isDarkMode ? ColorConfig.BLACK : ColorConfig.WHITE,
        selectedTileColor: isDarkMode
            ? ColorConfig.WHITE.withOpacity(0.15)
            : ColorConfig.WHITE,
        iconColor: isDarkMode ? ColorConfig.WHITE : ColorConfig.primary,
        tileColor: Colors.transparent,
      );

  static CardTheme _cardTheme(bool isDarkMode) => CardTheme(
        color: isDarkMode ? ColorConfig.DARK_CARD : ColorConfig.CARD,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // : const EdgeInsets.all(10),
        clipBehavior: Clip.hardEdge,
        surfaceTintColor: ColorConfig.primary,
      );

  static ColorScheme _colorScheme(bool isDarkMode) => isDarkMode
      ? const ColorScheme.dark(
          background: ColorConfig.DARK_BACKGROUND,
          primary: ColorConfig.primaryDark,
          onPrimary: ColorConfig.BLACK,
          onSecondary: ColorConfig.WHITE,
          primaryContainer: ColorConfig.DARK_CARD)
      : const ColorScheme.light(
          background: ColorConfig.BACKGROUND,
          primary: ColorConfig.primaryLight,
          onPrimary: ColorConfig.WHITE,
          onSecondary: ColorConfig.BLACK,
          primaryContainer: ColorConfig.GREY);

  static AppBarTheme _appBarTheme(bool isDarkMode) => AppBarTheme(
      backgroundColor:
          isDarkMode ? ColorConfig.primary : ColorConfig.primaryLight,
    iconTheme: _iconTheme(true),
  );

  static ThemeData themeData(bool isDarkMode) => ThemeData(
      fontFamily: 'Poppins',
      textTheme: _textTheme(isDarkMode),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      buttonTheme: _buttonTheme(isDarkMode),
      iconTheme: _iconTheme(isDarkMode),
      listTileTheme: _listTileTheme(isDarkMode),
      cardTheme: _cardTheme(isDarkMode),
      appBarTheme: _appBarTheme(isDarkMode),
      colorScheme: _colorScheme(isDarkMode),
      scaffoldBackgroundColor:
          isDarkMode ? ColorConfig.DARK_BACKGROUND : ColorConfig.BACKGROUND,
      // highlightColor: Colors.blue,
      // splashColor: Colors.red,
      // hoverColor: Colors.white.withOpacity(0.2),
      // highlightColor: Colors.white.withOpacity(0.3),
      hoverColor: Colors.white.withOpacity(0.2),
      primaryColor: ColorConfig.primary,
      primaryColorDark: ColorConfig.primaryDark,
      primaryColorLight: ColorConfig.primaryLight,
      shadowColor: isDarkMode
          ? ColorConfig.primary.withOpacity(0.08)
          : ColorConfig.primary.withOpacity(0.13));
}

extension DarkOrLight on ThemeData {
  bool get isDark => brightness == Brightness.dark;
}
