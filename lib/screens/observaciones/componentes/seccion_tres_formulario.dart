import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/modelsFormularios/opciones_observaciones.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/observacion_controller.dart';
import 'package:taller_alex_app_asesor/screens/widgets/toggle_icon.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';

class SeccionTresFormulario extends StatefulWidget {
  const SeccionTresFormulario({super.key});

  @override
  State<SeccionTresFormulario> createState() => _SeccionTresFormularioState();
}

class _SeccionTresFormularioState extends State<SeccionTresFormulario> {
  @override
  Widget build(BuildContext context) {
    final observacionProvider = Provider.of<ObservacionController>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                16, 16, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ExpandableNotifier(
                initialExpanded: false,
                child: ExpandablePanel(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(0, 0, 16, 0),
                      child: Icon(
                          observacionProvider.valorSeleccionP7 == "" ? 
                          Icons.check_box_outline_blank_rounded
                          :
                          Icons.check_box_rounded,
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          size: 25,
                        ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'Condiciones de temperatura en qué se presenta la falla.',
                        style: FlutterFlowTheme.of(context)
                            .title1
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .title1Family,
                              color: FlutterFlowTheme.of(context)
                                  .primaryText,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    ],
                  ),
                  collapsed: Divider(
                    thickness: 1.5,
                    color: FlutterFlowTheme.of(context).lineColor,
                  ),
                  expanded: Builder(
                    builder: (context) {
                      return ListView.builder(
                        controller: ScrollController(),
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 16, 0, 0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: observacionProvider.opcionesP7.length,
                        itemBuilder: (context, index) {
                        OpcionesObservaciones item = observacionProvider.opcionesP7[index];
                        return Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional
                                  .fromSTEB(0, 0, 16, 0),
                                child: ToggleIcon(
                                  onPressed: () {
                                    setState(() {
                                      // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                      if (item.seleccion) {
                                        observacionProvider.valorSeleccionP7 = "";
                                        // Cambia el estado.
                                        item.seleccion =
                                            !item.seleccion;
                                      } else {
                                        // Cuando se selecciona por primera vez el item
                                        for (var element in 
                                          observacionProvider.opcionesP7) {
                                          element.seleccion = false;
                                        }
                                        observacionProvider.valorSeleccionP7 = item.opcion;
                                        item.seleccion =
                                            !item.seleccion;
                                      }
                                    });
                                  },
                                  value: item.seleccion,
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
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  color: item.seleccion ?  FlutterFlowTheme.of(context).primaryColor : FlutterFlowTheme.of(context).white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x2B202529),
                                      offset: Offset(0, 3),
                                      spreadRadius: 5,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 10,
                                            sigmaY: 5,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 5, 10, 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  maybeHandleOverflow(
                                                      item.opcion,
                                                      40,
                                                      "..."),
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color: item.seleccion ?  FlutterFlowTheme.of(context).white : FlutterFlowTheme.of(context).tertiaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        },
                      );
                    },
                  ),
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    headerAlignment:
                        ExpandablePanelHeaderAlignment.center,
                    hasIcon: true,
                    iconColor:
                        FlutterFlowTheme.of(context).secondaryColor,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                16, 16, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ExpandableNotifier(
                initialExpanded: false,
                child: ExpandablePanel(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(0, 0, 16, 0),
                      child: Icon(
                          observacionProvider.valorSeleccionP8 == "" ? 
                          Icons.check_box_outline_blank_rounded
                          :
                          Icons.check_box_rounded,
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          size: 25,
                        ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        '¿A cuántas revoluciones?',
                        style: FlutterFlowTheme.of(context)
                            .title1
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .title1Family,
                              color: FlutterFlowTheme.of(context)
                                  .primaryText,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    ],
                  ),
                  collapsed: Divider(
                    thickness: 1.5,
                    color: FlutterFlowTheme.of(context).lineColor,
                  ),
                  expanded: Builder(
                    builder: (context) {
                      return ListView.builder(
                        controller: ScrollController(),
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 16, 0, 0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: observacionProvider.opcionesP8.length,
                        itemBuilder: (context, index) {
                        OpcionesObservaciones item = observacionProvider.opcionesP8[index];
                        return Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional
                                  .fromSTEB(0, 0, 16, 0),
                                child: ToggleIcon(
                                  onPressed: () {
                                    setState(() {
                                      // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                      if (item.seleccion) {
                                        observacionProvider.valorSeleccionP8 = "";
                                        // Cambia el estado.
                                        item.seleccion =
                                            !item.seleccion;
                                      } else {
                                        // Cuando se selecciona por primera vez el item
                                        for (var element in 
                                          observacionProvider.opcionesP8) {
                                          element.seleccion = false;
                                        }
                                        observacionProvider.valorSeleccionP8 = item.opcion;
                                        item.seleccion =
                                            !item.seleccion;
                                      }
                                    });
                                  },
                                  value: item.seleccion,
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
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  color: item.seleccion ?  FlutterFlowTheme.of(context).primaryColor : FlutterFlowTheme.of(context).white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x2B202529),
                                      offset: Offset(0, 3),
                                      spreadRadius: 5,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 10,
                                            sigmaY: 5,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 5, 10, 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  maybeHandleOverflow(
                                                      item.opcion,
                                                      40,
                                                      "..."),
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color: item.seleccion ?  FlutterFlowTheme.of(context).white : FlutterFlowTheme.of(context).tertiaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        },
                      );
                    },
                  ),
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    headerAlignment:
                        ExpandablePanelHeaderAlignment.center,
                    hasIcon: true,
                    iconColor:
                        FlutterFlowTheme.of(context).secondaryColor,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                16, 16, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ExpandableNotifier(
                initialExpanded: false,
                child: ExpandablePanel(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(0, 0, 16, 0),
                      child: Icon(
                          observacionProvider.valorSeleccionP9 == "" ? 
                          Icons.check_box_outline_blank_rounded
                          :
                          Icons.check_box_rounded,
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          size: 25,
                        ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'Condición del camino.',
                        style: FlutterFlowTheme.of(context)
                            .title1
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .title1Family,
                              color: FlutterFlowTheme.of(context)
                                  .primaryText,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    ],
                  ),
                  collapsed: Divider(
                    thickness: 1.5,
                    color: FlutterFlowTheme.of(context).lineColor,
                  ),
                  expanded: Builder(
                    builder: (context) {
                      return ListView.builder(
                        controller: ScrollController(),
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 16, 0, 0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: observacionProvider.opcionesP9.length,
                        itemBuilder: (context, index) {
                        OpcionesObservaciones item = observacionProvider.opcionesP9[index];
                        return Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional
                                  .fromSTEB(0, 0, 16, 0),
                                child: ToggleIcon(
                                  onPressed: () {
                                    setState(() {
                                      // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia.
                                      if (item.seleccion) {
                                        observacionProvider.valorSeleccionP9 = "";
                                        // Cambia el estado.
                                        item.seleccion =
                                            !item.seleccion;
                                      } else {
                                        // Cuando se selecciona por primera vez el item
                                        for (var element in 
                                          observacionProvider.opcionesP9) {
                                          element.seleccion = false;
                                        }
                                        observacionProvider.valorSeleccionP9 = item.opcion;
                                        item.seleccion =
                                            !item.seleccion;
                                      }
                                    });
                                  },
                                  value: item.seleccion,
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
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  color: item.seleccion ?  FlutterFlowTheme.of(context).primaryColor : FlutterFlowTheme.of(context).white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color(0x2B202529),
                                      offset: Offset(0, 3),
                                      spreadRadius: 5,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 10,
                                            sigmaY: 5,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 5, 10, 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  maybeHandleOverflow(
                                                      item.opcion,
                                                      40,
                                                      "..."),
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color: item.seleccion ?  FlutterFlowTheme.of(context).white : FlutterFlowTheme.of(context).tertiaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        },
                      );
                    },
                  ),
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    headerAlignment:
                        ExpandablePanelHeaderAlignment.center,
                    hasIcon: true,
                    iconColor:
                        FlutterFlowTheme.of(context).secondaryColor,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                16, 16, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ExpandableNotifier(
                initialExpanded: false,
                child: ExpandablePanel(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(0, 0, 16, 0),
                      child: Icon(
                          observacionProvider.respuestaP10 == "" ? 
                          Icons.check_box_outline_blank_rounded
                          :
                          Icons.check_box_rounded,
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          size: 25,
                        ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        '¿Desde cuándo se presenta la falla?',
                        style: FlutterFlowTheme.of(context)
                            .title1
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .title1Family,
                              color: FlutterFlowTheme.of(context)
                                  .primaryText,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    ],
                  ),
                  collapsed: Divider(
                    thickness: 1.5,
                    color: FlutterFlowTheme.of(context).lineColor,
                  ),
                  expanded: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: TextFormField(
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {
                        setState(() {
                          observacionProvider.respuestaP10 = value;
                        });
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Ingrese la respuesta indicada por el cliente...',
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
                                FlutterFlowTheme.of(context).secondaryColor,
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
                      maxLines: 4,
                      validator: (val) {
                        if (observacionProvider.respuestaP10 == "" ||
                            observacionProvider.respuestaP10.isEmpty) {
                          return 'La respuesta indicada es requerida.';
                        }
                        return null;
                      }
                    ),
                  ),
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    headerAlignment:
                        ExpandablePanelHeaderAlignment.center,
                    hasIcon: true,
                    iconColor:
                        FlutterFlowTheme.of(context).secondaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}