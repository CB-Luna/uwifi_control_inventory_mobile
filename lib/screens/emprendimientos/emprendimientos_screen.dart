import 'package:bizpro_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/screens/emprendimientos/grid_emprendimientos_screen.dart';
import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:bizpro_app/screens/emprendimientos/detalle_emprendimiento_screen.dart';
import 'package:bizpro_app/screens/widgets/side_menu/side_menu.dart';
import 'package:bizpro_app/screens/emprendimientos/agregar_emprendimiento_screen.dart';

class EmprendimientosScreen extends StatefulWidget {
  const EmprendimientosScreen({Key? key}) : super(key: key);

  @override
  State<EmprendimientosScreen> createState() => _EmprendimientosScreenState();
}

class _EmprendimientosScreenState extends State<EmprendimientosScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        getInfo();
      });
    });
  }

  getInfo() {
    print("PREFERS: ${prefs.getString("userId")}");
    context
        .read<UsuarioController>()
        .getUser(prefs.getString("userId") ?? "NONE");
  }

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
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AgregarEmprendimientoScreen(),
                  ),
                );
              },
              backgroundColor: const Color(0xFF4672FF),
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
                    'assets/images/bglogin2.png',
                  ).image,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 40, 20, 0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  scaffoldKey.currentState?.openDrawer();
                                },
                                child: Container(
                                  width: 50,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4672FF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                              Expanded(
                                child: Text(
                                  'Emprendimientos',
                                  textAlign: TextAlign.center,
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            color: const Color(0xFF221573),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 0, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0x49FFFFFF),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x39000000),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 0, 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(4, 0, 4, 0),
                                            child: TextFormField(
                                              controller: searchController,
                                              onChanged: (value) =>
                                                  setState(() {}),
                                              decoration: InputDecoration(
                                                labelText: 'Buscar...',
                                                labelStyle: AppTheme.of(context)
                                                    .bodyText2
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
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
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 5, 0),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(30),
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(30),
                                              ),
                                            ),
                                            child: InkWell(
                                              onTap: () async {
                                                setState(() {});
                                              },
                                              child: const Icon(
                                                Icons.search_rounded,
                                                color: Colors.white,
                                                size: 24,
                                              ),
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
                                    10, 0, 0, 0),
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4672FF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const GridEmprendimientosScreen(),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.grid_view,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 0, 0),
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4672FF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      FaIcon(
                                        FontAwesomeIcons.fileArrowDown,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 145, 0, 6),
                    child: Builder(
                      builder: (context) {
                        //TODO: agregar query con el ID correcto
                        List<Emprendimientos> emprendimientos =
                            usuarioProvider.getEmprendimientos();

                        //Busqueda
                        if (searchController.text != '') {
                          emprendimientos.removeWhere((element) {
                            final nombreEmprendimiento =
                                removeDiacritics(element.nombre).toLowerCase();
                            final nombreEmprendedor = removeDiacritics(
                                    '${element.emprendedor.target?.nombre ?? ''} ${element.emprendedor.target?.apellidos ?? ''}')
                                .toLowerCase();
                            final tempBusqueda =
                                removeDiacritics(searchController.text)
                                    .toLowerCase();
                            if (nombreEmprendimiento.contains(tempBusqueda) ||
                                nombreEmprendedor.contains(tempBusqueda)) {
                              return false;
                            }
                            return true;
                          });
                        }

                        List<String> emprendedores = [];
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: emprendimientos.length,
                          itemBuilder: (context, resultadoIndex) {
                            final emprendimiento =
                                emprendimientos[resultadoIndex];
                            // resultadoItem.emprendedores.forEach((element) {
                            //   emprendedores.add(element.nombre);
                            // });
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15, 10, 15, 0),
                              child: Container(
                                width: double.infinity,
                                height: 275,
                                decoration: BoxDecoration(
                                  color: const Color(0xB14672FF),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetalleEmprendimientoScreen(
                                              emprendimiento: emprendimiento,
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
                                        child: getImage(emprendimiento.imagen),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16, 10, 16, 5),
                                      child: Text(
                                        emprendimiento.nombre,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 16, 5),
                                      child: Text(
                                        emprendimiento
                                                .comunidad.target?.nombre
                                                .toString() ??
                                            'NONE',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16, 0, 16, 5),
                                      child: Text(
                                        emprendimiento.emprendedor.target
                                                    ?.nombre ==
                                                null
                                            ? 'SIN EMPRENDEDOR'
                                            : "${emprendimiento.emprendedor.target!.nombre} ${emprendimiento.emprendedor.target!.apellidos}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
