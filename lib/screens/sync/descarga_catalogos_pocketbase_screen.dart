import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/catalogo_pocketbase_provider.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/theme/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/ordenes_trabajo_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

class DescargaCatalogosPocketbaseScreen extends StatefulWidget {
  final bool usuarioExit;
  const DescargaCatalogosPocketbaseScreen({
    Key? key, 
    required this.usuarioExit
    }) : super(key: key);

  @override
  State<DescargaCatalogosPocketbaseScreen> createState() => _DescargaCatalogosPocketbaseScreenState();
}

class _DescargaCatalogosPocketbaseScreenState extends State<DescargaCatalogosPocketbaseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      setState(() {
        context.read<CatalogoPocketbaseProvider>().exitoso = true;
        context.read<CatalogoPocketbaseProvider>().procesoCargando(true);
        context.read<CatalogoPocketbaseProvider>().procesoTerminado(false);
        context.read<CatalogoPocketbaseProvider>().procesoExitoso(false);
        context.read<CatalogoPocketbaseProvider>().getCatalogos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalogoPocketbaseProvider = Provider.of<CatalogoPocketbaseProvider>(context);
    final UserState userState = Provider.of<UserState>(context);
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
                                '¡Descargando catálogos!',
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
                                'Descargando catálogos\nde la nube, por favor, no apague\nla conexión Wi-Fi o datos móviles hasta \nque se complete el proceso.\nEl proceso puede tardar algunos minutos.',
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
                            catalogoPocketbaseProvider.procesocargando
                                ? Visibility(
                                  visible: catalogoPocketbaseProvider.procesocargando,
                                  child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: getDownloadIndicatorAnimated(
                                          "Descargando..."),
                                    ),
                                )
                                : 
                                catalogoPocketbaseProvider.procesoexitoso
                                ? Visibility(
                                  visible: !catalogoPocketbaseProvider.procesocargando,
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
                                    visible: !catalogoPocketbaseProvider.procesocargando,
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
                              visible: catalogoPocketbaseProvider.procesoterminado && catalogoPocketbaseProvider.procesoexitoso,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 100, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (widget.usuarioExit) {
                                      snackbarKey.currentState?.showSnackBar(const SnackBar(
                                        content: Text("El Usuario no cuenta con los permisos necesarios para estar en sesión, favor de comunicarse con el Administrador."),
                                      ));
                                      await userState.logout();
                                    } else {
                                        await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OrdenesTrabajoScreen(),
                                        ),
                                      );
                                    }
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
                              visible: catalogoPocketbaseProvider.procesoterminado && (catalogoPocketbaseProvider.procesoexitoso == false),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 50, 0, 0),
                                    child: Text(
                                      'La sincronización no se hizo con éxito.\nVuelva a probar más tarde.',
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
                                        if (widget.usuarioExit) {
                                          snackbarKey.currentState?.showSnackBar(const SnackBar(
                                            content: Text("El Usuario no cuenta con los permisos necesarios para estar en sesión, favor de comunicarse con el Administrador."),
                                          ));
                                          await userState.logout();
                                        } else { 
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const OrdenesTrabajoScreen(),
                                              ),
                                            );
                                        }
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
