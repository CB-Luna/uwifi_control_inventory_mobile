import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/providers/sync_provider_emi_web.dart';
import 'package:taller_alex_app_asesor/providers/user_provider.dart';
import 'package:taller_alex_app_asesor/screens/sync/sincronizacion_informacion_pocketbase_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/theme/theme.dart';

class SincronizacionInformacionEmiWebScreen extends StatefulWidget {
  const SincronizacionInformacionEmiWebScreen({Key? key}) : super(key: key);

  @override
  State<SincronizacionInformacionEmiWebScreen> createState() => _SincronizacionInformacionEmiWebScreenState();
}

class _SincronizacionInformacionEmiWebScreenState extends State<SincronizacionInformacionEmiWebScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      setState(() {
        context.read<SyncProviderEmiWeb>().exitoso = true;
        context.read<SyncProviderEmiWeb>().procesoCargando(true);
        context.read<SyncProviderEmiWeb>().procesoTerminado(false);
        context.read<SyncProviderEmiWeb>().procesoExitoso(false);
         Future<bool> booleano = context.read<SyncProviderEmiWeb>().executeInstrucciones(
          dataBase.bitacoraBox
            .getAll()
            .toList()
            .where((element) => element.usuario == prefs.getString("userId")!)
            .toList()
         );
        Future(() async {
          if (await booleano) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SincronizacionInformacionPocketbaseScreen(
                      instruccionesFallidasEmiWeb: context.read<SyncProviderEmiWeb>().instruccionesFallidas, 
                      exitosoEmiWeb: true,
                      ),
              ),
            );
          } else {
            if (context.read<SyncProviderEmiWeb>().usuarioExit) {
              // Salimos de sesión
              await context.read<UserState>().logout();
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SincronizacionInformacionPocketbaseScreen(
                        instruccionesFallidasEmiWeb: context.read<SyncProviderEmiWeb>().instruccionesFallidas, 
                        exitosoEmiWeb: false,
                        ),
                ),
              );
            }
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
                                '¡Sincronizando a Emi Web!',
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
                                'Los datos de los emprendimientos\nse están sincronizando a Emi Web,\npor favor no apague la conexión\nWi-Fi o datos móviles hasta \nque se complete el proceso.',
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
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Text(
                                'En caso de tardar demasiado\npresione la pantalla.',
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
                                      child: getSyncIndicatorAnimated(
                                          "Sincronizando..."),
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
                                        child: SizedBox(),
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
