import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/control_form_provider.dart';
import 'package:taller_alex_app_asesor/providers/deeplink_bloc.dart';
import 'package:taller_alex_app_asesor/providers/providers.dart';
import 'package:taller_alex_app_asesor/database/object_box_database.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller_alex_app_asesor/screens/clientes/app_state.dart';
import 'providers/database_providers/cliente_controller.dart';
import 'providers/database_providers/delivery_form_controller.dart';
import 'providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/providers/catalogo_supabase_provider.dart';
import 'package:taller_alex_app_asesor/providers/roles_supabase_provider.dart';
import 'package:taller_alex_app_asesor/providers/sync_provider_supabase.dart';

import 'package:taller_alex_app_asesor/screens/screens.dart';
import 'package:taller_alex_app_asesor/services/navigation_service.dart';
import 'package:taller_alex_app_asesor/internationalization/internationalization.dart';

import 'providers/database_providers/vehiculo_controller.dart';

late ObjectBoxDatabase dataBase;
late SupabaseClient supabaseClient;
late GraphQLClient sbGQL;
DeepLinkBloc bloc = DeepLinkBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseURL,
    anonKey: anonKey,
  );
  await initHiveForFlutter();
  final defaultHeaders = ({
    "apikey": anonKey,
  });
  final HttpLink httpLink = HttpLink(supabaseGraphqlURL, defaultHeaders: defaultHeaders);
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
  GoogleFonts.config.allowRuntimeFetching = false;
  await initGlobals();
 supabaseClient = Supabase.instance.client;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ControlFormProvider>(
          create: (context) => ControlFormProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<ClienteController>(
          create: (context) => ClienteController(),
          lazy: false,
        ),
        ChangeNotifierProvider<VehiculoController>(
          create: (context) => VehiculoController(),
          lazy: false,
        ),
        ChangeNotifierProvider<DeliveryFormController>(
          create: (context) => DeliveryFormController(),
          lazy: false,
        ),
        ChangeNotifierProvider<UsuarioController>(
          create: (context) =>
              UsuarioController(email: prefs.getString("userId")),
          lazy: false,
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
  Locale _locale = const Locale('es');
  final ThemeMode _themeMode = ThemeMode.system;

  void setLocale(Locale value) => setState(() => _locale = value);

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
