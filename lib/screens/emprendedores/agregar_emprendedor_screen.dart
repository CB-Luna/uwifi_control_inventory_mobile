import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/providers/database_providers/emprendedor_controller.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';

class AgregarEmprendedorScreen extends StatefulWidget {
  const AgregarEmprendedorScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AgregarEmprendedorScreenState createState() =>
      _AgregarEmprendedorScreenState();
}

class _AgregarEmprendedorScreenState extends State<AgregarEmprendedorScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emprendedorKey = GlobalKey<FormState>();
  XFile? image;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final emprendedorProvider = Provider.of<EmprendedorController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFD9EEF9),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).secondaryBackground,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/bglogin2.png',
                    ).image,
                  ),
                ),
              ),
              Stack(
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: emprendedorKey,
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
                                    color: const Color(0xFF4672FF),
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
                                                fontFamily: AppTheme.of(context)
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
                                  'Registro de Emprendedor',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
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
                                            .fromSTEB(0, 10, 0, 0),
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
                                                imageQuality: 100,
                                              );
                                            } else {
                                              pickedFile =
                                                  await picker.pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 100,
                                              );
                                            }

                                            if (pickedFile == null) {
                                              return;
                                            }

                                            setState(() {
                                              image = pickedFile;
                                              emprendedorProvider.imagen =
                                                  image!.path;
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: AppTheme.of(context)
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
                                                color: const Color(0xFF221573),
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
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      emprendedorProvider.nombre = value;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Nombre(s)*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingresa nombre...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: (value) {
                                      return capitalizadoCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Para continuar, ingrese el nombre empezando por mayúscula.';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      emprendedorProvider.apellidos = value;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Apellido(s)*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese apellido...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: (value) {
                                      return capitalizadoCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Para continuar, ingrese los apellidos empezando por mayúscula.';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      emprendedorProvider.curp = value;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'CURP*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese el CURP...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: (value) {
                                      return curpCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Para continuar, ingrese un CURP válido con mayúsculas.';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      emprendedorProvider.integrantesFamilia =
                                          value;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Integrantes*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese integrantes...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    validator: (value) {
                                      return familiaCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Para continuar, ingrese un número de integrantes [0-99].';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      emprendedorProvider.telefono = value;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Numero telefónico',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese número telefónico...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(12),
                                      telefonoFormat
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onChanged: (value) {
                                      emprendedorProvider.comentarios = value;
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Comentarios',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingresa comentarios...',
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
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    maxLines: 5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 15),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (emprendedorProvider
                                                .validateForm(emprendedorKey)) {
                                              final emprendedor = 
                                               dataBase.emprendedoresBox.query(Emprendedores_.curp.equals(emprendedorProvider.curp)).build().findFirst();
                                              if (emprendedor != null && emprendedor.emprendimiento.target!.activo) {
                                                  snackbarKey.currentState
                                                      ?.showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "No es posible asignar este emprendedor a un nuevo emprendimiento, revise el CURP ingresado."),
                                                  ));
                                              }
                                              else {
                                                emprendedorProvider
                                                  .addTemporaly();
                                                Navigator.pop(context);
                                                snackbarKey.currentState
                                                    ?.showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "¡Emprendedor asocidado éxitosamente!"),
                                                ));
                                              }
                                            } else {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Campos vacíos'),
                                                    content: const Text(
                                                        'Para continuar, debe llenar todos los campos solicitados.'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext),
                                                        child:
                                                            const Text('Bien'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              return;
                                            }
                                          },
                                          text: 'Agregar',
                                          icon: const Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          options: FFButtonOptions(
                                            width: 150,
                                            height: 50,
                                            color: AppTheme.of(context)
                                                .secondaryText,
                                            textStyle: AppTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                            elevation: 3,
                                            borderSide: BorderSide(
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              width: 0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
