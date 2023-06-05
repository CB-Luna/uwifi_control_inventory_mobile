import 'dart:io';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/delivered_form_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/receiving_form_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/clientes/agregar_vehiculo_screen.dart';
import 'package:taller_alex_app_asesor/util/util.dart';
import 'package:badges/badges.dart' as badge;
import 'package:taller_alex_app_asesor/screens/widgets/side_menu/side_menu.dart';

class ControlDailyVehicleScreen extends StatefulWidget {
  const ControlDailyVehicleScreen({Key? key}) : super(key: key);

  @override
  State<ControlDailyVehicleScreen> createState() => _ControlDailyVehicleScreenState();
}

class _ControlDailyVehicleScreenState extends State<ControlDailyVehicleScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ControlForm? controlFormReceived;
  ControlForm? controlFormDelivered;


  @override
  void initState() {
    super.initState();
    setState(() {
      context.read<UsuarioController>().recoverPreviousControlForms(DateTime.now());
      controlFormReceived = context.read<UsuarioController>().getControlFormReceivedToday(DateTime.now());
      controlFormDelivered = context.read<UsuarioController>().getControlFormDeliveredToday(DateTime.now());
    });
  }
  @override
  Widget build(BuildContext context) {
    final receivedFormProvider = Provider.of<ReceivingFormController>(context);
    final deliveredFormProvider = Provider.of<DeliveredFormController>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
    usuarioProvider.recoverPreviousControlForms(DateTime.now());
    controlFormReceived = usuarioProvider.getControlFormReceivedToday(DateTime.now());
    controlFormDelivered = usuarioProvider.getControlFormDeliveredToday(DateTime.now());
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
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
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
                ),
                Padding(
                  padding: const EdgeInsetsDirectional
                    .fromSTEB(0, 5, 0, 5),
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          offset: const Offset(1.0, 1.0),
                        )
                      ],
                      color: FlutterFlowTheme.of(context).grayLighter,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      border: Border.all(
                        width: 1,
                        color: FlutterFlowTheme.of(context).secondaryColor,
                      )
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 140.0,
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
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(30.0),
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
                                            'Control Forms Check Up',
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
                                          "${dateTimeFormat('MMMM',
                                              getCurrentTimestamp)}: ${usuarioProvider.firstFormReceived.length} / ${usuarioProvider.firstFormDelivered.length}",
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(
                                                0.0, 10.0, 0.0, 0.0),
                                        child: Text(
                                          "${DateFormat(
                                            'MMMM').
                                            format(DateTime(
                                              getCurrentTimestamp.year, 
                                              DateTime(
                                                getCurrentTimestamp.year, 
                                                getCurrentTimestamp.month - 1, 
                                                getCurrentTimestamp.day).month))
                                                }: ${usuarioProvider.secondFormReceived.length} / ${usuarioProvider.secondFormDelivered.length}",
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(
                                                0.0, 10.0, 0.0, 0.0),
                                        child: Text(
                                          "${DateFormat(
                                            'MMMM').
                                            format(DateTime(
                                              getCurrentTimestamp.year, 
                                              DateTime(
                                                getCurrentTimestamp.year, 
                                                getCurrentTimestamp.month - 2, 
                                                getCurrentTimestamp.day).month))
                                                }: ${usuarioProvider.thirdFormReceived.length} / ${usuarioProvider.thirdFormDelivered.length}",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (controlFormReceived == null) {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AgregarVehiculoScreen(typeForm: true,),
                                    ),
                                  );
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Received Form is already has been registered."),
                                  ));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 15, 0, 0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
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
                                      bottomRight: Radius.circular(30.0),
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                10.0, 10.0, 10.0, 10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize:
                                                  MainAxisSize.max,
                                              children: [
                                                Transform(
                                                  alignment: Alignment.center,
                                                  transform: Matrix4.rotationY(3.14159), // Rotación en radiane
                                                  child: Icon(
                                                    Icons.sort_outlined,
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .white,
                                                    size: 35.0,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.local_shipping_outlined,
                                                  color: FlutterFlowTheme
                                                          .of(context)
                                                      .white,
                                                  size: 35.0,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Received',
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
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                10.0, 10.0, 10.0, 10.0),
                                        child: badge.Badge(
                                          badgeContent: Text(
                                            "${receivedFormProvider
                                            .pendingMeasures + receivedFormProvider
                                            .badStateLights + receivedFormProvider
                                            .badStateSecurity + receivedFormProvider
                                            .badStateFluids + receivedFormProvider
                                            .badStateEquipment}",
                                              style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).white)),
                                          showBadge: controlFormReceived == null,
                                          badgeColor: FlutterFlowTheme.of(context).secondaryColor,
                                          position: badge.BadgePosition.bottomEnd(),
                                          child: ClayContainer(
                                            height: 30,
                                            width: 30,
                                            depth: 10,
                                            spread: 1,
                                            borderRadius: 25,
                                            curveType: CurveType.concave,
                                            color: 
                                            controlFormReceived != null ?
                                            FlutterFlowTheme.of(context).buenoColor
                                            :
                                            FlutterFlowTheme.of(context).primaryColor,
                                            surfaceColor: 
                                            controlFormReceived != null ?
                                            FlutterFlowTheme.of(context).buenoColor
                                            :
                                            FlutterFlowTheme.of(context).primaryColor,
                                            parentColor: 
                                            controlFormReceived != null ?
                                            FlutterFlowTheme.of(context).buenoColor
                                            :
                                            FlutterFlowTheme.of(context).primaryColor,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: Icon(
                                                controlFormReceived != null ?
                                                 Icons.check
                                                 :
                                                 Icons.close,
                                                color:
                                                FlutterFlowTheme.of(context).white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (controlFormReceived == null) {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Received Form hadn't registered yet."),
                                  ));
                                } else {
                                  if (controlFormDelivered == null) {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AgregarVehiculoScreen(typeForm: false,),
                                        ),
                                      );
                                    } else {
                                      snackbarKey.currentState
                                          ?.showSnackBar(const SnackBar(
                                        content: Text(
                                            "Delivered Form is already has been registered."),
                                      ));
                                    }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 15, 0, 0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
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
                                      bottomRight: Radius.circular(30.0),
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                10.0, 10.0, 10.0, 10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize:
                                                  MainAxisSize.max,
                                              children: [
                                                Transform(
                                                  alignment: Alignment.center,
                                                  transform: Matrix4.rotationY(3.14159), // Rotación en radiane
                                                  child: Icon(
                                                    Icons.local_shipping_outlined,
                                                    color: FlutterFlowTheme
                                                            .of(context)
                                                        .white,
                                                    size: 35.0,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.sort_outlined,
                                                  color: FlutterFlowTheme
                                                          .of(context)
                                                      .white,
                                                  size: 35.0,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Delivered',
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
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                10.0, 10.0, 10.0, 10.0),
                                        child: badge.Badge(
                                          badgeContent: Text(
                                            "${deliveredFormProvider
                                            .pendingMeasures + deliveredFormProvider
                                            .badStateLights + deliveredFormProvider
                                            .badStateSecurity + deliveredFormProvider
                                            .badStateFluids + deliveredFormProvider
                                            .badStateEquipment}",
                                              style: TextStyle(
                                                  color: FlutterFlowTheme.of(context).white)),
                                          showBadge: controlFormDelivered == null,
                                          badgeColor: FlutterFlowTheme.of(context).secondaryColor,
                                          position: badge.BadgePosition.bottomEnd(),
                                          child: ClayContainer(
                                            height: 30,
                                            width: 30,
                                            depth: 10,
                                            spread: 1,
                                            borderRadius: 25,
                                            curveType: CurveType.concave,
                                            color: 
                                            controlFormDelivered != null ?
                                            FlutterFlowTheme.of(context).buenoColor
                                            :
                                            FlutterFlowTheme.of(context).primaryColor,
                                            surfaceColor: 
                                            controlFormDelivered != null ?
                                            FlutterFlowTheme.of(context).buenoColor
                                            :
                                            FlutterFlowTheme.of(context).primaryColor,
                                            parentColor: 
                                            controlFormDelivered != null ?
                                            FlutterFlowTheme.of(context).buenoColor
                                            :
                                            FlutterFlowTheme.of(context).primaryColor,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: Icon(
                                                controlFormDelivered != null ?
                                                 Icons.check
                                                 :
                                                 Icons.close,
                                                color:
                                                FlutterFlowTheme.of(context).white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: 
                            const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
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
                                bottomRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
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
                                                .white,
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
                                                    .secondaryColor,
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
                                                    .white,
                                                fontSize: 15.0,
                                                fontWeight:
                                                    FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        usuarioProvider.usuarioCurrent?.vehicle.target?.make ??
                                        '---',
                                        textAlign:
                                            TextAlign.center,
                                        style: FlutterFlowTheme
                                                .of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Inter',
                                              color: FlutterFlowTheme
                                                      .of(context)
                                                  .white,
                                              fontSize: 15.0,
                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                      ),
                                      const Spacer(),
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
                                                .white,
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
                                                    .secondaryColor,
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
                                                    .white,
                                                fontSize: 15.0,
                                                fontWeight:
                                                    FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        usuarioProvider.usuarioCurrent?.vehicle.target?.year ??
                                        '---',
                                        textAlign:
                                            TextAlign.center,
                                        style: FlutterFlowTheme
                                                .of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Inter',
                                              color: FlutterFlowTheme
                                                      .of(context)
                                                  .white,
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
                                                .white,
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
                                                    .secondaryColor,
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
                                                    .white,
                                                fontSize: 15.0,
                                                fontWeight:
                                                    FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        usuarioProvider.usuarioCurrent?.vehicle.target?.model ??
                                        '---',
                                        textAlign:
                                            TextAlign.center,
                                        style: FlutterFlowTheme
                                                .of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Inter',
                                              color: FlutterFlowTheme
                                                      .of(context)
                                                  .white,
                                              fontSize: 15.0,
                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                      ),
                                      const Spacer(),
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
                                                .white,
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
                                                    .secondaryColor,
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
                                                    .white,
                                                fontSize: 15.0,
                                                fontWeight:
                                                    FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        usuarioProvider.usuarioCurrent?.vehicle.target?.id.toString() ??
                                        '---',
                                        textAlign:
                                            TextAlign.center,
                                        style: FlutterFlowTheme
                                                .of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Inter',
                                              color: FlutterFlowTheme
                                                      .of(context)
                                                  .white,
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
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 280,
                                  height: 280,
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
                                    'assets/images/vehicle-placeholder.png',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: 80,
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
                                      bottomRight: Radius.circular(30.0),
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          width: 30.0,
                                          height: 30.0,
                                          decoration:
                                              BoxDecoration(
                                            color: FlutterFlowTheme
                                                    .of(context)
                                                .white,
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
                                                Icons.pin_outlined,
                                                color: FlutterFlowTheme
                                                        .of(context)
                                                    .secondaryColor,
                                                size: 25.0,
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
                                          'License Plates:',
                                          textAlign:
                                              TextAlign.center,
                                          style: FlutterFlowTheme
                                                  .of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Inter',
                                                color: FlutterFlowTheme
                                                        .of(context)
                                                    .white,
                                                fontSize: 18.0,
                                                fontWeight:
                                                    FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        usuarioProvider.usuarioCurrent?.vehicle.target?.licensePlates ??
                                        '---',
                                        textAlign:
                                            TextAlign.center,
                                        style: FlutterFlowTheme
                                            .of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme
                                                  .of(context)
                                              .white,
                                          fontSize: 18.0,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
