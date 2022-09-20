import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/screens/productos/agregar_producto_emprendedor_screen.dart';
import 'package:bizpro_app/screens/productos/detalle_producto_emprendedor.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_api.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_invoice_productos_emprendedor.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/invoice_info.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/productos_emprendedor_invoice.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bizpro_app/providers/user_provider.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

import '../widgets/get_image_widget.dart';


class ProductosEmprendedorScreen extends StatefulWidget {
  final List<ProductosEmp> productosEmprendedor;
  final Emprendimientos emprendimiento;
  const ProductosEmprendedorScreen({
    Key? key, 
    required this.productosEmprendedor, 
    required this.emprendimiento,
  }) : super(key: key);


  @override
  _ProductosEmprendedorScreenState createState() => _ProductosEmprendedorScreenState();
}

class _ProductosEmprendedorScreenState extends State<ProductosEmprendedorScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final Usuarios currentUser = usuarioProvider.usuarioCurrent!;
    final UserState userState = Provider.of<UserState>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        floatingActionButton: userState.rol == Rol.administrador
            ? FloatingActionButton(
                onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AgregarProductoEmprendedorScreen(emprendimiento: widget.emprendimiento,),
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
                                        Navigator.pop(context);
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
                                    'Productos de Emprendedores',
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
                                        final invoice = ProductosEmprendedorInvoice(
                                          info: InvoiceInfo(
                                            usuario:
                                                '${currentUser.nombre} ${currentUser.apellidoP}',
                                            fecha: date,
                                            titulo: 'Productos de Emprendedor',
                                            descripcion:
                                                'En la siguiente tabla se muestran todos los productos creados por el emprendedor ${widget.emprendimiento.emprendedor.target!.nombre} hasta el momento.',
                                          ),
                                          items: [
                                            for (var producto in widget.productosEmprendedor)
                                              ProductosEmprendedorItem(
                                                id: producto.id,
                                                emprendedor: 
                                                  "${producto.
                                                  emprendimientos.target!.
                                                  emprendedor.target!.nombre} ${producto.
                                                  emprendimientos.target!.
                                                  emprendedor.target!.apellidos}",
                                                tipoProyecto: 
                                                  producto.
                                                  emprendimientos.target!.
                                                  catalogoProyecto.target!.nombre,
                                                  emprendimiento: producto.
                                                  emprendimientos.target!.nombre,
                                                producto:
                                                  producto.nombre,
                                                descripcion: 
                                                  producto.descripcion,
                                                unidadMedida: 
                                                  producto.unidadMedida.target!.
                                                    unidadMedida,
                                                costo:
                                                  currencyFormat.format(producto.
                                                    costo.toStringAsFixed(2)),
                                                usuario:
                                                    "${producto.emprendimientos.target!.
                                                    usuario.target!.nombre} ${producto.
                                                    emprendimientos.target!.usuario.
                                                    target!.apellidoP}",
                                                fechaRegistro:
                                                    producto.fechaRegistro,
                                              ),
                                          ],
                                        );
                                        final pdfFile =
                                            await PdfInvoiceProductosEmprendedor
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
                                    // emprendimientos.removeWhere((element) {
                                    //   final nombreEmprendimiento =
                                    //       removeDiacritics(element.nombre)
                                    //           .toLowerCase();
                                    //   final nombreEmprendedor = removeDiacritics(
                                    //           '${element.emprendedor.target?.nombre ?? ''} ${element.emprendedor.target?.apellidos ?? ''}')
                                    //       .toLowerCase();
                                    //   final tempBusqueda =
                                    //       removeDiacritics(searchController.text)
                                    //           .toLowerCase();
                                    //   if (nombreEmprendimiento.contains(tempBusqueda) ||
                                    //       nombreEmprendedor.contains(tempBusqueda)) {
                                    //     return false;
                                    //   }
                                    //   return true;
                                    // });
                                  }
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: widget.productosEmprendedor.length,
                                    itemBuilder: (context, resultadoIndex) {
                                      final productoEmprendedor =
                                          widget.productosEmprendedor[resultadoIndex];
                                      return InkWell(
                                        onTap: () async {
                                           await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetalleProductoEmprendedor(
                                                      productoEmprendedor: productoEmprendedor,
                                                    ),
                                                  ),
                                                );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              15, 10, 15, 0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 250,
                                            decoration: BoxDecoration(
                                              color: const Color(
                                                0x374672FF),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                    bottomLeft: Radius.circular(0),
                                                    bottomRight: Radius.circular(0),
                                                    topLeft: Radius.circular(8),
                                                    topRight: Radius.circular(8),
                                                  ),
                                                  child:
                                                      getWidgetContainerImage(
                                                        productoEmprendedor.imagen,
                                                        150,
                                                        double.infinity),
                                                ),
                                                Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                        16, 12, 16, 8),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 5, 0),
                                                  child: Text(
                                                    productoEmprendedor.nombre,
                                                    style: AppTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodyText1Family,
                                                          color: AppTheme.of(context)
                                                                          .primaryText,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
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
                                                        productoEmprendedor.emprendimientos.target?.catalogoProyecto.target?.nombre ?? "SIN TIPO DE PROYECTO",
                                                        style: AppTheme.of(
                                                                context)
                                                            .bodyText2
                                                            .override(
                                                              fontFamily: 'Outfit',
                                                              color: AppTheme.of(context)
                                                                          .secondaryText,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.normal,
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
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Und: ${productoEmprendedor.unidadMedida.target!.unidadMedida}",
                                                      style: AppTheme.of(
                                                              context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                AppTheme.of(
                                                                        context)
                                                                    .bodyText1Family,
                                                            color: AppTheme.of(context)
                                                                          .secondaryText,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                    Text(
                                                      "Costo: \$${productoEmprendedor.costo.toStringAsFixed(2)}",
                                                      style: AppTheme.of(
                                                              context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                AppTheme.of(
                                                                        context)
                                                                    .bodyText1Family,
                                                            color: AppTheme.of(context)
                                                                          .primaryText,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
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
