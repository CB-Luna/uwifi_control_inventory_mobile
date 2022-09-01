import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/providers/database_providers/consultoria_controller.dart';


import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DetalleTareaConsultoriaScreen extends StatefulWidget {
  final Consultorias consultoria;
  final Tareas tarea;

  const DetalleTareaConsultoriaScreen({
    Key? key,
    required this.consultoria,
    required this.tarea,
  }) : super(key: key);

  @override
  _DetalleTareaConsultoriaScreenState createState() =>
      _DetalleTareaConsultoriaScreenState();
}

class _DetalleTareaConsultoriaScreenState
    extends State<DetalleTareaConsultoriaScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late bool activoController;

  @override
  void initState() {
    super.initState();
    activoController = widget.tarea.activo;
  }

  @override
  Widget build(BuildContext context) {
    String emprendedor = "";
    if (widget.consultoria.emprendimiento.target!.emprendedor.target != null) {
      emprendedor =
          "${widget.consultoria.emprendimiento.target!.emprendedor.target!.nombre} ${widget.consultoria.emprendimiento.target!.emprendedor.target!.apellidos}";
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(widget
                              .consultoria.emprendimiento.target!.imagen)),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 45, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 10),
                                    child: Container(
                                      width: 80,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            AppTheme.of(context).secondaryText,
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
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4672FF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  widget.consultoria.emprendimiento.target!
                                      .nombre,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 16, 15, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: const Color(0x554672FF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 5, 0, 0),
                                        child: Text(
                                          emprendedor == ""
                                              ? "SIN EMPRENDEDOR"
                                              : emprendedor,
                                          style: AppTheme.of(context).bodyText1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 5, 0, 5),
                                        child: Text(
                                          widget.consultoria.emprendimiento
                                              .target!.nombre,
                                          style: AppTheme.of(context).bodyText1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  initialValue: widget.tarea.tarea,
                                  enabled: false,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Tarea asignada*',
                                    labelStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    hintText: 'Tarea asignada...',
                                    hintStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Poppins',
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0x49FFFFFF),
                                  ),
                                  style: AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  maxLines: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  initialValue: widget.tarea.observacion,
                                  enabled: false,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Avance observado',
                                    labelStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    hintText: 'Ingresa avance observado...',
                                    hintStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Poppins',
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0x49FFFFFF),
                                  ),
                                  style: AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  maxLines: 3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  initialValue: widget.tarea.porcentaje.toString(),
                                  enabled: false,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Porcentaje de avance',
                                    labelStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    hintText: 'Ingresa porcentaje de avance...',
                                    hintStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Poppins',
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0x49FFFFFF),
                                  ),
                                  style: AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                    initialValue: dateTimeFormat('yMMMd', widget.tarea.fechaRevision),
                                    enabled: false,
                                    readOnly: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Fecha de revisión*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingresa fecha de revisión...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    keyboardType: TextInputType.none,
                                    showCursor: false,
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsetsDirectional.fromSTEB(
                              //       5, 0, 5, 10),
                              //   child: Row(
                              //     mainAxisSize: MainAxisSize.max,
                              //     children: [
                              //       Expanded(
                              //         child: FlutterFlowCheckboxGroup(
                              //           initiallySelected: !activoController,
                              //           options: '¿Tarea Completada?',
                              //           onChanged: (val) => setState(() {
                              //             print(val);
                              //             activoController = val;
                              //             print(activoController);
                              //           }),
                              //           activeColor:
                              //               AppTheme.of(context).primaryColor,
                              //           checkColor: Colors.white,
                              //           checkboxBorderColor:
                              //               const Color(0xFF95A1AC),
                              //           textStyle: AppTheme.of(context)
                              //               .bodyText1
                              //               .override(
                              //                 fontFamily: AppTheme.of(context)
                              //                     .bodyText1Family,
                              //                 fontWeight: FontWeight.w500,
                              //               ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
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
