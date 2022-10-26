import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/providers/sync_provider_pocketbase.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/screens/inversiones/inversiones_screen.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class CotizacionesPocketbaseScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;
  final Inversiones inversion;
  final InversionesXProdCotizados inversionesXProdCotizados;

  const CotizacionesPocketbaseScreen({
    Key? key, 
    required this.emprendimiento, 
    required this.inversion, 
    required this.inversionesXProdCotizados
    }) : super(key: key);

  @override
  State<CotizacionesPocketbaseScreen> createState() => _CotizacionesPocketbaseScreenState();
}

class _CotizacionesPocketbaseScreenState extends State<CotizacionesPocketbaseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      setState(() {
        context.read<SyncProviderPocketbase>().exitoso = true;
        context.read<SyncProviderPocketbase>().procesoCargando(true);
        context.read<SyncProviderPocketbase>().procesoTerminado(false);
        context.read<SyncProviderPocketbase>().procesoExitoso(false);
        context.read<SyncProviderPocketbase>().executeProductosCotizadosPocketbase(
          widget.emprendimiento, 
          widget.inversion, 
          widget.inversionesXProdCotizados
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    final syncProviderPocketbase = Provider.of<SyncProviderPocketbase>(context);
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
                                '¡Descargando\nproductos cotizados!',
                                textAlign: TextAlign.center,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 30,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Text(
                                'Descargando productos\ncotizados, por favor, no apague\nla conexión Wi-Fi o datos móviles hasta \nque se complete el proceso.\nEl proceso puede tardar algunos minutos.',
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
                            syncProviderPocketbase.procesocargando
                                ? Visibility(
                                  visible: syncProviderPocketbase.procesocargando,
                                  child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: getDownloadIndicatorAnimated(
                                          "Descargando..."),
                                    ),
                                )
                                : 
                                syncProviderPocketbase.procesoexitoso
                                ? Visibility(
                                  visible: !syncProviderPocketbase.procesocargando,
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
                                    visible: !syncProviderPocketbase.procesocargando,
                                    child: const Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: Icon(
                                          Icons.cancel_outlined,
                                          color: Color.fromARGB(228, 255, 82, 70),
                                          size: 250,
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
                                            InversionesScreen(idEmprendimiento: widget.emprendimiento.id,),
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
                                        0, 50, 0, 0),
                                    child: Text(
                                      'Error al descargar productos.\nLa descarga no se hizo con éxito.\nVuelva a probar más tarde.',
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
                                                InversionesScreen(idEmprendimiento: widget.emprendimiento.id,),
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
