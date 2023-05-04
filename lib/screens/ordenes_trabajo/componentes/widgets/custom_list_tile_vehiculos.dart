import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/orden_trabajo_controller.dart';

class CustomListTileVehiculos extends StatelessWidget {
  final String vin;
  final OrdenTrabajoController controller;
  const CustomListTileVehiculos({
    Key? key,
    required this.vin,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.location_on_outlined,
        color: Color(0xFFff3a3a),
      ),
      title: Text(vin),
      onTap: () {
        controller.seleccionarClienteVINPlacas(vin);
        controller.limpiarInformacion();
      },
      hoverColor: Colors.grey[200],
    );
  }
}
