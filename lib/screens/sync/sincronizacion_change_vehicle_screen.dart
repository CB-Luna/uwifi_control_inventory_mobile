import 'package:clay_containers/clay_containers.dart';
import 'package:fleet_management_tool_rta/database/entitys.dart';
import 'package:fleet_management_tool_rta/flutter_flow/flutter_flow_theme.dart';
import 'package:fleet_management_tool_rta/helpers/constants.dart';
import 'package:fleet_management_tool_rta/helpers/globals.dart';
import 'package:fleet_management_tool_rta/providers/database_providers/usuario_controller.dart';
import 'package:fleet_management_tool_rta/providers/sync_change_vehicle_provider.dart';
import 'package:fleet_management_tool_rta/providers/user_provider.dart';
import 'package:fleet_management_tool_rta/util/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:fleet_management_tool_rta/screens/widgets/flutter_flow_widgets.dart';

class SincronizacionChangeVehicleScreen extends StatefulWidget {

  const SincronizacionChangeVehicleScreen({
    Key? key, 
    }) : super(key: key);

  @override
  State<SincronizacionChangeVehicleScreen> createState() => _SincronizacionChangeVehicleScreenState();
}

class _SincronizacionChangeVehicleScreenState extends State<SincronizacionChangeVehicleScreen> {
  @override
  void initState() {
    super.initState();
      setState(() {
        context.read<SyncChangeVehicleProvider>().exitoso = true;
        context.read<SyncChangeVehicleProvider>().procesoCargando(true);
        context.read<SyncChangeVehicleProvider>().procesoTerminado(false);
        context.read<SyncChangeVehicleProvider>().procesoExitoso(false);
        final Users currentUser = context.read<UsuarioController>().usuarioCurrent!;
        Future<bool> booleano = context.read<SyncChangeVehicleProvider>().executeInstrucciones(currentUser);
        Future(() async {
          if (await booleano) {
          } else {
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final syncChangeVehicleProvider = Provider.of<SyncChangeVehicleProvider>(context);
    final userState = Provider.of<UserState>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).background,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: syncChangeVehicleProvider.procesocargando || syncChangeVehicleProvider.procesoexitoso,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 40, 0, 0),
                              child: Text(
                                'Changing vehicle!',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).bodyText1Family,
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 25,
                                    ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: syncChangeVehicleProvider.procesocargando || syncChangeVehicleProvider.procesoexitoso,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Text(
                                "User and Vehicle data\nsynchronizing\nto Data Base, don't interrput internet connection\nuntil the proccess finish.\nYou will have to log in\nagain after this.",
                                textAlign: TextAlign.center,
                                maxLines: 5,
                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).bodyText1Family,
                                      color: FlutterFlowTheme.of(context).dark400,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                          syncChangeVehicleProvider.procesocargando
                              ? Visibility(
                                visible: syncChangeVehicleProvider.procesocargando,
                                child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 70, 0, 0),
                                    child: getProgressIndicatorAnimated(
                                        "Sync..."),
                                  ),
                              )
                              : 
                              syncChangeVehicleProvider.procesoexitoso
                              ? Visibility(
                                  visible: !syncChangeVehicleProvider.procesocargando,
                                  child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 40, 0, 0),
                                      child: Lottie.asset(
                                        'assets/lottie_animations/elemento-creado.json',
                                        width: 250,
                                        height: 180,
                                        fit: BoxFit.cover,
                                        repeat: false,
                                        animate: true,
                                      ),
                                    ),
                                )
                                :
                                Visibility(
                                  visible: !syncChangeVehicleProvider.procesocargando,
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 30, 0, 0),
                                    child: Icon(
                                        Icons.warning_amber_outlined,
                                        color: FlutterFlowTheme.of(context).customColor4,
                                        size: 150,
                                        ),
                                  ),
                                ),
                          Visibility(
                            visible: syncChangeVehicleProvider.procesoterminado && syncChangeVehicleProvider.procesoexitoso,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 100, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  syncChangeVehicleProvider.instruccionesFallidas.clear();
                                  syncChangeVehicleProvider.procesoTerminado(false);
                                  prefs.setBool(
                                        "boolLogin", false);
                                      await userState.logout();
                                },
                                text: 'Continue',
                                options: FFButtonOptions(
                                  width: 130,
                                  height: 45,
                                  color: FlutterFlowTheme.of(context).dark400,
                                  textStyle:
                                      FlutterFlowTheme.of(context).subtitle2.override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .subtitle2Family,
                                            color: FlutterFlowTheme.of(context).white,
                                          ),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: syncChangeVehicleProvider.procesoterminado && (syncChangeVehicleProvider.procesoexitoso == false),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'Failed try to change vehicle.\nDeploy the details\nto more information.',
                                    textAlign: TextAlign.center,
                                    maxLines: 4,
                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context).bodyText1Family,
                                          color: FlutterFlowTheme.of(context).dark400,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    decoration: const BoxDecoration(
                                      color: Color(0x00F2F4F8),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      color: const Color(0x00F2F4F8),
                                      child: ExpandableNotifier(
                                        initialExpanded: true,
                                        child: ExpandablePanel(
                                          header: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 8, 0),
                                                child: Icon(
                                                  Icons.error_outline_sharp,
                                                  color: FlutterFlowTheme.of(context)
                                                      .dark400,
                                                  size: 20,
                                                ),
                                              ),
                                              Text(
                                                'Details',
                                                style: FlutterFlowTheme.of(context)
                                                    .title1
                                                    .override(
                                                      fontFamily: FlutterFlowTheme.of(context)
                                                          .title1Family,
                                                      color: FlutterFlowTheme.of(context)
                                                          .primaryText,
                                                      fontSize: 20,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          collapsed: Divider(
                                            thickness: 1.5,
                                            color: FlutterFlowTheme.of(context).white,
                                          ),
                                          expanded: Builder(
                                            builder: (context) {
                                              return ListView.builder(
                                                controller: ScrollController(),
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: syncChangeVehicleProvider.instruccionesFallidas.length,
                                                itemBuilder: (context, index) {
                                                  final error = syncChangeVehicleProvider.instruccionesFallidas[index];
                                                  return InkWell(
                                                    onTap: () async {
                                                      await showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width * 0.5,
                                                                  child: const Text("Error's Detail"),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: ClayContainer(
                                                                    height: 30,
                                                                    width: 30,
                                                                    depth: 15,
                                                                    spread: 1,
                                                                    borderRadius: 15,
                                                                    curveType: CurveType.concave,
                                                                    color:
                                                                    FlutterFlowTheme.of(context).secondaryColor,
                                                                    surfaceColor:
                                                                    FlutterFlowTheme.of(context).secondaryColor,
                                                                    parentColor:
                                                                    FlutterFlowTheme.of(context).secondaryColor,
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(25),
                                                                      ),
                                                                      child: Icon(
                                                                        Icons.close,
                                                                        color: FlutterFlowTheme.of(context).white,
                                                                        size: 30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            content: SizedBox( // Need to use container to add size constraint.
                                                              width: MediaQuery.of(context).size.width * 0.8,
                                                              height: MediaQuery.of(context).size.height * 0.45,
                                                              child: SingleChildScrollView(
                                                                controller: ScrollController(),
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context).size.width * 0.8,
                                                                      child: Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            5, 0, 5, 20),
                                                                        child: Row(
                                                                          children: [
                                                                            Text(
                                                                              'Date: ',
                                                                              style: FlutterFlowTheme.of(
                                                                                  context)
                                                                              .bodyText2
                                                                              .override(
                                                                                fontFamily:
                                                                                    'Poppins',
                                                                                color: FlutterFlowTheme.of(context).dark400,
                                                                                fontSize: 15,
                                                                                fontWeight:
                                                                                    FontWeight
                                                                                        .bold,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              dateTimeFormat('dd-MM-y hh:mm:ss', error.fecha),
                                                                              style: FlutterFlowTheme.of(
                                                                                  context)
                                                                              .bodyText2
                                                                              .override(
                                                                                fontFamily:
                                                                                    'Poppins',
                                                                                color: FlutterFlowTheme.of(context).dark400,
                                                                                fontSize: 13,
                                                                                fontWeight:
                                                                                    FontWeight
                                                                                        .normal,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          5, 0, 5, 5),
                                                                      child: Text(
                                                                        'Action: ',
                                                                        style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText2
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color: FlutterFlowTheme.of(context).dark400,
                                                                          fontSize: 15,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      error.instruccion,
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: FlutterFlowTheme.of(context).dark400,
                                                                        fontSize: 13,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
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
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(15, 10, 15, 0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                          color:
                                                              FlutterFlowTheme.of(context).secondaryColor,
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              blurRadius: 4,
                                                              color:
                                                                  Color(0x32000000),
                                                              offset: Offset(0, 2),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      16, 0, 16, 5),
                                                              child: Text(
                                                                'Action: ${error.instruccion}',
                                                                maxLines: 2,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: FlutterFlowTheme.of(context)
                                                                          .white,
                                                                      fontSize: 13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      16, 0, 16, 0),
                                                              child: Text(
                                                                'Date: ${dateTimeFormat('dd-MM-y hh:mm:ss', error.fecha)}',
                                                                maxLines: 1,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: FlutterFlowTheme.of(context)
                                                                          .white,
                                                                      fontSize: 13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      16, 0, 16, 0),
                                                              child: Icon(
                                                                Icons.remove_red_eye_outlined,
                                                                size: 30,
                                                                color: FlutterFlowTheme.of(context).white,
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
                                          theme: ExpandableThemeData(
                                            tapHeaderToExpand: true,
                                            tapBodyToExpand: false,
                                            tapBodyToCollapse: false,
                                            headerAlignment:
                                                ExpandablePanelHeaderAlignment.center,
                                            hasIcon: true,
                                            iconColor:
                                                FlutterFlowTheme.of(context).dark400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 30),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      syncChangeVehicleProvider.instruccionesFallidas.clear();
                                      syncChangeVehicleProvider.procesoTerminado(false);
                                      prefs.setBool(
                                            "boolLogin", false);
                                          await userState.logout();
                                    },
                                    text: 'Close',
                                    options: FFButtonOptions(
                                      width: 130,
                                      height: 45,
                                      color: FlutterFlowTheme.of(context).dark400,
                                      textStyle:
                                          FlutterFlowTheme.of(context).subtitle2.override(
                                                fontFamily: FlutterFlowTheme.of(context)
                                                    .subtitle2Family,
                                                color: FlutterFlowTheme.of(context).white,
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
                          ),
                        ],
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
