import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/screens/clientes/agregar_vehiculo_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';

class AgregarClienteScreen extends StatefulWidget {
  const AgregarClienteScreen({Key? key}) : super(key: key);

  @override
  _AgregarClienteScreenState createState() =>
      _AgregarClienteScreenState();
}

class _AgregarClienteScreenState extends State<AgregarClienteScreen> {
  XFile? image;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final clienteKey = GlobalKey<FormState>();
  final _unfocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Form(
              key: clienteKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20, 45, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primaryColor,
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
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Registro de Cliente',
                          style:
                              FlutterFlowTheme.of(context).title1.override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText1Family,
                                    fontSize: 18,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormField(
                        builder: (state) {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional
                                    .fromSTEB(0, 10, 0, 16),
                                child: InkWell(
                                  onTap: () async {
                                    String? option =
                                        await showModalBottomSheet(
                                      context: context,
                                      builder: (_) =>
                                          const CustomBottomSheet(),
                                    );

                                    if (option == null) return;

                                    final picker = ImagePicker();

                                    late final XFile? pickedFile;

                                    if (option == 'camera') {
                                      pickedFile =
                                          await picker.pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 50,
                                      );
                                    } else {
                                      pickedFile =
                                          await picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                    }

                                    if (pickedFile == null) {
                                      return;
                                    }

                                    setState(() {
                                      // image = pickedFile;
                                      // File file = File(image!.path);
                                      // List<int> fileInByte =
                                      //     file.readAsBytesSync();
                                      // String base64 =
                                      //     base64Encode(fileInByte);
                                      // var newImagenLocal = Imagenes(
                                      //     imagenes: image!.path,
                                      //     nombre: image!.name,
                                      //     path: image!.path,
                                      //     base64: base64,
                                      //     idEmprendimiento: 0);
                                      // emprendedorProvider.imagenLocal =
                                      //     newImagenLocal;
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context)
                                            .size
                                            .width *
                                        0.9,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/animation_500_l3ur8tqa.gif',
                                        ).image,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(8),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: getImage(image?.path),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                    child: TextFormField(
                      maxLength: 30,
                      textCapitalization:
                          TextCapitalization.words,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Nombre(s)*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese nombre...',
                        hintStyle: FlutterFlowTheme.of(context).bodyText2,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      validator: FormBuilderValidators.compose([
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'El Nombre es requerido.';
                          } else {
                            return (palabras.hasMatch(value))
                              ? null
                              : 'Evite usar números o caracteres especiales como diéresis.';
                          }
                        }
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                    child: TextFormField(
                      maxLength: 30,
                      textCapitalization:
                          TextCapitalization.words,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Apellido Paterno*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese apellido paterno...',
                        hintStyle: FlutterFlowTheme.of(context).bodyText2,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      validator: FormBuilderValidators.compose([
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'El Apellido Paterno es requerido.';
                          } else {
                            return (palabras.hasMatch(value))
                              ? null
                              : 'Evite usar números o caracteres especiales como diéresis.';
                          }
                        }
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                    child: TextFormField(
                      maxLength: 30,
                      textCapitalization:
                          TextCapitalization.words,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Apellido Materno',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese apellido materno...',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      validator: FormBuilderValidators.compose([
                        (value) {
                          return (palabras.hasMatch(value ?? ''))
                              ? null
                              : 'Evite usar números o caracteres especiales como diéresis.';
                        }
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                    child: TextFormField(
                      textCapitalization:
                          TextCapitalization.characters,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'CURP*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el CURP...',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El CURP es requerido.';
                        } else {
                          return curpCharacters
                              .hasMatch(value)
                          ? null
                          : 'Por favor captura el CURP a 18 posiciones.';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: TextFormField(
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Teléfono',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el teléfono...',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                        telefonoFormat
                      ],
                      validator: (value) {
                        if (value != "" && value != null) {
                          return value.length < 12
                              ? 'Por favor ingrese un número telefónico válido.'
                              : null;
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: TextFormField(
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Celular',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el celular...',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                        telefonoFormat
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El número de celular es requerido.';
                        } else {
                          return value.length < 12
                          ? 'Por favor ingrese un número de celular válido.'
                          : null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: TextFormField(
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el correo electrónico...',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El correo electrónico es requerido.';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Por favor ingresa un correo electrónico válido.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AgregarVehiculoScreen(),
                        ),
                      );
                      },
                      text: 'Asignar Vehículo',
                      options: FFButtonOptions(
                        width: 400,
                        height: 50,
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                        elevation: 3,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        
                      },
                      text: 'Registrar',
                      options: FFButtonOptions(
                        width: 200,
                        height: 50,
                        color: FlutterFlowTheme.of(context).primaryColor,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                        elevation: 3,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
