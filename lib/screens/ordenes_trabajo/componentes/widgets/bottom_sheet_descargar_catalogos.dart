import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/screens/sync/descarga_catalogos_supabase_screen.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

class BottomSheetDescargarCatalogos extends StatefulWidget {
  const BottomSheetDescargarCatalogos({Key? key})
      : super(key: key);

  @override
  State<BottomSheetDescargarCatalogos> createState() =>
      _BottomSheetDescargarCatalogosState();
}

class _BottomSheetDescargarCatalogosState
    extends State<BottomSheetDescargarCatalogos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: 3,
                        indent: 150,
                        endIndent: 150,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 4, 0, 0),
                              child: Text(
                                'Advertencia: Necesitas descargar los catálogos para llenar algunos formularios.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).title2.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).title2Family,
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 22,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_amber_outlined,
                              size: 50,
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 8, 0, 0),
                              child: Text(
                                'Algunos campos en el llenado de los formularios se encuentra vacío, debe de descargar esta información faltante que se encuentra en Internet.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).bodyText2Family,
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              text: 'CANCELAR',
                              options: FFButtonOptions(
                                width: 150,
                                height: 50,
                                color: const Color(0xFF8C8C8C),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).subtitle2Family,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 2,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                // catalogoEmiWebProvider.procesoCargando(true);
                                // catalogoEmiWebProvider.procesoTerminado(false);
                                // catalogoEmiWebProvider.procesoExitoso(false);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DescargaCatalogosSupabaseScreen(),
                                  ),
                                );
                              },
                              text: 'DESCARGAR',
                              options: FFButtonOptions(
                                width: 150,
                                height: 50,
                                color: FlutterFlowTheme.of(context).primaryColor,
                                textStyle:
                                    FlutterFlowTheme.of(context).subtitle2.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                elevation: 2,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
