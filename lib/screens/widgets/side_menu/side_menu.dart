import 'dart:io';

import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/perfil_usuario/perfil_usuario_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/bottom_sheet_cerrar_sesion.dart';
import 'package:taller_alex_app_asesor/screens/widgets/bottom_sheet_recover_catalogos.dart';
import 'package:taller_alex_app_asesor/screens/widgets/bottom_sheet_sincronizar_widget.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/providers/providers.dart';
import 'package:taller_alex_app_asesor/screens/clientes/clientes_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/control_daily_vehicle_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/side_menu/custom_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    final Users currentUser = usuarioProvider.usuarioCurrent!;

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
                        'assets/images/bgFleet@2x.png',
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
                            width: 100,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                            ),
                            child: Image.asset(
                              'assets/images/rta_logo.png',
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
                          //print("Veamos que tiene Imagen: ${currentUser.imagen.target!.nombre}");
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
                            currentUser.image == null
                                ? Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 5, 0),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Container(
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        child: Center(
                                          child: Text(
                                            "${currentUser.name.substring(0, 1)} ${currentUser.lastName.substring(0, 1)}",
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(context)
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
                                      width: 60,
                                      height: 60,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: const Color(0x00EEEEEE),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(File(currentUser
                                                .path!))),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Text(
                                maybeHandleOverflow("${usuarioProvider.usuarioCurrent!.name} ${usuarioProvider.usuarioCurrent!.lastName}", 16, "..."),
                                maxLines: 2,
                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).bodyText1Family,
                                      color: FlutterFlowTheme.of(context).alternate,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    CustomMenuItem(
                      label: 'Main',
                      iconData: Icons.home,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ControlDailyVehicleScreen(),
                          ),
                        );
                      },
                    ),

                    if (currentUser.role.target!.role == "Cliente")
                    CustomMenuItem(
                      label: 'Vehicles',
                      iconData: Icons.directions_car,
                      onTap: () async {
                     
                      },
                    ),

                    if (currentUser.role.target!.role == "Asesor")
                    CustomMenuItem(
                      label: 'Employees',
                      iconData: Icons.groups,
                      onTap: () async {
                        if (currentUser.role.target!.role == "Voluntario Estratégico") {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Permission Denied. You're not authorized to perform this action."),
                          ));
                        } else {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ClientesScreen(),
                            ),
                          );
                        }
                      },
                    ),
                    
                    CustomMenuItem(
                      label: 'Sync. Data',
                      iconData: Icons.sync_rounded,
                      lineHeight: 1.2,
                      onTap: () async {
                        if (currentUser.role.target!.role == "Admin" ||
                            currentUser.role.target!.role == "Manager") {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Permission Denied. You're not authorized to perform this action."),
                          ));
                        } else {
                          final connectivityResult =
                              await (Connectivity().checkConnectivity());
                          final bitacora = dataBase.bitacoraBox.getAll().toList();
                          //print("Tamaño bitacora: ${bitacora.length}");
                          // ignore: use_build_context_synchronously
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

                    if (currentUser.role.target!.role == "Asesor")
                    CustomMenuItem(
                      label: 'Report Recover',
                      iconData: Icons.downloading_outlined,
                      lineHeight: 1.2,
                      onTap: () async {
                      },
                    ),

                    if (currentUser.role.target!.role == "Asesor")
                    CustomMenuItem(
                      label: 'Sync. Catalog',
                      iconData: Icons.fact_check_outlined,
                      lineHeight: 1.2,
                      onTap: () async {
                        if (currentUser.role.target!.role == "Amigo del Cambio" ||
                            currentUser.role.target!.role == "Emprendedor") {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Permission Denied. You're not authorized to perform this action."),
                          ));
                        } else {
                          final connectivityResult =
                              await (Connectivity().checkConnectivity());
                          // ignore: use_build_context_synchronously
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
                      label: 'Log Out',
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
