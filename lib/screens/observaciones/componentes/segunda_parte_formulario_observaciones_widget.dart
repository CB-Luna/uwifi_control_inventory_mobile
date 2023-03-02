import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/orden_trabajo_controller.dart';
import 'package:taller_alex_app_asesor/screens/widgets/toggle_icon.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';


class SegundaParteFormularioObservacionesWidget extends StatefulWidget {
  const SegundaParteFormularioObservacionesWidget({
    Key? key, 
    }) : super(key: key);

  @override
  State<SegundaParteFormularioObservacionesWidget> createState() => _SegundaParteFormularioObservacionesWidgetState();
}

class _SegundaParteFormularioObservacionesWidgetState extends State<SegundaParteFormularioObservacionesWidget> {
  final ordenTrabajoFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ordenTrabajoProvider = Provider.of<OrdenTrabajoController>(context);
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Form(
        key: ordenTrabajoFormKey,
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
                            Icons.check_box_outline_blank_rounded,
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            size: 25,
                          ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          '¿Cómo ocurre el problema?',
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
                          itemCount: 2,
                          itemBuilder: (context, index) {
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
                                        // // emprendimientoTemp.proyecto.selected =
                                        // //     !emprendimientoTemp.proyecto.selected;
                                        
                                        // // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia. EmprendimientoSelected
                                        // if (emprendimientoTemp.proyecto.selected) {
                                        //   emprendimientoSelected = "";
                                        //   // Cambia el estado.
                                        //   emprendimientoTemp.proyecto.selected =
                                        //       !emprendimientoTemp.proyecto.selected;
                                        // } else {
                                        //   // Cuando se selecciona por primera vez el item
                                        //   for (var element in widget
                                        //       .usuarioProyectosTemporal
                                        //       .emprendimientosTemp) {
                                        //     element.proyecto.selected = false;
                                        //   }
                                        //   emprendimientoSelected = emprendimientoTemp
                                        //       .proyecto.idProyecto
                                        //       .toString();
                                        //   emprendimientoTemp.proyecto.selected =
                                        //       !emprendimientoTemp.proyecto.selected;
                                        // }
                                      });
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
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).white,
                                    // image: DecorationImage(
                                    //   fit: BoxFit.cover,
                                    //   image: Image.asset(
                                    //     'assets/images/mesgbluegradient.jpeg',
                                    //   ).image,
                                    // ),
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
                                                        "Opciones",
                                                        40,
                                                        "..."),
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: Colors.black,
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
                            Icons.check_box_outline_blank_rounded,
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            size: 25,
                          ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          'Después de qué tiempo de uso se presenta la falla.',
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
                        onChanged: (value) {
                          ordenTrabajoProvider.descripcionFalla = value;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Ingrese el tiempo indicado por el cliente...',
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
                        maxLines: 4,
                        validator: (val) {
                          if (ordenTrabajoProvider.descripcionFalla == "" ||
                              ordenTrabajoProvider.descripcionFalla.isEmpty) {
                            return 'El tiempo indicado es requerido.';
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
                            Icons.check_box_outline_blank_rounded,
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            size: 25,
                          ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          '¿La falla se presenta?',
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
                          itemCount: 2,
                          itemBuilder: (context, index) {
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
                                        // // emprendimientoTemp.proyecto.selected =
                                        // //     !emprendimientoTemp.proyecto.selected;
                                        
                                        // // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia. EmprendimientoSelected
                                        // if (emprendimientoTemp.proyecto.selected) {
                                        //   emprendimientoSelected = "";
                                        //   // Cambia el estado.
                                        //   emprendimientoTemp.proyecto.selected =
                                        //       !emprendimientoTemp.proyecto.selected;
                                        // } else {
                                        //   // Cuando se selecciona por primera vez el item
                                        //   for (var element in widget
                                        //       .usuarioProyectosTemporal
                                        //       .emprendimientosTemp) {
                                        //     element.proyecto.selected = false;
                                        //   }
                                        //   emprendimientoSelected = emprendimientoTemp
                                        //       .proyecto.idProyecto
                                        //       .toString();
                                        //   emprendimientoTemp.proyecto.selected =
                                        //       !emprendimientoTemp.proyecto.selected;
                                        // }
                                      });
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
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).white,
                                    // image: DecorationImage(
                                    //   fit: BoxFit.cover,
                                    //   image: Image.asset(
                                    //     'assets/images/mesgbluegradient.jpeg',
                                    //   ).image,
                                    // ),
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
                                                        "Opciones",
                                                        40,
                                                        "..."),
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: Colors.black,
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
                            Icons.check_box_outline_blank_rounded,
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
                          itemCount: 4,
                          itemBuilder: (context, index) {
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
                                        // // emprendimientoTemp.proyecto.selected =
                                        // //     !emprendimientoTemp.proyecto.selected;
                                        
                                        // // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia. EmprendimientoSelected
                                        // if (emprendimientoTemp.proyecto.selected) {
                                        //   emprendimientoSelected = "";
                                        //   // Cambia el estado.
                                        //   emprendimientoTemp.proyecto.selected =
                                        //       !emprendimientoTemp.proyecto.selected;
                                        // } else {
                                        //   // Cuando se selecciona por primera vez el item
                                        //   for (var element in widget
                                        //       .usuarioProyectosTemporal
                                        //       .emprendimientosTemp) {
                                        //     element.proyecto.selected = false;
                                        //   }
                                        //   emprendimientoSelected = emprendimientoTemp
                                        //       .proyecto.idProyecto
                                        //       .toString();
                                        //   emprendimientoTemp.proyecto.selected =
                                        //       !emprendimientoTemp.proyecto.selected;
                                        // }
                                      });
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
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).white,
                                    // image: DecorationImage(
                                    //   fit: BoxFit.cover,
                                    //   image: Image.asset(
                                    //     'assets/images/mesgbluegradient.jpeg',
                                    //   ).image,
                                    // ),
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
                                                        "Opciones",
                                                        40,
                                                        "..."),
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: Colors.black,
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
            const SizedBox(
              height: 120,
            )
          ],
        ),
      ),
    );
  }
}



