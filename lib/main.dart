import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fleet_management_tool_rta/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'package:fleet_management_tool_rta/helpers/globals.dart';
import 'package:fleet_management_tool_rta/providers/control_form_provider.dart';
import 'package:fleet_management_tool_rta/providers/deeplink_bloc.dart';
import 'package:fleet_management_tool_rta/providers/providers.dart';
import 'package:fleet_management_tool_rta/database/object_box_database.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fleet_management_tool_rta/screens/clientes/app_state.dart';
import 'providers/database_providers/checkin_form_controller.dart';
import 'providers/database_providers/checkout_form_controller.dart';
import 'providers/database_providers/usuario_controller.dart';
import 'package:fleet_management_tool_rta/providers/catalogo_supabase_provider.dart';
import 'package:fleet_management_tool_rta/providers/roles_supabase_provider.dart';
import 'package:fleet_management_tool_rta/providers/sync_provider_supabase.dart';

import 'package:fleet_management_tool_rta/screens/screens.dart';
import 'package:fleet_management_tool_rta/services/navigation_service.dart';
import 'package:fleet_management_tool_rta/internationalization/internationalization.dart';

import 'providers/database_providers/vehiculo_controller.dart';

late ObjectBoxDatabase dataBase;
late GraphQLClient sbGQL;
DeepLinkBloc bloc = DeepLinkBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  supabaseCRM = SupabaseClient(supabaseUrl, anonKey, schema: 'crm');
  supabaseCtrlV = SupabaseClient(supabaseUrl, anonKey, schema: 'ctrl_v');

  await Supabase.initialize(url: supabaseUrl, anonKey: anonKey);
  await initHiveForFlutter();
  final defaultHeaders = ({
    "apikey": anonKey,
  });
  final HttpLink httpLink = HttpLink(supabaseGraphqlUrl, defaultHeaders: defaultHeaders);
  final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $anonKey');
  final Link link = authLink.concat(httpLink);
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    sbGQL = GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore()))
  );
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
        ChangeNotifierProvider<ControlFormProvider>(
          create: (context) => ControlFormProvider(),
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
      title: 'vehicleControlSystemRTA',
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
