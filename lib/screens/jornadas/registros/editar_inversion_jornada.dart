import 'dart:io';
import 'package:bizpro_app/providers/database_providers/producto_inversion_jornada_controller.dart';
import 'package:bizpro_app/screens/jornadas/editar_jornada3_screen.dart';
import 'package:bizpro_app/screens/jornadas/registros/agregar_producto_inversion_jornada.dart';
import 'package:bizpro_app/screens/jornadas/registros/editar_producto_inversion_jornada.dart';
import 'package:bizpro_app/screens/jornadas/registros/inversion_jornada3_actualizada.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_animations.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:provider/provider.dart';

class EditarInversionJornadaScreen extends StatefulWidget {
  final List<ProdSolicitado> prodSolicitados;
  final Jornadas jornada;
  final Emprendimientos emprendimiento;
  final Inversiones inversion;
  const EditarInversionJornadaScreen({
    Key? key,
    required this.prodSolicitados, 
    required this.jornada, 
    required this.emprendimiento,
    required this.inversion,
  }) : super(key: key);

  @override
  _EditarInversionJornadaScreenState createState() =>
      _EditarInversionJornadaScreenState();
}

class _EditarInversionJornadaScreenState
    extends State<EditarInversionJornadaScreen> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double totalProyecto = 0.0;
  
  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
    for (var element in widget.prodSolicitados) {
      totalProyecto += (element.costoEstimado == null
          ? 0
          : element.costoEstimado! * element.cantidad);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productoInversionJornadaProvider = Provider.of<ProductoInversionJornadaController>(context);
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
                SingleChildScrollView(
                  child: Align(
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
                                    productoInversionJornadaProvider.clearInformation();
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditarJornada3Screen(
                                                jornada:
                                                    widget.jornada, emprendimiento: widget.emprendimiento,),
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
                                      'Inversión sugerida',
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
                                              File(widget.emprendimiento
                                                  .imagen.target!.path!),
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
                                                            widget
                                                                .emprendimiento
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
                                                              Text(
                                                                currencyFormat.format(totalProyecto.toStringAsFixed(2)),
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
                                                              widget.prodSolicitados
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
                                                        AgregarProductoInversionJornadaScreen(
                                                          emprendimiento: 
                                                              widget.emprendimiento,
                                                          jornada: 
                                                              widget.jornada,
                                                          inversion: 
                                                              widget.inversion,
                                                          emprendedor: 
                                                              "${widget.emprendimiento
                                                                .emprendedor.target!.nombre} ${widget
                                                                .emprendimiento.emprendedor
                                                                .target!.apellidos}",
                                                          porcentajePago:
                                                              widget.inversion
                                                              .porcentajePago.toString(),
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
                                            controller: ScrollController(),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: widget.prodSolicitados.length,
                                            itemBuilder: (context, index) {
                                              final prodSolicitado =
                                                  widget.prodSolicitados[index];
                                              return InkWell(
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditarProductoInversionJornada(
                                                              productoSol:
                                                                  prodSolicitado, 
                                                              jornada: 
                                                                  widget.jornada,
                                                              emprendimientoActual: widget.emprendimiento,
                                                              inversion: 
                                                                  widget.inversion,),
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
                                                                            prodSolicitado
                                                                                .producto,
                                                                            style: AppTheme.of(context)
                                                                                .subtitle1
                                                                                .override(
                                                                                  fontFamily: AppTheme.of(context).subtitle1Family,
                                                                                  color: AppTheme.of(context).primaryText,
                                                                                ),
                                                                          ),
                                                                           Text(
                                                                            prodSolicitado.tipoEmpaques.target?.tipo ?? "SIN TIPO EMPAQUE",
                                                                            style: AppTheme.of(context)
                                                                                .subtitle1
                                                                                .override(
                                                                                  fontFamily: AppTheme.of(context).subtitle1Family,
                                                                                  color: AppTheme.of(context).primaryText,
                                                                                  fontSize: 18,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                          ),
                                                                          Text(
                                                                            "\$ ${prodSolicitado.costoEstimado == null ? 0 : (prodSolicitado.costoEstimado! * prodSolicitado.cantidad).toStringAsFixed(2)}",
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: AppTheme.of(context)
                                                                                .subtitle2
                                                                                .override(
                                                                                  fontFamily: AppTheme.of(context).subtitle2Family,
                                                                                  color: AppTheme.of(context).primaryText,
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
                                                                              prodSolicitado.familiaProducto.target!.nombre,
                                                                              style: AppTheme.of(context).bodyText1.override(
                                                                                    fontFamily: AppTheme.of(context).bodyText1Family,
                                                                                    color: AppTheme.of(context).secondaryText,
                                                                                  ),
                                                                            ),
                                                                            Text(
                                                                              dateTimeFormat('dd/MM/yyyy',
                                                                                  prodSolicitado.fechaRegistro),
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
                                                                            prodSolicitado
                                                                                .descripcion,
                                                                            style: AppTheme.of(context)
                                                                                .bodyText1
                                                                                .override(
                                                                                  fontFamily: AppTheme.of(context).bodyText1Family,
                                                                                  color: AppTheme.of(context).secondaryText,
                                                                                ),
                                                                          ),
                                                                          Text(
                                                                            prodSolicitado.proveedorSugerido ??
                                                                                "",
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 10),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            productoInversionJornadaProvider
                                              .updateProductosInversionJ3(widget.inversion);
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InversionJornada3Actualizada(idEmprendimiento: widget.emprendimiento.id,),
                                              ),
                                            );
                                          },
                                          text: 'Actualizar',
                                          icon: const Icon(
                                            Icons.check_rounded,
                                            size: 15,
                                          ),
                                          options: FFButtonOptions(
                                            width: 130,
                                            height: 40,
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
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      )
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
