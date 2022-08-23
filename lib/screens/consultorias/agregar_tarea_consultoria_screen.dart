import 'dart:io';
import 'package:bizpro_app/database/entitys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/providers/database_providers/consultoria_controller.dart';
import 'package:bizpro_app/screens/consultorias/consultoria_creada.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_checkbox_group.dart';

import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class AgregarTareaConsultoriaScreen extends StatefulWidget {
  final Consultorias consultoria;
  final String numConsultoria;
  
  const AgregarTareaConsultoriaScreen({
    Key? key, 
    required this.consultoria,
    required this.numConsultoria, 
  }) : super(key: key);


  @override
  _AgregarTareaConsultoriaScreenState createState() => _AgregarTareaConsultoriaScreenState();
}

class _AgregarTareaConsultoriaScreenState extends State<AgregarTareaConsultoriaScreen> {
  TextEditingController fechaRevision = TextEditingController();
  List<String> checkboxGroupValues = [];
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fechaRevision = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final consultoriaProvider = Provider.of<ConsultoriaController>(context);
    String emprendedor = "";
    if (widget.consultoria.emprendimiento.target!.emprendedor.target != null) {
      emprendedor =
          "${widget.consultoria.emprendimiento.target!.emprendedor.target!.nombre} ${widget.consultoria.emprendimiento.target!.emprendedor.target!.apellidos}";
    }
    return Scaffold(
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
                      image: FileImage(File(widget.consultoria.emprendimiento.target!.imagen)),
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 45, 16, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      borderRadius:
                                          BorderRadius.circular(10),
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
                                            style:
                                                AppTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodyText1Family,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.consultoria.emprendimiento.target!.nombre,
                              maxLines: 1,
                              style: AppTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: AppTheme.of(context)
                                        .subtitle2Family,
                                    color: Colors.white,
                                    fontSize: 18,
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
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
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 0, 0),
                                      child: Text(
                                        "Consultoría ${widget.numConsultoria}",
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  AppTheme.of(context)
                                                      .bodyText1Family,
                                              color:
                                                  AppTheme.of(context)
                                                      .primaryText,
                                              fontSize: 18,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 0, 0),
                                      child: Text(
                                        emprendedor == "" ? "SIN EMPRENDEDOR" : emprendedor,
                                        style: AppTheme.of(context)
                                            .bodyText1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 0, 5),
                                      child: Text(
                                        widget.consultoria.emprendimiento.target!.nombre,
                                        style: AppTheme.of(context)
                                            .bodyText1,
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
                                textCapitalization: TextCapitalization.sentences,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                  consultoriaProvider.tarea = value;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Registrar Tarea*',
                                  labelStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Registro de tarea...',
                                  hintStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0x49FFFFFF),
                                ),
                                style: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                maxLines: 2,
                                validator: (value) {
                                return capitalizadoCharacters.hasMatch(value ?? '')
                                    ? null
                                    : 'Para continuar, ingrese la tarea empezando por mayúscula';
                                },
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  controller: fechaRevision,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onTap: () async {
                                    await DatePicker.showDatePicker(
                                      context,
                                      showTitleActions: true,
                                      onConfirm: (date) {
                                        setState(() {
                                          consultoriaProvider.fechaRevision = date;
                                          fechaRevision.text = dateTimeFormat('yMMMd', date);
                                        });
                                      },
                                      currentTime: getCurrentTimestamp,
                                      // minTime: getCurrentTimestamp,
                                    );
                                    
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Fecha de revisión*',
                                    labelStyle: AppTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: AppTheme.of(context)
                                              .secondaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintText: 'Ingresa fecha de revisión...',
                                    hintStyle: AppTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: AppTheme.of(context)
                                              .secondaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context)
                                            .primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context)
                                            .primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0x49FFFFFF),
                                  ),
                                  keyboardType: TextInputType.none,
                                  showCursor: false,
                                  style: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context)
                                            .primaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Para continuar, ingrese la fecha de revisión';
                                    }
                  
                                    return null;
                                  }
                                ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                              child: TextFormField(
                                textCapitalization: TextCapitalization.sentences,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                  consultoriaProvider.observacion = value;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Comentarios',
                                  labelStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Ingresa comentarios...',
                                  hintStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0x49FFFFFF),
                                ),
                                style: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                maxLines: 3,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                              child: TextFormField(
                                textCapitalization: TextCapitalization.sentences,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                  consultoriaProvider.descripcion = value;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Descripción*',
                                  labelStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Descripción...',
                                  hintStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0x49FFFFFF),
                                ),
                                style: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                maxLines: 3,
                                validator: (value) {
                                  return capitalizadoCharacters.hasMatch(value ?? '')
                                      ? null
                                      : 'Para continuar, ingrese la descripción empezando por mayúscula';
                                  },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 5, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: FlutterFlowCheckboxGroup(
                                      initiallySelected:
                                          !consultoriaProvider.activo,
                                      options: '¿Tarea Completada?',
                                      onChanged: (val) => setState(
                                          () {
                                            consultoriaProvider.activo = val;
                                            }),
                                      activeColor: AppTheme.of(context)
                                          .primaryColor,
                                      checkColor: Colors.white,
                                      checkboxBorderColor: const Color(0xFF95A1AC),
                                      textStyle: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily:
                                                AppTheme.of(context)
                                                    .bodyText1Family,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (consultoriaProvider
                                .validateForm(formKey)) {
                              // comunidadProvider.add();
                                print("Fecha revision ${consultoriaProvider.fechaRevision}");
                                print("Tarea ${consultoriaProvider.tarea}");
                                consultoriaProvider.addTareaConsultoria(widget.consultoria.id);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ConsultoriaCreada(),
                                  ),
                                );
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title:
                                        const Text('Campos vacíos'),
                                    content: const Text(
                                        'Para continuar, debe llenar los campos solicitados.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(
                                                alertDialogContext),
                                        child: const Text('Bien'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }
                          },
                          text: 'Crear',
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
                                  fontFamily: AppTheme.of(context)
                                      .subtitle2Family,
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
