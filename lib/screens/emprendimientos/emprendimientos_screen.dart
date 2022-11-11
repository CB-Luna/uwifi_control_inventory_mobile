import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/screens/emprendimientos/components/tarjeta_descripcion_widget.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimiento_archivado_screen.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimiento_retomado_screen.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimiento_reactivado_screen.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_archivar_emprendimiento.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_invoice_consultorias.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/consultorias_invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/util/util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/screens/emprendimientos/grid_emprendimientos_screen.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_descargar_catalogos.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_api.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_invoice_emprendimiento.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/emprendimiento_invoice.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_invoice_jornadas.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/jornadas_invoice.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/invoice_info.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_download_info.dart';
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
    final Usuarios currentUser = usuarioProvider.usuarioCurrent!;
    final UserState userState = Provider.of<UserState>(context);
    emprendimientos = [];
    emprendimientos = usuarioProvider.getEmprendimientos();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const SideMenu(),
        backgroundColor: Colors.white,
        floatingActionButton: (currentUser.rol.target!.rol == "Administrador" ||
                currentUser.rol.target!.rol == "Promotor")
            ? FloatingActionButton(
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
                                        0.65,
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
                                    child: InkWell(
                                      onTap: () async {
                                        if (currentUser.rol.target!.rol ==
                                            "Voluntario Estratégico") {
                                          snackbarKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                            content: Text(
                                                "Este usuario no tiene permisos para esta acción."),
                                          ));
                                        } else {
                                          final date = DateTime.now();
                                          String? option =
                                              await showModalBottomSheet(
                                            context: context,
                                            builder: (_) =>
                                                const CustomBottomDownloadInfo(),
                                          );
                                          if (option == null) return;
                                          if (option == "consultorias") {
                                            final invoice = ConsultoriasInvoice(
                                              info: InvoiceInfo(
                                                usuario:
                                                    '${currentUser.nombre} ${currentUser.apellidoP}',
                                                fecha: date,
                                                titulo: 'Consultorias',
                                                descripcion:
                                                    'En la siguiente tabla se muestran todas las consultorías creadas hasta el momento.',
                                              ),
                                              items: [
                                                for (var emp in emprendimientos)
                                                  for (var consultoria
                                                      in emp.consultorias)
                                                    ConsultoriasItem(
                                                      id: consultoria.id,
                                                      emprendedor:
                                                          "${emp.emprendedor.target!.nombre} ${emp.emprendedor.target!.apellidos}",
                                                      ambito: consultoria
                                                          .ambitoConsultoria
                                                          .target!
                                                          .nombreAmbito,
                                                      areaCirculo: consultoria
                                                          .areaCirculo
                                                          .target!
                                                          .nombreArea,
                                                      avanceObservado:
                                                          consultoria.tareas
                                                              .last.descripcion,
                                                      porcentajeAvance:
                                                          consultoria.tareas
                                                              .last.porcentaje
                                                              .toString(),
                                                      siguientesPasos:
                                                          consultoria.tareas
                                                              .last.descripcion,
                                                      fechaRevision: consultoria
                                                          .tareas
                                                          .last
                                                          .fechaRevision,
                                                      usuario:
                                                          "${emp.usuario.target!.nombre} ${emp.usuario.target!.apellidoP}",
                                                      fechaRegistro: consultoria
                                                          .fechaRegistro,
                                                    ),
                                              ],
                                            );
                                            final pdfFile =
                                                await PdfInvoiceConsultorias
                                                    .generate(invoice);
                                            PdfApi.openFile(pdfFile);
                                          }
                                          if (option == "jornadas") {
                                            final invoice = JornadasInvoice(
                                              info: InvoiceInfo(
                                                usuario:
                                                    '${currentUser.nombre} ${currentUser.apellidoP}',
                                                fecha: date,
                                                titulo: 'Jornadas',
                                                descripcion:
                                                    'En la siguiente tabla se muestran todas las jornadas creadas hasta el momento.',
                                              ),
                                              items: [
                                                for (var emp in emprendimientos)
                                                  for (var jornada
                                                      in emp.jornadas)
                                                    JornadasItem(
                                                      id: jornada.id,
                                                      emprendedor:
                                                          "${emp.emprendedor.target!.nombre} ${emp.emprendedor.target!.apellidos}",
                                                      comunidad: jornada
                                                          .emprendimiento
                                                          .target!
                                                          .emprendedor
                                                          .target!
                                                          .comunidad
                                                          .target!
                                                          .nombre,
                                                      emprendimiento:
                                                          emp.nombre,
                                                      jornada: jornada
                                                          .numJornada
                                                          .toString(),
                                                      tareaRegistrada: jornada
                                                          .tarea.target!.tarea,
                                                      fechaRevision:
                                                          jornada.fechaRevision,
                                                      completada:
                                                          jornada.completada ==
                                                                  true
                                                              ? "Sí"
                                                              : "No",
                                                      usuario:
                                                          "${emp.usuario.target!.nombre} ${emp.usuario.target!.apellidoP}",
                                                      fechaRegistro:
                                                          jornada.fechaRegistro,
                                                    ),
                                              ],
                                            );
                                            final pdfFile =
                                                await PdfInvoiceJornadas
                                                    .generate(invoice);
                                            PdfApi.openFile(pdfFile);
                                          }
                                          if (option == "emprendimientos") {
                                            final invoice =
                                                EmprendimientoInvoice(
                                              info: InvoiceInfo(
                                                usuario:
                                                    '${currentUser.nombre} ${currentUser.apellidoP}',
                                                fecha: date,
                                                titulo: 'Emprendimientos',
                                                descripcion:
                                                    'En la siguiente tabla se muestran todos los emprendimientos creados hasta el momento.',
                                              ),
                                              items: [
                                                for (var emp in emprendimientos)
                                                  EmprendimientoItem(
                                                    emprendedor:
                                                        "${emp.emprendedor.target!.nombre} ${emp.emprendedor.target!.apellidos}",
                                                    emprendimiento: emp.nombre,
                                                    comunidad: emp
                                                        .emprendedor
                                                        .target!
                                                        .comunidad
                                                        .target!
                                                        .nombre,
                                                    tipoProyecto: emp
                                                                .catalogoProyecto
                                                                .target !=
                                                            null
                                                        ? emp
                                                            .catalogoProyecto
                                                            .target!
                                                            .tipoProyecto
                                                            .target!
                                                            .tipoProyecto
                                                        : "",
                                                    fase: emp.faseActual,
                                                  ),
                                              ],
                                            );
                                            final pdfFile =
                                                await PdfInvoiceEmprendimiento
                                                    .generate(invoice);
                                            PdfApi.openFile(pdfFile);
                                          }
                                        }
                                      },
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
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                              shrinkWrap: true,
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
                                                        const Color(0xFF4672FF),
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
                                                                    const BottomSheetArchivarWidget(isVisible: true,),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        // Navigator.push(
                                                        // context,
                                                        // MaterialPageRoute(
                                                        // builder: (context) =>
                                                        //     const EmprendimientoArchivadoScreen(),
                                                        //       ),
                                                        // );
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
