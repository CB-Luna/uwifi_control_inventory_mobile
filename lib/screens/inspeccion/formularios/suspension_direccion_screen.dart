import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/screens/inspeccion/inspeccion_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/detalle_orden_trabajo_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/toggle_icon.dart';

class SuspensionDireccionScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const SuspensionDireccionScreen({
    super.key, 
    required this.ordenTrabajo
  });

  @override
  _SuspensionDireccionScreen createState() => _SuspensionDireccionScreen();
}

class _SuspensionDireccionScreen extends State<SuspensionDireccionScreen> {
  // Las siguientes dos variables son necesarias para controlar el stepper
  int activeStep = 0; // step inicial está configurado a 0

  int upperBound = 2; // upperBound debe ser el total de iconos menos 1

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              IconStepper(
                enableStepTapping: false,
                activeStepColor: FlutterFlowTheme.of(context).primaryColor,
                activeStepBorderColor: FlutterFlowTheme.of(context).primaryColor,
                lineColor: FlutterFlowTheme.of(context).primaryColor,
                lineDotRadius: 2.0,
                enableNextPreviousButtons: false,
                activeStep: activeStep,
                icons: [
                  Icon(
                    Icons.looks_one_outlined,
                    color: FlutterFlowTheme.of(context).white,
                  ),
                  Icon(
                    Icons.looks_two_outlined,
                    color: FlutterFlowTheme.of(context).white,
                  ),
                  Icon(
                    Icons.looks_3_outlined,
                    color: FlutterFlowTheme.of(context).white,
                  ),
                ],
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                    child: Text(
                      'Paso ${activeStep + 1} de 3',
                      style: FlutterFlowTheme.of(context)
                          .title1
                          .override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).primaryColor,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                    child: Text(
                      'Suspensión / Dirección',
                      style: FlutterFlowTheme.of(context)
                          .title1
                          .override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).primaryColor,
                            fontSize: 25,
                          ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16, 16, 16, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Rótulas superior:',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title1Family,
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryColor,
                                        fontSize: 22,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 0, 8, 0),
                                  child: Text(
                                    'IZQ',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: FlutterFlowTheme.of(context)
                                              .title1Family,
                                          color: FlutterFlowTheme.of(context)
                                              .grayDark,
                                          fontSize: 22,
                                        ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Bueno',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Recomendado',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Urgente',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Observaciones...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).lineColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).grayDark,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 0, 8, 0),
                                  child: Text(
                                    'DER',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: FlutterFlowTheme.of(context)
                                              .title1Family,
                                          color: FlutterFlowTheme.of(context)
                                              .grayDark,
                                          fontSize: 22,
                                        ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Bueno',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Recomendado',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Urgente',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Observaciones...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).lineColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).grayDark,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16, 16, 16, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Rótulas inferior:',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title1Family,
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryColor,
                                        fontSize: 22,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 0, 8, 0),
                                  child: Text(
                                    'IZQ',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: FlutterFlowTheme.of(context)
                                              .title1Family,
                                          color: FlutterFlowTheme.of(context)
                                              .grayDark,
                                          fontSize: 22,
                                        ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Bueno',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Recomendado',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Urgente',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Observaciones...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).lineColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).grayDark,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 0, 8, 0),
                                  child: Text(
                                    'DER',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: FlutterFlowTheme.of(context)
                                              .title1Family,
                                          color: FlutterFlowTheme.of(context)
                                              .grayDark,
                                          fontSize: 22,
                                        ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Bueno',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Recomendado',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Urgente',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Observaciones...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).lineColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).grayDark,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16, 16, 16, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Bujes Horquilla Superior:',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title1Family,
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryColor,
                                        fontSize: 22,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 0, 8, 0),
                                  child: Text(
                                    'IZQ',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: FlutterFlowTheme.of(context)
                                              .title1Family,
                                          color: FlutterFlowTheme.of(context)
                                              .grayDark,
                                          fontSize: 22,
                                        ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Bueno',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Recomendado',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Urgente',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Observaciones...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).lineColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).grayDark,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 0, 8, 0),
                                  child: Text(
                                    'DER',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: FlutterFlowTheme.of(context)
                                              .title1Family,
                                          color: FlutterFlowTheme.of(context)
                                              .grayDark,
                                          fontSize: 22,
                                        ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Bueno',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Recomendado',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Urgente',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Observaciones...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).lineColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).grayDark,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16, 16, 16, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Bujes Horquilla Inferior:',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .title1Family,
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryColor,
                                        fontSize: 22,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 0, 8, 0),
                                  child: Text(
                                    'IZQ',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: FlutterFlowTheme.of(context)
                                              .title1Family,
                                          color: FlutterFlowTheme.of(context)
                                              .grayDark,
                                          fontSize: 22,
                                        ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Bueno',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Recomendado',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Urgente',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Observaciones...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).lineColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).grayDark,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 0, 8, 0),
                                  child: Text(
                                    'DER',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: FlutterFlowTheme.of(context)
                                              .title1Family,
                                          color: FlutterFlowTheme.of(context)
                                              .grayDark,
                                          fontSize: 22,
                                        ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Bueno',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Recomendado',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                  height:1.0,
                                  color:
                                  FlutterFlowTheme.of(context).lineColor,),
                                ),
                                Column(
                                  children: [
                                    ToggleIcon(
                                      onPressed: () {
                                        // setState(() {
                                        //   // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                        //   if (item.seleccion) {
                                        //     observacionProvider.valorSeleccionP2 = "";
                                        //     // Cambia el estado.
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   } else {
                                        //     // Cuando se selecciona por primera vez el item
                                        //     for (var element in 
                                        //       observacionProvider.opcionesP2) {
                                        //       element.seleccion = false;
                                        //     }
                                        //     observacionProvider.valorSeleccionP2 = item.opcion;
                                        //     item.seleccion =
                                        //         !item.seleccion;
                                        //   }
                                        // });
                                      },
                                      value: false,
                                      onIcon: Icon(
                                        Icons.radio_button_checked_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                      offIcon: Icon(
                                        Icons.radio_button_off_outlined,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      'Urgente',
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .title1Family,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Observaciones...',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).lineColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).grayDark,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: BottomNavigationBar(
              selectedFontSize: 0,
              items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () async {
                    if (activeStep > 0) {
                      setState(() {
                        activeStep--;
                      });
                    } else {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: const Text(
                                '¿Seguro que quieres abandonar esta pantalla?'),
                            content: const Text(
                                'La información ingresada se perderá.'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetalleOrdenTrabajoScreen(
                                            ordenTrabajo: widget.ordenTrabajo,
                                            pantalla: "pantallaInspeccion",
                                          ),
                                    ),
                                  );
                                },
                                child:
                                    const Text('Abandonar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child:
                                    const Text('Cancelar'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                  },
                  child: ClayContainer(
                    height: 40,
                    width: 120,
                    depth: 40,
                    spread: 2,
                    borderRadius: 25,
                    curveType: CurveType.concave,
                    child: Center(
                      child: Text(
                        'Regresar',
                        style: FlutterFlowTheme.of(context)
                            .title1
                            .override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    if (activeStep < upperBound) {
                      setState(() {
                        activeStep++;
                      });
                    }
                  },
                  child: ClayContainer(
                    height: 40,
                    width: 120,
                    depth: 40,
                    spread: 2,
                    borderRadius: 25,
                    curveType: CurveType.concave,
                    child: Center(
                      child: Text(
                        'Continuar',
                        style: FlutterFlowTheme.of(context)
                            .title1
                            .override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ),
                ),
                label: "",
              ),
            ]),
          ),
        ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: Text('Next'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Text('Prev'),
    );
  }

  // /// Returns the header wrapping the header text.
  // Widget header() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.orange,
  //       borderRadius: BorderRadius.circular(5),
  //     ),
  //     child: Row(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(
  //             headerText(),
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 20,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

}