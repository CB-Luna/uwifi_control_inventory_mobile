import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
late SharedPreferences prefs;

abstract class AppTheme {
  static Future initialize() async =>
      prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = prefs.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? prefs.remove(kThemeModeKey)
      : prefs.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static AppTheme of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? DarkModeTheme()
          : LightModeTheme();

  abstract Color primaryColor;
  abstract Color secondaryColor;
  abstract Color tertiaryColor;
  abstract Color alternate;
  abstract Color primaryBackground;
  abstract Color secondaryBackground;
  abstract Color primaryText;
  abstract Color secondaryText;

  abstract Color primaryBtnText;
  abstract Color lineColor;
  abstract Color customColor1;
  abstract Color richBlackFOGRA39;
  abstract Color blue;
  abstract Color turquoise;
  abstract Color cultured;
  abstract Color cerise;

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
  @override
  Color primaryColor = const Color(0xFF4B39EF);
  @override
  Color secondaryColor = const Color(0xFF39D2C0);
  @override
  Color tertiaryColor = const Color(0xFFEE8B60);
  @override
  Color alternate = const Color(0xFFFF5963);
  @override
  Color primaryBackground = const Color(0xFFF1F4F8);
  @override
  Color secondaryBackground = const Color(0xFFFFFFFF);
  @override
  Color primaryText = const Color(0xFF101213);
  @override
  Color secondaryText = const Color(0xFF57636C);

  @override
  Color primaryBtnText = const Color(0xFFFFFFFF);
  @override
  Color lineColor = const Color(0xFFE0E3E7);
  @override
  Color customColor1 = const Color(0xFF2FB73C);
  @override
  Color richBlackFOGRA39 = const Color(0xFF070707);
  @override
  Color blue = const Color(0xFF3A28DE);
  @override
  Color turquoise = const Color(0xFF34D1BF);
  @override
  Color cultured = const Color(0xFFEFEFEF);
  @override
  Color cerise = const Color(0xFFD1345B);
}

class DarkModeTheme extends AppTheme {
  @override
  Color primaryColor = const Color(0xFF4B39EF);
  @override
  Color secondaryColor = const Color(0xFF39D2C0);
  @override
  Color tertiaryColor = const Color(0xFFEE8B60);
  @override
  Color alternate = const Color(0xFFFF5963);
  @override
  Color primaryBackground = const Color(0xFFFFFFFF);
  @override
  Color secondaryBackground = const Color(0xFFFFFFFF);
  @override
  Color primaryText = const Color(0xFFFFFFFF);
  @override
  Color secondaryText = const Color(0xFF95A1AC);

  @override
  Color primaryBtnText = const Color(0xFFFFFFFF);
  @override
  Color lineColor = const Color(0xFF22282F);
  @override
  Color customColor1 = const Color(0xFF452FB7);
  @override
  Color richBlackFOGRA39 = const Color(0xFF070707);
  @override
  Color blue = const Color(0xFF3A28DE);
  @override
  Color turquoise = const Color(0xFF34D1BF);
  @override
  Color cultured = const Color(0xFFEFEFEF);
  @override
  Color cerise = const Color(0xFFD1345B);
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

  @override
  String get title1Family => 'Poppins';
  @override
  TextStyle get title1 => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  @override
  String get title2Family => 'Poppins';
  @override
  TextStyle get title2 => GoogleFonts.getFont(
        'Poppins',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 22,
      );
  @override
  String get title3Family => 'Poppins';
  @override
  TextStyle get title3 => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      );
  @override
  String get subtitle1Family => 'Poppins';
  @override
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  @override
  String get subtitle2Family => 'Poppins';
  @override
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Poppins',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  @override
  String get bodyText1Family => 'Poppins';
  @override
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
  @override
  String get bodyText2Family => 'Poppins';
  @override
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Poppins',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    required String fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
