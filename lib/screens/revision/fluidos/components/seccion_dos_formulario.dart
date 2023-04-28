import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/fluidos_controller.dart';
import 'package:taller_alex_app_asesor/screens/revision/seccion_opcion_multiple_observaciones.dart';

class SeccionDosFormulario extends StatefulWidget {
  const SeccionDosFormulario({super.key});

  @override
  State<SeccionDosFormulario> createState() => _SeccionDosFormularioState();
}

class _SeccionDosFormularioState extends State<SeccionDosFormulario> {
  @override
  Widget build(BuildContext context) {
    final fluidosProvider = Provider.of<FluidosController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Anticongelante:', 
            funcionUnoBueno: fluidosProvider.actualizarAnticongelanteBueno, 
            funcionUnoRecomendado: fluidosProvider.actualizarAnticongelanteRecomendado, 
            funcionUnoUrgente: fluidosProvider.actualizarAnticongelanteUrgente, 
            variableUno: fluidosProvider.anticongelante,
            observacionesUno: fluidosProvider.observacionesAnticongelante,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Wipers:', 
            funcionUnoBueno: fluidosProvider.actualizarWipersBueno, 
            funcionUnoRecomendado: fluidosProvider.actualizarWipersRecomendado, 
            funcionUnoUrgente: fluidosProvider.actualizarWipersUrgente, 
            variableUno: fluidosProvider.wipers,
            observacionesUno: fluidosProvider.observacionesWipers,
          ),
        ],
      ),
    );
  }
}