import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/util/util.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizpro_app/screens/consultorias/editar_consultoria_screen.dart';
import 'package:bizpro_app/screens/consultorias/detalle_tarea_consultoria_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_animations.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_carousel.dart';

class DetalleConsultoriaScreen extends StatefulWidget {
  final Consultorias consultoria;
  final String numConsultoria;

  const DetalleConsultoriaScreen({
    Key? key,
    required this.consultoria,
    required this.numConsultoria,
  }) : super(key: key);

  @override
  _DetalleConsultoriaScreenState createState() =>
      _DetalleConsultoriaScreenState();
}

class _DetalleConsultoriaScreenState extends State<DetalleConsultoriaScreen>
    with TickerProviderStateMixin {
  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      hideBeforeAnimating: false,
      fadeIn: true,
      initialState: AnimationState(
        offset: const Offset(0, 70),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: const Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };
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
    List<Tareas> tareas = [];
    tareas = widget.consultoria.tareas.toList();
    print("Tareas: ${tareas.length}");
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Image.file(
                    File(widget.consultoria.emprendimiento.target!.imagen),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Color(0x51000000),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0x0014181B),
                            AppTheme.of(context).secondaryBackground
                          ],
                          stops: const [0, 1],
                          begin: const AlignmentDirectional(0, -1),
                          end: const AlignmentDirectional(0, 1),
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 45, 16, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).secondaryText,
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
                                      0, 0, 0, 10),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditarConsultoriaScreen(
                                            consultoria: widget.consultoria,
                                            numConsultoria:
                                                widget.numConsultoria, 
                                                tarea: widget.consultoria.tareas.last,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 45,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            AppTheme.of(context).secondaryText,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Icon(
                                            Icons.edit_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF4672FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                widget.consultoria.emprendimiento.target
                                        ?.nombre ??
                                    "SIN EMPRENDIMIENTO",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: const Color(0x554672FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Text(
                                  'Ámbito',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            fontSize: 15,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: AutoSizeText(
                                  widget.consultoria.ambitoConsultoria.target!
                                      .nombreAmbito,
                                  textAlign: TextAlign.start,
                                  maxLines: 4,
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Text(
                                  'Área del círculo',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            fontSize: 15,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Text(
                                  widget.consultoria.areaCirculo.target!
                                      .nombreArea,
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            fontWeight: FontWeight.w500,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Text(
                                  'Avance',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            fontSize: 15,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 5),
                                child: AutoSizeText(
                                  widget.consultoria.tareas.last.porcentaje.toString(),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Text(
                                  'Próxima visita',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            fontSize: 15,
                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 5),
                                child: AutoSizeText(
                                  dateTimeFormat('dd/MM/yyyy',
                                      widget.consultoria.tareas.last.fechaRevision),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                ),
                              ),
                              ListView.builder(
                                reverse: true,
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: tareas.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 8, 16, 12),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetalleTareaConsultoriaScreen(
                                              consultoria: widget.consultoria,
                                              tarea: tareas[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x2B202529),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(8, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              8, 0, 0, 4),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    0,
                                                                    10,
                                                                    0,
                                                                    0),
                                                            child: AutoSizeText(
                                                              tareas[index]
                                                                  .tarea,
                                                              maxLines: 2,
                                                              style: AppTheme.of(
                                                                      context)
                                                                  .subtitle1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Outfit',
                                                                    color: AppTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 10, 10, 0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFEEEEEE),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: const SizedBox(
                                                        width: 180,
                                                        height: 100,
                                                        child:
                                                            FlutterFlowCarousel(
                                                          width: 180,
                                                          height: 100,
                                                          listaImagenes:
                                                              [],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).animated([
                                        animationsMap[
                                            'containerOnPageLoadAnimation']!
                                      ]),
                                    ),
                                  );
                                },
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
      ),
    );
  }
}
