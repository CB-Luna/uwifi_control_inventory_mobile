import 'dart:io';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/archivados/archivados_screen.dart';
import 'package:bizpro_app/screens/perfil_usuario/perfil_usuario_screen.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_cerrar_sesion.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_recover_catalogos.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_sincronizar_widget.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/screens/emprendedores/emprendedores_screen.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:bizpro_app/screens/widgets/side_menu/custom_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String currentUserPhoto =
        'assets/images/default-user-profile-picture.jpg';
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final UserState userState = Provider.of<UserState>(context);

    if (usuarioProvider.usuarioCurrent == null) {
      return WillPopScope(
        onWillPop: () async => false,
        child: const Scaffold(
          body: Center(
            child: Text('Error al leer información'),
          ),
        ),
      );
    }

    final Usuarios currentUser = usuarioProvider.usuarioCurrent!;

    return SafeArea(
      child: SizedBox(
        width: 220,
        child: Drawer(
          elevation: 16,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/bglogin2.png',
                      ).image,
                    ),
                    borderRadius: BorderRadius.circular(0)),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/images/emlogo.png',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 0, 0),
                            child: Text(
                              'Encuentro con México',
                              maxLines: 2,
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily:
                                        AppTheme.of(context).bodyText1Family,
                                    color: AppTheme.of(context).primaryText,
                                    fontSize: 14,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(5, 25, 5, 0),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PerfilUsuarioScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            currentUser.image.target?.imagenes == ""
                                ? Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 5, 0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Container(
                                        color: Colors.blue,
                                        child: Center(
                                          child: Text(
                                            "${currentUser.nombre.substring(0, 1)} ${currentUser.apellidoP.substring(0, 1)}",
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      AppTheme.of(context)
                                                          .bodyText1Family,
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 5, 0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: const Color(0x00EEEEEE),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(File(currentUser
                                                .image.target!.imagenes))),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Text(
                                
                                maybeHandleOverflow("${usuarioProvider.usuarioCurrent!.nombre} ${usuarioProvider.usuarioCurrent!.apellidoP}", 16, "..."),
                                maxLines: 2,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 15,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    CustomMenuItem(
                      label: 'Emprendimientos',
                      iconData: Icons.home,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmprendimientosScreen(),
                          ),
                        );
                      },
                    ),

                    // if (userState.rol == Rol.administrador)
                    CustomMenuItem(
                      label: 'Emprendedores',
                      iconData: Icons.groups,
                      onTap: () async {
                        if (currentUser.rol.target!.rol == "Voluntario Estratégico") {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Este usuario no tiene permisos para esta acción."),
                          ));
                        } else {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EmprendedoresScreen(),
                            ),
                          );
                        }
                      },
                    ),

                    CustomMenuItem(
                      label: 'Archivados',
                      iconData: Icons.file_download_outlined,
                      onTap: () async {
                        if (currentUser.rol.target!.rol == "Voluntario Estratégico") {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Este usuario no tiene permisos para esta acción."),
                          ));
                        } else {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ArchivadosScreen(),
                            ),
                          );
                        }
                      },
                    ),
                    
                    CustomMenuItem(
                      label: 'Sinc. Información',
                      iconData: Icons.sync_rounded,
                      lineHeight: 1.2,
                      onTap: () async {
                        if (currentUser.rol.target!.rol == "Voluntario Estratégico" ||
                            currentUser.rol.target!.rol == "Amigo del Cambio" ||
                            currentUser.rol.target!.rol == "Emprendedor") {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Este usuario no tiene permisos para esta acción."),
                          ));
                        } else {
                          final connectivityResult =
                              await (Connectivity().checkConnectivity());
                          final bitacora = dataBase.bitacoraBox.getAll().toList();
                          print("Tamaño bitacora: ${bitacora.length}");
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                  child: connectivityResult ==
                                              ConnectivityResult.none ||
                                          bitacora.isEmpty
                                      ? const BottomSheetSincronizarWidget(
                                          isVisible: false,
                                        )
                                      : const BottomSheetSincronizarWidget(
                                          isVisible: true,
                                        ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),

                    CustomMenuItem(
                      label: 'Sinc. Catálogos',
                      iconData: Icons.fact_check_outlined,
                      lineHeight: 1.2,
                      onTap: () async {
                        if (currentUser.rol.target!.rol == "Voluntario Estratégico" ||
                            currentUser.rol.target!.rol == "Amigo del Cambio" ||
                            currentUser.rol.target!.rol == "Emprendedor") {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Este usuario no tiene permisos para esta acción."),
                          ));
                        } else {
                          final connectivityResult =
                              await (Connectivity().checkConnectivity());
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                  child: connectivityResult ==
                                              ConnectivityResult.none 
                                      ? const BottomSheetRecoverCatalogosWidget(
                                          isVisible: false,
                                        )
                                      : const BottomSheetRecoverCatalogosWidget(
                                          isVisible: true,
                                        ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),


                    CustomMenuItem(
                      label: 'Cerrar Sesión',
                      iconData: Icons.logout,
                      onTap: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                child: const BottomSheetCerrarSesion(),
                              ),
                            );
                          },
                        );
                      },
                      padding: const EdgeInsets.only(top: 60),
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
