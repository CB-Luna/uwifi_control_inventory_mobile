import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/providers/deeplink_bloc.dart';
import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/database/object_box_database.dart';

import 'providers/database_providers/emprendedor_controller.dart';
import 'providers/database_providers/emprendimiento_controller.dart';
import 'providers/database_providers/usuario_controller.dart';
import 'providers/database_providers/comunidad_controller.dart';

import 'package:bizpro_app/providers/select_image_provider.dart';

import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/services/navigation_service.dart';
import 'package:bizpro_app/internationalization/internationalization.dart';
import 'package:bizpro_app/theme/theme.dart';

late ObjectBoxDatabase dataBase;
DeepLinkBloc bloc = DeepLinkBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dataBase = await ObjectBoxDatabase.create();
  await AppTheme.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<EmprendimientoController>(
          create: (context) => EmprendimientoController(),
          lazy: false,
        ),
        ChangeNotifierProvider<UsuarioController>(
          create: (context) =>
              UsuarioController(email: prefs.getString("email")),
          lazy: false,
        ),
        ChangeNotifierProvider<ComunidadController>(
          create: (context) => ComunidadController(),
          lazy: false,
        ),
        ChangeNotifierProvider<EmprendedorController>(
          create: (context) => EmprendedorController(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => UserState(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => NetworkState(),
          lazy: false,
        ),
        ChangeNotifierProvider<SelectImageProvider>(
          create: (context) => SelectImageProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('es');
  ThemeMode _themeMode = AppTheme.themeMode;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        AppTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bizproEM',
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: snackbarKey,
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
      },
    );
  }
}
