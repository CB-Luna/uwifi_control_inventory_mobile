import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/emprendimiento_controller.dart';
import 'package:taller_alex_app_asesor/screens/clientes/agregar_cliente_screen.dart';
import 'package:taller_alex_app_asesor/screens/emprendimientos/components/tarjeta_descripcion_widget.dart';
import 'package:taller_alex_app_asesor/screens/emprendimientos/emprendimiento_archivado_screen.dart';
import 'package:taller_alex_app_asesor/screens/emprendimientos/emprendimiento_retomado_screen.dart';
import 'package:taller_alex_app_asesor/screens/emprendimientos/emprendimiento_reactivado_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/bottom_sheet_archivar_emprendimiento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/util/util.dart';

import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/screens/emprendimientos/grid_emprendimientos_screen.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/screens/widgets/bottom_sheet_descargar_catalogos.dart';
import 'package:taller_alex_app_asesor/screens/widgets/side_menu/side_menu.dart';
import 'package:taller_alex_app_asesor/screens/emprendimientos/agregar_emprendimiento_screen.dart';

class EmprendimientosScreen extends StatefulWidget {
  const EmprendimientosScreen({Key? key}) : super(key: key);

  @override
  State<EmprendimientosScreen> createState() => _EmprendimientosScreenState();
}

