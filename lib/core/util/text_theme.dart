part of "theme.dart";

// This uses the MaterialBasedCupertinoThemeData mechs so that
// we have one base text theme for both Material and Cupertino widgets
class TextThemeConfig {
  static TextStyle displayLarge(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_TEXT : ColorConfig.TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 96,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
        letterSpacing: -1.5,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Headline1',
        overflow: TextOverflow.fade,
      );

  static TextStyle displayMedium(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_TEXT : ColorConfig.TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 60,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
        letterSpacing: -0.5,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Headline2',
        overflow: TextOverflow.fade,
      );

  static TextStyle displaySmall(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_TEXT : ColorConfig.TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 48,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.0,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Headline3',
        overflow: TextOverflow.fade,
      );

  static TextStyle headlineMedium(bool isDarkMode) =>TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_TEXT : ColorConfig.TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 30,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.25,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Headline4',
        overflow: TextOverflow.fade,
      );

  static TextStyle headLineLarge(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_TEXT : ColorConfig.TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 34,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.25,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Headline4',
        overflow: TextOverflow.fade,
      );

  static TextStyle headlineSmall(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_TEXT : ColorConfig.TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.0,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Headline5',
        overflow: TextOverflow.fade,
      );

  static TextStyle titleLarge(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_TEXT : ColorConfig.TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.15,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Headline6',
        overflow: TextOverflow.fade,
      );

  static TextStyle titleMedium(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_SUBTITLE_TEXT : ColorConfig
            .SUBTITLE_TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.15,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Subtitle1',
        overflow: TextOverflow.fade,
      );

  static TextStyle titleSmall(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_SUBTITLE_TEXT : ColorConfig
            .SUBTITLE_TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.1,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Subtitle2',
        overflow: TextOverflow.fade,
      );

  static TextStyle bodyLarge(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_TEXT : ColorConfig.TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.5,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Bodytext1',
        overflow: TextOverflow.fade,
      );

  static TextStyle bodyMedium(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_TEXT : ColorConfig.TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.25,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Bodytext2',
        overflow: TextOverflow.fade,
      );

  static TextStyle bodySmall(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_SUBTITLE_TEXT : ColorConfig
            .SUBTITLE_TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        letterSpacing: 0.4,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Caption',
        overflow: TextOverflow.fade,
      );

  static TextStyle labelLarge(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.BLACK : ColorConfig.WHITE,
        backgroundColor: Colors.transparent,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 1.25,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Button',
        overflow: TextOverflow.fade,
      );

  static TextStyle labelSmall(bool isDarkMode) =>
      TextStyle(
        inherit: true,
        color: isDarkMode ? ColorConfig.DARK_TEXT : ColorConfig.TEXT,
        backgroundColor: Colors.transparent,
        fontSize: 10,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        letterSpacing: 1.5,
        textBaseline: TextBaseline.alphabetic,
        leadingDistribution: TextLeadingDistribution.even,
        debugLabel: 'Overline',
        overflow: TextOverflow.fade,
      );
}
