import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/frenos_controller.dart';
import 'package:taller_alex_app_asesor/screens/revision/seccion_opcion_multiple_observaciones.dart';

class SeccionDosFormulario extends StatefulWidget {
  const SeccionDosFormulario({super.key});

  @override
  State<SeccionDosFormulario> createState() => _SeccionDosFormularioState();
}

class _SeccionDosFormularioState extends State<SeccionDosFormulario> {
  @override
  Widget build(BuildContext context) {
    final frenosProvider = Provider.of<FrenosController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Clindro Maestro:', 
            funcionUnoBueno: frenosProvider.actualizarCilindroMaestroBueno, 
            funcionUnoRecomendado: frenosProvider.actualizarCilindroMaestroRecomendado, 
            funcionUnoUrgente: frenosProvider.actualizarCilindroMaestroUrgente, 
            variableUno: frenosProvider.cilindroMaestro,
            observacionesUno: frenosProvider.observacionesCilindroMaestro,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Birlos Y Tuercas:', 
            funcionUnoBueno: frenosProvider.actualizarBirlosYTuercasBueno, 
            funcionUnoRecomendado: frenosProvider.actualizarBirlosYTuercasRecomendado, 
            funcionUnoUrgente: frenosProvider.actualizarBirlosYTuercasUrgente, 
            variableUno: frenosProvider.birlosYTuercas,
            observacionesUno: frenosProvider.observacionesBirlosYTuercas,
          ),
        ],
      ),
    );
  }
}