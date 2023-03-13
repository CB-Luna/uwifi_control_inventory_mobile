import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/screens/widgets/toggle_icon.dart';

class SeccionOpcionMultipleIzqDerObservaciones extends StatelessWidget {
  final String tituloSeccion;
  final Function() funcionUnoBueno;
  final Function() funcionUnoRecomendado;
  final Function() funcionUnoUrgente;
  String variableUno;
  String observacionesUno;
  final Function() funcionDosBueno;
  final Function() funcionDosRecomendado;
  final Function() funcionDosUrgente;
  String variableDos;
  String observacionesDos;
   SeccionOpcionMultipleIzqDerObservaciones({
    super.key, 
    required this.tituloSeccion, 
    required this.funcionUnoBueno, 
    required this.funcionUnoRecomendado, 
    required this.funcionUnoUrgente, 
    this.variableUno = "",
    this.observacionesUno = "",
    required this.funcionDosBueno, 
    required this.funcionDosRecomendado, 
    required this.funcionDosUrgente,
    this.variableDos = "",
    this.observacionesDos = "",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          16, 16, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                tituloSeccion,
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
                    onPressed: funcionUnoBueno,
                    value: variableUno == "Bueno" ? true : false,
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
                    onPressed: funcionUnoRecomendado,
                    value: variableUno == "Recomendado" ? true : false,
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
                    onPressed: funcionUnoUrgente,
                    value: variableUno == "Urgente" ? true : false,
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
                observacionesUno = value;
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
                    onPressed: funcionDosBueno,
                    value: variableDos == "Bueno" ? true : false,
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
                    onPressed: funcionDosRecomendado,
                    value: variableDos == "Recomendado" ? true : false,
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
                    onPressed: funcionDosUrgente,
                    value: variableDos == "Urgente" ? true : false,
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
                observacionesDos = value;
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
    );
  }
}