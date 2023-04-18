import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/deeplink_bloc.dart';
import 'package:taller_alex_app_asesor/providers/providers.dart';
import 'package:taller_alex_app_asesor/database/object_box_database.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/database_providers/cliente_controller.dart';
import 'providers/database_providers/diagnostico_controller.dart';
import 'providers/database_providers/electrico_controller.dart';
import 'providers/database_providers/emprendedor_controller.dart';
import 'providers/database_providers/emprendimiento_controller.dart';
import 'providers/database_providers/fluidos_controller.dart';
import 'providers/database_providers/frenos_controller.dart';
import 'providers/database_providers/motor_controller.dart';
import 'providers/database_providers/observacion_controller.dart';
import 'providers/database_providers/orden_trabajo_controller.dart';
import 'providers/database_providers/producto_venta_controller.dart';
import 'providers/database_providers/producto_inversion_jornada_controller.dart';
import 'providers/database_providers/suspension_direccion_controller.dart';
import 'providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/providers/catalogo_emi_web_provider.dart';
import 'package:taller_alex_app_asesor/providers/sync_provider_emi_web.dart';
import 'package:taller_alex_app_asesor/providers/catalogo_pocketbase_provider.dart';
import 'package:taller_alex_app_asesor/providers/roles_emi_web_provider.dart';
import 'package:taller_alex_app_asesor/providers/roles_pocketbase_provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/cotizacion_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/inversion_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/inversion_jornada_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/producto_emprendedor_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/recepcion_y_entrega_inversion_controller.dart';
import 'package:taller_alex_app_asesor/providers/sync_provider_pocketbase.dart';

import 'package:taller_alex_app_asesor/screens/screens.dart';
import 'package:taller_alex_app_asesor/services/navigation_service.dart';
import 'package:taller_alex_app_asesor/internationalization/internationalization.dart';

import 'providers/database_providers/vehiculo_controller.dart';
import 'providers/database_providers/venta_controller.dart';
import 'providers/sync_emprendimientos_externos_pocketbase_provider.dart';
import 'providers/sync_emprendimientos_externos_emi_web_provider.dart';

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
        ChangeNotifierProvider<ClienteController>(
          create: (context) => ClienteController(),
          lazy: false,
        ),
        ChangeNotifierProvider<VehiculoController>(
          create: (context) => VehiculoController(),
          lazy: false,
        ),
        ChangeNotifierProvider<OrdenTrabajoController>(
          create: (context) => OrdenTrabajoController(),
          lazy: false,
        ),
        ChangeNotifierProvider<ObservacionController>(
          create: (context) => ObservacionController(),
          lazy: false,
        ),
        ChangeNotifierProvider<SuspensionDireccionController>(
          create: (context) => SuspensionDireccionController(),
          lazy: false,
        ),
        ChangeNotifierProvider<MotorController>(
          create: (context) => MotorController(),
          lazy: false,
        ),
        ChangeNotifierProvider<FluidosController>(
          create: (context) => FluidosController(),
          lazy: false,
        ),
        ChangeNotifierProvider<FrenosController>(
          create: (context) => FrenosController(),
          lazy: false,
        ),
        ChangeNotifierProvider<ElectricoController>(
          create: (context) => ElectricoController(),
          lazy: false,
        ),
        ChangeNotifierProvider<DiagnosticoController>(
          create: (context) => DiagnosticoController(),
          lazy: false,
        ),
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
        ChangeNotifierProvider<InversionController>(
          create: (context) => InversionController(),
          lazy: false,
        ),
        ChangeNotifierProvider<InversionJornadaController>(
          create: (context) => InversionJornadaController(),
          lazy: false,
        ),
        ChangeNotifierProvider<ProductoInversionJornadaController>(
          create: (context) => ProductoInversionJornadaController(),
          lazy: false,
        ),
        ChangeNotifierProvider<ProductoEmprendedorController>(
          create: (context) => ProductoEmprendedorController(),
          lazy: false,
        ),
        ChangeNotifierProvider<ProductoVentaController>(
          create: (context) => ProductoVentaController(),
          lazy: false,
        ),
        ChangeNotifierProvider<VentaController>(
          create: (context) => VentaController(),
          lazy: false,
        ),
        ChangeNotifierProvider<CotizacionController>(
          create: (context) => CotizacionController(),
          lazy: false,
        ),
        ChangeNotifierProvider<RecepcionYEntregaController>(
          create: (context) => RecepcionYEntregaController(),
          lazy: false,
        ),
        ChangeNotifierProvider<SyncEmpExternosEmiWebProvider>(
          create: (context) => SyncEmpExternosEmiWebProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<SyncEmpExternosPocketbaseProvider>(
          create: (context) => SyncEmpExternosPocketbaseProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<SyncProviderPocketbase>(
          create: (context) => SyncProviderPocketbase(),
          lazy: false,
        ),
        ChangeNotifierProvider<SyncProviderEmiWeb>(
          create: (context) => SyncProviderEmiWeb(),
          lazy: false,
        ),
        ChangeNotifierProvider<CatalogoPocketbaseProvider>(
          create: (context) => CatalogoPocketbaseProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<CatalogoEmiWebProvider>(
          create: (context) => CatalogoEmiWebProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<RolesPocketbaseProvider>(
          create: (context) => RolesPocketbaseProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<RolesEmiWebProvider>(
          create: (context) => RolesEmiWebProvider(),
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
      title: 'tallerAlex',
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
