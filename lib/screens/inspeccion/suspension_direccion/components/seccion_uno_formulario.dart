import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/suspension_direccion_controller.dart';
import 'package:taller_alex_app_asesor/screens/inspeccion/seccion_opcion_multiple_izq_der_observaciones.dart';

class SeccionUnoFormulario extends StatefulWidget {
  const SeccionUnoFormulario({super.key});

  @override
  State<SeccionUnoFormulario> createState() => _SeccionUnoFormularioState();
}

class _SeccionUnoFormularioState extends State<SeccionUnoFormulario> {
  @override
  Widget build(BuildContext context) {
    final suspensionDireccionProvider = Provider.of<SuspensionDireccionController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionOpcionMultipleIzqDerObservaciones(
            tituloSeccion: 'Rótulas Superior:', 
            funcionUnoBueno: suspensionDireccionProvider.actualizarRotulaSuperiorIzqBueno, 
            funcionUnoRecomendado: suspensionDireccionProvider.actualizarRotulaSuperiorIzqRecomendado, 
            funcionUnoUrgente: suspensionDireccionProvider.actualizarRotulaSuperiorIzqUrgente, 
            variableUno: suspensionDireccionProvider.rotulaSuperiorIzq,
            observacionesUno: suspensionDireccionProvider.observacionesRotulaSuperiorIzq,
            funcionDosBueno: suspensionDireccionProvider.actualizarRotulaSuperiorDerBueno, 
            funcionDosRecomendado: suspensionDireccionProvider.actualizarRotulaSuperiorDerRecomendado, 
            funcionDosUrgente: suspensionDireccionProvider.actualizarRotulaSuperiorDerUrgente,
            variableDos: suspensionDireccionProvider.rotulaSuperiorDer,
            observacionesDos: suspensionDireccionProvider.observacionesRotulaSuperiorDer,
          ),
          SeccionOpcionMultipleIzqDerObservaciones(
            tituloSeccion: 'Rótulas Inferior:', 
            funcionUnoBueno: suspensionDireccionProvider.actualizarRotulaInferiorIzqBueno, 
            funcionUnoRecomendado: suspensionDireccionProvider.actualizarRotulaInferiorIzqRecomendado, 
            funcionUnoUrgente: suspensionDireccionProvider.actualizarRotulaInferiorIzqUrgente, 
            variableUno: suspensionDireccionProvider.rotulaInferiorIzq,
            observacionesUno: suspensionDireccionProvider.observacionesRotulaInferiorIzq,
            funcionDosBueno: suspensionDireccionProvider.actualizarRotulaInferiorDerBueno, 
            funcionDosRecomendado: suspensionDireccionProvider.actualizarRotulaInferiorDerRecomendado, 
            funcionDosUrgente: suspensionDireccionProvider.actualizarRotulaInferiorDerUrgente,
            variableDos: suspensionDireccionProvider.rotulaInferiorDer,
            observacionesDos: suspensionDireccionProvider.observacionesRotulaInferiorDer,
          ),
          SeccionOpcionMultipleIzqDerObservaciones(
            tituloSeccion: 'Bujes Horquilla Superior:', 
            funcionUnoBueno: suspensionDireccionProvider.actualizarBujeHorquillaSuperiorIzqBueno, 
            funcionUnoRecomendado: suspensionDireccionProvider.actualizarBujeHorquillaSuperiorIzqRecomendado, 
            funcionUnoUrgente: suspensionDireccionProvider.actualizarBujeHorquillaSuperiorIzqUrgente, 
            variableUno: suspensionDireccionProvider.bujeHorquillaSuperiorIzq,
            observacionesUno: suspensionDireccionProvider.observacionesBujeHorquillaSuperiorIzq,
            funcionDosBueno: suspensionDireccionProvider.actualizarBujeHorquillaSuperiorDerBueno, 
            funcionDosRecomendado: suspensionDireccionProvider.actualizarBujeHorquillaSuperiorDerRecomendado, 
            funcionDosUrgente: suspensionDireccionProvider.actualizarBujeHorquillaSuperiorDerUrgente,
            variableDos: suspensionDireccionProvider.bujeHorquillaSuperiorDer,
            observacionesDos: suspensionDireccionProvider.observacionesBujeHorquillaSuperiorDer,
          ),
          SeccionOpcionMultipleIzqDerObservaciones(
            tituloSeccion: 'Bujes Horquilla Inferior:', 
            funcionUnoBueno: suspensionDireccionProvider.actualizarBujeHorquillaInferiorIzqBueno, 
            funcionUnoRecomendado: suspensionDireccionProvider.actualizarBujeHorquillaInferiorIzqRecomendado, 
            funcionUnoUrgente: suspensionDireccionProvider.actualizarBujeHorquillaInferiorIzqUrgente, 
            variableUno: suspensionDireccionProvider.bujeHorquillaInferiorIzq,
            observacionesUno: suspensionDireccionProvider.observacionesBujeHorquillaInferiorIzq,
            funcionDosBueno: suspensionDireccionProvider.actualizarBujeHorquillaInferiorDerBueno, 
            funcionDosRecomendado: suspensionDireccionProvider.actualizarBujeHorquillaInferiorDerRecomendado, 
            funcionDosUrgente: suspensionDireccionProvider.actualizarBujeHorquillaInferiorDerUrgente,
            variableDos: suspensionDireccionProvider.bujeHorquillaInferiorDer,
            observacionesDos: suspensionDireccionProvider.observacionesBujeHorquillaInferiorDer,
          ),
        ],
      ),
    );
  }
}