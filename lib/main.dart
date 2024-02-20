import 'dart:async';

import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/database/object_box_database.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/bundle_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/order_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/bundles_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/order_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/orders_delivery_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/orders_package_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/orders_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/screens.dart';
import 'package:uwifi_control_inventory_mobile/services/navigation_service.dart';
import 'package:uwifi_control_inventory_mobile/internationalization/internationalization.dart';

import 'providers/providers.dart';

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
        ChangeNotifierProvider<GatewayFormProvider>(
          create: (context) => GatewayFormProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<SIMSCardFormProvider>(
          create: (context) => SIMSCardFormProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<BundleFormProvider>(
          create: (context) => BundleFormProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<OrderFormProvider>(
          create: (context) => OrderFormProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<GatewaysProvider>(
          create: (context) => GatewaysProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<SIMSCardProvider>(
          create: (context) => SIMSCardProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<BundlesProvider>(
          create: (context) => BundlesProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<OrdersProvider>(
          create: (context) => OrdersProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<OrdersDeliveryProvider>(
          create: (context) => OrdersDeliveryProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<OrdersPackageProvider>(
          create: (context) => OrdersPackageProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<GatewayMenuProvider>(
          create: (context) => GatewayMenuProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<SIMSCardMenuProvider>(
          create: (context) => SIMSCardMenuProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<BundleMenuProvider>(
          create: (context) => BundleMenuProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<OrderMenuProvider>(
          create: (context) => OrderMenuProvider(),
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
