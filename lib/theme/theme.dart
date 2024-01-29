import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

abstract class AppTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static AppTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  late Color primaryColor;
  late Color secondaryColor;
  late Color tertiaryColor;
  late Color alternate;
  late Color buenoColor;
  late Color recomendadoColor;
  late Color urgenteColor;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color primaryText;
  late Color secondaryText;

  late Color customColor1;
  late Color grayLight;
  late Color grayLighter;
  late Color background;
  late Color dark400;
  late Color grayDark;
  late Color btnText;
  late Color lineColor;
  late Color customColor3;
  late Color customColor4;
  late Color white;
  late Color primaryBtnText;
  late Color backgroundComponents;

  String get title1Family => typography.title1Family;
  TextStyle get title1 => typography.title1;
  String get title2Family => typography.title2Family;
  TextStyle get title2 => typography.title2;
  String get title3Family => typography.title3Family;
  TextStyle get title3 => typography.title3;
  String get subtitle1Family => typography.subtitle1Family;
  TextStyle get subtitle1 => typography.subtitle1;
  String get subtitle2Family => typography.subtitle2Family;
  TextStyle get subtitle2 => typography.subtitle2;
  String get bodyText1Family => typography.bodyText1Family;
  TextStyle get bodyText1 => typography.bodyText1;
  String get bodyText2Family => typography.bodyText2Family;
  TextStyle get bodyText2 => typography.bodyText2;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends AppTheme {
  late Color primaryColor = const Color(0xFF00B837);
  late Color secondaryColor = const Color(0xFF7949DC);
  late Color tertiaryColor = const Color(0xFF8A5DD8);
  late Color alternate = const Color(0xFF492C7C);
  late Color buenoColor = const Color(0xFF228B22);
  late Color recomendadoColor = const Color(0xFFFFBF00);
  late Color urgenteColor = const Color(0xFF9C432D);
  late Color primaryBackground = const Color(0xFFF0F5F6);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color primaryText = const Color(0xFF14181B);
  late Color secondaryText = const Color(0xFF57636C);

  late Color customColor1 = Color(0xFFFFFFFF);
  late Color grayLight = Color(0xFF95A1AC);
  late Color grayLighter = Color(0xFFDBE2E7);
  late Color background = Color(0xFFF0F5F6);
  late Color dark400 = Color(0xFF1D2429);
  late Color grayDark = Color(0xFF57636C);
  late Color btnText = Color(0xFFFFFFFF);
  late Color lineColor = Color(0xFFDBE2E7);
  late Color customColor3 = Color(0xFFDF3F3F);
  late Color customColor4 = Color(0xFF090F13);
  late Color white = Color(0xFFFFFFFF);
  late Color primaryBtnText = Color(0xFFFFFFFF);
  late Color backgroundComponents = Color(0xFF1D2428);
}

abstract class Typography {
  String get title1Family;
  TextStyle get title1;
  String get title2Family;
  TextStyle get title2;
  String get title3Family;
  TextStyle get title3;
  String get subtitle1Family;
  TextStyle get subtitle1;
  String get subtitle2Family;
  TextStyle get subtitle2;
  String get bodyText1Family;
  TextStyle get bodyText1;
  String get bodyText2Family;
  TextStyle get bodyText2;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final AppTheme theme;

  String get title1Family => 'Outfit';
  TextStyle get title1 => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 28,
      );
  String get title2Family => 'Outfit';
  TextStyle get title2 => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  String get title3Family => 'Outfit';
  TextStyle get title3 => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  String get subtitle1Family => 'Outfit';
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  String get subtitle2Family => 'Outfit';
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  String get bodyText1Family => 'Outfit';
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  String get bodyText2Family => 'Outfit';
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Outfit',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

class DarkModeTheme extends AppTheme {
  late Color primaryColor = const Color(0xFFDE2979);
  late Color secondaryColor = const Color(0xFF4B39EF);
  late Color tertiaryColor = const Color(0xFF101213);
  late Color alternate = const Color(0xFFFFFFFF);
  late Color buenoColor = const Color(0xFFABEBEC);
  late Color recomendadoColor = const Color(0xFFD5B460);
  late Color urgenteColor = const Color(0xFF9C432D);
  late Color primaryBackground = const Color(0xFF1D2428);
  late Color secondaryBackground = const Color(0xFF14181B);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFF95A1AC);

  late Color customColor1 = Color(0xFF14181B);
  late Color grayLight = Color(0xFF95A1AC);
  late Color grayLighter = Color(0xFF323B45);
  late Color background = Color(0xFF1D2428);
  late Color dark400 = Color(0xFFFFFFFF);
  late Color grayDark = Color(0xFF95A1AC);
  late Color btnText = Color(0xFFFFFFFF);
  late Color lineColor = Color(0xFF323B45);
  late Color customColor3 = Color(0xFFDF3F3F);
  late Color customColor4 = Color(0xFF090F13);
  late Color white = Color(0xFFFFFFFF);
  late Color primaryBtnText = Color(0xFFFFFFFF);
  late Color backgroundComponents = Color(0xFF1D2428);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}

Gradient purpleRadial = const LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
      Color(0xFF8A5DD8),
      Color(0xFF7949DC),
      Color(0xFF8A5DD8),
      Color(0xFF7949DC),
      Color(0xFF492C7C)
  ],
);

Gradient whiteRadial = const LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Colors.white,
    Colors.white,
  ],
);