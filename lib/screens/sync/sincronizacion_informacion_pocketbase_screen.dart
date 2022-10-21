import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/screens/sync/sincronizacion_informacion_emi_web_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/providers/sync_provider_pocketbase.dart';

import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class SincronizacionInformacionPocketbaseScreen extends StatefulWidget {
  const SincronizacionInformacionPocketbaseScreen({Key? key}) : super(key: key);

  @override
  State<SincronizacionInformacionPocketbaseScreen> createState() => _SincronizacionInformacionPocketbaseScreenState();
}

class _SincronizacionInformacionPocketbaseScreenState extends State<SincronizacionInformacionPocketbaseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      setState(() {
        context.read<SyncProviderPocketbase>().exitoso = true;
        context.read<SyncProviderPocketbase>().procesoCargando(true);
        context.read<SyncProviderPocketbase>().procesoTerminado(false);
        context.read<SyncProviderPocketbase>().procesoExitoso(false);
         Future<bool> booleano = context.read<SyncProviderPocketbase>().executeInstrucciones(
          dataBase.bitacoraBox
            .getAll()
            .toList()
            .where((element) => element.usuario == prefs.getString("userId")!)
            .toList()
         );
        Future(() async {
          if (await booleano) {
            print("Se ha realizado con éxito el proceso de Sincronización con Pocketbase");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const SincronizacionInformacionEmiWebScreen(),
                    // const EmprendimientosScreen()
              ),
            );
          }
        });
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
                            Padding(
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
                                  child: const Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: SizedBox(),
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
                              visible: syncProviderPocketbase.procesoterminado && (syncProviderPocketbase.procesoexitoso == false),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 50, 0, 0),
                                    child: Text(
                                      'Error al sincronizar.\nLa conexión con la base de datos falló.\nVuelva a probar más tarde.',
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
                                                const EmprendimientosScreen(),
                                          ),
                                        );
                                        syncProviderPocketbase.procesoTerminado(false);
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
