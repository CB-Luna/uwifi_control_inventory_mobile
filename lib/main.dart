import 'package:bizpro_app/providers/catalog_provider.dart';
import 'package:bizpro_app/providers/database_providers/cotizacion_controller.dart';
import 'package:bizpro_app/providers/database_providers/inversion_sugerida_controller.dart';
import 'package:bizpro_app/providers/sync_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/providers/deeplink_bloc.dart';
import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/database/object_box_database.dart';

import 'providers/database_providers/consultoria_controller.dart';
import 'providers/database_providers/emprendedor_controller.dart';
import 'providers/database_providers/emprendimiento_controller.dart';
import 'providers/database_providers/usuario_controller.dart';
import 'providers/database_providers/jornada_controller.dart';

import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/services/navigation_service.dart';
import 'package:bizpro_app/internationalization/internationalization.dart';

late ObjectBoxDatabase dataBase;
DeepLinkBloc bloc = DeepLinkBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dataBase = await ObjectBoxDatabase.create();
  GoogleFonts.config.allowRuntimeFetching = false;
  await initGlobals();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<EmprendimientoController>(
          create: (context) => EmprendimientoController(),
          lazy: false,
        ),
        ChangeNotifierProvider<UsuarioController>(
          create: (context) =>
              UsuarioController(email: prefs.getString("userId")),
          lazy: false,
        ),
        ChangeNotifierProvider<EmprendedorController>(
          create: (context) => EmprendedorController(),
          lazy: false,
        ),
        ChangeNotifierProvider<JornadaController>(
          create: (context) => JornadaController(),
          lazy: false,
        ),
        ChangeNotifierProvider<ConsultoriaController>(
          create: (context) => ConsultoriaController(),
          lazy: false,
        ),
        ChangeNotifierProvider<InversionSugeridaController>(
          create: (context) => InversionSugeridaController(),
          lazy: false,
        ),
        ChangeNotifierProvider<CotizacionController>(
          create: (context) => CotizacionController(),
          lazy: false,
        ),
        ChangeNotifierProvider<SyncProvider>(
          create: (context) => SyncProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<CatalogProvider>(
          create: (context) => CatalogProvider(),
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
  final ThemeMode _themeMode = ThemeMode.system;

  void setLocale(Locale value) => setState(() => _locale = value);

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
