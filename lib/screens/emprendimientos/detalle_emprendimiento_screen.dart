import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/globals.dart';

import 'package:expandable/expandable.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:bizpro_app/screens/consultorias/detalle_consultoria_screen.dart';
import 'package:bizpro_app/screens/jornadas/detalle_jornada_screen.dart';
import 'package:bizpro_app/screens/jornadas/agregar_jornada2_screen.dart';
import 'package:bizpro_app/screens/jornadas/agregar_jornada1_screen.dart';
import 'package:bizpro_app/screens/jornadas/agregar_jornada3_screen.dart';
import 'package:bizpro_app/screens/productos/agregar_producto_emprendedor.dart';
import 'package:bizpro_app/screens/inversiones/inversion.dart';
import 'package:bizpro_app/screens/ventas/ventas_screen.dart';
import 'package:bizpro_app/screens/jornadas/agregar_jornada4_screen.dart';
import 'package:bizpro_app/screens/consultorias/agregar_consultoria_screen.dart';
import 'package:bizpro_app/screens/emprendimientos/editar_emprendimiento.dart';

class DetalleEmprendimientoScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;

  const DetalleEmprendimientoScreen({
    Key? key,
    required this.emprendimiento,
  }) : super(key: key);

  @override
  State<DetalleEmprendimientoScreen> createState() =>
      _DetalleEmprendimientoScreenState();
}

