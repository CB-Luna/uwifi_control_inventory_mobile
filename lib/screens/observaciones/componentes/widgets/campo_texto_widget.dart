import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';

class CampoTextoWidget extends StatefulWidget {
  String valorCadena;
  final String tituloExpandablePanel;
  final String hintText;
  final String mensajeValidator;

   CampoTextoWidget({
    super.key, 
    required this.valorCadena,
    required this.tituloExpandablePanel,
    required this.hintText, 
    required this.mensajeValidator,
  });

  @override
  State<CampoTextoWidget> createState() => _CampoTextoWidgetState();
}

class _CampoTextoWidgetState extends State<CampoTextoWidget> {
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
                    Icons.check_box_outline_blank_rounded,
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
            expanded: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: TextFormField(
                autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  widget.valorCadena = value;
                },
                obscureText: false,
                decoration: InputDecoration(
                  hintText: widget.hintText,
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
                  if (widget.valorCadena == "" ||
                      widget.valorCadena.isEmpty) {
                    return widget.mensajeValidator;
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
    );
  }
}