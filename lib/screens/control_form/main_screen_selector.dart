import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/screens/control_form/control_daily_vehicle_screen.dart';
import 'package:taller_alex_app_asesor/screens/sync/sincronizacion_informacion_pocketbase_screen.dart';

class MainScreenSelector extends StatefulWidget {
  const MainScreenSelector({Key? key}) : super(key: key);

  @override
  State<MainScreenSelector> createState() => _MainScreenSelectorState();
}

class _MainScreenSelectorState extends State<MainScreenSelector> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // context.read<UsuarioController>().setStream(false);
  }
  @override
  Widget build(BuildContext context) {
    // final usuarioProvider = Provider.of<UsuarioController>(context);
    // return StreamBuilder<bool>(
    //   stream: usuarioProvider.syncFlagStream,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       // Utiliza los datos del stream para construir la interfaz de usuario
    //       if (snapshot.data!) {
    //         return const SincronizacionInformacionSupabaseScreen();
    //       } else {
    //         return const ControlDailyVehicleScreen();
    //       }

    //     } else if (snapshot.hasError) {
    //       return Text('Error: ${snapshot.error}');
    //     } else {
    //       usuarioProvider.setStream(false);
    //       return const CircularProgressIndicator();
    //     }
    //   },
    // );
    switch (prefs.getBool("boolSyncData")) {
      case true:
        return const SincronizacionInformacionSupabaseScreen();
      default:
        return const ControlDailyVehicleScreen();
    }
  }
}
