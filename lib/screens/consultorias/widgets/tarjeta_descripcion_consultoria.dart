import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/screens/consultorias/detalle_consultoria_screen.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';


class TarjetaDescripcionConsultoria extends StatefulWidget {
  final Consultorias consultoria;
  final int index;
  final Color backgroundColor;
  const TarjetaDescripcionConsultoria({
    Key? key, 
    required this.consultoria,
    required this.index,
    required this.backgroundColor,
    }) : super(key: key);

  @override
  State<TarjetaDescripcionConsultoria> createState() => _TarjetaDescripcionConsultoriaState();
}

class _TarjetaDescripcionConsultoriaState extends State<TarjetaDescripcionConsultoria> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsetsDirectional
                  .fromSTEB(
              15, 10, 15, 10),
      child: InkWell(
        onTap: () async {
          if (widget.consultoria.archivado) {
            snackbarKey.currentState
                ?.showSnackBar(const SnackBar(
              content: Text(
                  "La consultoría está archivada y no es posible ver su contenido."),
            ));
          } else {
            await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetalleConsultoriaScreen(
                consultoria:
                    widget.consultoria,
                numConsultoria:
                    (widget.index + 1)
                        .toString(), 
                        emprendimientoActual: widget.consultoria.emprendimiento.target!,
              ),
            ),
          );
          }
        },
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Color(
                    0x32000000),
                offset:
                    Offset(0, 2),
              )
            ],
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
                        16,
                        5,
                        16,
                        5),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional
                              .fromSTEB(
                          0,
                          5,
                          0,
                          0),
                  child: Text(
                    'Consultoría No. ${widget.index + 1}',
                    maxLines: 1,
                    style: AppTheme.of(
                            context)
                        .title3
                        .override(
                          fontFamily:
                              'Poppins',
                          color: Colors
                              .white,
                          fontSize:
                              18,
                          fontWeight:
                              FontWeight
                                  .w500,
                        ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional
                            .fromSTEB(
                        16,
                        0,
                        16,
                        5),
                child: Text(
                  'Ámbito: ${widget.consultoria.ambitoConsultoria.target?.nombreAmbito ?? "Sin Ámbito"}',
                  maxLines: 1,
                  style: AppTheme.of(
                          context)
                      .bodyText2
                      .override(
                        fontFamily:
                            'Poppins',
                        color: Colors
                            .white,
                        fontSize:
                            13,
                        fontWeight:
                            FontWeight
                                .normal,
                      ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional
                            .fromSTEB(
                        16,
                        0,
                        16,
                        5),
                child: Text(
                  'Área Círculo: ${widget.consultoria.areaCirculo.target?.nombreArea ?? "Sin Área Círculo"}',
                  maxLines: 1,
                  style: AppTheme.of(
                          context)
                      .bodyText2
                      .override(
                        fontFamily:
                            'Poppins',
                        color: Colors
                            .white,
                        fontSize:
                            13,
                        fontWeight:
                            FontWeight
                                .normal,
                      ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional
                            .fromSTEB(
                        16,
                        0,
                        16,
                        5),
                child: Text(
                  'Registro: ${dateTimeFormat('dd/MM/yyyy', widget.consultoria.fechaRegistro)}',
                  maxLines: 1,
                  style: AppTheme.of(
                          context)
                      .bodyText2
                      .override(
                        fontFamily:
                            'Poppins',
                        color: Colors
                            .white,
                        fontSize:
                            13,
                        fontWeight:
                            FontWeight
                                .normal,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


