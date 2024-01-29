import 'dart:async';

import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:uwifi_control_inventory_mobile/providers/gateways_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/network_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/sims_card_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/deeplink_bloc.dart';
import 'package:uwifi_control_inventory_mobile/database/object_box_database.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uwifi_control_inventory_mobile/providers/user_provider.dart';
import 'providers/database_providers/checkout_form_controller.dart';
import 'providers/database_providers/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/providers/roles_supabase_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/sync_provider_supabase.dart';

import 'package:uwifi_control_inventory_mobile/screens/screens.dart';
import 'package:uwifi_control_inventory_mobile/services/navigation_service.dart';
import 'package:uwifi_control_inventory_mobile/internationalization/internationalization.dart';

import 'providers/database_providers/vehiculo_controller.dart';

late ObjectBoxDatabase dataBase;
DeepLinkBloc bloc = DeepLinkBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: supabaseUrl, anonKey: anonKey);
  await initHiveForFlutter();
  //Esconder Navigation Bar
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual, 
    overlays: [SystemUiOverlay.top]);
  dataBase = await ObjectBoxDatabase.create();
  GoogleFonts.config.allowRuntimeFetching = true;
  await initGlobals();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserState(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => NetworkState(),
          lazy: false,
        ),
        ChangeNotifierProvider<UsuarioController>(
          create: (context) =>
              UsuarioController(email: prefs.getString("userId")),
        ),
        ChangeNotifierProvider<RolesSupabaseProvider>(
          create: (context) => RolesSupabaseProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<VehiculoController>(
          create: (context) => VehiculoController(),
          lazy: false,
        ),
        ChangeNotifierProvider<CheckOutFormController>(
          create: (context) => CheckOutFormController(),
          lazy: false,
        ),
        ChangeNotifierProvider<GatewaysProvider>(
          create: (context) => GatewaysProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<SIMSCardMenuProvider>(
          create: (context) => SIMSCardMenuProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<SyncProviderSupabase>(
          create: (context) => SyncProviderSupabase(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
      Key? key, 
    }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');
  final ThemeMode _themeMode = ThemeMode.system;

  void setLocale(Locale value) => setState(() => _locale = value);
  UsuarioController usuarioController = UsuarioController();
  SyncProviderSupabase syncSupabaseController = SyncProviderSupabase();
  NetworkState networkState = NetworkState();
    @override
    void initState() {
      super.initState();

      _startTimeout();
    }

  Future<void> _startTimeout() async {

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (await networkState.getConnectionStatus()) {
        final bitacora = dataBase.bitacoraBox.getAll().toList();
        if (bitacora.isNotEmpty) {
  
          prefs.setBool("boolSyncData", true);
        } else {
         
          // usuarioController.setStream(false);
          prefs.setBool("boolSyncData", false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UCIMobileApp',
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
