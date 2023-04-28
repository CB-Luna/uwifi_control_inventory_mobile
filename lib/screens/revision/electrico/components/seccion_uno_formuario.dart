import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/electrico_controller.dart';
import 'package:taller_alex_app_asesor/screens/revision/seccion_opcion_multiple_observaciones.dart';

class SeccionUnoFormulario extends StatefulWidget {
  const SeccionUnoFormulario({super.key});

  @override
  State<SeccionUnoFormulario> createState() => _SeccionUnoFormularioState();
}

class _SeccionUnoFormularioState extends State<SeccionUnoFormulario> {
  @override
  Widget build(BuildContext context) {
    final electricoProvider = Provider.of<ElectricoController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Terminales De Bateria:', 
            funcionUnoBueno: electricoProvider.actualizarTerminalesDeBateriaBueno, 
            funcionUnoRecomendado: electricoProvider.actualizarTerminalesDeBateriaRecomendado, 
            funcionUnoUrgente: electricoProvider.actualizarTerminalesDeBateriaUrgente, 
            variableUno: electricoProvider.terminalesDeBateria,
            observacionesUno: electricoProvider.observacionesTerminalesDeBateria,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Luces Frenos:', 
            funcionUnoBueno: electricoProvider.actualizarLucesFrenosBueno, 
            funcionUnoRecomendado: electricoProvider.actualizarLucesFrenosRecomendado, 
            funcionUnoUrgente: electricoProvider.actualizarLucesFrenosUrgente, 
            variableUno: electricoProvider.lucesFrenos,
            observacionesUno: electricoProvider.observacionesLucesFrenos,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Luces Direccionales:', 
            funcionUnoBueno: electricoProvider.actualizarLucesDireccionalesBueno, 
            funcionUnoRecomendado: electricoProvider.actualizarLucesDireccionalesRecomendado, 
            funcionUnoUrgente: electricoProvider.actualizarLucesDireccionalesUrgente, 
            variableUno: electricoProvider.lucesDireccionales,
            observacionesUno: electricoProvider.observacionesLucesDireccionales,
          ),
        ],
      ),
    );
  }
}