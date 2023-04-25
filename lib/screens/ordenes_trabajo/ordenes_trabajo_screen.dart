import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/screens/clientes/agregar_cliente_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/agregar_orden_trabajo_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/componentes/widgets/bottom_sheet_descargar_catalogos.dart';
import 'package:taller_alex_app_asesor/util/util.dart';

import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/screens/widgets/side_menu/side_menu.dart';

import 'componentes/tarjeta_orden_trabajo_descripcion.dart';

class OrdenesTrabajoScreen extends StatefulWidget {
  const OrdenesTrabajoScreen({Key? key}) : super(key: key);

  @override
  State<OrdenesTrabajoScreen> createState() => _OrdenesTrabajoScreenState();
}

class _OrdenesTrabajoScreenState extends State<OrdenesTrabajoScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<OrdenTrabajo> ordenesTrabajo = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      getInfo();
      ordenesTrabajo = [];
      ordenesTrabajo = context.read<UsuarioController>().obtenerOrdenesTrabajo();
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
    final Usuarios currentUser = usuarioProvider.usuarioCurrent!;
    ordenesTrabajo = [];
    ordenesTrabajo = usuarioProvider.obtenerOrdenesTrabajo();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const SideMenu(),
        backgroundColor: FlutterFlowTheme.of(context).white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
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
                                    // await Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         GridOrdenesTrabajoScreen(
                                    //       emprendimientos: emprendimientos,
                                    //     ),
                                    //   ),
                                    // );
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
                      const EdgeInsetsDirectional.fromSTEB(0, 155, 0, 6),
                  child: Builder(
                    builder: (context) {
                      //Busqueda
                      if (searchController.text != '') {
                        ordenesTrabajo.removeWhere((element) {
                          final nombreCliente =
                              removeDiacritics("${element.cliente.target!.nombre} ${element.cliente.target!.apellidoP} ${element.cliente.target?.apellidoM}")
                                  .toLowerCase();
                          final modelo = removeDiacritics(
                                  element.vehiculo.target!.modelo)
                              .toLowerCase();
                          final marca = removeDiacritics(
                                  element.vehiculo.target!.marca)
                              .toLowerCase();
                          final descripcion = removeDiacritics(
                                  element.descripcionFalla)
                              .toLowerCase();
                          final tempBusqueda =
                              removeDiacritics(searchController.text)
                                  .toLowerCase();
                          if (nombreCliente.contains(tempBusqueda) ||
                              modelo.contains(tempBusqueda) ||
                              marca.contains(tempBusqueda) ||
                              descripcion.contains(tempBusqueda)) {
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
                          itemCount: ordenesTrabajo.length,
                          itemBuilder: (context, resultadoIndex) {
                            final ordenTrabajo =
                                ordenesTrabajo[resultadoIndex];
                              return  TargetaOrdenTrabajoDescripcion(
                                 ordenTrabajo: ordenTrabajo);
                            
                          },
                        ),
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  bottom: 35,
                  child: 
                  Align(
                    alignment: Alignment.bottomRight,
                    child: (currentUser.rol.target!.rol == "Asesor")
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryColor,
                              borderRadius:
                                  BorderRadius.circular(30
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 1),
                                )
                              ],
                            ),
                            child: InkWell(
                              onTap: () async {
                                //TODO: Colocar el último catálogo que se descargue
                                List<TipoProducto> listProdProyecto =
                                    dataBase.tipoProductoBox.getAll();
                                if (listProdProyecto.isNotEmpty) {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AgregarClienteScreen(),
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
                              child: Icon(
                              Icons.person_add,
                              color: FlutterFlowTheme.of(context).white,
                              size: 24,
                            ),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0, //Esto es solo para dar cierto margen entre los FAB
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryColor,
                              borderRadius:
                                  BorderRadius.circular(30
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 1),
                                )
                              ],
                            ),
                            child: InkWell(
                              onTap: () async {
                                //TODO: Colocar el último catálogo que se descargue
                                List<TipoProducto> listProdProyecto =
                                    dataBase.tipoProductoBox.getAll();
                                if (listProdProyecto.isNotEmpty) {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AgregarOrdenTrabajoScreen(),
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
                              child: Icon(
                                Icons.add,
                                color: FlutterFlowTheme.of(context).white,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0, //Esto es solo para dar cierto margen entre los FAB
                          ),
                        ],
                      )
                      : 
                      null,
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
