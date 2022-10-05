import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bizpro_app/providers/user_provider.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_invoice_inversiones.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/inversiones_invoice.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_api.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/invoice_info.dart';
import 'package:bizpro_app/screens/inversiones/agregar_primer_producto_inversion_screen.dart';
import 'package:bizpro_app/screens/inversiones/main_tab_opciones.dart';
import 'package:bizpro_app/screens/emprendimientos/detalle_emprendimiento_screen.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/helpers/constants.dart';

class InversionesScreen extends StatefulWidget {
  final int idEmprendimiento;
  const InversionesScreen({
    Key? key, 
    required this.idEmprendimiento,
  }) : super(key: key);


  @override
  _InversionesScreenState createState() => _InversionesScreenState();
}

class _InversionesScreenState extends State<InversionesScreen> {
  Emprendimientos? actualEmprendimiento;
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String emprendedor = "";
  late List<Inversiones> inversiones;

  @override
  void initState() {
    super.initState();
    actualEmprendimiento = dataBase.emprendimientosBox.get(widget.idEmprendimiento);
    if (actualEmprendimiento != null) {
      inversiones = actualEmprendimiento!.inversiones.toList();
      emprendedor = "";
      if (actualEmprendimiento!.emprendedor.target != null) {
        emprendedor =
            "${actualEmprendimiento!.emprendedor.target!.nombre} ${actualEmprendimiento!.emprendedor.target!.apellidos}";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    inversiones = actualEmprendimiento!.inversiones.toList();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        floatingActionButton: (actualEmprendimiento!.usuario.target!.rol.target!.rol == "Administrador" ||
            actualEmprendimiento!.usuario.target!.rol.target!.rol == "Promotor")
            ? FloatingActionButton(
                onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AgregarPrimerProductoInversionScreen(
                              idEmprendimiento: widget.idEmprendimiento,
                            ),
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
                height: MediaQuery.of(context).size.height * 1,
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
                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 35, 0, 0),
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          AppTheme.of(context).secondaryText,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetalleEmprendimientoScreen(
                                                    emprendimiento: actualEmprendimiento!,
                                                    ),
                                            ),
                                          );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Icon(
                                            Icons.arrow_back_ios_rounded,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          Text(
                                            'Atrás',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      AppTheme.of(context)
                                                          .bodyText1Family,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 35, 0, 0),
                                  child: Text(
                                    'Inversiones del Emprendimiento',
                                    style: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: AppTheme.of(context)
                                              .bodyText1Family,
                                          color: AppTheme.of(context)
                                              .primaryText,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 10, 0),
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        final date = DateTime.now();
                                        final invoice = InversionesInvoice(
                                          info: InvoiceInfo(
                                            usuario:
                                                '${actualEmprendimiento!.usuario.target!.nombre} ${actualEmprendimiento!.usuario.target!.apellidoP}',
                                            fecha: date,
                                            titulo: 'Inversiones',
                                            descripcion:
                                                'En la siguiente tabla se muestran todas las inversiones hechas en el emprendimiento ${actualEmprendimiento!.nombre} hasta el momento.',
                                          ),
                                          items: [
                                            for (var inversion in inversiones)
                                              for(var productoSol in inversion.prodSolicitados)
                                              InversionesItem(
                                                id: inversion.id,
                                                emprendedor: 
                                                  "${inversion.
                                                    emprendimiento.target!.
                                                    emprendedor.target!.nombre} ${inversion.
                                                    emprendimiento.target!.
                                                    emprendedor.target!.apellidos}",
                                                producto: 
                                                  productoSol.
                                                    producto,
                                                descripcion: 
                                                  productoSol.
                                                    descripcion,
                                                marcaSugerida: 
                                                  productoSol.
                                                    marcaSugerida ?? "",
                                                proveedorSugerido: 
                                                  productoSol.
                                                    proveedorSugerido ?? "",
                                                tipoEmpaque: 
                                                  productoSol.
                                                    tipoEmpaques.target!.tipo,
                                                cantidad: 
                                                  productoSol.
                                                    cantidad.toString(),
                                                costoEstimado:
                                                  productoSol.costoEstimado == null ?
                                                  ""
                                                  :
                                                  "\$${productoSol.
                                                    costoEstimado}",
                                                porcentajePago: 
                                                  "%${productoSol.
                                                    inversion.target!.
                                                    porcentajePago}",
                                                usuario:
                                                    "${inversion.emprendimiento.target!.
                                                    usuario.target!.nombre} ${inversion.
                                                    emprendimiento.target!.usuario.
                                                    target!.apellidoP}",
                                                fechaRegistro:
                                                    inversion.fechaRegistro,
                                              ),
                                          ],
                                        );
                                        final pdfFile =
                                            await PdfInvoiceInversiones
                                                .generate(invoice);

                                        PdfApi.openFile(pdfFile);
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const[
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
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0x49FFFFFF),
                                    boxShadow: const[
                                      BoxShadow(
                                          color: Color(0x39000000),
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
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 10, 0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              setState(() {});
                                            },
                                            text: '',
                                            icon: const Icon(
                                              Icons.search_rounded,
                                              size: 15,
                                            ),
                                            options: FFButtonOptions(
                                              width: 45,
                                              height: 40,
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              textStyle:
                                                  AppTheme.of(context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(
                                                                    context)
                                                                .subtitle2Family,
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
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 6),
                              child: Builder(
                                builder: (context) {
                                  //Busqueda
                                  if (searchController.text != '') {
                                    inversiones.removeWhere((element) {
                                      final estadoInversion =
                                          removeDiacritics(element.estadoInversion.target!.estado)
                                              .toLowerCase();
                                      final total = removeDiacritics(
                                                element.totalInversion.toStringAsFixed(2))
                                            .toLowerCase();
                                      final tempBusqueda =
                                          removeDiacritics(searchController.text)
                                              .toLowerCase();
                                      if (estadoInversion.contains(tempBusqueda) ||
                                          total.contains(tempBusqueda)) {
                                        return false;
                                      }
                                      return true;
                                    });
                                  }
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: inversiones.length,
                                    itemBuilder: (context, resultadoIndex) {
                                      final inversion =
                                          inversiones[resultadoIndex];
                                      return InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MainTabOpcionesScreen(
                                                      emprendimiento: actualEmprendimiento!,
                                                      idInversion: inversion.id,
                                                    ),
                                              ),
                                            );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              20, 10, 20, 20),
                                          child: Container(
                                            width: double.infinity,
                                            height: 130,
                                            decoration: BoxDecoration(
                                              color: const Color(
                                                0x374672FF),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional
                                                          .fromSTEB(10, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    12),
                                                            child: SizedBox(
                                                              height: 80,
                                                              width: 120,
                                                              child: getWidgetCoverImage(
                                                                actualEmprendimiento!.imagen
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            maybeHandleOverflow(
                                                              actualEmprendimiento!.nombre, 12, "..."
                                                              ),
                                                            style: AppTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      AppTheme.of(context)
                                                                          .bodyText1Family,
                                                                  fontSize:
                                                                      16,
                                                                  color: AppTheme.of(context)
                                                                          .secondaryText,
                                                                ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5, 0, 5, 5),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize.max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Container(
                                                                  width: 30,
                                                                  height: 30,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape:
                                                                        BoxShape.circle,
                                                                  ),
                                                                  child: getWidgetImageEmprendedor(
                                                                    actualEmprendimiento!.
                                                                      emprendedor.target!.imagen,
                                                                    30,
                                                                    30),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(5,
                                                                              0, 0, 0),
                                                                  child: Text(
                                                                    maybeHandleOverflow(emprendedor, 25, "..."),
                                                                    style: AppTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              AppTheme.of(context)
                                                                                  .bodyText1Family,
                                                                          fontSize:
                                                                              14,
                                                                          color: AppTheme.of(context)
                                                                                  .secondaryText,
                                                                        ),
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5, 0, 5, 0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize.max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              5,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                  child: Text(
                                                                    'Total Inversión:',
                                                                    style: AppTheme.of(
                                                                            context)
                                                                        .bodyText1,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              10,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                  child: Text(
                                                                    maybeHandleOverflow(
                                                                    currencyFormat.format(inversion.totalInversion.toStringAsFixed(2))
                                                                    , 12, "..."
                                                                    ),
                                                                    style: AppTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              AppTheme.of(context)
                                                                                  .bodyText1Family,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5,
                                                                        0,
                                                                        5,
                                                                        0),
                                                            child: Text(
                                                              "Estado: ${inversion.estadoInversion.target?.estado ?? ''}",
                                                              style: AppTheme.of(
                                                                      context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        AppTheme.of(context)
                                                                            .bodyText1Family,
                                                                    fontSize:
                                                                        14,
                                                                    color: AppTheme.of(context).secondaryText,
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5,
                                                                        0,
                                                                        5,
                                                                        0),
                                                            child: Text(
                                                              maybeHandleOverflow(
                                                              "Tipo de proyecto: ${
                                                                actualEmprendimiento!
                                                                  .catalogoProyecto
                                                                  .target!.nombre}", 38, "..."
                                                              ),
                                                              style: AppTheme.of(
                                                                      context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        AppTheme.of(context)
                                                                            .bodyText1Family,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
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
      ),
    );
  }
}
