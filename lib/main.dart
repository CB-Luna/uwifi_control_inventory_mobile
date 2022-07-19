import 'package:flutter/material.dart';
import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/database/object_box_database.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'providers/database_providers/emprendimiento_controller.dart';
import 'providers/database_providers/usuario_controller.dart';
import 'providers/database_providers/comunidad_controller.dart';

import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/services/navigation_service.dart';
import 'package:bizpro_app/internationalization/internationalization.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/providers/deeplink_bloc.dart';

late ObjectBoxDatabase dataBase;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dataBase = await ObjectBoxDatabase.create();
  //TODO: revisar persistencia
  await initHiveForFlutter();
  await AppTheme.initialize();
  DeepLinkBloc();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<EmprendimientoController>(
          create: (context) => EmprendimientoController(),
        ),
        ChangeNotifierProvider<UsuarioController>(
          create: (context) => UsuarioController(),
        ),
        ChangeNotifierProvider<ComunidadController>(
          create: (context) => ComunidadController(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserState(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => NetworkState(),
          lazy: false,
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
    final UserState userState = Provider.of<UserState>(context);
    return GraphQLProvider(
      client: userState.client,
      child: MaterialApp(
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
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashScreen(),
        },
      ),
    );
  }
}
