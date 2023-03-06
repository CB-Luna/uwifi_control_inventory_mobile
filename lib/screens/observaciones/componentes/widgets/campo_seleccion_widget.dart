import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/modelsFormularios/opciones_observaciones.dart';
import 'package:taller_alex_app_asesor/screens/widgets/toggle_icon.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';

class CampoSeleccionWidget extends StatefulWidget {
  final String tituloExpandablePanel;
  List<OpcionesObservaciones> valoresOpciones;
  String valorSeleccion;

   CampoSeleccionWidget({
    super.key, 
    required this.tituloExpandablePanel,
    required this.valoresOpciones,
    required this.valorSeleccion,
  });

  @override
  State<CampoSeleccionWidget> createState() => _CampoSeleccionWidgetState();
}

class _CampoSeleccionWidgetState extends State<CampoSeleccionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    widget.valorSeleccion == "" ? 
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
                  widget.tituloExpandablePanel,
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
                  itemCount: widget.valoresOpciones.length,
                  itemBuilder: (context, index) {
                  OpcionesObservaciones item = widget.valoresOpciones[index];
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
                                  widget.valorSeleccion = "";
                                  // Cambia el estado.
                                  item.seleccion =
                                      !item.seleccion;
                                } else {
                                  // Cuando se selecciona por primera vez el item
                                  for (var element in widget
                                      .valoresOpciones) {
                                    element.seleccion = false;
                                  }
                                  widget.valorSeleccion = item.opcion;
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
    );
  }
}