import 'package:bizpro_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:google_fonts/google_fonts.dart';


class ReversoTarjetaDescripcionWidget extends StatefulWidget {
  final Emprendimientos emprendimiento;
  const ReversoTarjetaDescripcionWidget({
    Key? key, 
    required this.emprendimiento, 
    }) : super(key: key);

  @override
  State<ReversoTarjetaDescripcionWidget> createState() => _ReversoTarjetaDescripcionWidgetState();
}


class _ReversoTarjetaDescripcionWidgetState extends State<ReversoTarjetaDescripcionWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Inversiones? inversionJornada3;
  List<ProdSolicitado> listProdSolicitados = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (widget.emprendimiento.inversiones.isNotEmpty) {
        inversionJornada3 = widget.emprendimiento.inversiones.first;
        if (inversionJornada3 != null) {
        listProdSolicitados = inversionJornada3!.prodSolicitados.toList();
        }
      }
      else {
        inversionJornada3 = null;
        listProdSolicitados = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          15, 10, 15, 10),
      child: Container(
        width: double.infinity,
        height: 275,
        decoration: BoxDecoration(
          color: widget.emprendimiento.faseEmp.last.fase == "Detenido" ?
          const Color.fromARGB(207, 255, 64, 128)
          :
          widget.emprendimiento.faseEmp.last.fase == "Consolidado" ?
          const Color.fromARGB(207, 38, 128, 55)
          :
          const Color(0xB14672FF),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x32000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(
                        5, 5, 5, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Producto',
                          style: AppTheme.of(
                                  context)
                              .bodyText1
                              .override(
                                fontFamily:
                                    AppTheme.of(
                                            context)
                                        .bodyText1Family,
                                fontSize: 10,
                                useGoogleFonts: GoogleFonts
                                        .asMap()
                                    .containsKey(
                                        AppTheme.of(
                                                context)
                                            .bodyText1Family),
                                color: Colors.white
                              ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Proveedor \nSugerido',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(
                                  context)
                              .bodyText1
                              .override(
                                fontFamily:
                                    AppTheme.of(
                                            context)
                                        .bodyText1Family,
                                fontSize: 10,
                                useGoogleFonts: GoogleFonts
                                        .asMap()
                                    .containsKey(
                                        AppTheme.of(
                                                context)
                                            .bodyText1Family),
                                color: Colors.white
                              ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Marca \nSugerida',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(
                                  context)
                              .bodyText1
                              .override(
                                fontFamily:
                                    AppTheme.of(
                                            context)
                                        .bodyText1Family,
                                fontSize: 10,
                                useGoogleFonts: GoogleFonts
                                        .asMap()
                                    .containsKey(
                                        AppTheme.of(
                                                context)
                                            .bodyText1Family),
                                color: Colors.white
                              ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Unidad de \nmedida',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(
                                  context)
                              .bodyText1
                              .override(
                                fontFamily:
                                    AppTheme.of(
                                            context)
                                        .bodyText1Family,
                                fontSize: 10,
                                useGoogleFonts: GoogleFonts
                                        .asMap()
                                    .containsKey(
                                        AppTheme.of(
                                                context)
                                            .bodyText1Family),
                                color: Colors.white
                              ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Cantidad',
                          style: AppTheme.of(
                                  context)
                              .bodyText1
                              .override(
                                fontFamily:
                                    AppTheme.of(
                                            context)
                                        .bodyText1Family,
                                fontSize: 10,
                                useGoogleFonts: GoogleFonts
                                        .asMap()
                                    .containsKey(
                                        AppTheme.of(
                                                context)
                                            .bodyText1Family),
                                color: Colors.white
                              ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Costo\nEstimado',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(
                                  context)
                              .bodyText1
                              .override(
                                fontFamily:
                                    AppTheme.of(
                                            context)
                                        .bodyText1Family,
                                fontSize: 10,
                                useGoogleFonts: GoogleFonts
                                        .asMap()
                                    .containsKey(
                                        AppTheme.of(
                                                context)
                                            .bodyText1Family),
                                color: Colors.white
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(
                        0, 2, 0, 5),
                child: Container(
                  width: MediaQuery.of(context)
                          .size
                          .width *
                      0.92,
                  height: 1,
                  decoration: const BoxDecoration(
                    color:
                        Colors.white,
                  ),
                ),
              ),
              Builder(
                builder: (context) {
                  return ListView.builder(
                    controller: ScrollController(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listProdSolicitados.length,
                    itemBuilder: (context, resultadoIndex) {
                      final prodSolicitado =
                          listProdSolicitados[resultadoIndex];
                      return Padding(
                        padding: const EdgeInsetsDirectional
                            .fromSTEB(5, 5, 5, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Column(
                              mainAxisSize:
                                  MainAxisSize.max,
                              children: [
                                Text(
                                  prodSolicitado.producto,
                                  style:
                                      AppTheme.of(
                                              context)
                                          .bodyText1
                                          .override(
                                            fontFamily: AppTheme.of(
                                                    context)
                                                .bodyText1Family,
                                            fontSize: 10,
                                            fontWeight:
                                                FontWeight
                                                    .normal,
                                            useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                .containsKey(
                                                    AppTheme.of(context)
                                                        .bodyText1Family),
                                            color: Colors.white
                                          ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize:
                                  MainAxisSize.max,
                              children: [
                                Text(
                                  prodSolicitado.proveedorSugerido ?? "-",
                                  textAlign:
                                      TextAlign.center,
                                  style:
                                      AppTheme.of(
                                              context)
                                          .bodyText1
                                          .override(
                                            fontFamily: AppTheme.of(
                                                    context)
                                                .bodyText1Family,
                                            fontSize: 10,
                                            fontWeight:
                                                FontWeight
                                                    .normal,
                                            useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                .containsKey(
                                                    AppTheme.of(context)
                                                        .bodyText1Family),
                                            color: Colors.white
                                          ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize:
                                  MainAxisSize.max,
                              children: [
                                Text(
                                  prodSolicitado.marcaSugerida ?? "-",
                                  textAlign:
                                      TextAlign.center,
                                  style:
                                      AppTheme.of(
                                              context)
                                          .bodyText1
                                          .override(
                                            fontFamily: AppTheme.of(
                                                    context)
                                                .bodyText1Family,
                                            fontSize: 10,
                                            fontWeight:
                                                FontWeight
                                                    .normal,
                                            useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                .containsKey(
                                                    AppTheme.of(context)
                                                        .bodyText1Family),
                                            color: Colors.white
                                          ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize:
                                  MainAxisSize.max,
                              children: [
                                Text(
                                  prodSolicitado.unidadMedida.target?.unidadMedida ??
                                  "-",
                                  textAlign:
                                      TextAlign.center,
                                  style:
                                      AppTheme.of(
                                              context)
                                          .bodyText1
                                          .override(
                                            fontFamily: AppTheme.of(
                                                    context)
                                                .bodyText1Family,
                                            fontSize: 10,
                                            fontWeight:
                                                FontWeight
                                                    .normal,
                                            useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                .containsKey(
                                                    AppTheme.of(context)
                                                        .bodyText1Family),
                                            color: Colors.white
                                          ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize:
                                  MainAxisSize.max,
                              children: [
                                Text(
                                  prodSolicitado.cantidad.toString(),
                                  style:
                                      AppTheme.of(
                                              context)
                                          .bodyText1
                                          .override(
                                            fontFamily: AppTheme.of(
                                                    context)
                                                .bodyText1Family,
                                            fontSize: 10,
                                            fontWeight:
                                                FontWeight
                                                    .normal,
                                            useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                .containsKey(
                                                    AppTheme.of(context)
                                                        .bodyText1Family),
                                            color: Colors.white
                                          ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize:
                                  MainAxisSize.max,
                              children: [
                                Text(
                                  prodSolicitado.costoEstimado != null ? 
                                  currencyFormat.format(prodSolicitado.costoEstimado!.toStringAsFixed(2))
                                  :
                                  "-",
                                  textAlign:
                                      TextAlign.center,
                                  style:
                                      AppTheme.of(
                                              context)
                                          .bodyText1
                                          .override(
                                            fontFamily: AppTheme.of(
                                                    context)
                                                .bodyText1Family,
                                            fontSize: 10,
                                            fontWeight:
                                                FontWeight
                                                    .normal,
                                            useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                .containsKey(
                                                    AppTheme.of(context)
                                                        .bodyText1Family),
                                            color: Colors.white
                                          ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              ),
              Padding(
                padding: const EdgeInsetsDirectional
                    .fromSTEB(5, 5, 5, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                      MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisSize:
                          MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional
                                  .fromSTEB(0, 0,
                                      30, 0),
                          child: Text(
                            'TOTAL',
                            textAlign:
                                TextAlign.center,
                            style: AppTheme
                                    .of(context)
                                .bodyText1
                                .override(
                                  fontFamily: AppTheme.of(
                                          context)
                                      .bodyText1Family,
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                  useGoogleFonts: GoogleFonts
                                          .asMap()
                                      .containsKey(
                                          AppTheme.of(context)
                                              .bodyText1Family),
                                  color: Colors.white
                                ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize:
                          MainAxisSize.max,
                      children: [
                        Text(
                          inversionJornada3 != null ?
                          currencyFormat.format(inversionJornada3!.totalInversion.toStringAsFixed(2))
                          :
                          "-",
                          textAlign:
                              TextAlign.center,
                          style:
                              AppTheme.of(
                                      context)
                                  .bodyText1
                                  .override(
                                    fontFamily: AppTheme.of(
                                            context)
                                        .bodyText1Family,
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                    useGoogleFonts: GoogleFonts
                                            .asMap()
                                        .containsKey(
                                            AppTheme.of(context)
                                                .bodyText1Family),
                                    color: Colors.white
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
      ),
    );
  }
}


