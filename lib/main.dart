import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:uwifi_control_inventory_mobile/providers/gateways_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/sims_card_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/sync_change_vehicle_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/deeplink_bloc.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:uwifi_control_inventory_mobile/database/object_box_database.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uwifi_control_inventory_mobile/screens/employees/widget/app_state.dart';
import 'providers/database_providers/checkin_form_controller.dart';
import 'providers/database_providers/checkout_form_controller.dart';
import 'providers/database_providers/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/providers/catalogo_supabase_provider.dart';
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
  supabaseCRM = SupabaseClient(supabaseUrl, anonKey, schema: 'crm');
  supabaseCtrlV = SupabaseClient(supabaseUrl, anonKey, schema: 'ctrl_v');

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
        ChangeNotifierProvider<VehiculoController>(
          create: (context) => VehiculoController(),
          lazy: false,
        ),
        ChangeNotifierProvider<CheckOutFormController>(
          create: (context) => CheckOutFormController(),
          lazy: false,
        ),
        ChangeNotifierProvider<CheckInFormController>(
          create: (context) => CheckInFormController(),
          lazy: false,
        ),
        ChangeNotifierProvider<UsuarioController>(
          create: (context) =>
              UsuarioController(email: prefs.getString("userId")),
        ),
        ChangeNotifierProvider<SyncProviderSupabase>(
          create: (context) => SyncProviderSupabase(),
          lazy: false,
        ),
        ChangeNotifierProvider<SyncChangeVehicleProvider>(
          create: (context) => SyncChangeVehicleProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<CatalogoSupabaseProvider>(
          create: (context) => CatalogoSupabaseProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<RolesSupabaseProvider>(
          create: (context) => RolesSupabaseProvider(),
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
        ChangeNotifierProvider<FFAppState>(
          create: (context) => FFAppState(),
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
    @override
    void initState() {
      super.initState();

      _startTimeout();
    }

  Future<void> _startTimeout() async {

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (await isInternetConnection()) {
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


  Future<bool> isInternetConnection() async {
    bool? boolLogin = prefs.getBool("boolLogin");
    if (boolLogin == null || boolLogin == false) {
      return false;
    }
    else {
      final connectivityResult =
        await (Connectivity().checkConnectivity());
      if(connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    }
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
