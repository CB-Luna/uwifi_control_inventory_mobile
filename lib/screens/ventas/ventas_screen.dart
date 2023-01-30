import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/emprendimientos/detalle_emprendimiento_screen.dart';
import 'package:bizpro_app/screens/ventas/editar_venta.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/invoice_info.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/ventas_invoice.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_api.dart';
import 'package:bizpro_app/screens/widgets/pdf/api/pdf_invoice_ventas.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bizpro_app/screens/ventas/agregar_venta.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/helpers/constants.dart';

class VentasScreen extends StatefulWidget {
  final List<Ventas> ventas;
  final Emprendimientos emprendimiento;
  const VentasScreen({
    Key? key,
    required this.ventas,
    required this.emprendimiento,
  }) : super(key: key);

  @override
  _VentasScreenState createState() => _VentasScreenState();
}

class _VentasScreenState extends State<VentasScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String emprendedor = "";
  List<Ventas> listActualVentas = [];

  @override
  void initState() {
    super.initState();
    emprendedor = "";
    listActualVentas = widget.ventas.toList();
    if (widget.emprendimiento.emprendedor.target != null) {
      emprendedor =
          "${widget.emprendimiento.emprendedor.target!.nombre} ${widget.emprendimiento.emprendedor.target!.apellidos}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final Usuarios currentUser = usuarioProvider.usuarioCurrent!;
    listActualVentas = widget.ventas.toList();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        floatingActionButton:
            (widget.emprendimiento.usuario.target!.rol.target!.rol ==
                        "Administrador" ||
                    widget.emprendimiento.usuario.target!.rol.target!.rol ==
                        "Promotor")
                ? FloatingActionButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AgregarVentaScreen(
                            idEmprendimiento: widget.emprendimiento.id,
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 35, 0, 0),
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).secondaryText,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetalleEmprendimientoScreen(
                                              idEmprendimiento:
                                                  widget.emprendimiento.id,
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
                                    'Ventas del Emprendimiento',
                                    style: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: AppTheme.of(context)
                                              .bodyText1Family,
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
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
                                      20, 0, 10, 0),
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).secondaryText,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        final date = DateTime.now();
                                        final invoice = VentasInvoice(
                                          info: InvoiceInfo(
                                            usuario:
                                                '${currentUser.nombre} ${currentUser.apellidoP}',
                                            fecha: date,
                                            titulo: 'Ventas del Emprendimiento',
                                            descripcion:
                                                'En la siguiente tabla se muestran todas las ventas hechas en el emprendimiento ${widget.emprendimiento.nombre} hasta el momento.',
                                          ),
                                          items: [
                                            for (var venta in widget.ventas)
                                              for (var productoVendido
                                                  in venta.prodVendidos)
                                                VentasItem(
                                                  id: venta.id,
                                                  emprendedor:
                                                      "${venta.emprendimiento.target!.emprendedor.target!.nombre} ${venta.emprendimiento.target!.emprendedor.target!.apellidos}",
                                                  fechaInicio:
                                                      venta.fechaInicio,
                                                  fechaTermino:
                                                      venta.fechaTermino,
                                                  producto: productoVendido
                                                      .productoEmp
                                                      .target!
                                                      .nombre,
                                                  unidadMedida: productoVendido
                                                      .productoEmp
                                                      .target!
                                                      .unidadMedida
                                                      .target!
                                                      .unidadMedida,
                                                  cantidadVendida:
                                                      productoVendido
                                                          .cantVendida
                                                          .toString(),
                                                  costoUnitario: currencyFormat
                                                      .format(productoVendido
                                                          .productoEmp
                                                          .target!
                                                          .costo
                                                          .toStringAsFixed(2)),
                                                  precioVenta: currencyFormat
                                                      .format(productoVendido
                                                          .precioVenta
                                                          .toStringAsFixed(2)),
                                                  total: currencyFormat.format(
                                                      productoVendido.subtotal
                                                          .toStringAsFixed(2)),
                                                  usuario:
                                                      "${venta.emprendimiento.target!.usuario.target!.nombre} ${venta.emprendimiento.target!.usuario.target!.apellidoP}",
                                                  fechaRegistro:
                                                      venta.fechaRegistro,
                                                ),
                                          ],
                                        );
                                        final pdfFile =
                                            await PdfInvoiceVentas.generate(
                                                invoice);

                                        PdfApi.openFile(pdfFile);
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
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
                                              obscureText: false,
                                              onChanged: (_) => setState(() {}),
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Ingresa búsqueda...',
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
                                              .fromSTEB(0, 0, 10, 0),
                                          child: FFButtonWidget(
                                            onPressed: () {
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
                                              textStyle: AppTheme.of(context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily:
                                                        AppTheme.of(context)
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 25, 0, 6),
                              child: Builder(
                                builder: (context) {
                                  //Busqueda
                                  if (searchController.text != '') {
                                    listActualVentas.removeWhere((element) {
                                      final nombreEmprendedor = removeDiacritics(
                                              '${element.emprendimiento.target!.emprendedor.target?.nombre ?? ''} ${element.emprendimiento.target!.emprendedor.target?.apellidos ?? ''}')
                                          .toLowerCase();
                                      final total = removeDiacritics(
                                              element.total.toStringAsFixed(2))
                                          .toLowerCase();
                                      final tempBusqueda = removeDiacritics(
                                              searchController.text)
                                          .toLowerCase();
                                      if (nombreEmprendedor
                                              .contains(tempBusqueda) ||
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
                                    itemCount: listActualVentas.length,
                                    itemBuilder: (context, resultadoIndex) {
                                      final venta =
                                          listActualVentas[resultadoIndex];
                                      return InkWell(
                                          onTap: () async {
                                            print("Total: ${venta.total}");
                                            if (widget
                                                        .emprendimiento
                                                        .usuario
                                                        .target!
                                                        .rol
                                                        .target!
                                                        .rol ==
                                                    "Amigo del Cambio" ||
                                                widget
                                                        .emprendimiento
                                                        .usuario
                                                        .target!
                                                        .rol
                                                        .target!
                                                        .rol ==
                                                    "Emprendedor") {
                                              snackbarKey.currentState
                                                  ?.showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Este usuario no tiene permisos para esta acción."),
                                              ));
                                            } else {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditarVentaScreen(
                                                    venta: venta,
                                                    idEmp:
                                                        widget.emprendimiento,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 10, 20, 20),
                                              child: Container(
                                                width: double.infinity,
                                                height: 170,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x374672FF),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                10, 0, 0, 0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child: SizedBox(
                                                                height: 80,
                                                                width: 120,
                                                                child: getWidgetCoverImage(
                                                                    widget
                                                                        .emprendimiento
                                                                        .imagen.target?.path),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      5,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      maybeHandleOverflow(
                                                                          emprendedor,
                                                                          25,
                                                                          "..."),
                                                                      style: AppTheme.of(
                                                                              context)
                                                                          .bodyText1,
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
                                                                      5),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5.0),
                                                                      child: Text(dateTimeFormat(
                                                                          "dd/MM/yyyy",
                                                                          venta
                                                                              .fechaInicio)))
                                                                              ,
                                                                  Padding(
                                                                        padding:
                                                                        const EdgeInsets.all(
                                                                            5.0),
                                                                        child:Text(
                                                                          maybeHandleOverflow(
                                                                              dateTimeFormat("dd/MM/yyyy", venta.fechaTermino),
                                                                              19,
                                                                              "..."),
                                                                        ),
                                                                      ),
                                                                  
                                                          ])),
                                                            Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            5,0,5,5),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(
                                                                        5.0),
                                                                    child:Text(
                                                                      "ID Local: ${venta.id}",
                                                                      style: AppTheme.of(context).bodyText1,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets.all(
                                                                        5.0),
                                                                    child:Text(
                                                                      "ID Emi Web: ${venta.idEmiWeb ?? 'Sin ID'}",
                                                                      style: AppTheme.of(context).bodyText1,
                                                                    ),
                                                                  ),
                                                          ]),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional.fromSTEB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                              child: Text(
                                                                                'Total\nVenta',
                                                                                style: AppTheme.of(context).bodyText1,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                              child: Text(
                                                                                currencyFormat.format(venta.total.toStringAsFixed(2)),
                                                                                style: AppTheme.of(context).bodyText1.override(
                                                                                      fontFamily: AppTheme.of(context).bodyText1Family,
                                                                                      color: AppTheme.of(context).secondaryText,
                                                                                      fontSize: 20,
                                                                                      fontWeight: FontWeight.w600,
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
                                                    ]),
                                              )));
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
