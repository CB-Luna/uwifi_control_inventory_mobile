import 'dart:io';
import 'package:bizpro_app/screens/ventas/editar_venta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/providers/database_providers/producto_venta_controller.dart';
import 'package:bizpro_app/providers/database_providers/venta_controller.dart';
import 'package:bizpro_app/screens/ventas/agregar_producto_venta.dart';
import 'package:bizpro_app/screens/ventas/editar_producto_venta.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_animations.dart';
import 'package:bizpro_app/theme/theme.dart';

class RegistroVentaScreen extends StatefulWidget {
  final Ventas venta;
  final Emprendimientos emprendimiento;
  const RegistroVentaScreen({
    Key? key,
    required this.venta, 
    required this.emprendimiento,
  }) : super(key: key);

  @override
  _RegistroVentaScreenState createState() =>
      _RegistroVentaScreenState();
}

class _RegistroVentaScreenState
    extends State<RegistroVentaScreen> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final productoVentaController =
        Provider.of<ProductoVentaController>(context);
    final ventaController =
        Provider.of<VentaController>(context);
    List<ProdVendidos> productosVendidos =
        widget.venta.prodVendidos.toList();
    List<String> nombreProductosVendidos = [];
    List<ProdVendidos> prodRegistradosVendidos = [];
    double totalProyecto = 0;
    ventaController.total = "";
    for (var element in productosVendidos) {
      prodRegistradosVendidos.add(element);
      nombreProductosVendidos.add(element.productoEmp.target?.nombre ?? "SIN NOMBRE");
      totalProyecto += (element.subtotal);
    }
    ventaController.total = totalProyecto.toString();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: AppTheme.of(context).secondaryBackground,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/bglogin2.png',
                  ).image,
                ),
              ),
            ),
            Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
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
                                          EditarVentaScreen(
                                            venta: widget.venta,
                                            idEmp: widget.emprendimiento ,
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
                                            fontFamily: AppTheme.of(context)
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
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Color(0x004672FF),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                        ).animated(
                            [animationsMap['containerOnPageLoadAnimation1']!]),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 10, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Productos vendidos',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontSize: 20,
                                            ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 4, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.92,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.file(
                                            File(widget.venta.emprendimiento.target!.imagen),
                                            fit: BoxFit.contain,
                                          ).image,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 6,
                                            color: Color(0x4B1A1F24),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF00968A),
                                            Color(0xFFF2A384)
                                          ],
                                          stops: [0, 1],
                                          begin: AlignmentDirectional(0.94, -1),
                                          end: AlignmentDirectional(-0.94, 1),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 20, 10, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.87,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0x9C000000),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            10, 0, 0, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          widget.venta
                                                              .emprendimiento
                                                              .target!
                                                              .nombre,
                                                          style: AppTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily: AppTheme.of(
                                                                        context)
                                                                    .bodyText1Family,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 5, 10, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0x9C000000),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            10, 0, 0, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      0,
                                                                      5,
                                                                      0,
                                                                      0),
                                                              child: Text(
                                                                'Total del proyecto',
                                                                style: AppTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          AppTheme.of(context)
                                                                              .bodyText1Family,
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                              ),
                                                            ),
                                                            Text(currencyFormat.format(totalProyecto.toStringAsFixed(2)),
                                                              style: AppTheme.of(
                                                                      context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        AppTheme.of(context)
                                                                            .bodyText1Family,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        25,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0x9C000000),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    0, 5, 0, 0),
                                                            child: Text(
                                                              'Cantidad Partidas',
                                                              style: AppTheme.of(
                                                                      context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        AppTheme.of(context)
                                                                            .bodyText1Family,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                            ),
                                                          ),
                                                          Text(
                                                            prodRegistradosVendidos
                                                                .length
                                                                .toString(),
                                                            style: AppTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily: AppTheme.of(
                                                                          context)
                                                                      .bodyText1Family,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 25,
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ).animated(
                                  [animationsMap['rowOnPageLoadAnimation1']!]),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 10, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0x004672FF),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 12, 5, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Partidas',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      AppTheme.of(context)
                                                          .bodyText1Family,
                                                  fontSize: 16,
                                                ),
                                          ),
                                          FFButtonWidget(
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AgregarProductoVenta(
                                                        emprendimiento: widget.venta.emprendimiento.target!,
                                                        prodRegistradosVendidos: nombreProductosVendidos,
                                                        idVenta: widget.venta.id,
                                                      ),
                                                ),
                                              );
                                            },
                                            text: 'Producto',
                                            icon: const Icon(
                                              Icons.add,
                                              size: 15,
                                            ),
                                            options: FFButtonOptions(
                                              width: 150,
                                              height: 35,
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              textStyle: AppTheme.of(context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily:
                                                        AppTheme.of(context)
                                                            .subtitle2Family,
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Builder(
                                      builder: (context) {
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: prodRegistradosVendidos.length,
                                          itemBuilder: (context, index) {
                                            final prodVendido =
                                                prodRegistradosVendidos[index];
                                            return InkWell(
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditarProductoVenta(
                                                          emprendimiento: 
                                                                widget.venta.emprendimiento.target!,
                                                          prodVendido:
                                                                prodVendido, 
                                                          venta: 
                                                                widget.venta,),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 24),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              0, 0, 0, 8),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.92,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0x374672FF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                      15,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Container(
                                                                width: 35,
                                                                height: 35,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      (index +
                                                                              1)
                                                                          .toString(),
                                                                      style: AppTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                AppTheme.of(context).bodyText1Family,
                                                                            fontSize:
                                                                                20,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .all(8),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          prodVendido
                                                                              .productoEmp.target?.nombre ?? "SIN NOMBRE",
                                                                          style: AppTheme.of(context)
                                                                              .subtitle1
                                                                              .override(
                                                                                fontFamily: AppTheme.of(context).subtitle1Family,
                                                                                color: AppTheme.of(context).primaryText,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          'Und: ${prodVendido.
                                                                                  productoEmp.
                                                                                  target?.
                                                                                  unidadMedida.target?.unidadMedida ?? "SIN UNIDADES"}',
                                                                          style: AppTheme.of(context)
                                                                              .subtitle1
                                                                              .override(
                                                                                fontFamily: AppTheme.of(context).subtitle1Family,
                                                                                color: AppTheme.of(context).primaryText,
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              5),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "Cantidad Vendida: ${prodVendido.cantVendida}",
                                                                            style: AppTheme.of(context)
                                                                                .bodyText1
                                                                                .override(
                                                                                  fontFamily: AppTheme.of(context).bodyText1Family,
                                                                                  color: AppTheme.of(context).secondaryText,
                                                                                ),
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize
                                                                                    .max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment
                                                                                    .end,
                                                                            children: [
                                                                              Text(
                                                                                    "Inicio: ${dateTimeFormat('dd/MM/yyyy',
                                                                                        widget.venta.fechaInicio)}",
                                                                                    textAlign:
                                                                                        TextAlign.end,
                                                                                    style: AppTheme.of(context).bodyText1.override(
                                                                                          fontFamily: AppTheme.of(context).bodyText1Family,
                                                                                          color: AppTheme.of(context).secondaryText,
                                                                                          fontSize: 12,
                                                                                        ),
                                                                                  ),
                                                                              Text(
                                                                                    "Termino: ${dateTimeFormat('dd/MM/yyyy',
                                                                                        widget.venta.fechaTermino)}",
                                                                                    textAlign:
                                                                                        TextAlign.end,
                                                                                    style: AppTheme.of(context).bodyText1.override(
                                                                                          fontFamily: AppTheme.of(context).bodyText1Family,
                                                                                          color: AppTheme.of(context).primaryText,
                                                                                          fontSize: 12,
                                                                                        ),
                                                                                  ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          "Precio:  ${currencyFormat.format(prodVendido
                                                                                    .precioVenta
                                                                                    .toStringAsFixed(2))}) ",
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style: AppTheme.of(context)
                                                                              .subtitle2
                                                                              .override(
                                                                                fontFamily: AppTheme.of(context).subtitle2Family,
                                                                                color: AppTheme.of(context).primaryText,
                                                                              ),
                                                                        ),
                                                                        Text(
                                                                          "Subtotal:  ${currencyFormat.format(prodVendido
                                                                                    .subtotal
                                                                                    .toStringAsFixed(2))}",
                                                                          style: AppTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: AppTheme.of(context).bodyText1Family,
                                                                                color: AppTheme.of(context).secondaryText,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
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
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ).animated([
                                animationsMap['containerOnPageLoadAnimation2']!
                              ]),
                            ),
                          ],
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
    );
  }
}
