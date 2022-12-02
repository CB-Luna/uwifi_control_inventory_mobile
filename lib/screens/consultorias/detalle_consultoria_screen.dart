import 'dart:io';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_expanded_image_view.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/util/util.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizpro_app/screens/consultorias/editar_consultoria_screen.dart';
import 'package:bizpro_app/screens/consultorias/detalle_tarea_consultoria_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_animations.dart';

class DetalleConsultoriaScreen extends StatefulWidget {
  final Consultorias consultoria;
  final String numConsultoria;
  final Emprendimientos emprendimientoActual;

  const DetalleConsultoriaScreen({
    Key? key,
    required this.consultoria,
    required this.numConsultoria, required this.emprendimientoActual,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    widget.consultoria.emprendimiento.target?.imagen.target?.path != null ?
                    Image.file(
                      File(widget.consultoria.emprendimiento.target!.imagen.target!.path!),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                    :
                    Image.asset(
                      "assets/images/default_image_placeholder.jpeg",
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
                                        print("Tareas totales de consultoria: ${widget.consultoria.tareas.toList().length}");
                                        if (widget.consultoria.emprendimiento.target!.usuario.target!.rol.target!.rol == "Amigo del Cambio" ||
                                            widget.consultoria.emprendimiento.target!.usuario.target!.rol.target!.rol == "Emprendedor") {
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
                                                  EditarConsultoriaScreen(
                                                consultoria: widget.consultoria,
                                                numConsultoria:
                                                    widget.numConsultoria, 
                                                    tarea: widget.consultoria.tareas.last, 
                                                emprendimientoEditar: widget.emprendimientoActual,
                                              ),
                                            ),
                                          );
                                        }
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
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 40),
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
                                    widget.consultoria.tareas.last.porcentaje.target!.porcentajeAvance.toString(),
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
                                // Padding(
                                //   padding: const EdgeInsetsDirectional.fromSTEB(
                                //       0, 5, 0, 0),
                                //   child: Text(
                                //     'Tarea Principal',
                                //     style:
                                //         AppTheme.of(context).bodyText1.override(
                                //               fontFamily: AppTheme.of(context)
                                //                   .bodyText1Family,
                                //               fontSize: 15,
                                //             ),
                                //   ),
                                // ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsetsDirectional.fromSTEB(
                                //           16, 8, 16, 12),
                                //   child: InkWell(
                                //     onTap: () async {
                                //       await Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) =>
                                //               DetalleTareaConsultoriaScreen(
                                //             consultoria: widget.consultoria,
                                //             tarea: tareas.first,
                                //           ),
                                //         ),
                                //       );
                                //     },
                                //     child: Container(
                                //       width: double.infinity,
                                //       height: 120,
                                //       decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         boxShadow: const [
                                //           BoxShadow(
                                //             blurRadius: 4,
                                //             color: Color(0x2B202529),
                                //             offset: Offset(0, 2),
                                //           )
                                //         ],
                                //         borderRadius:
                                //             BorderRadius.circular(12),
                                //       ),
                                //       child: Column(
                                //         mainAxisSize: MainAxisSize.max,
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.start,
                                //         children: [
                                //           Padding(
                                //             padding:
                                //                 const EdgeInsetsDirectional
                                //                     .fromSTEB(8, 0, 0, 0),
                                //             child: Row(
                                //               mainAxisSize: MainAxisSize.max,
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               children: [
                                //                 Expanded(
                                //                   child: Padding(
                                //                     padding:
                                //                         const EdgeInsetsDirectional
                                //                                 .fromSTEB(
                                //                             8, 0, 0, 4),
                                //                     child: Column(
                                //                       mainAxisSize:
                                //                           MainAxisSize.max,
                                //                       mainAxisAlignment:
                                //                           MainAxisAlignment
                                //                               .center,
                                //                       crossAxisAlignment:
                                //                           CrossAxisAlignment
                                //                               .start,
                                //                       children: [
                                //                         Padding(
                                //                           padding:
                                //                               const EdgeInsetsDirectional
                                //                                       .fromSTEB(
                                //                                   0,
                                //                                   10,
                                //                                   0,
                                //                                   0),
                                //                           child: AutoSizeText(
                                //                             tareas.first
                                //                                 .tarea,
                                //                             maxLines: 2,
                                //                             style: AppTheme.of(
                                //                                     context)
                                //                                 .subtitle1
                                //                                 .override(
                                //                                   fontFamily:
                                //                                       'Outfit',
                                //                                   color: AppTheme.of(
                                //                                           context)
                                //                                       .primaryText,
                                //                                   fontSize:
                                //                                       20,
                                //                                   fontWeight:
                                //                                       FontWeight
                                //                                           .w500,
                                //                                 ),
                                //                           ),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                   ),
                                //                 ),
                                //                 Padding(
                                //                   padding:
                                //                       const EdgeInsetsDirectional
                                //                               .fromSTEB(
                                //                           0, 10, 10, 0),
                                //                   child: Container(
                                //                     width:
                                //                         MediaQuery.of(context)
                                //                                 .size
                                //                                 .width *
                                //                             0.4,
                                //                     height: 100,
                                //                     decoration: BoxDecoration(
                                //                       color: const Color(0x554672FF),
                                //                       borderRadius: BorderRadius.circular(8),
                                //                       border: Border.all(
                                //                         width: 1.5,           
                                //                       ),
                                //                     ),
                                //                     child: InkWell(
                                //                       onTap: () async {
                                //                         if (tareas.first.imagenes.last.imagenes != "") {
                                //                           await Navigator.push(
                                //                           context,
                                //                           PageTransition(
                                //                             type: PageTransitionType.fade,
                                //                             child:
                                //                                 FlutterFlowExpandedImageView(
                                //                               image: getWidgetContainImage(
                                //                                 tareas.first.imagenes.last.imagenes
                                //                               ),
                                //                               allowRotation: false,
                                //                               tag: tareas.first.imagenes.last.imagenes,
                                //                               useHeroAnimation: true,
                                //                             ),
                                //                           ),
                                //                         );
                                //                         }
                                //                       },
                                //                       child: Hero(
                                //                         tag: tareas.first.imagenes.last.imagenes,
                                //                         transitionOnUserGestures: true,
                                //                         child: ClipRRect(
                                //                           borderRadius:
                                //                               BorderRadius.circular(8),
                                //                           child: 
                                //                           getWidgetContainerImage(
                                //                             tareas.first.imagenes.last.imagenes, 
                                //                             170, 
                                //                             120,
                                //                             ),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ).animated([
                                //       animationsMap[
                                //           'containerOnPageLoadAnimation']!
                                //     ]),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Text(
                                    'Tarea Principal',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontSize: 15,
                                            ),
                                  ),
                                ),
                                Padding(
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
                                            tarea: tareas.first,
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
                                                            tareas.first
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
                                                // Padding(
                                                //   padding:
                                                //       const EdgeInsetsDirectional
                                                //               .fromSTEB(
                                                //           0, 10, 10, 0),
                                                //   child: Container(
                                                //     width:
                                                //         MediaQuery.of(context)
                                                //                 .size
                                                //                 .width *
                                                //             0.4,
                                                //     height: 100,
                                                //     decoration: BoxDecoration(
                                                //       color: const Color(0x554672FF),
                                                //       borderRadius: BorderRadius.circular(8),
                                                //       border: Border.all(
                                                //         width: 1.5,           
                                                //       ),
                                                //     ),
                                                //     child: InkWell(
                                                //       onTap: () async {
                                                //         if (tareas.first.imagenes.last.imagenes != "") {
                                                //           await Navigator.push(
                                                //           context,
                                                //           PageTransition(
                                                //             type: PageTransitionType.fade,
                                                //             child:
                                                //                 FlutterFlowExpandedImageView(
                                                //               image: getWidgetContainImage(
                                                //                 tareas.first.imagenes.last.imagenes
                                                //               ),
                                                //               allowRotation: false,
                                                //               tag: tareas.first.imagenes.last.imagenes,
                                                //               useHeroAnimation: true,
                                                //             ),
                                                //           ),
                                                //         );
                                                //         }
                                                //       },
                                                //       child: Hero(
                                                //         tag: tareas.first.imagenes.last.imagenes,
                                                //         transitionOnUserGestures: true,
                                                //         child: ClipRRect(
                                                //           borderRadius:
                                                //               BorderRadius.circular(8),
                                                //           child: 
                                                //           getWidgetContainerImage(
                                                //             tareas.first.imagenes.last.imagenes, 
                                                //             170, 
                                                //             120,
                                                //             ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
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
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Text(
                                    'SubTareas',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontSize: 15,
                                            ),
                                  ),
                                ),
                                (tareas.length  - 1 ) == 0 ?
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 10),
                                  child: Text(
                                    "Sin SubTareas",
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontWeight: FontWeight.w500,
                                            ),
                                  ),
                                )
                                :
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: tareas.length - 1,
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
                                                tarea: tareas[index + 1],
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
                                                                tareas[index + 1]
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
                                                          color: const Color(0x554672FF),
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(
                                                            width: 1.5,           
                                                          ),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            if (tareas[index + 1].imagenes.last.imagenes != "") {
                                                              await Navigator.push(
                                                              context,
                                                              PageTransition(
                                                                type: PageTransitionType.fade,
                                                                child:
                                                                    FlutterFlowExpandedImageView(
                                                                  image: getWidgetContainImage(
                                                                    tareas[index + 1].imagenes.last.imagenes
                                                                  ),
                                                                  allowRotation: false,
                                                                  tag: tareas[index + 1].imagenes.last.imagenes,
                                                                  useHeroAnimation: true,
                                                                ),
                                                              ),
                                                            );
                                                            }
                                                          },
                                                          child: Hero(
                                                            tag: tareas[index + 1].imagenes.isNotEmpty ?
                                                            tareas[index + 1].imagenes.last.imagenes :
                                                             "No image",
                                                            transitionOnUserGestures: true,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(8),
                                                              child: 
                                                              getWidgetContainerImage(
                                                                tareas[index + 1].imagenes.isNotEmpty ?
                                                                tareas[index + 1].imagenes.last.imagenes :
                                                                null, 
                                                                170, 
                                                                120,
                                                                ),
                                                            ),
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
      ),
    );
  }
}
