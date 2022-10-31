import 'dart:io';
import 'package:bizpro_app/providers/sync_provider_emi_web.dart';
import 'package:bizpro_app/screens/sync/cotizaciones_emi_web_screen.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/screens/inversiones/cotizacion_aceptada.dart';
import 'package:bizpro_app/screens/inversiones/cotizacion_cancelada.dart';
import 'package:bizpro_app/screens/inversiones/cotizacion_solicitar_otra.dart';
import 'package:bizpro_app/providers/database_providers/cotizacion_controller.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_animations.dart';

class CotizacionTab extends StatefulWidget {

  final Emprendimientos emprendimiento;
  final Inversiones inversion;
  final InversionesXProdCotizados inversionesXprodCotizados;
  
  const CotizacionTab({
    Key? key, 
    required this.emprendimiento, 
    required this.inversion, 
    required this.inversionesXprodCotizados, 
    }) : super(key: key);
    

  @override
  State<CotizacionTab> createState() => _CotizacionTabState();
}

class _CotizacionTabState extends State<CotizacionTab> 
with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<ProdCotizados> productosCot = [];
  double totalProyecto = 0.00;

   @override
  void initState() {
    super.initState();
    productosCot = [];
    totalProyecto = 0.00;
    for (var element in widget.inversionesXprodCotizados.prodCotizados) {
      productosCot.add(element);
      totalProyecto += (element.costoTotal); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final syncProviderEmiWeb =
        Provider.of<SyncProviderEmiWeb>(context);
    final cotizacionProvider =
        Provider.of<CotizacionController>(context);
    return SingleChildScrollView(
      child: Align(
        alignment: const AlignmentDirectional(0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional
                  .fromSTEB(20, 10, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    'Cotización del emprendimiento',
                    style: AppTheme.of(
                            context)
                        .bodyText1
                        .override(
                          fontFamily:
                              AppTheme.of(
                                      context)
                                  .bodyText1Family,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional
                  .fromSTEB(0, 4, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 10,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              8),
                    ),
                    child: Container(
                      width:
                          MediaQuery.of(context)
                                  .size
                                  .width *
                              0.92,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.file(
                            File(widget.emprendimiento.imagen),
                            fit: BoxFit.contain,
                          ).image,
                        ),
                        boxShadow: const [
                           BoxShadow(
                            blurRadius: 6,
                            color: Color(
                                0x4B1A1F24),
                            offset:
                                Offset(0, 2),
                          )
                        ],
                        gradient:
                            const LinearGradient(
                          colors: [
                            Color(0xFF00968A),
                            Color(0xFFF2A384)
                          ],
                          stops: [0, 1],
                          begin:
                              AlignmentDirectional(
                                  0.94, -1),
                          end:
                              AlignmentDirectional(
                                  -0.94, 1),
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(8),
                      ),
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(
                                        10,
                                        20,
                                        10,
                                        0),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize
                                      .max,
                              children: [
                                Container(
                                  width: MediaQuery.of(
                                              context)
                                          .size
                                          .width *
                                      0.87,
                                  height: 40,
                                  decoration:
                                      BoxDecoration(
                                    color: const Color(
                                        0x9C000000),
                                    borderRadius:
                                        BorderRadius
                                            .circular(8),
                                  ),
                                  child:
                                      Padding(
                                    padding: const EdgeInsetsDirectional
                                        .fromSTEB(
                                            10,
                                            0,
                                            0,
                                            0),
                                    child: Row(
                                      mainAxisSize:
                                          MainAxisSize
                                              .max,
                                      children: [
                                        Text(
                                          widget.emprendimiento.nombre,
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: AppTheme.of(context).bodyText1Family,
                                                color: Colors.white,
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
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(
                                        10,
                                        5,
                                        10,
                                        0),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize
                                      .max,
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(
                                              context)
                                          .size
                                          .width *
                                      0.45,
                                  height: 60,
                                  decoration:
                                      BoxDecoration(
                                    color: const Color(
                                        0x9C000000),
                                    borderRadius:
                                        BorderRadius
                                            .circular(8),
                                  ),
                                  child:
                                      Padding(
                                    padding: const EdgeInsetsDirectional
                                        .fromSTEB(
                                            10,
                                            0,
                                            0,
                                            0),
                                    child: Row(
                                      mainAxisSize:
                                          MainAxisSize
                                              .max,
                                      children: [
                                        Column(
                                          mainAxisSize:
                                              MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                              child: Text(
                                                'Total del proyecto',
                                                style: AppTheme.of(context).bodyText1.override(
                                                      fontFamily: AppTheme.of(context).bodyText1Family,
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              currencyFormat.format(totalProyecto.toStringAsFixed(2)),
                                              style: AppTheme.of(context).bodyText1.override(
                                                    fontFamily: AppTheme.of(context).bodyText1Family,
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(
                                              context)
                                          .size
                                          .width *
                                      0.3,
                                  height: 60,
                                  decoration:
                                      BoxDecoration(
                                    color: const Color(
                                        0x9C000000),
                                    borderRadius:
                                        BorderRadius
                                            .circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize:
                                        MainAxisSize
                                            .max,
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                    children: [
                                      Column(
                                        mainAxisSize:
                                            MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                0,
                                                5,
                                                0,
                                                0),
                                            child:
                                                Text(
                                              'Cantidad Partidas',
                                              style: AppTheme.of(context).bodyText1.override(
                                                    fontFamily: AppTheme.of(context).bodyText1Family,
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            productosCot.length.toString(),
                                            style: AppTheme.of(context).bodyText1.override(
                                                  fontFamily: AppTheme.of(context).bodyText1Family,
                                                  color: Colors.white,
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
              ).animated([
                animationsMap[
                    'rowOnPageLoadAnimation1']!
              ]),
            ),
            Padding(
              padding: const EdgeInsetsDirectional
                  .fromSTEB(10, 0, 10, 0),
              child: Container(
                width: MediaQuery.of(context)
                    .size
                    .width,
                decoration: const BoxDecoration(
                  color: Color(0x004672FF),
                  borderRadius:
                      BorderRadius.only(
                    bottomLeft:
                        Radius.circular(0),
                    bottomRight:
                        Radius.circular(0),
                    topLeft:
                        Radius.circular(16),
                    topRight:
                        Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional
                              .fromSTEB(10, 12,
                                  5, 12),
                      child: Row(
                        mainAxisSize:
                            MainAxisSize.max,
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                        children: [
                          Text(
                            'Partidas',
                            style: AppTheme
                                    .of(context)
                                .bodyText1
                                .override(
                                  fontFamily: AppTheme.of(
                                          context)
                                      .bodyText1Family,
                                  fontSize: 16,
                                ),
                          ),
                          FFButtonWidget(
                            onPressed:
                                () async {
                                  if (widget.emprendimiento.usuario.target!.rol.target!.rol != "Amigo del Cambio" 
                                  && widget.emprendimiento.usuario.target!.rol.target!.rol != "Emprendedor") {
                                    if (widget.inversion.jornada3) {
                                      snackbarKey.currentState
                                          ?.showSnackBar(const SnackBar(
                                        content: Text(
                                            "No se puede hacer seguimiento a esta inversión."),
                                      ));
                                    } else {
                                        switch (widget.inversion.estadoInversion.target!.estado) {
                                        case "Solicitada":
                                          if(widget.inversion.idEmiWeb != null){
                                            final connectivityResult =
                                            await (Connectivity().checkConnectivity());
                                            if(connectivityResult == ConnectivityResult.none) {
                                              snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Necesitas conexión a internet para obtener la cotización."),
                                              ));
                                            }
                                            else {
                                              if (await syncProviderEmiWeb.validateCotizacionEmiWeb(widget.inversion)) {
                                                // ignore: use_build_context_synchronously
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => CotizacionesEmiWebScreen(
                                                          emprendimiento: widget.emprendimiento, 
                                                          inversion: widget.inversion,
                                                          inversionesXProdCotizados: widget.inversionesXprodCotizados,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                snackbarKey.currentState
                                                  ?.showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Aún no hay datos de cotización de esta inversión."),
                                                ));
                                              }
                                            }
                                            break;
                                          } else {
                                            snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                            content: Text(
                                                "Primero debes sincronizar tu información."),
                                            ));
                                            break;
                                          }
                                        case "En Cotización":
                                          snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                          content: Text(
                                              "Esta inversión ya ha sido cotizada."),
                                          ));
                                          break;
                                        case "Buscar Otra Cotización":
                                          snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                          content: Text(
                                              "Debes volver a sincronizar tu información."),
                                          ));
                                          break;
                                        default:
                                          break;
                                      }
                                    }
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Este usuario no tiene permisos para esta acción."),
                                  ));
                                }
                            },
                            text: 'Obtener Cotización',
                            icon: const Icon(
                              Icons.add,
                              size: 15,
                            ),
                            options:
                                FFButtonOptions(
                              width: 180,
                              height: 35,
                              color: AppTheme
                                      .of(context)
                                  .secondaryText,
                              textStyle:
                                  AppTheme.of(
                                          context)
                                      .subtitle2
                                      .override(
                                        fontFamily:
                                            AppTheme.of(context).subtitle2Family,
                                        color: Colors
                                            .white,
                                        fontSize:
                                            15,
                                      ),
                              borderSide:
                                  const BorderSide(
                                color: Colors
                                    .transparent,
                                width: 1,
                              ),
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          8),
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
                          itemCount: productosCot.length,
                          itemBuilder: (context, index) {
                            final productoCot = productosCot[index];
                            return Padding(
                              padding:
                                  const EdgeInsetsDirectional
                                      .fromSTEB(
                                          0, 0, 0, 24),
                              child: Column(
                                mainAxisSize:
                                    MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional
                                            .fromSTEB(
                                                0,
                                                0,
                                                0,
                                                8),
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
                                                .circular(
                                                    8),
                                      ),
                                      child: Row(
                                        mainAxisSize:
                                            MainAxisSize
                                                .max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(
                                                    15,
                                                    0,
                                                    0,
                                                    0),
                                            child:
                                                Container(
                                              width: 35,
                                              height:
                                                  35,
                                              decoration:
                                                  BoxDecoration(
                                                color: AppTheme.of(context)
                                                    .secondaryBackground,
                                                shape: BoxShape
                                                    .circle,
                                              ),
                                              child:
                                                  Column(
                                                mainAxisSize:
                                                    MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    (index + 1).toString(),
                                                    style: AppTheme.of(context).bodyText1.override(
                                                          fontFamily: AppTheme.of(context).bodyText1Family,
                                                          fontSize: 20,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child:
                                                Padding(
                                              padding: const EdgeInsetsDirectional.all(8),
                                              child:
                                                  Column(
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
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                          productoCot.productosProv.target!.nombre,
                                                          style: AppTheme.of(context).bodyText1.override(
                                                          fontFamily: AppTheme.of(context).bodyText1Family,
                                                          color: AppTheme.of(context).secondaryText,
                                                          ),
                                                        ),
                                                      Text(
                                                          dateTimeFormat('dd/MM/yyyy', productoCot.fechaRegistro),
                                                          textAlign:
                                                          TextAlign.end,
                                                          style: AppTheme.of(context).bodyText1.override(
                                                          fontFamily: AppTheme.of(context).bodyText1Family,
                                                          color: AppTheme.of(context).secondaryText,
                                                          fontSize: 12,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                                    child: Row(
                                                      mainAxisSize: 
                                                          MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Und: ${productoCot.productosProv.target?.unidadMedida.target?.unidadMedida ?? "SIN UND"}',
                                                              style: AppTheme.of(context).subtitle1.override(
                                                                    fontFamily: AppTheme.of(context).subtitle1Family,
                                                                    color: AppTheme.of(context).primaryText,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                            ),
                                                            Text(
                                                              currencyFormat.format((productoCot.costoTotal).toStringAsFixed(2)),
                                                              textAlign: TextAlign.end,
                                                              style: AppTheme.of(context).subtitle2.override(
                                                                    fontFamily: AppTheme.of(context).subtitle2Family,
                                                                    color: AppTheme.of(context).primaryText,
                                                                  ),
                                                            ),
                                                          ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                          maybeHandleOverflow(productoCot.productosProv.target!.descripcion,14,"..."),
                                                          style: AppTheme.of(context).bodyText1.override(
                                                                fontFamily: AppTheme.of(context).bodyText1Family,
                                                                color: AppTheme.of(context).secondaryText,
                                                              ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Text(
                                                          maybeHandleOverflow(productoCot.productosProv.target?.familiaProducto.target?.nombre ?? "SIN FAMILIA",13,"..."),
                                                          style: AppTheme.of(context).bodyText1.override(
                                                                fontFamily: AppTheme.of(context).bodyText1Family,
                                                                color: AppTheme.of(context).secondaryText,
                                                              ),
                                                          overflow: TextOverflow.ellipsis,
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
                            );
                          },
                        );
                      },
                    ),
                    Visibility(
                      visible: widget.inversion.estadoInversion.target!.estado == "En Cotización",
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
                                  if (widget.emprendimiento.usuario.target!.rol.target!.rol != "Amigo del Cambio"
                                  && widget.emprendimiento.usuario.target!.rol.target!.rol != "Emprendedor") {
                                    final connectivityResult =
                                      await (Connectivity().checkConnectivity());
                                    if(connectivityResult == ConnectivityResult.none) {
                                      snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Necesitas conexión a internet para aceptar la cotización."),
                                      ));
                                    } else
                                    {
                                      if (await cotizacionProvider.acceptCotizacion(
                                      widget.inversion,
                                      widget.inversionesXprodCotizados.id
                                      )) {
                                        // ignore: use_build_context_synchronously
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CotizacionAceptada(
                                              idEmprendimiento: widget.emprendimiento.id,
                                              ),
                                          ),
                                        );
                                      } else {
                                        snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                          content: Text(
                                              "No se pudo completar el proceso de aceptación, intente más tarde."),
                                        ));
                                      }
                                    }
                                  } else {
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Este usuario no tiene permisos para esta acción."),
                                    ));
                                  }
                                },
                                text: 'Aceptar',
                                icon: const Icon(
                                  Icons.check_circle_outlined,
                                  size: 15,
                                ),
                                options: FFButtonOptions(
                                  width: 150,
                                  height: 50,
                                  color: Colors.green,
                                  textStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
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
                                  if (widget.emprendimiento.usuario.target!.rol.target!.rol != "Amigo del Cambio"
                                  && widget.emprendimiento.usuario.target!.rol.target!.rol != "Emprendedor") {
                                    final connectivityResult =
                                      await (Connectivity().checkConnectivity());
                                    if(connectivityResult == ConnectivityResult.none) {
                                      snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Necesitas conexión a internet para cancelar la cotización."),
                                      ));
                                    } else
                                    {
                                      if (await cotizacionProvider.cancelCotizacion(
                                      widget.inversion,
                                      widget.inversionesXprodCotizados.id
                                      )) {
                                        // ignore: use_build_context_synchronously
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CotizacionCancelada(
                                              idEmprendimiento: widget.emprendimiento.id,
                                              ),
                                          ),
                                        );
                                      } else {
                                        snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                          content: Text(
                                              "No se pudo completar el proceso de cancelación, intente más tarde."),
                                        ));
                                      }
                                    }
                                   } else {
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Este usuario no tiene permisos para esta acción."),
                                    ));
                                  }
                                },
                                text: 'Rechazar',
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  size: 15,
                                ),
                                options: FFButtonOptions(
                                  width: 150,
                                  height: 50,
                                  color: const Color.fromARGB(228, 255, 82, 70),
                                  textStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  if (widget.emprendimiento.usuario.target!.rol.target!.rol != "Amigo del Cambio"
                                  && widget.emprendimiento.usuario.target!.rol.target!.rol != "Emprendedor") {
                                    final connectivityResult =
                                      await (Connectivity().checkConnectivity());
                                    if(connectivityResult == ConnectivityResult.none) {
                                      snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Necesitas conexión a internet para buscar Otra Cotización."),
                                      ));
                                    } else
                                    {
                                      if (await cotizacionProvider.buscarOtraCotizacion(
                                      widget.inversion,
                                      widget.inversionesXprodCotizados.id
                                      )) {
                                        // ignore: use_build_context_synchronously
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CotizacionSolicitarOtra(
                                              idEmprendimiento: widget.emprendimiento.id,
                                              ),
                                          ),
                                        );
                                      } else {
                                        snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                          content: Text(
                                              "No se pudo completar el proceso de búsqueda de otra cotización, intente más tarde."),
                                        ));
                                      }
                                    } 
                                  } else {
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Este usuario no tiene permisos para esta acción."),
                                    ));
                                  }
                                },
                                text: 'Solicitar otra cotización',
                                icon: const Icon(
                                  Icons.restart_alt_outlined,
                                  size: 15,
                                ),
                                options: FFButtonOptions(
                                  width: 200,
                                  height: 50,
                                  color: const Color(0xFF4672FF),
                                  textStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
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
                      ],),
                    )
                  ],
                ),
              ).animated([
                animationsMap[
                    'containerOnPageLoadAnimation2']!
              ]),
            ),
          ],
        ),
      ),
    );
  }
}


