import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleet_management_tool_rta/database/entitys.dart';
import 'package:fleet_management_tool_rta/flutter_flow/flutter_flow_theme.dart';
import 'package:fleet_management_tool_rta/helpers/globals.dart';
import 'package:fleet_management_tool_rta/providers/database_providers/usuario_controller.dart';
import 'package:fleet_management_tool_rta/providers/database_providers/vehiculo_controller.dart';
import 'package:fleet_management_tool_rta/providers/user_provider.dart';
import 'package:fleet_management_tool_rta/screens/control_form/main_screen_selector.dart';
import 'package:fleet_management_tool_rta/screens/select_vehicle/components/select_vehicle_failed.dart';
import 'package:fleet_management_tool_rta/screens/widgets/get_image_widget.dart';
import 'package:fleet_management_tool_rta/util/flutter_flow_util.dart';

class SelectVehicleScreen extends StatefulWidget {
  const SelectVehicleScreen({Key? key}) : super(key: key);

  @override
  State<SelectVehicleScreen> createState() => _SelectVehicleScreenState();
}

class _SelectVehicleScreenState extends State<SelectVehicleScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Vehicle> vehicleAvailables = [];


  @override
  void initState() {
    super.initState();
    setState(() {
      vehicleAvailables = context.read<UsuarioController>().getVehiclesAvailables();
      context.read<VehiculoController>().vehicleSelected = vehicleAvailables.first;
    });
  }
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final vehiculoController = Provider.of<VehiculoController>(context);
    final UserState userState = Provider.of<UserState>(context);
    vehicleAvailables = usuarioProvider.getVehiclesAvailables();
    usuarioProvider.recoverPreviousControlForms(DateTime.now());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).background,
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20, 50, 20, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Please select an Available Vehicle to continue',
                              textAlign: TextAlign.center,
                              style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .title1Family,
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
                    padding: 
                      const EdgeInsetsDirectional.fromSTEB(20, 25, 20, 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: blueRadial,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () async {
                              // usuarioProvider.clearInformation();
                              vehiculoController.cleanComponents();
                              prefs.setBool(
                                    "boolLogin", false);
                             await userState.logout();
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
                                  'Back',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily:
                                            FlutterFlowTheme.of(context)
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

                        Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: blueRadial,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () async {
                              if (vehiculoController.vehicleSelected == null) {
                                snackbarKey.currentState
                                    ?.showSnackBar(const SnackBar(
                                  content: Text(
                                      "You need to select an Available Vehicle to continue."),
                                ));
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('Validation'),
                                      content: Text(
                                          "Are you sure you want to Select the Vehicle with License Plates: '${vehiculoController.vehicleSelected!.licensePlates}'."),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            if (await vehiculoController.vehicleAssigned(usuarioProvider.usuarioCurrent!)) {
                                              // ignore: use_build_context_synchronously
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainScreenSelector(),
                                                  ),
                                                );
                                            } else {
                                              // ignore: use_build_context_synchronously
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SelectVehicleFailedScreen(),
                                                  ),
                                                );
                                            }
                                          },
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Continue',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily:
                                            FlutterFlowTheme.of(context)
                                                .bodyText1Family,
                                        color: FlutterFlowTheme.of(context).white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: FlutterFlowTheme.of(context).white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: 
                      const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            offset: const Offset(3.0, 3.0),
                          )
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            FlutterFlowTheme.of(context).alternate,
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
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 15.0, 12.0, 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: Row(
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
                                        maybeHandleOverflow(
                                          vehiculoController
                                          .vehicleSelected?.make ?? '---', 
                                          15, "..."),
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  child: Row( 
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
                                        vehiculoController.vehicleSelected?.year ??
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
                                    ],),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 10.0, 12.0, 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: Row(
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
                                        maybeHandleOverflow(
                                          vehiculoController
                                          .vehicleSelected?.model ?? '---', 
                                          15, "..."),
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  child: Row(
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
                                        vehiculoController.vehicleSelected?.idDBR ??
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
                                )
                              ],
                            ),
                          ),
                          
                            Padding(
                              padding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 10.0, 12.0, 15.0),
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
                                          Icons.pin_outlined,
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
                                          fontSize: 15.0,
                                          fontWeight:
                                              FontWeight.w500,
                                        ),
                                  ),
                                ),
                                Text(
                                  vehiculoController.vehicleSelected?.licensePlates ??
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

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: Container(
                      width: 260,
                      height: 260,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: FlutterFlowTheme.of(context).grayLighter,
                            offset: const Offset(3.0, 3.0),
                          )
                        ],
                      ),
                      child: 
                      vehiculoController.vehicleSelected?.path != null ?
                      Image.file(
                        File(vehiculoController.vehicleSelected!.path),
                        fit: BoxFit.contain,
                      )
                      :
                      Image.asset(
                        'assets/images/vehicle-placeholder.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: CarouselSlider(
                options: CarouselOptions(height: 200),
                items: vehicleAvailables.map((data) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: () {
                          vehiculoController.updateVehicleSelected(data);
                        },
                        child: Container(
                          height: 200,
                          width: 290,
                          decoration: BoxDecoration(
                            gradient: blueRadial,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: FlutterFlowTheme.of(context).secondaryColor,
                                offset: const Offset(2, 2),
                              )
                            ],
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 130,
                                    height: 130,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                         Radius.circular(80.0),
                                        ),
                                    ),
                                    child: getImageContainer(data.path),
                                  ),
                                ),
                                Text(
                                  "License Plates: ${data.licensePlates}", 
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
