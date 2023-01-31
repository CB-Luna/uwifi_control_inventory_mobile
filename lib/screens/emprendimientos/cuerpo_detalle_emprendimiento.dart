

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/providers/database_providers/consultoria_controller.dart';
import 'package:bizpro_app/screens/consultorias/consultoria_archivada_screen.dart';
import 'package:bizpro_app/screens/consultorias/consultoria_desarchivada_screen.dart';
import 'package:bizpro_app/screens/consultorias/widgets/tarjeta_descripcion_consultoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/jornadas/detalle_jornada_screen.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CuerpoDetalleEmprendimiento extends StatefulWidget {
  final Emprendimientos emprendimiento;
  const CuerpoDetalleEmprendimiento({
    Key? key, 
    required this.emprendimiento,
    }) : super(key: key);

  @override
  State<CuerpoDetalleEmprendimiento> createState() => _CuerpoDetalleEmprendimientoState();
}

class _CuerpoDetalleEmprendimientoState extends State<CuerpoDetalleEmprendimiento> {
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final consultoriaProvider = Provider.of<ConsultoriaController>(context);
    String emprendedor = "";
    if (widget.emprendimiento.emprendedor.target != null) {
      emprendedor =
          "${widget.emprendimiento.emprendedor.target!.nombre} ${widget.emprendimiento.emprendedor.target!.apellidos}";
    }
    final List<Jornadas> jornadas = [];
    for (var element in widget.emprendimiento.jornadas) {
      jornadas.add(element);
    }
    final List<Consultorias> consultorias = [];
    for (var element in widget.emprendimiento.consultorias) {
      consultorias.add(element);
    }
    return Padding(
      padding:
          const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0x00F2F4F8),
            ),
            child: Container(
              width: double.infinity,
              color: const Color(0x00F2F4F8),
              child: ExpandableNotifier(
                initialExpanded: false,
                child: ExpandablePanel(
                  header: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional
                            .fromSTEB(0, 0, 8, 0),
                        child: Icon(
                          Icons.info_rounded,
                          color: AppTheme.of(context)
                              .secondaryText,
                          size: 24,
                        ),
                      ),
                      Text(
                        'Detalles Emprendimiento',
                        style: AppTheme.of(context)
                            .title1
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .title1Family,
                              color: AppTheme.of(context)
                                  .primaryText,
                              fontSize: 20,
                            ),
                      ),
                    ],
                  ),
                  collapsed: const Divider(
                    thickness: 1.5,
                    color: Color(0xFF8B8B8B),
                  ),
                  expanded: Container(
                    width: MediaQuery.of(context).size.width *
                        0.9,
                    decoration: BoxDecoration(
                      color: const Color(0x1C4672FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(5, 0, 5, 0),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(0, 5, 0, 0),
                            child: Text(
                              'Descripción del emprendimiento',
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(0, 5, 0, 0),
                            child: AutoSizeText(
                              maybeHandleOverflow(
                                  widget.emprendimiento
                                      .descripcion,
                                  100,
                                  "..."),
                              textAlign: TextAlign.start,
                              maxLines: 4,
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontWeight:
                                        FontWeight.normal,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(0, 5, 0, 0),
                            child: Text(
                              'Emprendedor',
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(0, 5, 0, 0),
                            child: Text(
                              emprendedor == ""
                                  ? 'SIN EMPRENDEDOR'
                                  : emprendedor,
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontWeight:
                                        FontWeight.w500,
                                  ),
                            ),
                          ),
                          // getImage(widget.emprendimiento.emprendedor.target?.imagen ?? null)!,
                          Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(0, 5, 0, 0),
                            child: Text(
                              'Fecha de creación',
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(0, 5, 0, 5),
                            child: AutoSizeText(
                              dateTimeFormat(
                                  'dd/MM/yyyy',
                                  widget.emprendimiento
                                      .fechaRegistro),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontWeight:
                                        FontWeight.normal,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(0, 5, 0, 0),
                            child: Text(
                              'Creado por promotor',
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(0, 5, 0, 5),
                            child: AutoSizeText(
                              "${usuarioProvider.usuarioCurrent!.nombre} ${usuarioProvider.usuarioCurrent!.apellidoP}",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontWeight:
                                        FontWeight.normal,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    headerAlignment:
                        ExpandablePanelHeaderAlignment.center,
                    hasIcon: true,
                    iconColor:
                        AppTheme.of(context).secondaryText,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0x00F2F4F8),
            ),
            child: Container(
              width: double.infinity,
              color: const Color(0x00F2F4F8),
              child: ExpandableNotifier(
                initialExpanded: false,
                child: ExpandablePanel(
                  header: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional
                            .fromSTEB(0, 0, 8, 0),
                        child: FaIcon(
                          FontAwesomeIcons.calendarCheck,
                          color: AppTheme.of(context)
                              .secondaryText,
                          size: 20,
                        ),
                      ),
                      Text(
                        'Jornadas',
                        style: AppTheme.of(context)
                            .title1
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .title1Family,
                              color: AppTheme.of(context)
                                  .primaryText,
                              fontSize: 20,
                            ),
                      ),
                    ],
                  ),
                  collapsed: const Divider(
                    thickness: 1.5,
                    color: Color(0xFF8B8B8B),
                  ),
                  expanded: Builder(
                    builder: (context) {
                      return ListView.builder(
                        controller: ScrollController(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: jornadas.length,
                        itemBuilder: (context, index) {
                          final jornada = jornadas[index];
                          return Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(15, 10, 15, 0),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetalleJornadaScreen(
                                      jornada: jornada,empActual: widget.emprendimiento,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF1F68CB),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color:
                                          Color(0x32000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius:
                                      BorderRadius.circular(
                                          8),
                                ),
                                child: Column(
                                  mainAxisSize:
                                      MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional
                                                  .fromSTEB(
                                              16, 5, 16, 5),
                                      child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                0, 5, 0, 0),
                                        child: Text(
                                          'Jornada No. ${jornada.numJornada.toString()}',
                                          maxLines: 1,
                                          style: AppTheme.of(
                                                  context)
                                              .title3
                                              .override(
                                                fontFamily:
                                                    'Poppins',
                                                color: Colors
                                                    .white,
                                                fontSize: 18,
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
                                              16, 0, 16, 5),
                                      child: Text(
                                        'Emprendedor: ${jornada.emprendimiento.target?.emprendedor.target?.nombre ?? "Sin Emprendedor"}',
                                        maxLines: 1,
                                        style: AppTheme.of(
                                                context)
                                            .bodyText2
                                            .override(
                                              fontFamily:
                                                  'Poppins',
                                              color: Colors
                                                  .white,
                                              fontSize: 13,
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
                                              16, 0, 16, 5),
                                      child: Text(
                                        'Próxima visita: ${dateTimeFormat('d/MMMM/y', jornada.fechaRevision)}',
                                        maxLines: 1,
                                        style: AppTheme.of(
                                                context)
                                            .bodyText2
                                            .override(
                                              fontFamily:
                                                  'Poppins',
                                              color: Colors
                                                  .white,
                                              fontSize: 13,
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
                        },
                      );
                    },
                  ),
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    headerAlignment:
                        ExpandablePanelHeaderAlignment.center,
                    hasIcon: true,
                    iconColor:
                        AppTheme.of(context).secondaryText,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0x00F2F4F8),
            ),
            child: Container(
              width: double.infinity,
              color: const Color(0x00F2F4F8),
              child: IgnorePointer(
                ignoring: widget.emprendimiento.usuario.target!.rol.target!.rol == "Voluntario Estratégico",
                child: ExpandableNotifier(
                  initialExpanded: false,
                  child: ExpandablePanel(
                    header: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional
                              .fromSTEB(0, 0, 8, 0),
                          child: Icon(
                            Icons.folder_rounded,
                            color: AppTheme.of(context)
                                .secondaryText,
                            size: 24,
                          ),
                        ),
                        Text(
                          'Consultorías',
                          style: AppTheme.of(context)
                              .title1
                              .override(
                                fontFamily: AppTheme.of(context)
                                    .title1Family,
                                color: AppTheme.of(context)
                                    .primaryText,
                                fontSize: 20,
                              ),
                        ),
                      ],
                    ),
                    collapsed: const Divider(
                      thickness: 1.5,
                      color: Color(0xFF8B8B8B),
                    ),
                    expanded: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(
                          builder: (context) {
                            return ListView.builder(
                              controller: ScrollController(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: consultorias.length,
                              itemBuilder: (context, index) {
                                final consultoria =
                                    consultorias[index];
                                return 
                                consultoria.archivado ? 
                                Slidable(
                                    startActionPane: ActionPane(
                                      motion: const DrawerMotion(), 
                                      children: [
                                        SlidableAction(
                                          label: "Desarchivar",
                                          icon: Icons.file_upload_outlined,
                                          backgroundColor: const Color(0xFFBA0000),
                                          onPressed: (context) async {
                                            if (usuarioProvider.usuarioCurrent!.rol.target!.rol == "Administrador" ||
                                                usuarioProvider.usuarioCurrent!.rol.target!.rol == "Promotor") {
                                                consultoriaProvider.desarchivarConsultoria(consultoria.id, widget.emprendimiento.id);
                                                await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                builder: (context) =>
                                                      ConsultoriaDesarchivadaScreen(idEmprendimiento: widget.emprendimiento.id,),
                                                    ),
                                                );
                                            } else {
                                              snackbarKey.currentState
                                                    ?.showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Este usuario no tiene permisos para esta acción."),
                                                ));
                                            }
                                          }
                                        ),
                                      ]),
                                    child: Stack(
                                      children: [
                                        TarjetaDescripcionConsultoria(
                                          consultoria: consultoria,
                                          index: index, 
                                          backgroundColor: const Color(0xFFBA0000)),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                  15, 10, 15, 10),
                                          child: Container(
                                            width: 40,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              gradient:
                                                  const LinearGradient(
                                                colors: [
                                                  Color.fromARGB(46, 207, 207, 207),
                                                  Color(0xFFBA0000),
                                                ],
                                                stops: [0, 1],
                                                begin:
                                                    Alignment.centerLeft,
                                                end:
                                                    Alignment.centerRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8),
                                            ),
                                            child: const Icon(
                                              Icons.double_arrow_rounded,
                                              size: 65,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                )
                                :
                                Slidable(
                                    startActionPane: ActionPane(
                                      motion: const DrawerMotion(), 
                                      children: [
                                        SlidableAction(
                                          label: "Archivar",
                                          icon: Icons.file_download_outlined,
                                          backgroundColor: const Color(0xFF1F68CB),
                                          onPressed: (context) async {
                                            if (usuarioProvider.usuarioCurrent!.rol.target!.rol == "Administrador" ||
                                                usuarioProvider.usuarioCurrent!.rol.target!.rol == "Promotor") {
                                                consultoriaProvider.archivarConsultoria(consultoria.id, widget.emprendimiento.id);
                                                await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                builder: (context) =>
                                                      ConsultoriaArchivadaScreen(idEmprendimiento: widget.emprendimiento.id,),
                                                    ),
                                                );
                                            } else {
                                              snackbarKey.currentState
                                                    ?.showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Este usuario no tiene permisos para esta acción."),
                                                ));
                                            }
                                          }
                                        ),
                                      ]),
                                    child: Stack(
                                      children: [
                                        TarjetaDescripcionConsultoria(
                                          consultoria: consultoria,
                                          index: index, 
                                          backgroundColor: const Color(0xFF1F68CB)),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                  15, 10, 15, 10),
                                          child: Container(
                                            width: 40,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              gradient:
                                                  const LinearGradient(
                                                colors: [
                                                  Color.fromARGB(46, 207, 207, 207),
                                                  Color(0xFF1F68CB),
                                                ],
                                                stops: [0, 1],
                                                begin:
                                                    Alignment.centerLeft,
                                                end:
                                                    Alignment.centerRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8),
                                            ),
                                            child: const Icon(
                                              Icons.double_arrow_rounded,
                                              size: 65,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                )
                                ;
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 120,
                        )
                      ],
                    ),
                    theme: ExpandableThemeData(
                      tapHeaderToExpand: true,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      headerAlignment:
                          ExpandablePanelHeaderAlignment.center,
                      hasIcon: true,
                      iconColor:
                          AppTheme.of(context).secondaryText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}