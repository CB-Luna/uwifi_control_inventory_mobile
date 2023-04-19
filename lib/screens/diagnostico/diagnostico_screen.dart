import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/screens/diagnostico/agregar_diagnostico_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
class DiagnosticoScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const DiagnosticoScreen({
    Key? key, 
    required this.ordenTrabajo
    }) : super(key: key);

  @override
  _DiagnosticoScreenState createState() => _DiagnosticoScreenState();
}

class _DiagnosticoScreenState extends State<DiagnosticoScreen>
    with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
    'textOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 50),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 70),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'textOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 80),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 90),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 90),
          end: const Offset(0, 0),
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

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              duration: const Duration(milliseconds: 240),
              reverseDuration: const Duration(milliseconds: 240),
              child: AgregarDiagnosticoScreen(
                vehiculo: widget.ordenTrabajo.vehiculo.target!,
                ordenTrabajo: widget.ordenTrabajo
                ,),
            ),
          );
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        elevation: 8,
        child: Icon(
          Icons.add_rounded,
          color: FlutterFlowTheme.of(context).alternate,
          size: 32,
        ),
      ),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Diagnóstico',
          textAlign: TextAlign.center,
          style:
              FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: FlutterFlowTheme.of(context)
                        .bodyText1Family,
                    color: FlutterFlowTheme.of(context).tertiaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Text(
                    'Solicitadas',
                    textAlign: TextAlign.center,
                    style:
                        FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .bodyText1Family,
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                  ).animateOnPageLoad(
                      animationsMap['textOnPageLoadAnimation1']!),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Builder(
                    builder: (context) {
                      return ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                            child: InkWell(
                              onTap: () async {
                                // await Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         AppointmentDetailsWidget(
                                //       appointmentRef:
                                //           listViewCarAppointmentsRecord,
                                //     ),
                                //   ),
                                // );
                              },
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x2B202529),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Slidable(
                                startActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                      label: "Aceptar",
                                      icon: Icons
                                          .check_circle_outline,
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).primaryColor,
                                      onPressed: (context) async {
                                      }),
                                  SlidableAction(
                                      label: "Rechazar",
                                      icon: Icons
                                          .cancel_outlined,
                                      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
                                      onPressed: (context) async {
                                      }),
                                ]),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 0),
                                        child: Builder(
                                          builder: (context) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .fromSTEB(8, 4, 0, 4),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Nombre Del Técnico Encargado",
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyText2
                                                                  .override(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    fontSize: 12,
                                                                  ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 4, 0, 0),
                                                          child: Text(
                                                            "Calibración de Llantas",
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .subtitle1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 4, 0, 0),
                                                          child: Text(
                                                            "${formatNumber(
                                                              119.99,
                                                              formatType:
                                                                  FormatType
                                                                      .decimal,
                                                              decimalType:
                                                                  DecimalType
                                                                      .automatic,
                                                              currency: '\$',
                                                            )} (Costo Servicio)",
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const ClipRRect(
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(12),
                                                    topLeft: Radius.circular(0),
                                                    topRight: Radius.circular(12),
                                                  ),
                                                  child: Image(
                                                    height: 100,
                                                    width: 160,
                                                    image: AssetImage('assets/images/calibracionLlantas.jpeg'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 16, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: FlutterFlowTheme.of(context)
                                                  .tertiaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.access_time_rounded,
                                                  color:
                                                      FlutterFlowTheme.of(context)
                                                          .white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(12, 0, 0, 0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Fecha de Entrega",
                                                      style:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyText2,
                                                    ),
                                                    Text(
                                                      dateTimeFormat(
                                                        'yMMMEd',
                                                        DateTime.now().add(const Duration(days:2))),
                                                      style:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyText1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                      12, 0, 0, 0),
                                              child: Text(
                                                dateTimeFormat(
                                                    'yMMMEd',
                                                    DateTime.now()),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ).animateOnPageLoad(animationsMap[
                                'containerOnPageLoadAnimation1']!),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 8),
                  child: Text(
                    'Autorizadas',
                    textAlign: TextAlign.center,
                    style:
                        FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .bodyText1Family,
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                  ).animateOnPageLoad(
                      animationsMap['textOnPageLoadAnimation2']!),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 16),
                  child: Builder(
                    builder: (context) {
                      // Customize what your widget looks like when it's loading.
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: widget.ordenTrabajo.diagnostico.target?.servicios.toList().length ?? 0,
                        itemBuilder: (context, listViewIndex) {
                          final servicio = widget.ordenTrabajo.diagnostico.target?.servicios.toList()[listViewIndex];
                          return Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                            child: InkWell(
                              onTap: () async {
                                // await Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         AppointmentDetailsWidget(
                                //       appointmentRef:
                                //           listViewCarAppointmentsRecord,
                                //     ),
                                //   ),
                                // );
                              },
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x2B202529),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Slidable(
                                  startActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                        label: "Eliminar",
                                        icon: Icons
                                            .check_circle_outline,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context).primaryColor,
                                        onPressed: (context) async {
                                        }),
                                  ]),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 0),
                                        child: Builder(
                                          builder: (context) {
                                            // Customize what your widget looks like when it's loading.
                                            // if (!snapshot.hasData) {
                                            //   return Center(
                                            //     child: SizedBox(
                                            //       width: 50,
                                            //       height: 50,
                                            //       child: SpinKitCubeGrid(
                                            //         color: FlutterFlowTheme.of(
                                            //                 context)
                                            //             .primaryColor,
                                            //         size: 50,
                                            //       ),
                                            //     ),
                                            //   );
                                            // }
                                            // final rowProductNameRecord =
                                            //     snapshot.data!;
                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .fromSTEB(8, 4, 0, 4),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Nombre Del Técnico Encargado",
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyText2
                                                                  .override(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    fontSize: 12,
                                                                  ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 4, 0, 0),
                                                          child: Text(
                                                            "${servicio?.servicio}",
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .subtitle1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 4, 0, 0),
                                                          child: Text(
                                                            "${formatNumber(
                                                              servicio?.costoServicio ?? 0,
                                                              formatType:
                                                                  FormatType
                                                                      .decimal,
                                                              decimalType:
                                                                  DecimalType
                                                                      .automatic,
                                                              currency: '\$',
                                                            )} (Costo Servicio)",
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(12),
                                                    topLeft: Radius.circular(0),
                                                    topRight: Radius.circular(12),
                                                  ),
                                                  child: getAssetImage(
                                                        servicio?.imagen ?? "assets/images/default_image_placeholder.jpeg",
                                                        height: 100,
                                                        width: 160
                                                      ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 16, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.access_time_rounded,
                                                  color:
                                                      FlutterFlowTheme.of(context)
                                                          .secondaryBackground,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(12, 0, 0, 0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Fecha de Entrega",
                                                      style:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyText2,
                                                    ),
                                                    Text(
                                                      dateTimeFormat(
                                                        'yMMMEd',
                                                        servicio?.fechaEntrega ?? DateTime.now()),
                                                      style:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyText1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                      12, 0, 0, 0),
                                              child: Text(
                                                "Registrado",
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2.override(
                                                          fontFamily:
                                                              'Outfit',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold
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
                            ).animateOnPageLoad(animationsMap[
                                'containerOnPageLoadAnimation2']!),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
