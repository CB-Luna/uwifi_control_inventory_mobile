import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/motor_controller.dart';
import 'package:taller_alex_app_asesor/screens/inspeccion/seccion_opcion_multiple_observaciones.dart';

class SeccionUnoFormulario extends StatefulWidget {
  const SeccionUnoFormulario({super.key});

  @override
  State<SeccionUnoFormulario> createState() => _SeccionUnoFormularioState();
}

class _SeccionUnoFormularioState extends State<SeccionUnoFormulario> {
  @override
  Widget build(BuildContext context) {
    final motorProvider = Provider.of<MotorController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Aceite:', 
            funcionUnoBueno: motorProvider.actualizarAceiteBueno, 
            funcionUnoRecomendado: motorProvider.actualizarAceiteRecomendado, 
            funcionUnoUrgente: motorProvider.actualizarAceiteUrgente, 
            variableUno: motorProvider.aceite,
            observacionesUno: motorProvider.observacionesAceite,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Filtro De Aire:', 
            funcionUnoBueno: motorProvider.actualizarFiltroDeAireBueno, 
            funcionUnoRecomendado: motorProvider.actualizarFiltroDeAireRecomendado, 
            funcionUnoUrgente: motorProvider.actualizarFiltroDeAireUrgente, 
            variableUno: motorProvider.filtroDeAire,
            observacionesUno: motorProvider.observacionesFiltroDeAire,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Cpo. De Aceleración:', 
            funcionUnoBueno: motorProvider.actualizarCpoDeAceleracionBueno, 
            funcionUnoRecomendado: motorProvider.actualizarCpoDeAceleracionRecomendado, 
            funcionUnoUrgente: motorProvider.actualizarCpoDeAceleracionUrgente, 
            variableUno: motorProvider.cpoDeAceleracion,
            observacionesUno: motorProvider.observacionesCpoDeAceleracion,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Bujias:', 
            funcionUnoBueno: motorProvider.actualizarBujiasBueno, 
            funcionUnoRecomendado: motorProvider.actualizarBujiasRecomendado, 
            funcionUnoUrgente: motorProvider.actualizarBujiasUrgente, 
            variableUno: motorProvider.bujias,
            observacionesUno: motorProvider.observacionesBujias,
          ),
        ],
      ),
    );
  }
}