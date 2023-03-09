
import 'package:clay_containers/clay_containers.dart';
import 'package:diacritic/diacritic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/observacion_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/componentes/primera_parte_formulario_observaciones_widget.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/componentes/segunda_parte_formulario_observaciones_widget.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/componentes/tercera_parte_formulario_observaciones_widget.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/detalle_orden_trabajo_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter/material.dart';

import '../ordenes_trabajo/flutter_flow_animaciones.dart';

class AgregarObservacionScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const AgregarObservacionScreen({Key? key, required this.ordenTrabajo}) : super(key: key);

  @override
  _AgregarObservacionScreenState createState() =>
      _AgregarObservacionScreenState();
}

class _AgregarObservacionScreenState extends State<AgregarObservacionScreen> {
  XFile? image;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  String _currentPageName = 'primeraParte';
  List<String> listaClientes = [];
  String cliente = "";
  String correo = "";
  String formaPago = "";
  List<String> listaVehiculos = [];
  String vehiculo = "";
  String vin = "";
  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(79, 0),
          end: Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 1,
          end: 1,
        ),
      ],
    ),
  };
  @override
  void initState() {
    super.initState();
    listaClientes = [];
    listaVehiculos = [];
    cliente = "";
    correo = "";
    vehiculo = "";
    vin = "";
    formaPago = "";
    if (context.read<UsuarioController>().usuarioCurrent != null) {
      print(context.read<UsuarioController>().usuarioCurrent!.clientes.toList());
    context.read<UsuarioController>().usuarioCurrent!.clientes.toList().forEach((element) {
        listaClientes.add("${element.nombre} ${element.apellidoP} -- ${element.correo}");
    });
    listaClientes.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    }
  }
  @override
  Widget build(BuildContext context) {
    final observacionProvider = Provider.of<ObservacionController>(context);
    final tabs = {
      'primeraParte': PrimeraParteFormularioObservacionesWidget(ordenTrabajo: widget.ordenTrabajo,),
      // 'segundaParte': SegundaParteFormularioObservacionesWidget(),
      // 'terceraParte': TerceraParteFormularioObservacionesWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20, 45, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x39000000),
                                  offset: Offset(-4, 8),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: InkWell(
                              onTap: () async {
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
                                            observacionProvider.limpiarInformacion();
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetalleOrdenTrabajoScreen(
                                                      ordenTrabajo: widget.ordenTrabajo,
                                                      pantalla: "pantallaRecepcion",
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
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                Icon(
                                    Icons.arrow_back_ios_rounded,
                                    color: FlutterFlowTheme.of(context).white,
                                    size: 16,
                                  ),
                                  Text(
                                    'Atrás',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: FlutterFlowTheme.of(context)
                                              .bodyText1Family,
                                          color: FlutterFlowTheme.of(context).white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 16, 0, 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Registro de Observaciones',
                            style:
                                FlutterFlowTheme.of(context).title1.override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyText1Family,
                                      fontSize: 18,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              Flexible(
                child: tabs[_currentPageName]!,
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
            ],
          )
        ),
        // bottomNavigationBar: SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.1,
        //   child: BottomNavigationBar(
        //     selectedFontSize: 0,
        //     currentIndex: currentIndex,
        //     onTap: (i) => setState(() {
        //       print("Valor OP2: ${observacionProvider.valorSeleccionP2}");
        //       _currentPageName = tabs.keys.toList()[i];
        //     }),
        //     items: <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: ClayContainer(
        //         height: 40,
        //         width: 40,
        //         depth: 20,
        //         borderRadius: 25,
        //         curveType: CurveType.concave,
        //         child: Container(
        //           decoration: BoxDecoration(
        //             border: Border.all(color: FlutterFlowTheme.of(context).white.withOpacity(0.2), width: 2),
        //             borderRadius: BorderRadius.circular(25),
        //           ),
        //           child: Center(
        //             child: Text(
        //               '1',
        //               style: FlutterFlowTheme.of(context)
        //                   .title1
        //                   .override(
        //                     fontFamily: 'Outfit',
        //                     color: FlutterFlowTheme.of(context).grayDark.withOpacity(0.75),
        //                     fontSize: 25,
        //                   ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       activeIcon: ClayContainer(
        //         height: 40,
        //         width: 40,
        //         depth: 100,
        //         borderRadius: 25,
        //         curveType: CurveType.concave,
        //         child: Container(
        //           decoration: BoxDecoration(
        //             border: Border.all(color: FlutterFlowTheme.of(context).white.withOpacity(0.2), width: 2),
        //             borderRadius: BorderRadius.circular(25),
        //           ),
        //           child: Center(
        //             child: Text(
        //               '1',
        //               style: FlutterFlowTheme.of(context)
        //                   .title1
        //                   .override(
        //                     fontFamily: 'Outfit',
        //                     color: FlutterFlowTheme.of(context).grayDark.withOpacity(0.75),
        //                     fontSize: 25,
        //                   ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       label: "",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: ClayContainer(
        //         height: 40,
        //         width: 40,
        //         depth: 20,
        //         borderRadius: 25,
        //         curveType: CurveType.concave,
        //         child: Container(
        //           decoration: BoxDecoration(
        //             border: Border.all(color: FlutterFlowTheme.of(context).white.withOpacity(0.2), width: 2),
        //             borderRadius: BorderRadius.circular(25),
        //           ),
        //           child: Center(
        //             child: Text(
        //               '2',
        //               style: FlutterFlowTheme.of(context)
        //                   .title1
        //                   .override(
        //                     fontFamily: 'Outfit',
        //                     color: FlutterFlowTheme.of(context).grayDark.withOpacity(0.75),
        //                     fontSize: 25,
        //                   ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       activeIcon: ClayContainer(
        //         surfaceColor: FlutterFlowTheme.of(context).white.withOpacity(0.8),
        //         height: 40,
        //         width: 40,
        //         depth: 100,
        //         borderRadius: 25,
        //         curveType: CurveType.concave,
        //         child: Container(
        //           decoration: BoxDecoration(
        //             border: Border.all(color: FlutterFlowTheme.of(context).white.withOpacity(0.2), width: 2),
        //             borderRadius: BorderRadius.circular(25),
        //           ),
        //           child: Center(
        //             child: Text(
        //               '2',
        //               style: FlutterFlowTheme.of(context)
        //                   .title1
        //                   .override(
        //                     fontFamily: 'Outfit',
        //                     color: FlutterFlowTheme.of(context).grayDark.withOpacity(0.75),
        //                     fontSize: 25,
        //                   ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       label: "",
        //     ),
        //     // BottomNavigationBarItem(
        //     //   icon: ClayContainer(
        //     //     height: 40,
        //     //     width: 40,
        //     //     depth: 20,
        //     //     borderRadius: 25,
        //     //     curveType: CurveType.concave,
        //     //     child: Container(
        //     //       decoration: BoxDecoration(
        //     //         border: Border.all(color: FlutterFlowTheme.of(context).white.withOpacity(0.2), width: 2),
        //     //         borderRadius: BorderRadius.circular(25),
        //     //       ),
        //     //       child: Center(
        //     //         child: Text(
        //     //           '3',
        //     //           style: FlutterFlowTheme.of(context)
        //     //               .title1
        //     //               .override(
        //     //                 fontFamily: 'Outfit',
        //     //                 color: FlutterFlowTheme.of(context).grayDark.withOpacity(0.75),
        //     //                 fontSize: 25,
        //     //               ),
        //     //         ),
        //     //       ),
        //     //     ),
        //     //   ),
        //     //   activeIcon: ClayContainer(
        //     //     surfaceColor: FlutterFlowTheme.of(context).white.withOpacity(0.8),
        //     //     height: 40,
        //     //     width: 40,
        //     //     depth: 100,
        //     //     borderRadius: 25,
        //     //     curveType: CurveType.concave,
        //     //     child: Container(
        //     //       decoration: BoxDecoration(
        //     //         border: Border.all(color: FlutterFlowTheme.of(context).white.withOpacity(0.2), width: 2),
        //     //         borderRadius: BorderRadius.circular(25),
        //     //       ),
        //     //       child: Center(
        //     //         child: Text(
        //     //           '3',
        //     //           style: FlutterFlowTheme.of(context)
        //     //               .title1
        //     //               .override(
        //     //                 fontFamily: 'Outfit',
        //     //                 color: FlutterFlowTheme.of(context).grayDark.withOpacity(0.75),
        //     //                 fontSize: 25,
        //     //               ),
        //     //         ),
        //     //       ),
        //     //     ),
        //     //   ),
        //     //   label: "",
        //     // ),
        //   ]),
        // ),
      ),
    );
  }
}
