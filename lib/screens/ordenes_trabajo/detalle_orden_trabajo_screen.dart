import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taller_alex_app_asesor/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/agregar_observacion_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import '../widgets/flutter_flow_widgets.dart';
import 'flutter_flow_animaciones.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DetalleOrdenTrabajoScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const DetalleOrdenTrabajoScreen({Key? key, required this.ordenTrabajo}) : super(key: key);

  @override
  _DetalleOrdenTrabajoScreenState createState() => _DetalleOrdenTrabajoScreenState();
}

class _DetalleOrdenTrabajoScreenState extends State<DetalleOrdenTrabajoScreen>
    with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();

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

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    20, 25, 20, 0),
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
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EmprendimientosScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                            Text(
                              'Atrás',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText1Family,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryColor,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x39000000),
                                  offset: Offset(-4, 8),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.build,
                                  color: FlutterFlowTheme.of(context).alternate,
                                  size: 30,
                                ),
                                AutoSizeText(
                                  'Técnico',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .subtitle1
                                      .override(
                                        fontFamily: 'Outfit',
                                        color:
                                            FlutterFlowTheme.of(context).alternate,
                                        fontSize: 15,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 60,
                            height: 60,
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: FlutterFlowTheme.of(context).alternate,
                                  size: 30,
                                ),
                                AutoSizeText(
                                  'Cliente',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .subtitle1
                                      .override(
                                        fontFamily: 'Outfit',
                                        color:
                                            FlutterFlowTheme.of(context).alternate,
                                        fontSize: 15,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${widget.ordenTrabajo.cliente.target?.nombre} ${widget.ordenTrabajo.cliente.target?.apellidoP} ${widget.ordenTrabajo.cliente.target?.apellidoM}",
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${widget.ordenTrabajo.vehiculo.target?.marca} - ${widget.ordenTrabajo.vehiculo.target?.modelo}",
                      style: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Outfit',
                            color: FlutterFlowTheme.of(context).dark400,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  height: 240,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x43000000),
                        offset: Offset(-4, 8),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: getImageEmprendimiento(
                    widget.ordenTrabajo.vehiculo.target?.imagen.target?.path).
                      animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
                ),
              ),
              // Image.asset(
              //   'assets/images/carHome@3x.png',
              //   width: MediaQuery.of(context).size.width,
              //   height: 240,
              //   fit: BoxFit.cover,
              // ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: LinearPercentIndicator(
                  percent: 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  lineHeight: 24,
                  animation: true,
                  progressColor: FlutterFlowTheme.of(context).primaryColor,
                  backgroundColor: FlutterFlowTheme.of(context).grayLighter,
                  barRadius: Radius.circular(40),
                  padding: EdgeInsets.zero,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                          child: Text(
                            'Avance',
                            style: FlutterFlowTheme.of(context).bodyText2,
                          ),
                        ),
                        Text(
                          '20%',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Outfit',
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                          child: Text(
                            'Estatus',
                            style: FlutterFlowTheme.of(context).bodyText2,
                          ),
                        ),
                        Text(
                          'Revisión',
                          style: FlutterFlowTheme.of(context).title1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: const BoxDecoration(
                  color: Color(0x004672FF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 12, 5, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Observaciones',
                            style: FlutterFlowTheme.of(context).bodyText2.override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 20,
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AgregarObservacionScreen(ordenTrabajo: widget.ordenTrabajo,),
                                ),
                              );
                              // if (widget.emprendimiento.usuario.target!.rol
                              //             .target!.rol !=
                              //         "Amigo del Cambio" &&
                              //     widget.emprendimiento.usuario.target!.rol
                              //             .target!.rol !=
                              //         "Emprendedor") {
                              //   if (widget.inversion.jornada3) {
                              //     snackbarKey.currentState
                              //         ?.showSnackBar(const SnackBar(
                              //       content: Text(
                              //           "No se puede hacer seguimiento a esta inversión."),
                              //     ));
                              //   } else {
                              //     if (widget.inversion.estadoInversion.target!
                              //                 .estado ==
                              //             "Solicitada" &&
                              //         widget.inversion.idDBR == null) {
                              //       await Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               AgregarProductoInversionScreen(
                              //             emprendimiento: widget.emprendimiento,
                              //             inversion: widget.inversion,
                              //           ),
                              //         ),
                              //       );
                              //     } else {
                              //       snackbarKey.currentState
                              //           ?.showSnackBar(const SnackBar(
                              //         content: Text(
                              //             "Ya no puedes agregar más productos."),
                              //       ));
                              //     }
                              //   }
                              // } else {
                              //   snackbarKey.currentState
                              //       ?.showSnackBar(const SnackBar(
                              //     content: Text(
                              //         "Este usuario no tiene permisos para esta acción."),
                              //   ));
                              // }
                            },
                            text: 'Agregar',
                            icon: const Icon(
                              Icons.add,
                              size: 15,
                            ),
                            options: FFButtonOptions(
                              width: 150,
                              height: 35,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily:
                                        FlutterFlowTheme.of(context).subtitle2Family,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        return ListView.builder(
                          controller: ScrollController(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 110,
                              child: InkWell(
                                onTap: () async {
                                  //print("object");
                                  // if (widget.emprendimiento.usuario.target!.rol
                                  //             .target!.rol !=
                                  //         "Amigo del Cambio" &&
                                  //     widget.emprendimiento.usuario.target!.rol
                                  //             .target!.rol !=
                                  //         "Emprendedor") {
                                  //   if (widget.inversion.jornada3) {
                                  //     snackbarKey.currentState
                                  //         ?.showSnackBar(const SnackBar(
                                  //       content: Text(
                                  //           "No se puede hacer seguimiento a esta inversión."),
                                  //     ));
                                  //   } else {
                                  //     await Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             EditarProductoInversionScreen(
                                  //           inversion: widget.inversion,
                                  //           prodSolicitado: productoSolicitado,
                                  //           idEmprendimiento:
                                  //               widget.emprendimiento.id,
                                  //         ),
                                  //       ),
                                  //     );
                                  //   }
                                  // } else {
                                  //   snackbarKey.currentState
                                  //       ?.showSnackBar(const SnackBar(
                                  //     content: Text(
                                  //         "Este usuario no tiene permisos para esta acción."),
                                  //   ));
                                  // }
                                },
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 8),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.92,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).grayLighter,
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x43000000),
                                                offset: Offset(-4, 8),
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(15, 0, 0, 0),
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        (index + 1).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1Family,
                                                                  fontSize: 20,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .all(8),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            maybeHandleOverflow(
                                                                "Nombre Asesor Atendió",
                                                                25,
                                                                "..."),
                                                            style:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyText1Family,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                    ),
                                                          ),
                                                          Text(
                                                            dateTimeFormat(
                                                                'd/MMM/y',
                                                                DateTime.now()),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1Family,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize: 12,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 5),
                                                        child: Text(
                                                          maybeHandleOverflow('Resumen de la obervación realizada por el cliente...', 84, "..."),
                                                          maxLines: 2,
                                                          style: FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle1
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle1Family,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
            ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: FlutterFlowTheme.of(context).customColor1,
        selectedItemColor: FlutterFlowTheme.of(context).primaryColor,
        unselectedItemColor: FlutterFlowTheme.of(context).grayLight,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_car_outlined,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.directions_car,
              size: 24,
            ),
            label: '•',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.checklist_rtl_outlined,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.checklist_rtl_outlined,
              size: 24,
            ),
            label: '•',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.car_repair,
              size: 24,
            ),
            label: '__',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.attach_money_rounded,
              size: 24,
            ),
            activeIcon: Icon(
              Icons.attach_money_rounded,
              size: 24,
            ),
            label: '•',
            tooltip: '',
          )
        ],
      ),
    );
  }
}
