import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/suspension_direccion_controller.dart';
import 'package:taller_alex_app_asesor/screens/revision/seccion_opcion_multiple_izq_der_observaciones.dart';

class SeccionTresFormulario extends StatefulWidget {
  const SeccionTresFormulario({super.key});

  @override
  State<SeccionTresFormulario> createState() => _SeccionTresFormularioState();
}

class _SeccionTresFormularioState extends State<SeccionTresFormulario> {
  @override
  Widget build(BuildContext context) {
    final suspensionDireccionProvider = Provider.of<SuspensionDireccionController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionOpcionMultipleIzqDerObservaciones(
            tituloSeccion: 'Link Kit Delantero:', 
            funcionUnoBueno: suspensionDireccionProvider.actualizarLinkKitDelanteroIzqBueno, 
            funcionUnoRecomendado: suspensionDireccionProvider.actualizarLinkKitDelanteroIzqRecomendado, 
            funcionUnoUrgente: suspensionDireccionProvider.actualizarLinkKitDelanteroIzqUrgente, 
            variableUno: suspensionDireccionProvider.linkKitDelanteroIzq,
            observacionesUno: suspensionDireccionProvider.observacionesLinkKitDelanteroIzq,
            funcionDosBueno: suspensionDireccionProvider.actualizarLinkKitDelanteroDerBueno, 
            funcionDosRecomendado: suspensionDireccionProvider.actualizarLinkKitDelanteroDerRecomendado, 
            funcionDosUrgente: suspensionDireccionProvider.actualizarLinkKitDelanteroDerUrgente,
            variableDos: suspensionDireccionProvider.linkKitDelanteroDer,
            observacionesDos: suspensionDireccionProvider.observacionesLinkKitDelanteroDer,
          ),
          SeccionOpcionMultipleIzqDerObservaciones(
            tituloSeccion: 'Link Kit Trasero:', 
            funcionUnoBueno: suspensionDireccionProvider.actualizarLinkKitTraseroIzqBueno, 
            funcionUnoRecomendado: suspensionDireccionProvider.actualizarLinkKitTraseroIzqRecomendado, 
            funcionUnoUrgente: suspensionDireccionProvider.actualizarLinkKitTraseroIzqUrgente, 
            variableUno: suspensionDireccionProvider.linkKitTraseroIzq,
            observacionesUno: suspensionDireccionProvider.observacionesLinkKitTraseroIzq,
            funcionDosBueno: suspensionDireccionProvider.actualizarLinkKitTraseroDerBueno, 
            funcionDosRecomendado: suspensionDireccionProvider.actualizarLinkKitTraseroDerRecomendado, 
            funcionDosUrgente: suspensionDireccionProvider.actualizarLinkKitTraseroDerUrgente,
            variableDos: suspensionDireccionProvider.linkKitTraseroDer,
            observacionesDos: suspensionDireccionProvider.observacionesLinkKitTraseroDer,
          ),
          SeccionOpcionMultipleIzqDerObservaciones(
            tituloSeccion: 'Terminal Interior', 
            funcionUnoBueno: suspensionDireccionProvider.actualizarTerminalInteriorIzqBueno, 
            funcionUnoRecomendado: suspensionDireccionProvider.actualizarTerminalInteriorIzqRecomendado, 
            funcionUnoUrgente: suspensionDireccionProvider.actualizarTerminalInteriorIzqUrgente, 
            variableUno: suspensionDireccionProvider.terminalInteriorIzq,
            observacionesUno: suspensionDireccionProvider.observacionesTerminalInteriorIzq,
            funcionDosBueno: suspensionDireccionProvider.actualizarTerminalInteriorDerBueno, 
            funcionDosRecomendado: suspensionDireccionProvider.actualizarTerminalInteriorDerRecomendado, 
            funcionDosUrgente: suspensionDireccionProvider.actualizarTerminalInteriorDerUrgente,
            variableDos: suspensionDireccionProvider.terminalInteriorDer,
            observacionesDos: suspensionDireccionProvider.observacionesTerminalInteriorDer,
          ),
          SeccionOpcionMultipleIzqDerObservaciones(
            tituloSeccion: 'Terminal Exterior', 
            funcionUnoBueno: suspensionDireccionProvider.actualizarTerminalExteriorIzqBueno, 
            funcionUnoRecomendado: suspensionDireccionProvider.actualizarTerminalExteriorIzqRecomendado, 
            funcionUnoUrgente: suspensionDireccionProvider.actualizarTerminalExteriorIzqUrgente, 
            variableUno: suspensionDireccionProvider.terminalExteriorIzq,
            observacionesUno: suspensionDireccionProvider.observacionesTerminalExteriorIzq,
            funcionDosBueno: suspensionDireccionProvider.actualizarTerminalExteriorDerBueno, 
            funcionDosRecomendado: suspensionDireccionProvider.actualizarTerminalExteriorDerRecomendado, 
            funcionDosUrgente: suspensionDireccionProvider.actualizarTerminalExteriorDerUrgente,
            variableDos: suspensionDireccionProvider.terminalExteriorDer,
            observacionesDos: suspensionDireccionProvider.observacionesTerminalExteriorDer,
          ),
        ],
      ),
    );
  }
}