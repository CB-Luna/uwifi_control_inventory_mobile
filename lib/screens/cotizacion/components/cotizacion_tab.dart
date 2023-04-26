import 'dart:io';

import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_animations.dart';

class CotizacionTab extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;

  const CotizacionTab({
    Key? key,
    required this.ordenTrabajo,
  }) : super(key: key);

  @override
  State<CotizacionTab> createState() => _CotizacionTabState();
}

class _CotizacionTabState extends State<CotizacionTab>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Servicio> servicios = [];
  double totalProyecto = 0.00;

  @override
  void initState() {
    super.initState();
    widget.ordenTrabajo.ordenServicio.target?.servicios.toList().forEach((element) {
      if (element.autorizado) {
        servicios.add(element);
      }
    });
    totalProyecto = widget.ordenTrabajo.ordenServicio.target?.costoTotal ?? 0.00;
  }

  @override
  Widget build(BuildContext context) {
    totalProyecto = widget.ordenTrabajo.ordenServicio.target?.costoTotal ?? 0.00;
    servicios.clear();
    widget.ordenTrabajo.ordenServicio.target?.servicios.toList().forEach((element) {
      if (element.autorizado) {
        servicios.add(element);
      }
    });
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
          child: SingleChildScrollView(
            child: Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cotización de la Orden de Servicio',
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: FlutterFlowTheme.of(context).title1Family,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
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
                            width: MediaQuery.of(context).size.width * 0.92,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: widget.ordenTrabajo.vehiculo.target?.path == null ?
                                Image.asset(
                                        "assets/images/default_image_placeholder.jpeg",
                                      ).image
                                :
                                Image.file(
                                      File(widget.ordenTrabajo.vehiculo.target!.path),
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
                                colors: [Color(0xFF00968A), Color(0xFFF2A384)],
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 20, 10, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: const Color(0x9C000000),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 10, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  maybeHandleOverflow(
                                                      "${widget
                                                      .ordenTrabajo
                                                      .vehiculo
                                                      .target?.modelo}-${
                                                      widget
                                                      .ordenTrabajo
                                                      .vehiculo
                                                      .target?.marca}",
                                                      30,
                                                      "..."),
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: FlutterFlowTheme.of(context)
                                                            .bodyText1Family,
                                                        color: FlutterFlowTheme.of(context).white,
                                                        fontSize: 20,
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
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          height: 65,
                                          decoration: BoxDecoration(
                                            color: const Color(0x9C000000),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 10, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 5, 0, 5),
                                                  child: Text(
                                                    'Total del servicio',
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(context)
                                                                  .bodyText1Family,
                                                          color: FlutterFlowTheme.of(context).white,
                                                          fontSize: 15,
                                                        ),
                                                  ),
                                                ),
                                                Text(
                                                  maybeHandleOverflow(currencyFormat.format(
                                                      totalProyecto
                                                          .toStringAsFixed(2)), 11, "..."),
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(context)
                                                                .bodyText1Family,
                                                        color: FlutterFlowTheme.of(context).white,
                                                        fontSize: 30,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          height: 65,
                                          decoration: BoxDecoration(
                                            color: const Color(0x9C000000),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .fromSTEB(0, 5, 0, 5),
                                                    child: Text(
                                                      'Cantidad Servicios',
                                                      style: FlutterFlowTheme.of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(context)
                                                                    .bodyText1Family,
                                                            color: FlutterFlowTheme.of(context).white,
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${widget
                                                      .ordenTrabajo
                                                      .ordenServicio
                                                      .target?.
                                                      servicios
                                                      .toList()
                                                      .length.toString()}",
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(context)
                                                                  .bodyText1Family,
                                                          color: FlutterFlowTheme.of(context).white,
                                                          fontSize: 30,
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).animated([animationsMap['rowOnPageLoadAnimation1']!]),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
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
                                const EdgeInsetsDirectional.fromSTEB(10, 12, 5, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Servicios',
                                  style: FlutterFlowTheme.of(context).bodyText1.override(
                                        fontFamily:
                                            FlutterFlowTheme.of(context).bodyText1Family,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              return ListView.builder(
                                controller: ScrollController(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: servicios.length,
                                itemBuilder: (context, index) {
                                  final servicio = servicios[index];
                                  double totalProductos = 0.0;
                                  servicio.productos.toList().forEach((element) {
                                    totalProductos += element.costo;
                                  },);
                                  return InkWell(
                                    onTap: () async {
                                      // await Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => DetalleCotizacion(
                                      //         detalleCot: productoCot),
                                      //   ),
                                      // );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 24),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 8),
                                            child: Container(
                                              width:
                                                  MediaQuery.of(context).size.width *
                                                      0.92,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(context).white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    blurRadius: 6,
                                                    color: Color(0x4B1A1F24),
                                                    offset: Offset(0, 2),
                                                  )
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(15, 0, 0, 0),
                                                    child: Container(
                                                      width: 35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme.of(context)
                                                            .primaryColor,
                                                        shape: BoxShape.circle,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            blurRadius: 6,
                                                            color: Color(0x4B1A1F24),
                                                            offset: Offset(0, 2),
                                                          )
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            (index + 1).toString(),
                                                            style:
                                                                FlutterFlowTheme.of(context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1Family,
                                                                      fontSize: 20,
                                                                      color: FlutterFlowTheme.of(context).white
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
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                servicio
                                                                  .servicio,
                                                                style:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context)
                                                                                  .bodyText1Family,
                                                                          color: FlutterFlowTheme.of(
                                                                                  context)
                                                                              .secondaryText,
                                                                        ),
                                                              ),
                                                              Text(
                                                                dateTimeFormat(
                                                                    'd/MMMM/y',
                                                                    servicio
                                                                      .fechaEntrega),
                                                                textAlign:
                                                                    TextAlign.end,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyText1Family,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize: 12,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize.max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Productos: ${servicio.productos.toList().length}',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtitle1
                                                                      .override(
                                                                        fontFamily: FlutterFlowTheme.of(
                                                                                context)
                                                                            .subtitle1Family,
                                                                        color: FlutterFlowTheme.of(
                                                                                context)
                                                                            .primaryText,
                                                                        fontSize: 15,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  currencyFormat.format(
                                                                      (servicio
                                                                        .costoServicio)
                                                                          .toStringAsFixed(
                                                                              2)),
                                                                  textAlign:
                                                                      TextAlign.end,
                                                                  style:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .subtitle2
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context)
                                                                                    .subtitle2Family,
                                                                            color: FlutterFlowTheme.of(
                                                                                    context)
                                                                                .primaryText,
                                                                          ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                maybeHandleOverflow(
                                                                  "Total Productos: ${currencyFormat.format(
                                                                    (totalProductos)
                                                                        .toStringAsFixed(
                                                                            2))}",
                                                                    40,
                                                                    "..."),
                                                                style:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context)
                                                                                  .bodyText1Family,
                                                                          color: FlutterFlowTheme.of(
                                                                                  context)
                                                                              .secondaryText,
                                                                        ),
                                                                overflow: TextOverflow
                                                                    .ellipsis,
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
                          Visibility(
                            visible: servicios.isEmpty ? false : true ,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: () async {
                                        },
                                        text: 'Aceptar',
                                        icon: const Icon(
                                          Icons.check_circle_outlined,
                                          size: 15,
                                        ),
                                        options: FFButtonOptions(
                                          width: 150,
                                          height: 50,
                                          color: FlutterFlowTheme.of(context).primaryColor,
                                          textStyle:
                                              FlutterFlowTheme.of(context).title3.override(
                                                    fontFamily: 'Poppins',
                                                    color: FlutterFlowTheme.of(context).white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                          elevation: 3,
                                          borderSide: const BorderSide(
                                            color: Color(0x002CC3F4),
                                            width: 0,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      FFButtonWidget(
                                        onPressed: () async {
                                        },
                                        text: 'Cancelar Cotización',
                                        icon: const Icon(
                                          Icons.cancel_outlined,
                                          size: 15,
                                        ),
                                        options: FFButtonOptions(
                                          width: 170,
                                          height: 50,
                                          color:
                                              FlutterFlowTheme.of(context).primaryText,
                                          textStyle:
                                              FlutterFlowTheme.of(context).title3.override(
                                                    fontFamily: 'Poppins',
                                                    color: FlutterFlowTheme.of(context).white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                          elevation: 3,
                                          borderSide: const BorderSide(
                                            color: Color(0x002CC3F4),
                                            width: 0,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ).animated([animationsMap['containerOnPageLoadAnimation2']!]),
                  ),
                ],
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }
}
