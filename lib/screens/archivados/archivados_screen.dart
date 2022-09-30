import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/screens/archivados/emprendimiento_desarchivado_screen.dart';
import 'package:bizpro_app/screens/emprendimientos/components/tarjeta_descripcion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/util/util.dart';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/screens/widgets/side_menu/side_menu.dart';

class ArchivadosScreen extends StatefulWidget {
  const ArchivadosScreen({Key? key}) : super(key: key);

  @override
  State<ArchivadosScreen> createState() => _ArchivadosScreenState();
}

class _ArchivadosScreenState extends State<ArchivadosScreen> {
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
      dataBase.areaCirculoBox.getAll().forEach((element) {listAreaCirculo.add(element.nombreArea);});
      listAreaCirculo.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
      emprendimientosPDF = context.read<UsuarioController>().getEmprendimientos();
      emprendimientos = context.read<UsuarioController>().getEmprendimientos();
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
    final emprendimientoProvider = Provider.of<EmprendimientoController>(context);
    emprendimientos = [];
    emprendimientos = usuarioProvider.getEmprendimientos();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const SideMenu(),
        backgroundColor: Colors.white,
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
                                    'Archivados',
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
                                        0.9,
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
                                                  labelStyle: AppTheme.of(
                                                          context)
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
                          return SlidableAutoCloseBehavior(
                            closeWhenOpened: true,
                            child: ListView.builder(
                              reverse: true,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: emprendimientos.length,
                              itemBuilder: (context, resultadoIndex) {
                                final emprendimiento =
                                    emprendimientos[resultadoIndex];
                                    while (emprendimiento.archivado) {
                                      return Slidable(
                                        startActionPane: ActionPane(
                                          motion: const DrawerMotion(), 
                                          children: [
                                            SlidableAction(
                                              label: "Desarchivar",
                                              icon: Icons.file_upload_outlined,
                                              backgroundColor: Colors.black54,
                                              onPressed: (context) async {
                                                  emprendimientoProvider.desarchivarEmprendimiento(emprendimiento.id);
                                                  await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                  builder: (context) =>
                                                      const EmprendimientoDesarchivadoScreen(),
                                                        ),
                                                  );                                            
                                              }
                                            ),
                                          ]),
                                        child: Stack(
                                          children: [
                                            TargetaDescripcionWidget(
                                              emprendimiento: emprendimiento
                                              ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                15, 10, 15, 10),
                                              child: Container(
                                                width: 60,
                                                height: 275,
                                                decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Colors.black26,
                                                      Color(0x0014181B),
                                                    ],
                                                    stops: [0, 1],
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8),
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
                                      );
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
