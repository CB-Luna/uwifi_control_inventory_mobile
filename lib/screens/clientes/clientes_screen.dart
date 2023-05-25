import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';

import 'package:taller_alex_app_asesor/util/util.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_button.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/screens/widgets/side_menu/side_menu.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Usuarios> clientes = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      clientes = [];
      clientes = context.read<UsuarioController>().obtenerClientes();
    });
  }


  @override
  Widget build(BuildContext context) {
    clientes = [];
    clientes = context.read<UsuarioController>().obtenerClientes();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const SideMenu(),
        backgroundColor: FlutterFlowTheme.of(context).white,
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
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    'Clientes',
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
                                      color: FlutterFlowTheme.of(context).grayLighter,
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
                                                obscureText: false,
                                                onChanged: (_) =>
                                                    setState(() {}),
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'Ingresa búsqueda...',
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
                                                .fromSTEB(0, 0, 10, 0),
                                            child: CustomButton(
                                              onPressed: () async {
                                                setState(() {});
                                              },
                                              text: '',
                                              icon: const Icon(
                                                Icons.search_rounded,
                                                size: 15,
                                              ),
                                              options: ButtonOptions(
                                                width: 50,
                                                height: 40,
                                                color: FlutterFlowTheme.of(context).primaryColor,
                                                textStyle: FlutterFlowTheme.of(context)
                                                    .subtitle2
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                      //   await Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         GridClientesScreen(emprendedores: emprendedores),
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
                            clientes.removeWhere((element) {
                              final nombreCliente = removeDiacritics(
                                      '${element.nombre} ${element.apellidoP} ${element.apellidoM}')
                                  .toLowerCase();
                              final correo =
                                  removeDiacritics(element.correo)
                                      .toLowerCase();
                              final celular =
                                  removeDiacritics(element.celular)
                                      .toLowerCase();
                              final tempBusqueda =
                                  removeDiacritics(searchController.text)
                                      .toLowerCase();
                              if (correo.contains(tempBusqueda) ||
                                  nombreCliente.contains(tempBusqueda) ||
                                  celular.contains(tempBusqueda)
                                  ) {
                                return false;
                              }
                              return true;
                            });
                          }
                          return ListView.builder(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                              reverse: true,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: clientes.length,
                              itemBuilder: (context, index) {
                                final cliente = clientes[index];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 10, 15, 10),
                                  child: Container(
                                    width: double.infinity,
                                    height: 275,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).grayLighter,
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
                                            // await Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         DetallesEmprendedorScreen(
                                            //             idEmprendedor:
                                            //                 cliente.id),
                                            //   ),
                                            // );
                                          },
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
                                              child: getWidgetImageCliente(
                                                  cliente.path, 180, double.infinity)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16, 12, 16, 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    maybeHandleOverflow("${cliente.nombre} ${
                                                      cliente.apellidoP} ${
                                                        cliente.apellidoM}", 30, "..."),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: FlutterFlowTheme.of(context)
                                                        .title3
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme.of(context).primaryColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 0, 0),
                                                    child: Text(
                                                      maybeHandleOverflow(cliente.correo, 50, "..."),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: FlutterFlowTheme.of(context)
                                                          .bodyText2
                                                          .override(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.normal,
                                                          ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "No. Celular: ${cliente.celular}",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                  ),
                                                ],
                                              ), 
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    "Vehículos",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: FlutterFlowTheme.of(context)
                                                        .title3
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme.of(context).tertiaryColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 0, 0),
                                                    child: ClayContainer(
                                                      height: 35,
                                                      width: 35,
                                                      depth: 40,
                                                      spread: 2,
                                                      borderRadius: 25,
                                                      curveType: CurveType.concave,
                                                      parentColor: FlutterFlowTheme.of(context).grayLighter,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(25),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "${cliente.vehicle.target?.color}",
                                                            style: FlutterFlowTheme.of(context)
                                                                .title1
                                                                .override(
                                                                  fontFamily: 'Outfit',
                                                                  color: FlutterFlowTheme.of(context).grayDark.withOpacity(0.75),
                                                                  fontSize: 25,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
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
