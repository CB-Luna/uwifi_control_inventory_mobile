import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/util/util.dart';

class CampoFechaWidget extends StatefulWidget {
  TextEditingController textEditingController;
  DateTime? valorFecha;
  final String tituloExpandablePanel;
  final String hintText;
  final String mensajeValidator;

   CampoFechaWidget({
    super.key, 
    required this.textEditingController,
    required this.valorFecha,
    required this.tituloExpandablePanel,
    required this.hintText, 
    required this.mensajeValidator,
  });

  @override
  State<CampoFechaWidget> createState() => _CampoFechaWidgetState();
}

class _CampoFechaWidgetState extends State<CampoFechaWidget> {
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
                controller: widget.textEditingController,
                autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                onTap: () async {
                  await DatePicker.showDatePicker(
                    context,
                    locale: LocaleType.es,
                    showTitleActions: true,
                    onConfirm: (date) {
                      setState(() {
                        widget.valorFecha = date;
                        widget.textEditingController = TextEditingController(text: dateTimeFormat('d/MMMM/y', date));
                      });
                    },
                    currentTime: getCurrentTimestamp,
                  );
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
                suffixIcon: Icon(
                    Icons.date_range_outlined,
                    color: FlutterFlowTheme.of(context)
                        .secondaryText,
                    size: 24,
                  ),
                ),
                style: FlutterFlowTheme.of(context).bodyText1,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.none,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.mensajeValidator;
                  }
                  return null;
                }),
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