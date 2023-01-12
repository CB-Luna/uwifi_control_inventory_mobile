import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/providers/sync_emprendimientos_externos_emi_web_provider.dart';
import 'package:bizpro_app/screens/sync/descarga_proyectos_externos_pocketbase_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';

class DescargaProyectosExternosEmiWebScreen extends StatefulWidget {
  final Usuarios usuario;
  final String idEmprendimiento;
  const DescargaProyectosExternosEmiWebScreen({
    Key? key, 
    required this.usuario, 
    required this.idEmprendimiento,
    }) : super(key: key);

  @override
  State<DescargaProyectosExternosEmiWebScreen> createState() => _DescargaProyectosExternosEmiWebScreenState();
}

class _DescargaProyectosExternosEmiWebScreenState extends State<DescargaProyectosExternosEmiWebScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      setState(() {
        context.read<SyncEmpExternosEmiWebProvider>().exitoso = true;
        context.read<SyncEmpExternosEmiWebProvider>().idEmprendimientoPocketbase = "";
        context.read<SyncEmpExternosEmiWebProvider>().usuarioExit = false;
        context.read<SyncEmpExternosEmiWebProvider>().procesoCargando(true);
        context.read<SyncEmpExternosEmiWebProvider>().procesoTerminado(false);
        context.read<SyncEmpExternosEmiWebProvider>().procesoExitoso(false);
        Future<bool> booleano = context.read<SyncEmpExternosEmiWebProvider>().getProyectosExternosEmiWeb(widget.idEmprendimiento, widget.usuario);
        Future(() async {
          if (await booleano) {
            print("Se ha realizado con éxito el proceso de Descarga del Proyecto de Emi Web");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DescargaProyectosExternosPocketbaseScreen(
                      idEmprendimiento: context.read<SyncEmpExternosEmiWebProvider>().idEmprendimientoPocketbase,
                      usuario: widget.usuario,
                      tokenGlobal: context.read<SyncEmpExternosEmiWebProvider>().tokenGlobal,
                      idEmprendimientoEmiWeb: widget.idEmprendimiento,
                    ),
              ),
            );
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    final syncEmpExternosEmiWebProvider = Provider.of<SyncEmpExternosEmiWebProvider>(context);
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
                                '¡Conectando a\nproyectos de EMI Web!',
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
                            syncEmpExternosEmiWebProvider.procesocargando
                                ? Visibility(
                                  visible: syncEmpExternosEmiWebProvider.procesocargando,
                                  child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: getProgressIndicatorAnimated(
                                          "Conectando..."),
                                    ),
                                )
                                : 
                                syncEmpExternosEmiWebProvider.procesoexitoso
                                ? Visibility(
                                  visible: !syncEmpExternosEmiWebProvider.procesocargando,
                                  child: const Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 70, 0, 0),
                                      child: SizedBox(),
                                    ),
                                  )
                                  :
                                  Visibility(
                                    visible: !syncEmpExternosEmiWebProvider.procesocargando,
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
                              visible: syncEmpExternosEmiWebProvider.procesoterminado && (syncEmpExternosEmiWebProvider.procesoexitoso == false),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 50, 0, 0),
                                    child: Text(
                                      '\nLa conexión con EMI Web no se hizo con éxito.\nVuelva a probar más tarde.',
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
                                        if (syncEmpExternosEmiWebProvider.usuarioExit) {
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
