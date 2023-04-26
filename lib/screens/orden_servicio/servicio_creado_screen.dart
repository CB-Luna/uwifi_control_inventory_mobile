import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/screens/clientes/clientes_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/detalle_orden_trabajo_screen.dart';

import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

class ServicioCreadoScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const ServicioCreadoScreen({
    Key? key, 
    required this.ordenTrabajo
  }) : super(key: key);

  @override
  State<ServicioCreadoScreen> createState() => _ServicioCreadoScreenState();
}

class _ServicioCreadoScreenState extends State<ServicioCreadoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFDDEEF8),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Text(
                        '¡Servicio\nAsignado!',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 30,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(                                
                        'El registro se ha guadado con éxito.',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                      child: SizedBox(
                        child: Icon(
                          Icons.check_circle_outline,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          size: 250,
                          )
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalleOrdenTrabajoScreen(
                                    ordenTrabajo: widget.ordenTrabajo,
                                    pantalla: "pantallaOrdenServicio",),
                            ),
                          );
                        },
                        text: 'Listo',
                        options: FFButtonOptions(
                          width: 200,
                          height: 45,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
