import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/cliente_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/vehiculo_controller.dart';
import 'package:taller_alex_app_asesor/screens/clientes/agregar_vehiculo_screen.dart';
import 'package:taller_alex_app_asesor/screens/clientes/cliente_creado_screen.dart';
import 'package:taller_alex_app_asesor/screens/clientes/cliente_no_creado_screen.dart';
import 'package:taller_alex_app_asesor/screens/screens.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';

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
    final vehiculoProvider = Provider.of<VehiculoController>(context);
    final clienteProvider = Provider.of<ClienteController>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
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
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text(
                                        '¿Seguro que quieres abandonar esta pantalla?'),
                                    content: const Text(
                                        'La información ingresada se perderá.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          vehiculoProvider.limpiarInformacion();
                                          clienteProvider.limpiarInformacion();
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrdenesTrabajoScreen(),
                                            ),
                                          );
                                        },
                                        child:
                                            const Text('Abandonar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:
                                            const Text('Cancelar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
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
                                      image = pickedFile;
                                      File file = File(image!.path);
                                      List<int> fileInByte =
                                          file.readAsBytesSync();
                                      String base64 =
                                          base64Encode(fileInByte);
                                      clienteProvider.imagenCliente =
                                          base64;
                                      clienteProvider.path = 
                                        file.path;
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
                        clienteProvider.nombre = value;
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
                                FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
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
                        clienteProvider.apellidoP = value;
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
                                FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
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
                        clienteProvider.apellidoM = value;
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
                                FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
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
                        clienteProvider.rfc = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'RFC*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el RFC...',
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
                                FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
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
                          return 'El RFC es requerido.';
                        } else {
                          return rfcCharacters
                              .hasMatch(value)
                          ? null
                          : 'Por favor captura el RFC a 12 posiciones.';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                    child: TextFormField(
                      maxLines: 2,
                      textCapitalization:
                          TextCapitalization.words,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        clienteProvider.domicilio = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Domicilio*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese domicilio...',
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
                                FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
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
                            return 'El Domicilio es requerido.';
                          } else {
                            return null;
                          }
                        }
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: TextFormField(
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        clienteProvider.telefono = value;
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
                                FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
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
                        clienteProvider.celular = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Celular*',
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
                                FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
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
                        clienteProvider.correo = value;
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
                                FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
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
                        if (vehiculoProvider.clienteAsociado) {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Ya se ha asignado un vehículo, no puedes agregar más."),
                          ));
                        } else {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                   AgregarVehiculoScreen(),
                            ),
                          );
                        }
                      },
                      text: vehiculoProvider.clienteAsociado
                      ? 'Vehículo Asignado'
                      : 'Asignar Vehículo',
                      options: FFButtonOptions(
                        width: 400,
                        height: 50,
                        color: vehiculoProvider.clienteAsociado
                        ?
                        FlutterFlowTheme.of(context).grayLight
                        :
                        FlutterFlowTheme.of(context).tertiaryColor,
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
                        if (clienteProvider
                              .validateForm(clienteKey) &&
                          vehiculoProvider.clienteAsociado) {
                        //Se crea cliente sin vehiculo
                        final idCliente = clienteProvider.add(usuarioProvider.usuarioCurrent);
                        //Se asigna el cliente al usuario actual
                        if (usuarioProvider.addCliente(idCliente)) {
                          //Se agrega vehículo
                          vehiculoProvider.add(idCliente);
                          vehiculoProvider
                              .limpiarInformacion();
                          clienteProvider
                              .limpiarInformacion();
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ClienteCreadoScreen(),
                            ),
                          );
                        } else {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ClienteNoCreadoScreen(),
                            ),
                          );
                        }
                      } else {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title:
                                  const Text('Campos requeridos vacíos.'),
                              content: const Text(
                                  'Para continuar, debe llenar todos los campos requeridos y asociar un vehículo.'),
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
