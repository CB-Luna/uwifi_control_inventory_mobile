import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/clientes/agregar_vehiculo_screen.dart';
import 'package:taller_alex_app_asesor/util/util.dart';
import 'package:taller_alex_app_asesor/screens/widgets/side_menu/side_menu.dart';

class ControlDailyVehicleScreen extends StatefulWidget {
  const ControlDailyVehicleScreen({Key? key}) : super(key: key);

  @override
  State<ControlDailyVehicleScreen> createState() => _ControlDailyVehicleScreenState();
}

class _ControlDailyVehicleScreenState extends State<ControlDailyVehicleScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    setState(() {
      context.read<UsuarioController>().recoverTodayControlForms();
    });
  }
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const SideMenu(),
        backgroundColor: FlutterFlowTheme.of(context).white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).background,
            ),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20, 50, 20, 0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                scaffoldKey.currentState?.openDrawer();
                              },
                              child: Container(
                                width: 50,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.menu_rounded,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Control Daily Vehicle',
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0, 120, 0, 6),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color:
                          FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 25.0, 0.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 80.0,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                  offset: const Offset(6.0, 6.0),
                                )
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  FlutterFlowTheme.of(context).alternate,
                                  FlutterFlowTheme.of(context).alternate.withOpacity(0.8),
                                ],
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5.0, 5.0, 5.0, 5.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisSize:
                                              MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          10.0,
                                                          0.0),
                                              child: Container(
                                                width: 20.0,
                                                height: 20.0,
                                                decoration:
                                                    BoxDecoration(
                                                  color: FlutterFlowTheme
                                                          .of(context)
                                                      .secondaryBackground,
                                                  shape:
                                                      BoxShape.circle,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Icon(
                                                      Icons.inventory_outlined,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryColor,
                                                      size: 15.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Control Forms Check Up (${dateTimeFormat('MMM',
                                                getCurrentTimestamp)})',
                                              textAlign:
                                                  TextAlign.center,
                                              style: FlutterFlowTheme
                                                      .of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .primaryBackground,
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(
                                                  0.0, 10.0, 0.0, 0.0),
                                          child: Text(
                                            '15',
                                            style: FlutterFlowTheme.of(
                                                    context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme
                                                          .of(context)
                                                      .primaryBackground,
                                                  fontSize: 18.0,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 5.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons
                                            .keyboard_arrow_right_outlined,
                                        color:
                                            FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (usuarioProvider.controlFormReceived == null) {
                              snackbarKey.currentState
                                  ?.showSnackBar(const SnackBar(
                                content: Text(
                                    "Received Form hadn't registered yet."),
                              ));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 80.0,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8.0,
                                    color: FlutterFlowTheme.of(context).secondaryColor,
                                    offset: const Offset(6.0, 6.0),
                                  )
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    FlutterFlowTheme.of(context).secondaryColor,
                                    FlutterFlowTheme.of(context).secondaryColor.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(0.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5.0, 5.0, 5.0, 5.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize:
                                                MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            10.0,
                                                            0.0),
                                                child: Container(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  decoration:
                                                      BoxDecoration(
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    shape:
                                                        BoxShape.circle,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.checklist_outlined,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryColor,
                                                        size: 15.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Today Form Check Up (Received)',
                                                textAlign:
                                                    TextAlign.center,
                                                style: FlutterFlowTheme
                                                        .of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Text(
                                              usuarioProvider.controlFormReceived == null ?
                                              'Unregistered'
                                                :
                                              'Registered',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .primaryBackground,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 5.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons
                                              .keyboard_arrow_right_outlined,
                                          color:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (usuarioProvider.controlFormDelivered == null) {
                              snackbarKey.currentState
                                  ?.showSnackBar(const SnackBar(
                                content: Text(
                                    "Delivered Form hadn't registered yet."),
                              ));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 80.0,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8.0,
                                    color: FlutterFlowTheme.of(context).secondaryColor,
                                    offset: const Offset(6.0, 6.0),
                                  )
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    FlutterFlowTheme.of(context).secondaryColor,
                                    FlutterFlowTheme.of(context).secondaryColor.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(30.0),
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(0.0),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5.0, 5.0, 5.0, 5.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize:
                                                MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            10.0,
                                                            0.0),
                                                child: Container(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  decoration:
                                                      BoxDecoration(
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    shape:
                                                        BoxShape.circle,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.checklist_rtl_outlined,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryColor,
                                                        size: 15.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Today Form Check Up (Delivered)',
                                                textAlign:
                                                    TextAlign.center,
                                                style: FlutterFlowTheme
                                                        .of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Text(
                                              usuarioProvider.controlFormDelivered == null ?
                                              'Unregistered'
                                                :
                                              'Registered',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .primaryBackground,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 5.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons
                                              .keyboard_arrow_right_outlined,
                                          color:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15.0, 15.0, 15.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 8.0,
                                      color: FlutterFlowTheme.of(context).white,
                                      offset: const Offset(6.0, 6.0),
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      FlutterFlowTheme.of(context).white,
                                      FlutterFlowTheme.of(context).white.withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(30.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).alternate,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12.0, 15.0, 12.0, 5.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        5.0,
                                                        0.0),
                                            child: Container(
                                              width: 20.0,
                                              height: 20.0,
                                              decoration:
                                                  BoxDecoration(
                                                color: FlutterFlowTheme
                                                        .of(context)
                                                    .alternate,
                                                shape:
                                                    BoxShape.circle,
                                              ),
                                              child: Column(
                                                mainAxisSize:
                                                    MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: [
                                                  Icon(
                                                    Icons.label_important_outline,
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .white,
                                                    size: 15.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        5.0,
                                                        0.0),
                                            child: Text(
                                              'Make:',
                                              textAlign:
                                                  TextAlign.center,
                                              style: FlutterFlowTheme
                                                      .of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .alternate,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            usuarioProvider.usuarioCurrent?.vehicle.target?.make ??
                                            'RAM',
                                            textAlign:
                                                TextAlign.center,
                                            style: FlutterFlowTheme
                                                    .of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme
                                                          .of(context)
                                                      .alternate,
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12.0, 15.0, 12.0, 15.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        5.0,
                                                        0.0),
                                            child: Container(
                                              width: 20.0,
                                              height: 20.0,
                                              decoration:
                                                  BoxDecoration(
                                                color: FlutterFlowTheme
                                                        .of(context)
                                                    .alternate,
                                                shape:
                                                    BoxShape.circle,
                                              ),
                                              child: Column(
                                                mainAxisSize:
                                                    MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: [
                                                  Icon(
                                                    Icons.local_shipping_outlined,
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .white,
                                                    size: 15.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        5.0,
                                                        0.0),
                                            child: Text(
                                              'Model:',
                                              textAlign:
                                                  TextAlign.center,
                                              style: FlutterFlowTheme
                                                      .of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .alternate,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            usuarioProvider.usuarioCurrent?.vehicle.target?.model??
                                            'Ram 4500 HD Chassis',
                                            textAlign:
                                                TextAlign.center,
                                            style: FlutterFlowTheme
                                                    .of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme
                                                          .of(context)
                                                      .alternate,
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 8.0,
                                      color: FlutterFlowTheme.of(context).white,
                                      offset: const Offset(6.0, 6.0),
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      FlutterFlowTheme.of(context).white,
                                      FlutterFlowTheme.of(context).white.withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).alternate,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12.0, 15.0, 12.0, 5.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        5.0,
                                                        0.0),
                                            child: Container(
                                              width: 20.0,
                                              height: 20.0,
                                              decoration:
                                                  BoxDecoration(
                                                color: FlutterFlowTheme
                                                        .of(context)
                                                    .alternate,
                                                shape:
                                                    BoxShape.circle,
                                              ),
                                              child: Column(
                                                mainAxisSize:
                                                    MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month_outlined,
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .white,
                                                    size: 15.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        5.0,
                                                        0.0),
                                            child: Text(
                                              'Year:',
                                              textAlign:
                                                  TextAlign.center,
                                              style: FlutterFlowTheme
                                                      .of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .alternate,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            usuarioProvider.usuarioCurrent?.vehicle.target?.year ??
                                            '2022',
                                            textAlign:
                                                TextAlign.center,
                                            style: FlutterFlowTheme
                                                    .of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme
                                                          .of(context)
                                                      .alternate,
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12.0, 15.0, 12.0, 15.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        5.0,
                                                        0.0),
                                            child: Container(
                                              width: 20.0,
                                              height: 20.0,
                                              decoration:
                                                  BoxDecoration(
                                                color: FlutterFlowTheme
                                                        .of(context)
                                                    .alternate,
                                                shape:
                                                    BoxShape.circle,
                                              ),
                                              child: Column(
                                                mainAxisSize:
                                                    MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: [
                                                  Icon(
                                                    Icons.key_outlined,
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .white,
                                                    size: 15.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0,
                                                        0.0,
                                                        5.0,
                                                        0.0),
                                            child: Text(
                                              'ID:',
                                              textAlign:
                                                  TextAlign.center,
                                              style: FlutterFlowTheme
                                                      .of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .alternate,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            "${usuarioProvider.usuarioCurrent?.vehicle.target?.id??
                                            022}",
                                            textAlign:
                                                TextAlign.center,
                                            style: FlutterFlowTheme
                                                    .of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme
                                                          .of(context)
                                                      .alternate,
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional
                              .fromSTEB(
                                  0.0, 15.0, 0.0, 0.0),
                          child: GradientText(
                            usuarioProvider.usuarioCurrent?.vehicle.target?.company.target?.company ??
                            'CRY',
                            style: FlutterFlowTheme.of(
                                    context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Inter',
                                  color:
                                      FlutterFlowTheme.of(
                                              context)
                                          .primaryText,
                                  fontSize: 50.0,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                            colors: [
                              FlutterFlowTheme.of(context)
                                .alternate,
                              FlutterFlowTheme.of(context)
                                .secondaryColor
                            ],
                            gradientDirection:
                                GradientDirection.ltr,
                            gradientType:
                                GradientType.linear,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Container(
                            width: 320,
                            height: 320,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                            ),
                            child: 
                            usuarioProvider.usuarioCurrent?.vehicle.target?.path != null ?
                            Image.file(
                              File(usuarioProvider.usuarioCurrent!.vehicle.target!.path),
                              fit: BoxFit.contain,
                            )
                            :
                            Image.asset(
                              'assets/images/van2.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 35,
                  child: 
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .alternate,
                              borderRadius:
                                  BorderRadius.circular(30
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 1),
                                )
                              ],
                            ),
                            child: InkWell(
                              onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AgregarVehiculoScreen(),
                                    ),
                                  );
                              },
                              child: Icon(
                              Icons.local_shipping,
                              color: FlutterFlowTheme.of(context).white,
                              size: 24,
                            ),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                        ],
                      ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
