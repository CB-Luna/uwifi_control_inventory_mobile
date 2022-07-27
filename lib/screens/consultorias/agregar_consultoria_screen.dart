import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/providers/database_providers/consultoria_controller.dart';
import 'package:bizpro_app/screens/consultorias/consultoria_creada.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';


class AgregarConsultoriaScreen extends StatefulWidget {
  final int idEmprendimiento;
  final String nombreEmprendimiento;
  final String nombreEmprendedor;

  const AgregarConsultoriaScreen({
    Key? key, 
    required this.idEmprendimiento, 
    required this.nombreEmprendimiento, 
    required this.nombreEmprendedor}) : super(key: key);

  @override
  _AgregarConsultoriaScreenState createState() =>
      _AgregarConsultoriaScreenState();
}

class _AgregarConsultoriaScreenState
    extends State<AgregarConsultoriaScreen> {
  final consultoriaKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final consultoriaProvider = Provider.of<ConsultoriaController>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF008DD4),
        automaticallyImplyLeading: true,
        title: Text(
          'Registrar Consultoría',
          style: AppTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFD9EEF9),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: consultoriaKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5, 10, 5, 10),
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            initialValue: widget.nombreEmprendedor,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Emprendedor',
                              labelStyle: AppTheme.of(context).title3.override(
                                    fontFamily: 'Montserrat',
                                    color: AppTheme.of(context).secondaryText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5, 10, 5, 10),
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            initialValue: widget.nombreEmprendimiento,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Emprendimiento',
                              labelStyle: AppTheme.of(context).title3.override(
                                    fontFamily: 'Montserrat',
                                    color: AppTheme.of(context).secondaryText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                        //   child: TextFormField(
                        //     obscureText: false,
                        //     decoration: InputDecoration(
                        //       labelText: 'Fecha registro',
                        //       labelStyle:
                        //           AppTheme.of(context).title3.override(
                        //                 fontFamily: 'Montserrat',
                        //                 color: AppTheme.of(context)
                        //                     .secondaryText,
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.normal,
                        //               ),
                        //       hintText: 'Ingresa fecha..',
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //           color: Colors.transparent,
                        //           width: 1,
                        //         ),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderSide: BorderSide(
                        //           color: Colors.transparent,
                        //           width: 1,
                        //         ),
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //       filled: true,
                        //       fillColor: Colors.white,
                        //     ),
                        //     style: AppTheme.of(context).title3.override(
                        //           fontFamily: 'Poppins',
                        //           color: Colors.black,
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.normal,
                        //         ),
                        //     keyboardType: TextInputType.datetime,
                        //   ),
                        // ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              consultoriaProvider.documentos = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Documentos*',
                              labelStyle:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Ingresar documentos...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF3F2F2),
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF131515),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            maxLines: 5,
                            validator: (value) {
                              return cualquierCharacters.hasMatch(value ?? '')
                                  ? null
                                  : 'Para continuar, ingrese un documento';
                            },
                          ),
                        ),
                        // Row(
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     Expanded(
                        //       child: FlutterFlowCheckboxGroup(
                        //         initiallySelected: checkboxGroupValues ??= [],
                        //         options: ['¿Tarea Completada?'].toList(),
                        //         onChanged: (val) =>
                        //             setState(() => checkboxGroupValues = val),
                        //         activeColor:
                        //             AppTheme.of(context).primaryColor,
                        //         checkColor: Colors.white,
                        //         checkboxBorderColor: Color(0xFF95A1AC),
                        //         textStyle: AppTheme.of(context)
                        //             .bodyText1
                        //             .override(
                        //               fontFamily: 'Poppins',
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  //   child: Padding(
                  //     padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
                  //     child: TextFormField(
                  //       obscureText: false,
                  //       decoration: InputDecoration(
                  //         labelText: 'Fecha de revisión',
                  //         labelStyle: AppTheme.of(context)
                  //             .title3
                  //             .override(
                  //               fontFamily: 'Montserrat',
                  //               color:
                  //                   AppTheme.of(context).secondaryText,
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.normal,
                  //             ),
                  //         hintText: 'Ingresa fecha..',
                  //         enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Colors.transparent,
                  //             width: 1,
                  //           ),
                  //           borderRadius: BorderRadius.circular(8),
                  //         ),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Colors.transparent,
                  //             width: 1,
                  //           ),
                  //           borderRadius: BorderRadius.circular(8),
                  //         ),
                  //         filled: true,
                  //         fillColor: Colors.white,
                  //       ),
                  //       style: AppTheme.of(context).title3.override(
                  //             fontFamily: 'Poppins',
                  //             color: Colors.black,
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.normal,
                  //           ),
                  //       keyboardType: TextInputType.datetime,
                  //     ),
                  //   ),
                  // ),
                  FFButtonWidget(
                    onPressed: () async {
                      if (consultoriaProvider.validateForm(consultoriaKey)) {
                              consultoriaProvider.add(widget.idEmprendimiento);
                              // emprendimientoProvider.updateEmprendedores(widget.idEmprendimiento, emprendedorProvider.emprendedores[emprendedorProvider.emprendedores.length - 1]); 
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
                                    title: const Text('Campos vacíos'),
                                    content: const Text(
                                        'Para continuar, debe llenar todos los campos'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
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
                    options: FFButtonOptions(
                      width: 150,
                      height: 40,
                      color: AppTheme.of(context).primaryColor,
                      textStyle: AppTheme.of(context).subtitle2.override(
                            fontFamily: 'Poppins',
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
          ),
        ),
      ),
    );
  }
}