class _EmprendimientosScreenState extends State<EmprendimientosScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> listAreaCirculo = [];
  List<Emprendimientos> emprendimientos = [];
  List<Emprendimientos> emprendimientosPDF = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      getInfo();
      listAreaCirculo = [];
      emprendimientosPDF = [];
      emprendimientos = [];
      dataBase.areaCirculoBox.getAll().forEach((element) {
        listAreaCirculo.add(element.nombreArea);
      });
      listAreaCirculo
          .sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
      emprendimientosPDF =
          context.read<UsuarioController>().getEmprendimientos();
      emprendimientos = context.read<UsuarioController>().getEmprendimientos();
    });
  }

  getInfo() {
    //print("PREFERS: ${prefs.getString("userId")}");
    context
        .read<UsuarioController>()
        .getUser(prefs.getString("userId") ?? "NONE");
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final emprendimientoProvider =
        Provider.of<EmprendimientoController>(context);
    final Usuarios currentUser = usuarioProvider.usuarioCurrent!;
    emprendimientos = [];
    emprendimientos = usuarioProvider.getEmprendimientos();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const SideMenu(),
        backgroundColor: Colors.white,
        floatingActionButton: (currentUser.rol.target!.rol == "Asesor")
            ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                 FloatingActionButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AgregarClienteScreen(),
                        ),
                      );
                  },
                  backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                  elevation: 8,
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(
                  width: 15.0, //Esto es solo para dar cierto margen entre los FAB
                ),
                FloatingActionButton(
                  onPressed: () async {
                    //TODO: Colocar el último catálogo que se descargue
                    List<ProdProyecto> listProdProyecto =
                        dataBase.productosProyectoBox.getAll();
                    if (listProdProyecto.isNotEmpty) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AgregarEmprendimientoScreen(),
                        ),
                      );
                    } else {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: const BottomSheetDescargarCatalogos(),
                            ),
                          );
                        },
                      );
                    }
                  },
                  backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                  elevation: 8,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            )
            : 
            null,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).background,
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
                                20, 50, 20, 0),
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
                                      color: FlutterFlowTheme.of(context).primaryColor,
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
                                Expanded(
                                  child: Text(
                                    'Órdenes de Trabajo',
                                    textAlign: TextAlign.center,
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1.override(
                                              fontFamily: FlutterFlowTheme.of(context)
                                                  .bodyText1Family,
                                              color: FlutterFlowTheme.of(context).tertiaryColor,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.8,
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
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(4, 0, 4, 0),
                                              child: TextFormField(
                                                controller: searchController,
                                                onChanged: (value) =>
                                                    setState(() {}),
                                                decoration: InputDecoration(
                                                  labelText: 'Buscar...',
                                                  labelStyle: FlutterFlowTheme.of(context)
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
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  prefixIcon: const Icon(
                                                    Icons.search_sharp,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                                style: FlutterFlowTheme.of(context)
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
                                                color: FlutterFlowTheme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(8),
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
                                      color: FlutterFlowTheme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GridEmprendimientosScreen(
                                              emprendimientos: emprendimientos,
                                            ),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 145, 0, 6),
                      child: Builder(
                        builder: (context) {
                          //Busqueda
                          if (searchController.text != '') {
                            emprendimientos.removeWhere((element) {
                              final nombreEmprendimiento =
                                  removeDiacritics(element.nombre)
                                      .toLowerCase();
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
                          return SingleChildScrollView(
                            child: ListView.builder(
                              reverse: true,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: emprendimientos.length,
                              itemBuilder: (context, resultadoIndex) {
                                final emprendimiento =
                                    emprendimientos[resultadoIndex];
                                while (!emprendimiento.archivado) {
                                  return emprendimiento.faseActual == "Detenido"
                                      ? Slidable(
                                          startActionPane: ActionPane(
                                              motion: const DrawerMotion(),
                                              children: [
                                                SlidableAction(
                                                    label: "Reactivar",
                                                    icon: Icons
                                                        .play_circle_outlined,
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(context).primaryColor,
                                                    onPressed: (context) async {
                                                      if (currentUser.rol.target!.rol == "Voluntario Estratégico" ||
                                                          currentUser
                                                                  .rol
                                                                  .target!
                                                                  .rol ==
                                                              "Amigo del Cambio" ||
                                                          currentUser
                                                                  .rol
                                                                  .target!
                                                                  .rol ==
                                                              "Emprendedor") {
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Este usuario no tiene permisos para esta acción."),
                                                        ));
                                                      } else {
                                                        emprendimientoProvider
                                                            .reactivarOdesconsolidarEmprendimiento(
                                                                emprendimiento
                                                                    .id);
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const EmprendimientoReactivadoScreen(),
                                                          ),
                                                        );
                                                      }
                                                    }),
                                                SlidableAction(
                                                    label: "Archivar",
                                                    icon: Icons
                                                        .file_download_outlined,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            207, 255, 64, 128),
                                                    onPressed: (context) async {
                                                      if (currentUser.rol.target!.rol == "Voluntario Estratégico" ||
                                                          currentUser
                                                                  .rol
                                                                  .target!
                                                                  .rol ==
                                                              "Amigo del Cambio" ||
                                                          currentUser
                                                                  .rol
                                                                  .target!
                                                                  .rol ==
                                                              "Emprendedor") {
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Este usuario no tiene permisos para esta acción."),
                                                        ));
                                                      } else {
                                                        emprendimientoProvider
                                                            .archivarEmprendimiento(
                                                                emprendimiento
                                                                    .id);
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          context: context,
                                                          builder: (context) {
                                                            return Padding(
                                                              padding: MediaQuery
                                                                      .of(context)
                                                                  .viewInsets,
                                                              child: SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.45,
                                                                child:
                                                                    const BottomSheetArchivarWidget(
                                                                  isVisible:
                                                                      true,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }
                                                    }),
                                              ]),
                                          child: Stack(
                                            children: [
                                              TargetaDescripcionWidget(
                                                  emprendimiento:
                                                      emprendimiento),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        15, 10, 15, 10),
                                                child: Container(
                                                  width: 60,
                                                  height: 275,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            80, 255, 64, 128),
                                                        Color(0x0014181B),
                                                      ],
                                                      stops: [0, 1],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: const Icon(
                                                    Icons.double_arrow_rounded,
                                                    size: 65,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : emprendimiento.faseActual ==
                                              "Consolidado"
                                          ? Slidable(
                                              startActionPane: ActionPane(
                                                  motion: const DrawerMotion(),
                                                  children: [
                                                    SlidableAction(
                                                        label: "Retomar",
                                                        icon: Icons
                                                            .thumb_down_outlined,
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF4672FF),
                                                        onPressed:
                                                            (context) async {
                                                          if (currentUser.rol.target!.rol == "Voluntario Estratégico" ||
                                                              currentUser
                                                                      .rol
                                                                      .target!
                                                                      .rol ==
                                                                  "Amigo del Cambio" ||
                                                              currentUser
                                                                      .rol
                                                                      .target!
                                                                      .rol ==
                                                                  "Emprendedor") {
                                                            snackbarKey
                                                                .currentState
                                                                ?.showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  "Este usuario no tiene permisos para esta acción."),
                                                            ));
                                                          } else {
                                                            emprendimientoProvider
                                                                .reactivarOdesconsolidarEmprendimiento(
                                                                    emprendimiento
                                                                        .id);
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const EmprendimientoRetomadoScreen(),
                                                              ),
                                                            );
                                                          }
                                                        }),
                                                    SlidableAction(
                                                        label: "Archivar",
                                                        icon: Icons
                                                            .file_download_outlined,
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                207,
                                                                38,
                                                                128,
                                                                55),
                                                        onPressed:
                                                            (context) async {
                                                          if (currentUser.rol.target!.rol == "Voluntario Estratégico" ||
                                                              currentUser
                                                                      .rol
                                                                      .target!
                                                                      .rol ==
                                                                  "Amigo del Cambio" ||
                                                              currentUser
                                                                      .rol
                                                                      .target!
                                                                      .rol ==
                                                                  "Emprendedor") {
                                                            snackbarKey
                                                                .currentState
                                                                ?.showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  "Este usuario no tiene permisos para esta acción."),
                                                            ));
                                                          } else {
                                                            emprendimientoProvider
                                                                .archivarEmprendimiento(
                                                                    emprendimiento
                                                                        .id);
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const EmprendimientoArchivadoScreen(),
                                                              ),
                                                            );
                                                          }
                                                        }),
                                                  ]),
                                              child: Stack(
                                                children: [
                                                  TargetaDescripcionWidget(
                                                      emprendimiento:
                                                          emprendimiento),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            15, 10, 15, 10),
                                                    child: Container(
                                                      width: 60,
                                                      height: 275,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(80,
                                                                38, 128, 55),
                                                            Color(0x0014181B),
                                                          ],
                                                          stops: [0, 1],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: const Icon(
                                                        Icons
                                                            .double_arrow_rounded,
                                                        size: 65,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : TargetaDescripcionWidget(
                                              emprendimiento: emprendimiento);
                                }
                                return const SizedBox();
                              },
                            ),
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
      ),
    );
  }
}
