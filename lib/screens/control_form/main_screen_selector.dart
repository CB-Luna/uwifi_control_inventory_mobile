import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
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
  }
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    switch (usuarioProvider.syncFlag) {
      case true:
        return const SincronizacionInformacionSupabaseScreen();
      default:
        return const ControlDailyVehicleScreen();
    }
  }
}
