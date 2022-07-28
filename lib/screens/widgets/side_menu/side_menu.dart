import 'package:bizpro_app/screens/sync/sync_screen.dart';
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
    final UserState userState = Provider.of<UserState>(context);
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
                  color: const Color(0xFFEEEEEE),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/mesgbluegradient.jpeg',
                    ).image,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0x3E000000),
                  borderRadius: BorderRadius.circular(0),
                ),
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
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                      child: InkWell(
                        onTap: () async {
                          //TODO: agregar pantalla
                          // await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => PerfilUsuarioWidget(),
                          //   ),
                          // );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            //TODO: agregar imagen
                            // Padding(
                            //   padding: const EdgeInsetsDirectional.fromSTEB(
                            //       10, 0, 5, 0),
                            //   child: AuthUserStreamWidget(
                            //     child: Container(
                            //       width: 40,
                            //       height: 40,
                            //       clipBehavior: Clip.antiAlias,
                            //       decoration: const BoxDecoration(
                            //         shape: BoxShape.circle,
                            //       ),
                            //       child: Image.network(
                            //         currentUserPhoto,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            //TODO: agregar nombre
                            // Padding(
                            //   padding: const EdgeInsetsDirectional.fromSTEB(
                            //       0, 5, 0, 0),
                            //   child: AuthUserStreamWidget(
                            //     child: Text(
                            //       currentUserDisplayName,
                            //       maxLines: 2,
                            //       style: AppTheme.of(context)
                            //           .bodyText1
                            //           .override(
                            //             fontFamily: 'Poppins',
                            //             color: Colors.white,
                            //             fontSize: 20,
                            //           ),
                            //     ),
                            //   ),
                            // ),
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
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EmprendedoresScreen(),
                          ),
                        );
                      },
                    ),

                    // if (userState.rol == Rol.administrador)
                    CustomMenuItem(
                      label: 'Promotores',
                      iconData: Icons.work,
                      onTap: () async {
                        //TODO: agregar pantalla
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         ListaPromotoresWidget(),
                        //   ),
                        // );
                      },
                    ),

                    CustomMenuItem(
                      label: 'Jornadas',
                      iconData: Icons.folder_rounded,
                      onTap: () async {
                        //TODO: agregar pantalla
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         ListaPromotoresWidget(),
                        //   ),
                        // );
                      },
                    ),

                    CustomMenuItem(
                      label: 'Consultorías',
                      iconData: Icons.work,
                      onTap: () async {
                        //TODO: agregar pantalla
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         ListaPromotoresWidget(),
                        //   ),
                        // );
                      },
                    ),

                    if (userState.rol == Rol.administrador)
                      CustomMenuItem(
                        label: 'Inversión',
                        iconData: Icons.show_chart_rounded,
                        onTap: () async {
                          //TODO: agregar pantalla
                          // await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         ListaPromotoresWidget(),
                          //   ),
                          // );
                        },
                      ),

                    if (userState.rol == Rol.administrador)
                      CustomMenuItem(
                        label: 'Ventas',
                        iconData: Icons.attach_money,
                        onTap: () async {
                          //TODO: agregar pantalla
                          // await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         ListaPromotoresWidget(),
                          //   ),
                          // );
                        },
                      ),

                    if (userState.rol == Rol.administrador)
                      CustomMenuItem(
                        label: 'Proveedores\ny productos',
                        iconData: Icons.inventory,
                        lineHeight: 1.2,
                        onTap: () async {
                          //TODO: agregar pantalla
                          // await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         ListaPromotoresWidget(),
                          //   ),
                          // );
                        },
                      ),

                    CustomMenuItem(
                        label: 'Syncronización',
                        iconData: Icons.sync_outlined,
                        lineHeight: 1.2,
                        onTap: () async {
                          // TODO: agregar pantalla
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SyncScreen(),
                            ),
                          );
                        },
                      ),

                    CustomMenuItem(
                      label: 'Cerrar Sesión',
                      iconData: Icons.logout,
                      onTap: () async {
                        await userState.logout();
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
