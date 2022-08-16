import 'dart:io';
import 'package:bizpro_app/screens/inversiones/agregar_inversion_sugerida_screen.dart';
import 'package:bizpro_app/util/util.dart';
import 'package:flutter/material.dart';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_animations.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';


class InversionSugeridaTab extends StatefulWidget {

  final Emprendimientos emprendimiento;
  
  const InversionSugeridaTab({
    Key? key, 
    required this.emprendimiento
    }) : super(key: key);
    

  @override
  State<InversionSugeridaTab> createState() => _InversionSugeridaTabState();
}

class _InversionSugeridaTabState extends State<InversionSugeridaTab> 
with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

   @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductosEmp> productosEmp = [];
    double totalProyecto = 0;
    widget.emprendimiento.productosEmp.forEach((element) {
      productosEmp.add(element);
      totalProyecto += (element.costo * element.cantidad); 
    });
    return Align(
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
                  'Inversión del emprendimiento',
                  style: AppTheme.of(
                          context)
                      .bodyText1
                      .override(
                        fontFamily:
                            AppTheme.of(
                                    context)
                                .bodyText1Family,
                        fontSize: 20,
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
                                            '\$ $totalProyecto',
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
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          productosEmp.length.toString(),
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
                            await Navigator
                                .push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        AgregarInversionSugeridaScreen(emprendimiento: widget.emprendimiento,),
                              ),
                            );
                          },
                          text: 'Inversión',
                          icon: const Icon(
                            Icons.add,
                            size: 15,
                          ),
                          options:
                              FFButtonOptions(
                            width: 150,
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
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: productosEmp.length,
                        itemBuilder: (context, index) {
                          final productoEmp = productosEmp[index];
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
                                                      productoEmp.nombre,
                                                      style: AppTheme.of(context).subtitle1.override(
                                                            fontFamily: AppTheme.of(context).subtitle1Family,
                                                            color: AppTheme.of(context).primaryText,
                                                          ),
                                                    ),
                                                    Text(
                                                      'Und: ${productoEmp.cantidad}',
                                                      style: AppTheme.of(context).subtitle1.override(
                                                            fontFamily: AppTheme.of(context).subtitle1Family,
                                                            color: AppTheme.of(context).primaryText,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                    ),
                                                    Text(
                                                      "\$ ${productoEmp.costo * productoEmp.cantidad}",
                                                      textAlign: TextAlign.end,
                                                      style: AppTheme.of(context).subtitle2.override(
                                                            fontFamily: AppTheme.of(context).subtitle2Family,
                                                            color: AppTheme.of(context).primaryText,
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
                                                              productoEmp.familiaInversion.target?.nombre  ?? "SIN FAMILIA",
                                                              style: AppTheme.of(context).bodyText1.override(
                                                              fontFamily: AppTheme.of(context).bodyText1Family,
                                                              color: AppTheme.of(context).secondaryText,
                                                            ),
                                                            ),
                                                          Text(
                                                              dateTimeFormat('dd/MM/yyyy', productoEmp.fechaRegistro),
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
                                                      MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      productoEmp.descripcion,
                                                      style: AppTheme.of(context).bodyText1.override(
                                                            fontFamily: AppTheme.of(context).bodyText1Family,
                                                            color: AppTheme.of(context).secondaryText,
                                                          ),
                                                    ),
                                                    Text(
                                                      productoEmp.proveedor,
                                                      style: AppTheme.of(context).bodyText1.override(
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
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ).animated([
              animationsMap[
                  'containerOnPageLoadAnimation2']!
            ]),
          ),
        ],
      ),
    );
  }
}


