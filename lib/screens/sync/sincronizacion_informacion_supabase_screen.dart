import 'package:clay_containers/clay_containers.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/main.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/main_screen_selector.dart';
import 'package:uwifi_control_inventory_mobile/util/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';

import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class SincronizacionInformacionSupabaseScreen extends StatefulWidget {

  const SincronizacionInformacionSupabaseScreen({
    Key? key, 
    }) : super(key: key);

  @override
  State<SincronizacionInformacionSupabaseScreen> createState() => _SincronizacionInformacionSupabaseScreenState();
}

class _SincronizacionInformacionSupabaseScreenState extends State<SincronizacionInformacionSupabaseScreen> {
  @override
  void initState() {
    super.initState();
      setState(() {
        context.read<SyncProviderSupabase>().exitoso = true;
        context.read<SyncProviderSupabase>().updatePassword = false;
        context.read<SyncProviderSupabase>().procesoCargando(true);
        context.read<SyncProviderSupabase>().procesoTerminado(false);
        context.read<SyncProviderSupabase>().procesoExitoso(false);
        Future<bool> booleano = context.read<SyncProviderSupabase>().executeInstrucciones(dataBase.bitacoraBox
            .getAll()
            .toList()
            .where((element) => element.usuarioPropietario == prefs.getString("userId")!)
            .toList()
            );
        Future(() async {
          if (await booleano) {
          } else {
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    final syncProviderSupabase = Provider.of<SyncProviderSupabase>(context);
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
                            visible: syncProviderSupabase.procesocargando || syncProviderSupabase.procesoexitoso,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 40, 0, 0),
                              child: Text(
                                'Sync data!',
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
                            visible: syncProviderSupabase.procesocargando || syncProviderSupabase.procesoexitoso,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Text(
                                "Control data form\nsynchronizing\nto Data Base, don't interrput internet connection\nuntil the proccess finish.",
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
                          syncProviderSupabase.procesocargando
                              ? Visibility(
                                visible: syncProviderSupabase.procesocargando,
                                child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 70, 0, 0),
                                    child: getProgressIndicatorAnimated(
                                        "Sync..."),
                                  ),
                              )
                              : 
                              syncProviderSupabase.procesoexitoso
                              ? Visibility(
                                  visible: !syncProviderSupabase.procesocargando,
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
                                  visible: !syncProviderSupabase.procesocargando,
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
                            visible: syncProviderSupabase.procesoterminado && syncProviderSupabase.procesoexitoso,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 100, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  prefs.setBool("boolSyncData", false);
                                  syncProviderSupabase.procesoTerminado(false);
                                  if (syncProviderSupabase.updatePassword) {
                                    prefs.setBool(
                                        "boolLogin", false);
                                      await userState.logout();
                                  } else {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MainScreenSelector(),
                                      ),
                                    );
                                  }
                                  // usuarioController.setStream(false);
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
                            visible: syncProviderSupabase.procesoterminado && (syncProviderSupabase.procesoexitoso == false),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'Failed sync.\nDeploy the details\nto more information.',
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
                                                itemCount: syncProviderSupabase.instruccionesFallidas.length,
                                                itemBuilder: (context, index) {
                                                  final error = syncProviderSupabase.instruccionesFallidas[index];
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
                                      syncProviderSupabase.instruccionesFallidas.clear();
                                      prefs.setBool("boolSyncData", false);
                                      syncProviderSupabase.procesoTerminado(false);
                                      if (syncProviderSupabase.updatePassword) {
                                        prefs.setBool(
                                            "boolLogin", false);
                                          await userState.logout();
                                      } else {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreenSelector(),
                                          ),
                                        );
                                      }
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
