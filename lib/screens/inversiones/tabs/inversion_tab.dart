import 'dart:io';
import 'package:bizpro_app/providers/sync_provider_pocketbase.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/screens/inversiones/agregar_producto_inversion_screen.dart';
import 'package:bizpro_app/screens/inversiones/editar_producto_inversion.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_sincronizar_widget.dart';
//import 'package:bizpro_app/util/util.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_animations.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:provider/provider.dart';

class InversionTab extends StatefulWidget {
  final Emprendimientos emprendimiento;
  final Inversiones inversion;

  const InversionTab(
      {Key? key, required this.emprendimiento, required this.inversion})
      : super(key: key);

  @override
  State<InversionTab> createState() => _InversionTabState();
}

class _InversionTabState extends State<InversionTab>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final syncProviderPocketbase = Provider.of<SyncProviderPocketbase>(context);
    final List<ProdSolicitado> prodSolicitado = [];
    double totalProyecto = 0;
    for (var element in widget.inversion.prodSolicitados.toList()) {
      prodSolicitado.add(element);
      totalProyecto +=
          (element.cantidad.toDouble() * (element.costoEstimado ?? 0));
    }
    return SingleChildScrollView(
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
                    'Inversión del emprendimiento',
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: AppTheme.of(context).bodyText1Family,
                          fontSize: 20,
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
                          image: widget.emprendimiento.imagen.target != null ?
                          Image.file(
                            File(widget.emprendimiento.imagen.target!.path!),
                          ).image
                          :
                          Image.asset(
                            "assets/images/default_image_placeholder.jpeg",
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
                                10, 20, 10, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.87,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0x9C000000),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          maybeHandleOverflow(widget.emprendimiento.nombre, 30, "..."),
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: AppTheme.of(context)
                                                    .bodyText1Family,
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 5, 10, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0x9C000000),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 0, 0),
                                              child: Text(
                                                'Total del proyecto',
                                                style: AppTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily:
                                                          AppTheme.of(context)
                                                              .bodyText1Family,
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              currencyFormat.format(
                                                  totalProyecto
                                                      .toStringAsFixed(2)),
                                              style: AppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily:
                                                        AppTheme.of(context)
                                                            .bodyText1Family,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 60,
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
                                                .fromSTEB(0, 5, 0, 0),
                                            child: Text(
                                              'Cantidad Partidas',
                                              style: AppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily:
                                                        AppTheme.of(context)
                                                            .bodyText1Family,
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            prodSolicitado.length.toString(),
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      AppTheme.of(context)
                                                          .bodyText1Family,
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
                            'Partidas',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily:
                                      AppTheme.of(context).bodyText1Family,
                                  fontSize: 16,
                                ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              if (widget.emprendimiento.usuario.target!.rol
                                          .target!.rol !=
                                      "Amigo del Cambio" &&
                                  widget.emprendimiento.usuario.target!.rol
                                          .target!.rol !=
                                      "Emprendedor") {
                                if (widget.inversion.jornada3) {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "No se puede hacer seguimiento a esta inversión."),
                                  ));
                                } else {
                                  if (widget.inversion.estadoInversion.target!
                                              .estado ==
                                          "Solicitada" &&
                                      widget.inversion.idDBR == null) {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AgregarProductoInversionScreen(
                                          emprendimiento: widget.emprendimiento,
                                          inversion: widget.inversion,
                                        ),
                                      ),
                                    );
                                  } else {
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Ya no puedes agregar más productos."),
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
                            text: 'Producto',
                            icon: const Icon(
                              Icons.add,
                              size: 15,
                            ),
                            options: FFButtonOptions(
                              width: 150,
                              height: 35,
                              color: AppTheme.of(context).secondaryText,
                              textStyle: AppTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily:
                                        AppTheme.of(context).subtitle2Family,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
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
                          itemCount: prodSolicitado.length,
                          itemBuilder: (context, index) {
                            final productoSolicitado = prodSolicitado[index];
                            return InkWell(
                              onTap: () async {
                                if (widget.emprendimiento.usuario.target!.rol
                                            .target!.rol !=
                                        "Amigo del Cambio" &&
                                    widget.emprendimiento.usuario.target!.rol
                                            .target!.rol !=
                                        "Emprendedor") {
                                  if (widget.inversion.jornada3) {
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "No se puede hacer seguimiento a esta inversión."),
                                    ));
                                  } else {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditarProductoInversionScreen(
                                          inversion: widget.inversion,
                                          prodSolicitado: productoSolicitado,
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Este usuario no tiene permisos para esta acción."),
                                  ));
                                }
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
                                          color: const Color(0x374672FF),
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                                  color: AppTheme.of(context)
                                                      .secondaryBackground,
                                                  shape: BoxShape.circle,
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
                                                          AppTheme.of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily: AppTheme.of(
                                                                        context)
                                                                    .bodyText1Family,
                                                                fontSize: 20,
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
                                                          maybeHandleOverflow(productoSolicitado
                                                              .producto,15,"..."),
                                                          style:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        AppTheme.of(context)
                                                                            .bodyText1Family,
                                                                    color: AppTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                  ),
                                                        ),
                                                        Text(
                                                          dateTimeFormat(
                                                              'dd/MM/yyyy',
                                                              productoSolicitado
                                                                  .fechaRegistro),
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: AppTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily: AppTheme.of(
                                                                        context)
                                                                    .bodyText1Family,
                                                                color: AppTheme.of(
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
                                                            'Cantidad: ${productoSolicitado.cantidad}',
                                                            style: AppTheme.of(
                                                                    context)
                                                                .subtitle1
                                                                .override(
                                                                  fontFamily: AppTheme.of(
                                                                          context)
                                                                      .subtitle1Family,
                                                                  color: AppTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                          Text(
                                                            currencyFormat.format(
                                                                ((productoSolicitado.costoEstimado ??
                                                                            0) *
                                                                        productoSolicitado
                                                                            .cantidad)
                                                                    .toStringAsFixed(
                                                                        2)),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style:
                                                                AppTheme.of(
                                                                        context)
                                                                    .subtitle2
                                                                    .override(
                                                                      fontFamily:
                                                                          AppTheme.of(context)
                                                                              .subtitle2Family,
                                                                      color: AppTheme.of(
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
                                                          maybeHandleOverflow(productoSolicitado
                                                              .descripcion,13,"..."),
                                                          style:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        AppTheme.of(context)
                                                                            .bodyText1Family,
                                                                    color: AppTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                  ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          maybeHandleOverflow(productoSolicitado
                                                              .familiaProducto
                                                              .target!
                                                              .nombre,13,"..."),
                                                          style:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        AppTheme.of(context)
                                                                            .bodyText1Family,
                                                                    color: AppTheme.of(
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 12, 5, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              if (widget.emprendimiento.usuario.target!.rol
                                          .target!.rol !=
                                      "Amigo del Cambio" &&
                                  widget.emprendimiento.usuario.target!.rol
                                          .target!.rol !=
                                      "Emprendedor") {
                                if (widget.inversion.jornada3) {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "No se puede hacer seguimiento a esta inversión."),
                                  ));
                                } else {
                                  final connectivityResult =
                                      await (Connectivity()
                                          .checkConnectivity());
                                  final bitacora =
                                      dataBase.bitacoraBox.getAll().toList();
                                  print("Tamaño bitacora: ${bitacora.length}");
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.45,
                                          child: connectivityResult ==
                                                      ConnectivityResult.none ||
                                                  bitacora.isEmpty
                                              ? const BottomSheetSincronizarWidget(
                                                  isVisible: false,
                                                )
                                              : const BottomSheetSincronizarWidget(
                                                  isVisible: true,
                                                ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              } else {
                                snackbarKey.currentState
                                    ?.showSnackBar(const SnackBar(
                                  content: Text(
                                      "Este usuario no tiene permisos para esta acción."),
                                ));
                              }
                            },
                            text: 'Sincronizar',
                            icon: const Icon(
                              Icons.sync_rounded,
                              size: 18,
                            ),
                            options: FFButtonOptions(
                              width: 150,
                              height: 45,
                              color: AppTheme.of(context).secondaryText,
                              textStyle: AppTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily:
                                        AppTheme.of(context).subtitle2Family,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
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
              ).animated([animationsMap['containerOnPageLoadAnimation2']!]),
            ),
          ],
        ),
      ),
    );
  }
}
