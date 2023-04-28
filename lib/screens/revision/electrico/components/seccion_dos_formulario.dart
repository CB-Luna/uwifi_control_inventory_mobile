import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/electrico_controller.dart';
import 'package:taller_alex_app_asesor/screens/revision/seccion_opcion_multiple_observaciones.dart';

class SeccionDosFormulario extends StatefulWidget {
  const SeccionDosFormulario({super.key});

  @override
  State<SeccionDosFormulario> createState() => _SeccionDosFormularioState();
}

class _SeccionDosFormularioState extends State<SeccionDosFormulario> {
  @override
  Widget build(BuildContext context) {
    final electricoProvider = Provider.of<ElectricoController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Luces Cuartos:', 
            funcionUnoBueno: electricoProvider.actualizarLucesCuartosBueno, 
            funcionUnoRecomendado: electricoProvider.actualizarLucesCuartosRecomendado, 
            funcionUnoUrgente: electricoProvider.actualizarLucesCuartosUrgente, 
            variableUno: electricoProvider.lucesCuartos,
            observacionesUno: electricoProvider.observacionesLucesCuartos,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Check Engine:', 
            funcionUnoBueno: electricoProvider.actualizarCheckEngineBueno, 
            funcionUnoRecomendado: electricoProvider.actualizarCheckEngineRecomendado, 
            funcionUnoUrgente: electricoProvider.actualizarCheckEngineUrgente, 
            variableUno: electricoProvider.checkEngine,
            observacionesUno: electricoProvider.observacionesCheckEngine,
          ),
        ],
      ),
    );
  }
}