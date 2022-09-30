import 'dart:io';

import 'package:bizpro_app/screens/emprendedores/grid_emprendedores_screen.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/main.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:bizpro_app/util/util.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/providers/database_providers/emprendedor_controller.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/screens/emprendedores/detalle_emprendedor_screen.dart';
import 'package:bizpro_app/screens/perfil_usuario/perfil_usuario_screen.dart';
import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:bizpro_app/screens/widgets/side_menu/side_menu.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_api.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_invoice_emprendedor.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/emprendedor_invoice.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/invoice_info.dart';

class EmprendedoresScreen extends StatefulWidget {
  const EmprendedoresScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EmprendedoresScreen> createState() => _EmprendedoresScreenState();
}

class _EmprendedoresScreenState extends State<EmprendedoresScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Emprendedores> emprendedoresPDF = [];
  List<Emprendedores> emprendedores = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      getInfo();
      emprendedoresPDF = [];
      emprendedores = [];
      emprendedoresPDF = context.read<EmprendedorController>().getEmprendedoresActualUser(
        context.read<UsuarioController>().getEmprendimientos());
      emprendedores = context.read<EmprendedorController>().getEmprendedoresActualUser(
        context.read<UsuarioController>().getEmprendimientos());
    });
  }

  getInfo() {
    print("PREFERS: ${prefs.getString("userId")}");
    context.read<EmprendedorController>().getEmprendedoresActualUser(
        context.read<UsuarioController>().getEmprendimientos());
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final Usuarios currentUser = usuarioProvider.usuarioCurrent!;
    //TODO: almacenar imagen?
    const String currentUserPhoto =
        'assets/images/default-user-profile-picture.jpg';
    emprendedores = [];
    emprendedores = context.read<EmprendedorController>().getEmprendedoresActualUser(
        context.read<UsuarioController>().getEmprendimientos());
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
                                Text(
                                  'Emprendedores',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color: const Color(0xFF221573),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PerfilUsuarioScreen(),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: currentUserPhoto,
                                    transitionOnUserGestures: true,
                                    child: currentUser.image.target?.imagenes ==
                                            ""
                                        ? Container(
                                            width: 40,
                                            height: 40,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Container(
                                              color: Colors.blue,
                                              child: Center(
                                                child: Text(
                                                  "${currentUser.nombre.substring(0, 1)} ${currentUser.apellidoP.substring(0, 1)}",
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: AppTheme.of(
                                                                context)
                                                            .bodyText1Family,
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: 40,
                                            height: 40,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              color: const Color(0x00EEEEEE),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: FileImage(File(
                                                      currentUser.image.target!
                                                          .imagenes))),
                                              shape: BoxShape.circle,
                                            ),
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
                                                obscureText: false,
                                                onChanged: (_) =>
                                                    setState(() {}),
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'Ingresa búsqueda...',
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
                                                color: const Color(0xFF4672FF),
                                                textStyle: AppTheme.of(context)
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
                                      color: const Color(0xFF4672FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GridEmprendedoresScreen(emprendedores: emprendedores),
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
                                        print(
                                            "Length emprendedores: ${emprendedoresPDF.length}");
                                        final date = DateTime.now();
                                        final invoice = EmprendedorInvoice(
                                          info: InvoiceInfo(
                                            usuario:
                                                '${currentUser.nombre} ${currentUser.apellidoP}',
                                            fecha: date,
                                            titulo: 'Emprendedores',
                                            descripcion:
                                                'En la siguiente tabla se muestran todos los emprendedores creados hasta el momento.',
                                          ),
                                          items: [
                                            for (var emp in emprendedoresPDF)
                                              EmprendedorItem(
                                                id: emp.id,
                                                nombre: emp.nombre,
                                                apellidos: emp.apellidos,
                                                curp: emp.curp,
                                                integrantesFamilia:
                                                    emp.integrantesFamilia,
                                                comunidad: emp
                                                    .comunidad.target!.nombre,
                                                telefono: emp.telefono ?? "",
                                                emprendimiento: emp
                                                    .emprendimiento
                                                    .target!
                                                    .nombre,
                                                comentarios: emp.comentarios,
                                                usuario:
                                                    "${emp.emprendimiento.target!.usuario.target!.nombre} ${emp.emprendimiento.target!.usuario.target!.apellidoP}",
                                                fechaRegistro:
                                                    emp.fechaRegistro,
                                              ),
                                          ],
                                        );
                                        final pdfFile =
                                            await PdfInvoiceEmprendedor
                                                .generate(invoice);

                                        PdfApi.openFile(pdfFile);
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
                            emprendedores.removeWhere((element) {
                              final nombreEmprendedor = removeDiacritics(
                                      '${element.nombre} ${element.apellidos}')
                                  .toLowerCase();
                              final nombreEmprendimiento =
                                  removeDiacritics(element.emprendimiento.target!.nombre)
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
                          return ListView.builder(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                              reverse: true,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: emprendedores.length,
                              itemBuilder: (context, index) {
                                final emprendedor = emprendedores[index];
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 10, 15, 10),
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
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetallesEmprendedorScreen(
                                                        idEmprendedor:
                                                            emprendedor.id),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
                                              child: getWidgetImageEmprendedor(
                                                  emprendedor.imagen, 180, double.infinity)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16, 12, 16, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 5, 0),
                                                child: Text(
                                                  emprendedor.nombre,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTheme.of(context)
                                                      .title3
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                              Text(
                                                emprendedor.apellidos,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTheme.of(context)
                                                    .title3
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16, 0, 16, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  emprendedor.comunidad.target
                                                          ?.nombre ??
                                                      "SIN COMUNIDAD",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTheme.of(context)
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
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16, 0, 16, 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                emprendedor.emprendimiento.target
                                                            ?.nombre ==
                                                        null
                                                    ? 'SIN EMPRENDIMIENTO'
                                                    : emprendedor.emprendimiento.target!.nombre,
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
