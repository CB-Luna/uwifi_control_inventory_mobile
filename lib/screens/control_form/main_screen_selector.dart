import 'package:flutter/material.dart';
import 'package:fleet_management_tool_rta/helpers/globals.dart';
import 'package:fleet_management_tool_rta/screens/control_form/control_daily_vehicle_screen.dart';
import 'package:fleet_management_tool_rta/screens/sync/sincronizacion_informacion_pocketbase_screen.dart';

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