class _DetalleEmprendimientoScreenState
    extends State<DetalleEmprendimientoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            //Imagen de fondo
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: AppTheme.of(context).secondaryBackground,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/bglogin2.png',
                ).image,
              ),
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          //Imagen de emprendimiento
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                    File(widget.emprendimiento.imagen)),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                            child: Container(
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
                            ),
                          ),

                          //Opciones superiores
                          Positioned(
                            left: 16,
                            top: 45,
                            right: 16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4672FF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Row(
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
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Container(
                                    width: 45,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4672FF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      onTap: () async {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          FaIcon(
                                            FontAwesomeIcons.fileArrowDown,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 45,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4672FF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditarEmprendimientoScreen(
                                                    emprendimiento:
                                                        widget.emprendimiento)),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Titulo de emprendimiento
                          Positioned.fill(
                            top: 100,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4672FF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  widget.emprendimiento.nombre,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      AppTheme.of(context).subtitle2.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            top: 150,
                            child: Align(
                              alignment: Alignment.center,
                              child: Material(
                                color: Colors.transparent,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xCF4672FF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                            },
                                            child: const FaIcon(
                                              Icons.pause_circle_outline,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          Text(
                                            'Detener',
                                            style:
                                                AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                    ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: ()  {
                            
                                            },
                                            child: const Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          Text(
                                            'Reactivar',
                                            style:
                                                AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                    ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                            },
                                            child: const FaIcon(
                                              Icons.file_download_outlined,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          Text(
                                            'Archivar',
                                            style:
                                                AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                    ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Detalles de emprendimiento
                      Padding(
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
                                                        jornada: jornada,
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
                                                          'Próxima visita: ${dateTimeFormat('dd/MM/yyyy', jornada.fechaRevision)}',
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
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: consultorias.length,
                                              itemBuilder: (context, index) {
                                                final consultoria =
                                                    consultorias[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          15, 10, 15, 0),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetalleConsultoriaScreen(
                                                            consultoria:
                                                                consultoria,
                                                            numConsultoria:
                                                                (index + 1)
                                                                    .toString(),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFF1F68CB),
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
                                                                'Consultoría No. ${index + 1}',
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
                                                              'Emprendedor: ${consultoria.emprendimiento.target?.emprendedor.target?.nombre ?? "Sin Emprendedor"}',
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
                                                              'Registro: ${dateTimeFormat('dd/MM/yyyy', consultoria.fechaRegistro)}',
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
                                              },
                                            );
                                          },
                                        ),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Menu inferior
                Positioned.fill(
                  bottom: 30,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Material(
                      color: Colors.transparent,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xCF4672FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (widget.emprendimiento.emprendedor
                                        .target !=
                                    null) {
                                  if (widget
                                      .emprendimiento.jornadas.isNotEmpty) {
                                    final int numJornada = int.parse(widget
                                        .emprendimiento
                                        .jornadas
                                        .last
                                        .numJornada);
                                    if (numJornada < 4) {
                                      switch (numJornada) {
                                        case 1:
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AgregarJornada2Screen(
                                                emprendimiento:
                                                    widget.emprendimiento,
                                                numJornada: numJornada + 1,
                                              ),
                                            ),
                                          );
                                          break;
                                        case 2:
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AgregarJornada3Screen(
                                                emprendimiento:
                                                    widget.emprendimiento,
                                                numJornada: numJornada + 1,
                                              ),
                                            ),
                                          );
                                          break;
                                        case 3:
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AgregarJornada4Screen(
                                                emprendimiento:
                                                    widget.emprendimiento,
                                                numJornada: numJornada + 1,
                                              ),
                                            ),
                                          );
                                          break;
                                        default:
                                      }
                                    } else {
                                      snackbarKey.currentState
                                          ?.showSnackBar(const SnackBar(
                                        content: Text(
                                            "No se pueden registrar más de 4 jornadas"),
                                      ));
                                    }
                                  } else {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AgregarJornada1Screen(
                                          emprendimiento:
                                              widget.emprendimiento,
                                          numJornada: 1,
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Necesitas registrar un emprendedor a este emprendimiento"),
                                  ));
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.calendarCheck,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Text(
                                    'Jornada',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 8,
                                            ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget
                                    .emprendimiento.jornadas.isNotEmpty) {
                                  final int numJornada = int.parse(widget
                                      .emprendimiento
                                      .jornadas
                                      .last
                                      .numJornada);
                                  if (numJornada == 4) {
                                    if (widget.emprendimiento.consultorias
                                        .isNotEmpty) {
                                      final int numConsultoria = widget
                                          .emprendimiento.consultorias
                                          .toList()
                                          .length;
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AgregarConsultoriaScreen(
                                            emprendimiento:
                                                widget.emprendimiento,
                                            numConsultoria:
                                                numConsultoria + 1,
                                          ),
                                        ),
                                      );
                                    } else {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AgregarConsultoriaScreen(
                                            emprendimiento:
                                                widget.emprendimiento,
                                            numConsultoria: 1,
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Necesitas tener 4 jornadas registradas"),
                                    ));
                                  }
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Necesitas tener 4 jornadas registradas"),
                                  ));
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Text(
                                    'Consultoría',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 8,
                                            ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget
                                    .emprendimiento.jornadas.isNotEmpty) {
                                  final int numJornada = int.parse(widget
                                      .emprendimiento
                                      .jornadas
                                      .last
                                      .numJornada);
                                  if (numJornada == 4) {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AgregarProductoEmprendedor(
                                            productosEmprendedor:
                                                widget.emprendimiento.productosEmp.toList(),
                                              emprendimiento: widget.emprendimiento,
                                          ),
                                        ),
                                      );
                                  } else {
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Necesitas tener 4 jornadas registradas"),
                                    ));
                                  }
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Necesitas tener 4 jornadas registradas"),
                                  ));
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.productHunt,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Text(
                                    'Productos',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 8,
                                            ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (widget
                                    .emprendimiento.productosEmp.isNotEmpty) {
                                    await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VentasScreen(
                                          ventas: 
                                          widget.emprendimiento.
                                            ventas.toList(),
                                          emprendimiento:
                                              widget.emprendimiento),
                                    ),
                                  );
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Para poder registrar una Venta es necesario que primero registres los productos del Emprendedor dentro del módulo 'Productos'"),
                                  ));
                                }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.stacked_line_chart_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Text(
                                    'Ventas',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 8,
                                            ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InversionScreen(
                                        emprendimiento:
                                            widget.emprendimiento),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.attach_money_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  Text(
                                    'Inversión',
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 8,
                                            ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
