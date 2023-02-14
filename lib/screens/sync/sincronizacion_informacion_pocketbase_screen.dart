import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/instruccion_no_sincronizada.dart';
import 'package:taller_alex_app_asesor/providers/sync_provider_emi_web.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/theme/theme.dart';

import 'package:taller_alex_app_asesor/providers/sync_provider_pocketbase.dart';

import 'package:taller_alex_app_asesor/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

class SincronizacionInformacionPocketbaseScreen extends StatefulWidget {
  final List<InstruccionNoSincronizada> instruccionesFallidasEmiWeb;
  final bool exitosoEmiWeb;

  const SincronizacionInformacionPocketbaseScreen({
    Key? key, 
    required this.instruccionesFallidasEmiWeb, 
    required this.exitosoEmiWeb
    }) : super(key: key);

  @override
  State<SincronizacionInformacionPocketbaseScreen> createState() => _SincronizacionInformacionPocketbaseScreenState();
}

class _SincronizacionInformacionPocketbaseScreenState extends State<SincronizacionInformacionPocketbaseScreen> {
  @override
  void initState() {
    super.initState();
      setState(() {
        context.read<SyncProviderPocketbase>().exitoso = widget.exitosoEmiWeb;
        context.read<SyncProviderPocketbase>().procesoCargando(true);
        context.read<SyncProviderPocketbase>().procesoTerminado(false);
        context.read<SyncProviderPocketbase>().procesoExitoso(false);
        Future<bool> booleano = context.read<SyncProviderPocketbase>().executeInstrucciones(dataBase.bitacoraBox
            .getAll()
            .toList()
            .where((element) => element.usuario == prefs.getString("userId")!)
            .toList(), 
            widget.instruccionesFallidasEmiWeb
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
    final syncProviderPocketbase = Provider.of<SyncProviderPocketbase>(context);
    final syncProviderEmiWeb = Provider.of<SyncProviderEmiWeb>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFFDDEEF8),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).secondaryBackground,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/bglogin2.png',
                    ).image,
                  ),
                ),
              ),
              SingleChildScrollView(
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
                                visible: syncProviderPocketbase.procesocargando || syncProviderPocketbase.procesoexitoso,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 40, 0, 0),
                                  child: Text(
                                    '¡Sincronizando información!',
                                    textAlign: TextAlign.center,
                                    style: AppTheme.of(context).bodyText1.override(
                                          fontFamily:
                                              AppTheme.of(context).bodyText1Family,
                                          color: AppTheme.of(context).primaryText,
                                          fontSize: 25,
                                        ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: syncProviderPocketbase.procesocargando || syncProviderPocketbase.procesoexitoso,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Text(
                                    'Los datos de los emprendimientos\nse están sincronizando a la\nbase de Datos, no apague la\nconexión Wi-Fi o datos móviles hasta\nque se complete el proceso.',
                                    textAlign: TextAlign.center,
                                    maxLines: 5,
                                    style: AppTheme.of(context).bodyText1.override(
                                          fontFamily:
                                              AppTheme.of(context).bodyText1Family,
                                          color: AppTheme.of(context).secondaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ),
                              syncProviderPocketbase.procesocargando
                                  ? Visibility(
                                    visible: syncProviderPocketbase.procesocargando,
                                    child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 70, 0, 0),
                                        child: getProgressIndicatorAnimated(
                                            "Sincronizando..."),
                                      ),
                                  )
                                  : 
                                  syncProviderPocketbase.procesoexitoso
                                  ? Visibility(
                                      visible: !syncProviderPocketbase.procesocargando,
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
                                      visible: !syncProviderPocketbase.procesocargando,
                                      child: const Padding(
                                        padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 30, 0, 0),
                                        child: Icon(
                                            Icons.warning_amber_outlined,
                                            color: Color.fromARGB(255, 255, 176, 7),
                                            size: 150,
                                            ),
                                      ),
                                    ),
                              Visibility(
                                visible: syncProviderPocketbase.procesoterminado && syncProviderPocketbase.procesoexitoso,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 100, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const EmprendimientosScreen(),
                                        ),
                                      );
                                      syncProviderPocketbase.procesoTerminado(false);
                                    },
                                    text: 'Listo',
                                    options: FFButtonOptions(
                                      width: 130,
                                      height: 45,
                                      color: AppTheme.of(context).secondaryText,
                                      textStyle:
                                          AppTheme.of(context).subtitle2.override(
                                                fontFamily: AppTheme.of(context)
                                                    .subtitle2Family,
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
                              ),
                              Visibility(
                                visible: syncProviderPocketbase.procesoterminado && (syncProviderPocketbase.procesoexitoso == false),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        'Sincronización incompleta.\nPara más información\nvea los detalles registrados.',
                                        textAlign: TextAlign.center,
                                        maxLines: 4,
                                        style: AppTheme.of(context).bodyText1.override(
                                              fontFamily:
                                                  AppTheme.of(context).bodyText1Family,
                                              color: AppTheme.of(context).secondaryText,
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
                                                      color: AppTheme.of(context)
                                                          .secondaryText,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Detalles Registrados',
                                                    style: AppTheme.of(context)
                                                        .title1
                                                        .override(
                                                          fontFamily: AppTheme.of(context)
                                                              .title1Family,
                                                          color: AppTheme.of(context)
                                                              .primaryText,
                                                          fontSize: 20,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              collapsed: const Divider(
                                                thickness: 1.5,
                                                color: Color(0xFF8B8B8B),
                                              ),
                                              expanded: Builder(
                                                builder: (context) {
                                                  return ListView.builder(
                                                    controller: ScrollController(),
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.vertical,
                                                    itemCount: syncProviderPocketbase.instruccionesFallidas.length,
                                                    itemBuilder: (context, index) {
                                                      final error = syncProviderPocketbase.instruccionesFallidas[index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(15, 10, 15, 0),
                                                        child: Container(
                                                          width: double.infinity,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                            color:
                                                                const Color(0xFF1F68CB),
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
                                                                        16, 5, 16, 5),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                          0, 5, 0, 0),
                                                                  child: Text(
                                                                    maybeHandleOverflow(
                                                                      'Emprendimiento: ${error.emprendimiento ?? "No aplica"}', 
                                                                      60, 
                                                                      "..."),
                                                                    maxLines: 1,
                                                                    style: AppTheme.of(
                                                                            context)
                                                                        .title3
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: 13,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        16, 0, 16, 5),
                                                                child: Text(
                                                                  'Instruccion: ${error.instruccion}',
                                                                  maxLines: 2,
                                                                  style: AppTheme.of(
                                                                          context)
                                                                      .bodyText2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
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
                                                                  'Fecha: ${dateTimeFormat('dd-MM-y hh:mm:ss', error.fecha)}',
                                                                  maxLines: 1,
                                                                  style: AppTheme.of(
                                                                          context)
                                                                      .bodyText2
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: 13,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
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
                                                    AppTheme.of(context).secondaryText,
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
                                          syncProviderEmiWeb.instruccionesFallidas.clear();
                                          syncProviderPocketbase.instruccionesFallidas.clear();
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const EmprendimientosScreen(),
                                            ),
                                          );
                                        },
                                        text: 'Cerrar',
                                        options: FFButtonOptions(
                                          width: 130,
                                          height: 45,
                                          color: AppTheme.of(context).secondaryText,
                                          textStyle:
                                              AppTheme.of(context).subtitle2.override(
                                                    fontFamily: AppTheme.of(context)
                                                        .subtitle2Family,
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
