import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/suspension_direccion_controller.dart';
import 'package:taller_alex_app_asesor/screens/revision/seccion_opcion_multiple_izq_der_observaciones.dart';

class SeccionDosFormulario extends StatefulWidget {
  const SeccionDosFormulario({super.key});

  @override
  State<SeccionDosFormulario> createState() => _SeccionDosFormularioState();
}

class _SeccionDosFormularioState extends State<SeccionDosFormulario> {
  @override
  Widget build(BuildContext context) {
    final suspensionDireccionProvider = Provider.of<SuspensionDireccionController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionOpcionMultipleIzqDerObservaciones(
            tituloSeccion: 'Amortiguadores Delanteros:', 
            funcionUnoBueno: suspensionDireccionProvider.actualizarAmortiguadorDelanteroIzqBueno, 
            funcionUnoRecomendado: suspensionDireccionProvider.actualizarAmortiguadorDelanteroIzqRecomendado, 
            funcionUnoUrgente: suspensionDireccionProvider.actualizarAmortiguadorDelanteroIzqUrgente, 
            variableUno: suspensionDireccionProvider.amortiguadorDelanteroIzq,
            observacionesUno: suspensionDireccionProvider.observacionesAmortiguadorDelanteroIzq,
            funcionDosBueno: suspensionDireccionProvider.actualizarAmortiguadorDelanteroDerBueno, 
            funcionDosRecomendado: suspensionDireccionProvider.actualizarAmortiguadorDelanteroDerRecomendado, 
            funcionDosUrgente: suspensionDireccionProvider.actualizarAmortiguadorDelanteroDerUrgente,
            variableDos: suspensionDireccionProvider.amortiguadorDelanteroDer,
            observacionesDos: suspensionDireccionProvider.observacionesAmortiguadorDelanteroDer,
          ),
          SeccionOpcionMultipleIzqDerObservaciones(
            tituloSeccion: 'Amortiguadores Traseros:', 
            funcionUnoBueno: suspensionDireccionProvider.actualizarAmortiguadorTraseroIzqBueno, 
            funcionUnoRecomendado: suspensionDireccionProvider.actualizarAmortiguadorTraseroIzqRecomendado, 
            funcionUnoUrgente: suspensionDireccionProvider.actualizarAmortiguadorTraseroIzqUrgente, 
            variableUno: suspensionDireccionProvider.amortiguadorTraseroIzq,
            observacionesUno: suspensionDireccionProvider.observacionesAmortiguadorTraseroIzq,
            funcionDosBueno: suspensionDireccionProvider.actualizarAmortiguadorTraseroDerBueno, 
            funcionDosRecomendado: suspensionDireccionProvider.actualizarAmortiguadorTraseroDerRecomendado, 
            funcionDosUrgente: suspensionDireccionProvider.actualizarAmortiguadorTraseroDerUrgente,
            variableDos: suspensionDireccionProvider.amortiguadorTraseroDer,
            observacionesDos: suspensionDireccionProvider.observacionesAmortiguadorTraseroDer,
          ),
          SeccionOpcionMultipleIzqDerObservaciones(
            tituloSeccion: 'Bujes Barra Estabilizadora:', 
            funcionUnoBueno: suspensionDireccionProvider.actualizarBujeBarraEstabilizadoraIzqBueno, 
            funcionUnoRecomendado: suspensionDireccionProvider.actualizarBujeBarraEstabilizadoraIzqRecomendado, 
            funcionUnoUrgente: suspensionDireccionProvider.actualizarBujeBarraEstabilizadoraIzqUrgente, 
            variableUno: suspensionDireccionProvider.bujeBarraEstabilizadoraIzq,
            observacionesUno: suspensionDireccionProvider.observacionesBujeBarraEstabilizadoraIzq,
            funcionDosBueno: suspensionDireccionProvider.actualizarBujeBarraEstabilizadoraDerBueno, 
            funcionDosRecomendado: suspensionDireccionProvider.actualizarBujeBarraEstabilizadoraDerRecomendado, 
            funcionDosUrgente: suspensionDireccionProvider.actualizarBujeBarraEstabilizadoraDerUrgente,
            variableDos: suspensionDireccionProvider.bujeBarraEstabilizadoraDer,
            observacionesDos: suspensionDireccionProvider.observacionesBujeBarraEstabilizadoraDer,
          ),
        ],
      ),
    );
  }
}