import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/providers/catalogo_emi_web_provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/sync/descarga_catalogos_pocketbase_screen.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';

class DescargaCatalogosEmiWebScreen extends StatefulWidget {
  const DescargaCatalogosEmiWebScreen({Key? key}) : super(key: key);

  @override
  State<DescargaCatalogosEmiWebScreen> createState() => _DescargaCatalogosEmiWebScreenState();
}

class _DescargaCatalogosEmiWebScreenState extends State<DescargaCatalogosEmiWebScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      setState(() {
        context.read<CatalogoEmiWebProvider>().exitoso = true;
        context.read<CatalogoEmiWebProvider>().usuarioExit = false;
        context.read<CatalogoEmiWebProvider>().procesoCargando(true);
        context.read<CatalogoEmiWebProvider>().procesoTerminado(false);
        context.read<CatalogoEmiWebProvider>().procesoExitoso(false);
        Future<bool> booleano = context.read<CatalogoEmiWebProvider>().getCatalogosEmiWeb();
        Future(() async {
          if (await booleano) {
            print("Se ha realizado con éxito el proceso de Descarga Emi Web");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DescargaCatalogosPocketbaseScreen(
                      usuarioExit: context.read<CatalogoEmiWebProvider>().usuarioExit,
                    ),
              ),
            );
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalogoEmiWebProvider = Provider.of<CatalogoEmiWebProvider>(context);
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
                                '¡Conectando a\ncatálogos de EMI Web!',
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
                                'Se está realizando la conexión\na EMI Web, por favor, no apague\nla conexión Wi-Fi o datos móviles hasta \nque se complete el proceso.\nEl proceso puede tardar algunos minutos.',
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
                            catalogoEmiWebProvider.procesocargando
                                ? Visibility(
                                  visible: catalogoEmiWebProvider.procesocargando,
                                  child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: getProgressIndicatorAnimated(
                                          "Conectando..."),
                                    ),
                                )
                                : 
                                catalogoEmiWebProvider.procesoexitoso
                                ? Visibility(
                                  visible: !catalogoEmiWebProvider.procesocargando,
                                  child: const Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: SizedBox(),
                                    ),
                                  )
                                  :
                                  Visibility(
                                    visible: !catalogoEmiWebProvider.procesocargando,
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
                              visible: catalogoEmiWebProvider.procesoterminado && (catalogoEmiWebProvider.procesoexitoso == false),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 50, 0, 0),
                                    child: Text(
                                      'Error al conectar.\nLa conexión con EMI Web no se hizo con éxito.\nVuelva a probar más tarde.',
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
                                        if (catalogoEmiWebProvider.usuarioExit) {
                                          snackbarKey.currentState?.showSnackBar(const SnackBar(
                                            content: Text("El Usuario no cuenta con los permisos necesarios para estar en sesión, favor de comunicarse con el Administrador."),
                                          ));
                                          await userState.logout();
                                        } else {
                                            await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const EmprendimientosScreen(),
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
