import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/providers/database_providers/comunidad_controller.dart';
import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/providers/select_image_provider.dart';

import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimiento_creado.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/theme/theme.dart';

class AgregarEmprendimientoScreen extends StatefulWidget {
  const AgregarEmprendimientoScreen({Key? key}) : super(key: key);

  @override
  State<AgregarEmprendimientoScreen> createState() =>
      _AgregarEmprendimientoScreenState();
}

class _AgregarEmprendimientoScreenState
    extends State<AgregarEmprendimientoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emprendimientoKey = GlobalKey<FormState>();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    final emprendimientoProvider =
        Provider.of<EmprendimientoController>(context);
    final comunidadProvider = Provider.of<ComunidadController>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final selectImageProvider = Provider.of<SelectImageProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF008DD4),
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
        title: Text(
          'Emprendimientos',
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
      backgroundColor: const Color(0xFFD9EEF9),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: emprendimientoKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Registro de Emprendimiento',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: const Color(0xFF0D0E0F),
                                fontSize: 16,
                              ),
                        ),
                      ],
                    ),
                  ),
                  FormField(builder: (state) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              String? option = await showModalBottomSheet(
                                context: context,
                                builder: (_) => const CustomBottomSheet(),
                              );

                              if (option == null) return;

                              final picker = ImagePicker();

                              late final XFile? pickedFile;

                              if (option == 'camera') {
                                pickedFile = await picker.pickImage(
                                  source: ImageSource.camera,
                                  imageQuality: 100,
                                );
                              } else {
                                pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 100,
                                );
                              }

                              if (pickedFile == null) {
                                return;
                              }

                              setState(() {
                                image = pickedFile;
                                emprendimientoProvider.imagen = image!.path;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                    'assets/images/animation_500_l3ur8tqa.gif',
                                  ).image,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF2CC3F4),
                                  width: 2,
                                ),
                              ),
                              child: getImage(image?.path),
                            ),
                          ),
                        ),
                      ],
                    );
                  }, validator: (val) {
                    if (emprendimientoProvider.imagen == null ||
                        emprendimientoProvider.imagen.isEmpty) {
                      return 'Para continuar, cargue una imagen';
                    }
                    return null;
                  }),
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
                          child: TextFormField(
                            onChanged: (value) {
                              emprendimientoProvider.nombre = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Nombre de emprendimiento*',
                              labelStyle: AppTheme.of(context).title3.override(
                                    fontFamily: 'Montserrat',
                                    color: AppTheme.of(context).secondaryText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              hintText: 'Ingresa el nombre...',
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
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Para continuar, ingrese el nombre.';
                              }

                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              emprendimientoProvider.descripcion = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Descripción de emprendimiento*',
                              labelStyle: AppTheme.of(context).title3.override(
                                    fontFamily: 'Montserrat',
                                    color: AppTheme.of(context).secondaryText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              hintText: 'Descripción del emprendimiento...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF060606),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            maxLines: 5,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Para continuar, ingrese la descripción.';
                              }

                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              comunidadProvider.nombre = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Comunidad*',
                              labelStyle: AppTheme.of(context).title3.override(
                                    fontFamily: 'Montserrat',
                                    color: AppTheme.of(context).secondaryText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              hintText: 'Ingresa comunidad...',
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
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Para continuar, ingrese la comunidad.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  if (emprendimientoProvider
                                      .validateForm(emprendimientoKey)) {
                                    comunidadProvider.add();
                                    emprendimientoProvider.add(comunidadProvider.comunidades.last.id);
                                    usuarioProvider.addEmprendimiento(emprendimientoProvider.emprendimiento!);
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EmprendimientoCreado(),
                                      ),
                                    );
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: const Text('Campos vacíos'),
                                          content: const Text(
                                              'Para continuar, debe llenar todos los campos e incluír una imagen.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
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
                                text: 'Agregar Emprendimiento',
                                options: FFButtonOptions(
                                  width: 290,
                                  height: 50,
                                  color: const Color(0xFF2CC3F4),
                                  textStyle:
                                      AppTheme.of(context).title3.override(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                  elevation: 3,
                                  borderSide: const BorderSide(
                                    color: Color(0xFF2CC3F4),
                                    width: 0,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
