import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/providers/sync_ordenes_trabajo_externas_supabase_provider.dart';
import 'package:taller_alex_app_asesor/theme/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/control_daily_vehicle_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

class DescargaOrdenesTrabajoExternasSupabaseScreen extends StatefulWidget {
  final Usuarios usuario;
  final String idEmprendimiento;
  final String tokenGlobal;
  final String idEmprendimientoEmiWeb;
  const DescargaOrdenesTrabajoExternasSupabaseScreen({
    Key? key, 
    required this.idEmprendimiento, 
    required this.usuario, 
    required this.tokenGlobal, 
    required this.idEmprendimientoEmiWeb,
    }) : super(key: key);

  @override
  State<DescargaOrdenesTrabajoExternasSupabaseScreen> createState() => _DescargaOrdenesTrabajoExternasSupabaseScreenState();
}

class _DescargaOrdenesTrabajoExternasSupabaseScreenState extends State<DescargaOrdenesTrabajoExternasSupabaseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      setState(() {
        context.read<SyncOrdenesTrabajoExternasSupabaseProvider>().exitoso = true;
        context.read<SyncOrdenesTrabajoExternasSupabaseProvider>().procesoCargando(true);
        context.read<SyncOrdenesTrabajoExternasSupabaseProvider>().procesoTerminado(false);
        context.read<SyncOrdenesTrabajoExternasSupabaseProvider>().procesoExitoso(false);
        context.read<SyncOrdenesTrabajoExternasSupabaseProvider>().getOrdenesTrabajoExternasSupabaseCliente(widget.usuario);
    });
  }

  @override
  Widget build(BuildContext context) {
    final empExternosPocketbaseProvider = Provider.of<SyncOrdenesTrabajoExternasSupabaseProvider>(context);
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
              Stack(
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
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 40, 0, 0),
                              child: Text(
                                '¡Descargando proyectos!',
                                textAlign: TextAlign.center,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 26,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Text(
                                'Descargando proyectos\nde la nube, por favor, no apague\nla conexión Wi-Fi o datos móviles hasta \nque se complete el proceso.\nEl proceso puede tardar algunos minutos.',
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
                            empExternosPocketbaseProvider.procesocargando
                                ? Visibility(
                                  visible: empExternosPocketbaseProvider.procesocargando,
                                  child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: getDownloadIndicatorAnimated(
                                          "Descargando..."),
                                    ),
                                )
                                : 
                                empExternosPocketbaseProvider.procesoexitoso
                                ? Visibility(
                                  visible: !empExternosPocketbaseProvider.procesocargando,
                                  child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
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
                                    visible: !empExternosPocketbaseProvider.procesocargando,
                                    child: const Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: Icon(
                                          Icons.warning_amber_outlined,
                                          color: Color.fromARGB(255, 255, 176, 7),
                                          size: 150,
                                          ),
                                    ),
                                  ),
                            Visibility(
                              visible: empExternosPocketbaseProvider.procesoterminado && empExternosPocketbaseProvider.procesoexitoso,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 100, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                        await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ControlDailyVehicleScreen(),
                                        ),
                                      );
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
                              visible: empExternosPocketbaseProvider.procesoterminado && (empExternosPocketbaseProvider.procesoexitoso == false),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 50, 0, 0),
                                    child: Text(
                                      'La descarga no se hizo con éxito.\nVuelva a probar más tarde.',
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
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ControlDailyVehicleScreen(),
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
            ],
          ),
        ),
      ),
    );
  }
}
