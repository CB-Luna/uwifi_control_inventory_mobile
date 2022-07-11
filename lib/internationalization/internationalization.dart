import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static List<String> languages() => ['es', 'en'];

  String get languageCode => locale.languageCode;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.languageCode] ?? '';

  String getVariableText({
    String esText = '',
    String enText = '',
  }) =>
      [esText, enText][languageIndex];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.languages().contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // login
  {
    'sd8g73bh': {
      'es': 'Ingresar',
      'en': 'Sign In',
    },
    'as1hd844': {
      'es': 'Correo electrónico',
      'en': 'Email',
    },
    'z5ptzzko': {
      'es': 'El correo es requerido',
      'en': 'Email is required',
    },
    'xo3592mv': {
      'es': 'Contraseña',
      'en': 'Password',
    },
    'gi5nd9gr': {
      'es': 'La contraseña es requerida',
      'en': 'Password is required',
    },
    'ltqfb0y2': {
      'es': 'Olvidaste tu contraseña? Clic Aquí',
      'en': 'Forgot password? Click here',
    },
  },
].reduce((a, b) => a..addAll(b));
