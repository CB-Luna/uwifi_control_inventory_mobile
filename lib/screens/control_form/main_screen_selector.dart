import 'package:fleet_management_tool_rta/providers/database_providers/usuario_controller.dart';
import 'package:fleet_management_tool_rta/screens/select_vehicle_tsm/select_vehicle_tsm_screen.dart';
import 'package:flutter/material.dart';
import 'package:fleet_management_tool_rta/helpers/globals.dart';
import 'package:fleet_management_tool_rta/screens/control_form/control_daily_vehicle_screen.dart';
import 'package:fleet_management_tool_rta/screens/sync/sincronizacion_informacion_pocketbase_screen.dart';
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
    final usuarioProvider = Provider.of<UsuarioController>(context);
    switch (prefs.getBool("boolSyncData")) {
      case true:
        return const SincronizacionInformacionSupabaseScreen();
      default:
        if (usuarioProvider.isEmployee || usuarioProvider.isTechSupervisor) {
          return const ControlDailyVehicleScreen();
        } else {
          return const SelectVehicleTSMScreen();
        }
        
    }
  }
}
