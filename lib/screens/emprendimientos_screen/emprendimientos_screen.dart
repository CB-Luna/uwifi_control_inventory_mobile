import 'package:bizpro_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';

import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:bizpro_app/screens/widgets/side_menu/side_menu.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bizpro_app/screens/emprendimientos_screen/detalle_proyecto_screen.dart';
import 'package:bizpro_app/screens/emprendimientos_screen/agregar_emprendimiento_widget.dart';

class EmprendimientosScreen extends StatefulWidget {
  const EmprendimientosScreen({Key? key}) : super(key: key);

  @override
  State<EmprendimientosScreen> createState() => _EmprendimientosScreenState();
}

class _EmprendimientosScreenState extends State<EmprendimientosScreen> {
  TextEditingController textController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final emprendimientoProvider =
        Provider.of<EmprendimientoController>(context);
    final UserState userState = Provider.of<UserState>(context);
    return Scaffold(
      key: scaffoldKey,
      drawer: const SideMenu(),
      backgroundColor: Colors.white,
      floatingActionButton: userState.rol == Rol.administrador
          ? FloatingActionButton(
              onPressed: () async {
                //TODO: agregar pantalla
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AgregarEmprendimientoScreen(),
                  ),
                );
              },
              backgroundColor: const Color(0xFF006AFF),
              elevation: 8,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              ),
            )
          : null,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 145, 0, 6),
                    child: Builder(
                      builder: (context) {
                        //TODO: agregar query con el ID correcto
                        final resultado = usuarioProvider.usuarioCurrent!.emprendimientos.toList();
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: resultado.length,
                          itemBuilder: (context, resultadoIndex) {
                            final resultadoItem = resultado[resultadoIndex];
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15, 10, 15, 0),
                              child: Container(
                                width: double.infinity,
                                height: 270,
                                decoration: BoxDecoration(
                                  color: const Color(0x83FFFFFF),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x32000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        //TODO: agregar pantalla
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetalleProyectoScreen(
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: resultadoItem.imagen,
                                          width: double.infinity,
                                          height: 190,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16, 12, 16, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              resultadoItem.nombre,
                                              maxLines: 1,
                                              style: AppTheme.of(context)
                                                  .title3
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 16, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              resultadoItem.comunidades.target?.nombre.toString() ?? 'NONE',
                                              maxLines: 1,
                                              style: AppTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      decoration: const BoxDecoration(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    decoration: const BoxDecoration(
                      color: Color(0x00EEEEEE),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 35, 0, 0),
                                child: InkWell(
                                  onTap: () async {
                                    scaffoldKey.currentState?.openDrawer();
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0x57FFFFFF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.menu_rounded,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 35, 60, 0),
                                child: Text(
                                  'Emprendimientos',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                          ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15, 10, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0x49FFFFFF),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0x39000000),
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4, 4, 0, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(4, 0, 4, 0),
                                          child: TextFormField(
                                            controller: textController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Ingresa búsqueda...',
                                              labelStyle: AppTheme.of(context)
                                                  .bodyText2
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.search_sharp,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 10, 0),
                                        child: CustomButton(
                                          onPressed: () async {
                                            //TODO: agregar funcionalidad
                                            // setState(() =>
                                            //     algoliaSearchResults = null);
                                            // await ProyectosRecord.search(
                                            //   term: textController.text,
                                            //   maxResults: 15,
                                            // )
                                            //     .then((r) =>
                                            //         algoliaSearchResults = r)
                                            //     .onError((_, __) =>
                                            //         algoliaSearchResults = [])
                                            //     .whenComplete(
                                            //         () => setState(() {}));
                                          },
                                          text: 'Buscar',
                                          options: ButtonOptions(
                                            width: 68,
                                            height: 40,
                                            color: const Color(0xFF006AFF),
                                            textStyle: AppTheme.of(context)
                                                .subtitle2
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 10, 5, 0),
                              child: CustomButton(
                                onPressed: () async {
                                  //TODO: agregar
                                  // await showModalBottomSheet(
                                  //   isScrollControlled: true,
                                  //   backgroundColor: const Color(0xFF3B9FE5),
                                  //   context: context,
                                  //   builder: (context) {
                                  //     return Padding(
                                  //       padding:
                                  //           MediaQuery.of(context).viewInsets,
                                  //       child: Container(
                                  //         height: MediaQuery.of(context)
                                  //                 .size
                                  //                 .height *
                                  //             1,
                                  //         child: GridEmpredimientosWidget(),
                                  //       ),
                                  //     );
                                  //   },
                                  // );
                                },
                                text: '',
                                icon: const Icon(
                                  Icons.grid_view,
                                  size: 30,
                                ),
                                options: ButtonOptions(
                                  width: 55,
                                  height: 50,
                                  color: const Color(0x3BFFFFFF),
                                  textStyle:
                                      AppTheme.of(context).subtitle2.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
