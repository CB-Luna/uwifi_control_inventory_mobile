import 'dart:io';

import 'package:uwifi_control_inventory_mobile/database/entitys.dart' as DBO;
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:uwifi_control_inventory_mobile/main.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/main_screen_selector.dart';
import 'package:uwifi_control_inventory_mobile/screens/select_vehicle_tsm/select_vehicle_tsm_screen.dart';
import 'package:uwifi_control_inventory_mobile/screens/user_profile/perfil_usuario_screen.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/bottom_sheet_cerrar_sesion.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/bottom_sheet_sincronizar_widget.dart';
import 'package:uwifi_control_inventory_mobile/util/flutter_flow_util.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/side_menu/custom_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);

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

    final DBO.Users currentUser = usuarioProvider.usuarioCurrent!;

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
                              'assets/images/uwifi.png',
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
                            currentUser.image.target == null
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
                                            "${currentUser.firstName.substring(0, 1)} ${currentUser.lastName.substring(0, 1)}",
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
                                                .image.target!.path))),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: SizedBox(
                                width: 130,
                                child: Text(
                                  maybeHandleOverflow("${usuarioProvider.usuarioCurrent!.firstName} ${usuarioProvider.usuarioCurrent!.lastName}", 22, "..."),
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
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (currentUser.role.target?.role == "Inventory Warehouse" ||
                        currentUser.role.target?.role == "Manager" ||
                        currentUser.role.target?.role == "Tech Supervisor")
                    CustomMenuItem( 
                      label: 'Main',
                      iconData: Icons.home,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreenSelector(),
                          ),
                        );
                      },
                    ),

                    if (currentUser.role.target?.role == "Tech Supervisor")
                    CustomMenuItem( 
                      label: 'Vehicles',
                      iconData: Icons.local_shipping,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectVehicleTSMScreen(),
                          ),
                        );
                      },
                    ),
                    
                    if (currentUser.role.target?.role == "Inventory Warehouse" ||
                        currentUser.role.target?.role == "Manager" ||
                        currentUser.role.target?.role == "Tech Supervisor")
                    CustomMenuItem(
                      label: 'Sync. Data',
                      iconData: Icons.sync_rounded,
                      lineHeight: 1.2,
                      onTap: () async {
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
