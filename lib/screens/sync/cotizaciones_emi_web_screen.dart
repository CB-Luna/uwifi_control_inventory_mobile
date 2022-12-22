import 'package:bizpro_app/providers/sync_provider_emi_web.dart';
import 'package:bizpro_app/screens/sync/cotizaciones_pocketbase_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/screens/inversiones/inversiones_screen.dart';

import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class CotizacionesEmiWebScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;
  final Inversiones inversion;
  final InversionesXProdCotizados productCot;
  const CotizacionesEmiWebScreen({
    Key? key, 
    required this.emprendimiento, 
    required this.inversion, required this.productCot, 
    }) : super(key: key);

  @override
  State<CotizacionesEmiWebScreen> createState() => _CotizacionesEmiWebScreenState();
}

class _CotizacionesEmiWebScreenState extends State<CotizacionesEmiWebScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      context.read<SyncProviderEmiWeb>().exitoso = true;
      context.read<SyncProviderEmiWeb>().procesoCargando(true);
      context.read<SyncProviderEmiWeb>().procesoTerminado(false);
      context.read<SyncProviderEmiWeb>().procesoExitoso(false);
      Future<bool> booleano = context.read<SyncProviderEmiWeb>().executeProductosCotizadosEmiWeb(widget.inversion);
        Future(() async {
          if (await booleano) {
            print("Se ha realizado con éxito el proceso de Cotización Emi Web");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CotizacionesPocketbaseScreen(
                      emprendimiento: widget.emprendimiento, 
                      inversion: widget.inversion,
                      
                    ),
              ),
            );
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                                '¡Obteniendo Cotización\nen Emi Web!',
                                textAlign: TextAlign.center,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 28,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Text(
                                'Conectando a información\nde cotizaciones, por favor, no apague\nla conexión Wi-Fi o datos móviles hasta \nque se complete el proceso.',
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
                            syncProviderEmiWeb.procesocargando
                                ? Visibility(
                                  visible: syncProviderEmiWeb.procesocargando,
                                  child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: getProgressIndicatorAnimated(
                                          "Conectando..."),
                                    ),
                                )
                                : 
                                syncProviderEmiWeb.procesoexitoso
                                ? Visibility(
                                  visible: !syncProviderEmiWeb.procesocargando,
                                  child: const Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: SizedBox(),
                                    ),
                                  )
                                  :
                                  Visibility(
                                    visible: !syncProviderEmiWeb.procesocargando,
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
                              visible: syncProviderEmiWeb.procesoterminado && (syncProviderEmiWeb.procesoexitoso == false),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 50, 0, 0),
                                    child: Text(
                                      'La conexión con EMI Web no se hizo con éxito.\nVuelva a probar más tarde.',
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
