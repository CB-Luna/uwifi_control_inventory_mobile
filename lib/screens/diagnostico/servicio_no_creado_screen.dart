import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/screens/emprendedores/clientes_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/detalle_orden_trabajo_screen.dart';

import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

class ServicioNoCreadoScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const ServicioNoCreadoScreen({
    Key? key, 
    required this.ordenTrabajo}) : super(key: key);

  @override
  State<ServicioNoCreadoScreen> createState() => _ServicioNoCreadoScreenState();
}

class _ServicioNoCreadoScreenState extends State<ServicioNoCreadoScreen> {
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
                        '¡Falló en la\ncreación del Servicio!',
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
                        'El registro no se ejecutó con éxito.',
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
                          Icons.cancel_outlined,
                          color: FlutterFlowTheme.of(context).tertiaryColor,
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
                                    pantalla: "pantallaRecepcion",),
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
