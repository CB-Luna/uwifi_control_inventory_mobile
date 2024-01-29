import 'package:uwifi_control_inventory_mobile/providers/database/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/control_daily_vehicle_screen.dart';
import 'package:uwifi_control_inventory_mobile/screens/sync/sincronizacion_informacion_supabase_screen.dart';
import 'package:provider/provider.dart';

class MainScreenSelector extends StatefulWidget {
  const MainScreenSelector({Key? key}) : super(key: key);

  @override
  State<MainScreenSelector> createState() => _MainScreenSelectorState();
}

class _MainScreenSelectorState extends State<MainScreenSelector> {

   @override
  void initState() {
    super.initState();
    setState(() {
      context.read<UsuarioController>().getUser(prefs.getString("userId") ?? "");
    });
  }
  @override
  Widget build(BuildContext context) {
    switch (prefs.getBool("boolSyncData")) {
      case true:
        return const SincronizacionInformacionSupabaseScreen();
      default:
          return const ControlDailyVehicleScreen();
    }
  }
}
