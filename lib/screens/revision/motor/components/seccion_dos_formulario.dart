import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/motor_controller.dart';
import 'package:taller_alex_app_asesor/screens/revision/seccion_opcion_multiple_observaciones.dart';

class SeccionDosFormulario extends StatefulWidget {
  const SeccionDosFormulario({super.key});

  @override
  State<SeccionDosFormulario> createState() => _SeccionDosFormularioState();
}

class _SeccionDosFormularioState extends State<SeccionDosFormulario> {
  @override
  Widget build(BuildContext context) {
    final motorProvider = Provider.of<MotorController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Banda/Cadena De Tiempo:', 
            funcionUnoBueno: motorProvider.actualizarBandaCadenaTiempoBueno, 
            funcionUnoRecomendado: motorProvider.actualizarBandaCadenaTiempoRecomendado, 
            funcionUnoUrgente: motorProvider.actualizarBandaCadenaTiempoUrgente, 
            variableUno: motorProvider.bandaCadenaTiempo,
            observacionesUno: motorProvider.observacionesBandaCadenaTiempo,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Soportes:', 
            funcionUnoBueno: motorProvider.actualizarSoportesBueno, 
            funcionUnoRecomendado: motorProvider.actualizarSoportesRecomendado, 
            funcionUnoUrgente: motorProvider.actualizarSoportesUrgente, 
            variableUno: motorProvider.soportes,
            observacionesUno: motorProvider.observacionesSoportes,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Bandas:', 
            funcionUnoBueno: motorProvider.actualizarBandasBueno, 
            funcionUnoRecomendado: motorProvider.actualizarBandasRecomendado, 
            funcionUnoUrgente: motorProvider.actualizarBandasUrgente, 
            variableUno: motorProvider.bandas,
            observacionesUno: motorProvider.observacionesBandas,
          ),
          SeccionOpcionMultipleObservaciones(
            tituloSeccion: 'Mangueras:', 
            funcionUnoBueno: motorProvider.actualizarManguerasBueno, 
            funcionUnoRecomendado: motorProvider.actualizarManguerasRecomendado, 
            funcionUnoUrgente: motorProvider.actualizarManguerasUrgente, 
            variableUno: motorProvider.mangueras,
            observacionesUno: motorProvider.observacionesMangueras,
          ),
        ],
      ),
    );
  }
}