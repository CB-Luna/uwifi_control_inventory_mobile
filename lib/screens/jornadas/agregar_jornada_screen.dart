import 'package:bizpro_app/screens/jornadas/jornada_creada.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/util/util.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AgregarJornadaScreen extends StatefulWidget {
  const AgregarJornadaScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AgregarJornadaScreenState createState() => _AgregarJornadaScreenState();
}

class _AgregarJornadaScreenState extends State<AgregarJornadaScreen> {
  DateTime datePicked1 = DateTime.now();
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  List<String> checkboxGroupValue = [];
  DateTime datePicked2 = DateTime.now();
  final formKey1 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey5 = GlobalKey<FormState>();
  final formKey6 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController4 = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
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
                      Image.asset(
                        "assets/images/bglogin2.png",
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color(0x51000000),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0x0014181B),
                                AppTheme.of(context).secondaryBackground
                              ],
                              stops: [0, 1],
                              begin: AlignmentDirectional(0, -1),
                              end: AlignmentDirectional(0, 1),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 45, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
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
                                              Icon(
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
                                  "SIN TEXTO",
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
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                key: formKey4,
                                autovalidateMode: AutovalidateMode.always,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    controller: textController1,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Número de jornada*',
                                      labelStyle: AppTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: AppTheme.of(context)
                                                .secondaryText,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      hintText: 'Ingresa jornada...',
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
                                      fillColor: Colors.white,
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
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Field is required';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Form(
                                key: formKey1,
                                autovalidateMode: AutovalidateMode.always,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    controller: textController2,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Emprendedor*',
                                      labelStyle: AppTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: AppTheme.of(context)
                                                .secondaryText,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      hintText: 'Ingresa emprendedor...',
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
                                      fillColor: Colors.white,
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
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Field is required';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Form(
                                key: formKey5,
                                autovalidateMode: AutovalidateMode.always,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    controller: textController3,
                                    readOnly: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Emprendimiento',
                                      labelStyle: AppTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: AppTheme.of(context)
                                                .secondaryText,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      hintText: 'Ingresa emprendimiento...',
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
                                      fillColor: Colors.white,
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
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Field is required';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Form(
                                key: formKey6,
                                autovalidateMode: AutovalidateMode.always,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: InkWell(
                                    onTap: () async {
                                      // await DatePicker.showDatePicker(
                                      //   context,
                                      //   showTitleActions: true,
                                      //   onConfirm: (date) {
                                      //     setState(() => datePicked1 = date);
                                      //   },
                                      //   currentTime: getCurrentTimestamp,
                                      //   minTime: getCurrentTimestamp,
                                      // );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: AppTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppTheme.of(context)
                                              .primaryText,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 0, 0),
                                                child: Text(
                                                  'Fecha registro*',
                                                  style: AppTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodyText1Family,
                                                        color:
                                                            Color(0xFF5B6570),
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 6, 0, 0),
                                                child: Text(
                                                  dateTimeFormat(
                                                      'yMMMd', datePicked1),
                                                  style: AppTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodyText1Family,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
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
                              Form(
                                key: formKey2,
                                autovalidateMode: AutovalidateMode.always,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    controller: textController4,
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
                                      fillColor: Colors.white,
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
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Field is required';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // Expanded(
                                  //   child: FlutterFlowCheckboxGroup(
                                  //     initiallySelected:
                                  //         checkboxGroupValues ??= [],
                                  //     options: ['¿Tarea Completada?'].toList(),
                                  //     onChanged: (val) => setState(
                                  //         () => checkboxGroupValues = val),
                                  //     activeColor: AppTheme.of(context)
                                  //         .primaryColor,
                                  //     checkColor: Colors.white,
                                  //     checkboxBorderColor: Color(0xFF95A1AC),
                                  //     textStyle: AppTheme.of(context)
                                  //         .bodyText1
                                  //         .override(
                                  //           fontFamily:
                                  //               AppTheme.of(context)
                                  //                   .bodyText1Family,
                                  //           fontWeight: FontWeight.w500,
                                  //         ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Form(
                                key: formKey3,
                                autovalidateMode: AutovalidateMode.always,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: InkWell(
                                    onTap: () async {
                                      // await DatePicker.showDatePicker(
                                      //   context,
                                      //   showTitleActions: true,
                                      //   onConfirm: (date) {
                                      //     setState(() => datePicked2 = date);
                                      //   },
                                      //   currentTime: getCurrentTimestamp,
                                      //   minTime: getCurrentTimestamp,
                                      // );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: AppTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: AppTheme.of(context)
                                              .primaryText,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 0, 0),
                                                child: Text(
                                                  'Fecha de revisión*',
                                                  style: AppTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodyText1Family,
                                                        color:
                                                            AppTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 6, 0, 0),
                                                child: Text(
                                                  dateTimeFormat(
                                                      'yMMMd', datePicked2),
                                                  style: AppTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(
                                                                    context)
                                                                .bodyText1Family,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
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
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            if (formKey4.currentState == null ||
                                !formKey4.currentState!.validate()) {
                              return;
                            }

                            if (formKey1.currentState == null ||
                                !formKey1.currentState!.validate()) {
                              return;
                            }

                            if (formKey5.currentState == null ||
                                !formKey5.currentState!.validate()) {
                              return;
                            }

                            if (formKey6.currentState == null ||
                                !formKey6.currentState!.validate()) {
                              return;
                            }

                            if (datePicked1 == null) {
                              return;
                            }

                            if (formKey2.currentState == null ||
                                !formKey2.currentState!.validate()) {
                              return;
                            }

                            if (formKey3.currentState == null ||
                                !formKey3.currentState!.validate()) {
                              return;
                            }

                            if (datePicked2 == null) {
                              return;
                            }

                            // final jornadasCreateData = createJornadasRecordData(
                            //   emprendedor: textController2.text,
                            //   emprendimiento: textController3?.text ?? '',
                            //   fecha: datePicked1,
                            //   fecharevision: datePicked2,
                            //   tarea: textController4.text,
                            //   refemprendimiento:
                            //       registrarJornadaProyectosRecord.reference,
                            //   numerojornada: int.parse(textController1.text),
                            // );
                            // await JornadasRecord.collection
                            //     .doc()
                            //     .set(jornadasCreateData);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JornadaCreada(),
                              ),
                            );
                          },
                          text: 'Crear',
                          icon: Icon(
                            Icons.check_rounded,
                            size: 15,
                          ),
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: AppTheme.of(context).secondaryText,
                            textStyle:
                                AppTheme.of(context).subtitle2.override(
                                      fontFamily: AppTheme.of(context)
                                          .subtitle2Family,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
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
