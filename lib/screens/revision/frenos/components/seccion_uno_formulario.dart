import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/frenos_controller.dart';
import 'package:taller_alex_app_asesor/screens/revision/seccion_opcion_multiple_observaciones.dart';

class SeccionUnoFormulario extends StatefulWidget {
  const SeccionUnoFormulario({super.key});

  @override
  State<SeccionUnoFormulario> createState() => _SeccionUnoFormularioState();
}

class _SeccionUnoFormularioState extends State<SeccionUnoFormulario> {
  @override
  Widget build(BuildContext context) {
    final frenosProvider = Provider.of<FrenosController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Balatas Delanteras:', 
            funcionUnoBueno: frenosProvider.actualizarBalatasDelanterasBueno, 
            funcionUnoRecomendado: frenosProvider.actualizarBalatasDelanterasRecomendado, 
            funcionUnoUrgente: frenosProvider.actualizarBalatasDelanterasUrgente, 
            variableUno: frenosProvider.balatasDelanteras,
            observacionesUno: frenosProvider.observacionesBalatasDelanteras,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Balatas Traseras (Disco / Tambor):', 
            funcionUnoBueno: frenosProvider.actualizarBalatasTraserasDiscoTamborBueno, 
            funcionUnoRecomendado: frenosProvider.actualizarBalatasTraserasDiscoTamborRecomendado, 
            funcionUnoUrgente: frenosProvider.actualizarBalatasTraserasDiscoTamborUrgente, 
            variableUno: frenosProvider.balatasTraserasDiscoTambor,
            observacionesUno: frenosProvider.observacionesBalatasTraserasDiscoTambor,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Mangueras:', 
            funcionUnoBueno: frenosProvider.actualizarManguerasLineasBueno, 
            funcionUnoRecomendado: frenosProvider.actualizarManguerasLineasRecomendado, 
            funcionUnoUrgente: frenosProvider.actualizarManguerasLineasUrgente, 
            variableUno: frenosProvider.manguerasLineas,
            observacionesUno: frenosProvider.observacionesManguerasLineas,
          ),
        ],
      ),
    );
  }
}