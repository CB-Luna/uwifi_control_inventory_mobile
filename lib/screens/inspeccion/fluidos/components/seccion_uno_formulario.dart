import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/fluidos_controller.dart';
import 'package:taller_alex_app_asesor/screens/inspeccion/seccion_opcion_multiple_observaciones.dart';

class SeccionUnoFormulario extends StatefulWidget {
  const SeccionUnoFormulario({super.key});

  @override
  State<SeccionUnoFormulario> createState() => _SeccionUnoFormularioState();
}

class _SeccionUnoFormularioState extends State<SeccionUnoFormulario> {
  @override
  Widget build(BuildContext context) {
    final fluidosProvider = Provider.of<FluidosController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'ATF:', 
            funcionUnoBueno: fluidosProvider.actualizarATFBueno, 
            funcionUnoRecomendado: fluidosProvider.actualizarATFRecomendado, 
            funcionUnoUrgente: fluidosProvider.actualizarATFUrgente, 
            variableUno: fluidosProvider.atf,
            observacionesUno: fluidosProvider.observacionesATF,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Power:', 
            funcionUnoBueno: fluidosProvider.actualizarPowerBueno, 
            funcionUnoRecomendado: fluidosProvider.actualizarPowerRecomendado, 
            funcionUnoUrgente: fluidosProvider.actualizarPowerUrgente, 
            variableUno: fluidosProvider.power,
            observacionesUno: fluidosProvider.observacionesPower,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Frenos:', 
            funcionUnoBueno: fluidosProvider.actualizarFrenosBueno, 
            funcionUnoRecomendado: fluidosProvider.actualizarFrenosRecomendado, 
            funcionUnoUrgente: fluidosProvider.actualizarFrenosUrgente, 
            variableUno: fluidosProvider.frenos,
            observacionesUno: fluidosProvider.observacionesFrenos,
          ),
        ],
      ),
    );
  }
}