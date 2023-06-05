import 'dart:convert';
import 'dart:io';

import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:taller_alex_app_asesor/screens/perfil_usuario/cambiar_password_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/drop_down.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/perfil_usuario/usuario_actualizado.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_button.dart';

class EditarUsuarioScreen extends StatefulWidget {
  const EditarUsuarioScreen({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final Users usuario;

  @override
  State<EditarUsuarioScreen> createState() => _EditarUsuarioScreenState();
}

class _EditarUsuarioScreenState extends State<EditarUsuarioScreen> {
  String uploadedFileUrl = '';
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoPController = TextEditingController();
  TextEditingController apellidoMController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  XFile? image;
  String rolUsuario = "";
  List<String> listRoles = [];
  String? newImagen;
  String? imagenTemp;

  @override
  void initState() {
    super.initState();
    rolUsuario = widget.usuario.role.target!.role;
    listRoles = [];
    for (var element in widget.usuario.roles) {
      listRoles.add(element.role);
    }
    newImagen = "";
    imagenTemp = widget.usuario.path;
    nombreController = TextEditingController(text: widget.usuario.name);
    apellidoPController = TextEditingController(text: widget.usuario.lastName);
    apellidoMController = TextEditingController(text: widget.usuario.middleName);
    telefonoController = TextEditingController(text: widget.usuario.homePhone);
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/bglogin2.png',
                      ).image,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 230, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).grayLighter,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8, 40, 8, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).grayLighter,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
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
                                          Icon(
                                            Icons.arrow_back_ios_rounded,
                                            color: FlutterFlowTheme.of(context).white,
                                            size: 16,
                                          ),
                                          Text(
                                            'Atrás',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyText1Family,
                                                  color: FlutterFlowTheme.of(context).white,
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
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              25, 0, 0, 0),
                                      child: AutoSizeText(
                                        "Data of ${maybeHandleOverflow('${widget.usuario.name} ${widget.usuario.lastName}', 25, '...')}",
                                        maxLines: 2,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(context)
                                                  .bodyText1Family,
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryText,
                                              fontSize: 15,
                                            ),
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
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          imagenTemp == null
                              ? Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 0),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      child: Center(
                                        child: Text(
                                          "${widget.usuario.name.substring(0, 1)} ${widget.usuario.lastName.substring(0, 1)}",
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: FlutterFlowTheme.of(context)
                                                    .bodyText1Family,
                                                color: FlutterFlowTheme.of(context).white,
                                                fontSize: 70,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 0),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: const Color(0x00EEEEEE),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(File(imagenTemp!))),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                          FormField(
                            builder: (state) {
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                    child: CustomButton(
                                      onPressed: () async {
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
                                          pickedFile = await picker.pickImage(
                                            source: ImageSource.camera,
                                            imageQuality: 50,
                                          );
                                        } else {
                                          pickedFile = await picker.pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 50,
                                          );
                                        }

                                        if (pickedFile == null) {
                                          return;
                                        }

                                        setState(() {
                                          image = pickedFile;
                                          imagenTemp = image!.path;
                                          File file = File(image!.path);
                                          List<int> fileInByte = file.readAsBytesSync();
                                          String base64 = base64Encode(fileInByte);
                                          newImagen = base64.toString();
                                        });
                                      },
                                      text: 'Cambiar Foto',
                                      icon: Icon(
                                        Icons.add_a_photo,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 15,
                                      ),
                                      options: ButtonOptions(
                                        width: 150,
                                        height: 30,
                                        color: FlutterFlowTheme.of(context).white,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(context)
                                                  .subtitle2Family,
                                              color: FlutterFlowTheme.of(context).tertiaryColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).tertiaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 20, 0, 0),
                            child: Text(
                              widget.usuario.correo,
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily:
                                        FlutterFlowTheme.of(context).bodyText1Family,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          FormField(
                            builder: (state) {
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                    child: CustomButton(
                                      onPressed: () async {
                                        //print("ID IMAGEN: ${widget.usuario.imagen.target?.idEmiWeb}");
                                        if (imagenTemp != widget.usuario.path) {
                                          //print("Sí");
                                          if (nombreController.text !=
                                                widget.usuario.name ||
                                            apellidoPController.text !=
                                                widget.usuario.lastName ||
                                            apellidoMController.text !=
                                                widget.usuario.middleName ||
                                            telefonoController.text !=
                                                widget.usuario.homePhone) {
                                          if (usuarioProvider.validateForm(formKey)) {
                                            if (rolUsuario !=
                                                    widget.usuario.role.target!.role) {
                                              final idRol = dataBase.roleBox
                                                  .query(Role_.role.equals(rolUsuario))
                                                  .build()
                                                  .findFirst()
                                                  ?.id;
                                              if (idRol != null) {
                                                //print("Se va a actualizar el rol del Usuario");
                                                usuarioProvider.updateRol(
                                                  widget.usuario.id,
                                                  idRol,
                                                );
                                              }
                                            }
                                            if (widget.usuario.path != null) {
                                                //print("Se va a actualizar la imagen del Usuario");
                                                // usuarioProvider.updateImagenUsuario(
                                                //   1,
                                                //   newImagen!.nombre!,
                                                //   newImagen!.path!,
                                                //   newImagen!.base64!,
                                                // );
                                              } else {
                                                //print("Se va a agregar la imagen del Usuario");
                                                // usuarioProvider.addImagenUsuario(
                                                //   1,
                                                //   newImagen!.nombre!,
                                                //   newImagen!.path!,
                                                //   newImagen!.base64!,
                                                // );
                                              }
                                              //print("Sí se actualizan los datos del Usuario");
                                              usuarioProvider.updateDatos(
                                                widget.usuario.id,
                                                nombreController.text,
                                                apellidoPController.text,
                                                apellidoMController.text,
                                                telefonoController.text,
                                              );
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const UsuarioActualizado(),
                                                ),
                                              );
                                          } else {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: const Text('Campos vacíos'),
                                                  content: const Text(
                                                      'Para continuar, debe llenar los campos solicitados.'),
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
                                        } else {
                                          if (rolUsuario !=
                                                  widget.usuario.role.target!.role) {
                                            final idRol = dataBase.roleBox
                                                .query(Role_.role.equals(rolUsuario))
                                                .build()
                                                .findFirst()
                                                ?.id;
                                            if (idRol != null) {
                                              //print("Sólo se va a actualizar el rol del Usuario");
                                              usuarioProvider.updateRol(
                                                widget.usuario.id,
                                                idRol,
                                              );
                                            }
                                          }
                                          if (imagenTemp != widget.usuario.path) {
                                            if (widget.usuario.path != null) {
                                              //print("Se va a actualizar la imagen del Usuario");
                                              // usuarioProvider.updateImagenUsuario(
                                              //   1,
                                              //   newImagen!.nombre!,
                                              //   newImagen!.path!,
                                              //   newImagen!.base64!,
                                              // );
                                            } else {
                                              //print("Se va a agregar la imagen del Usuario");
                                              // usuarioProvider.addImagenUsuario(
                                              //   1,
                                              //   newImagen!.nombre!,
                                              //   newImagen!.path!,
                                              //   newImagen!.base64!,
                                              // );
                                            }
                                          }
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const UsuarioActualizado(),
                                            ),
                                          );
                                        }
                                        } else {
                                          //print("No");
                                          if (nombreController.text !=
                                                  widget.usuario.name ||
                                              apellidoPController.text !=
                                                  widget.usuario.lastName ||
                                              apellidoMController.text !=
                                                  widget.usuario.middleName ||
                                              telefonoController.text !=
                                                  widget.usuario.homePhone) {
                                            if (usuarioProvider.validateForm(formKey)) {
                                              if (rolUsuario !=
                                                      widget.usuario.role.target!.role) {
                                                final idRol = dataBase.roleBox
                                                    .query(Role_.role.equals(rolUsuario))
                                                    .build()
                                                    .findFirst()
                                                    ?.id;
                                                if (idRol != null) {
                                                  //print("Se va a actualizar el rol del Usuario");
                                                  usuarioProvider.updateRol(
                                                    widget.usuario.id,
                                                    idRol,
                                                  );
                                                }
                                              }
                                              //print("Sí se actualizan los datos del Usuario");
                                              usuarioProvider.updateDatos(
                                                widget.usuario.id,
                                                nombreController.text,
                                                apellidoPController.text,
                                                apellidoMController.text,
                                                telefonoController.text,
                                              );
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const UsuarioActualizado(),
                                                ),
                                              );
                                            } else {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: const Text('Campos vacíos'),
                                                    content: const Text(
                                                        'Para continuar, debe llenar los campos solicitados.'),
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
                                          } else {
                                            if (rolUsuario !=
                                                    widget.usuario.role.target!.role) {
                                                final idRol = dataBase.roleBox
                                                    .query(Role_.role.equals(rolUsuario))
                                                    .build()
                                                    .findFirst()
                                                    ?.id;
                                                if (idRol != null) {
                                                  //print("Sólo se va a actualizar el rol del Usuario");
                                                  usuarioProvider.updateRol(
                                                    widget.usuario.id,
                                                    idRol,
                                                  );
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const UsuarioActualizado(),
                                                    ),
                                                  );
                                                }
                                            }
                                          }
                                        }
                                      },
                                      text: 'Guardar cambios',
                                      icon: Icon(
                                        Icons.check_rounded,
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        size: 15,
                                      ),
                                      options: ButtonOptions(
                                        width: 150,
                                        height: 30,
                                        color: FlutterFlowTheme.of(context).white,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(context)
                                                  .subtitle2Family,
                                              color: FlutterFlowTheme.of(context).tertiaryColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).tertiaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                35, 20, 35, 0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: nombreController,
                              decoration: InputDecoration(
                                labelText: "Nombre(s)*",
                                labelStyle:
                                    FlutterFlowTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context).tertiaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context).white,
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              validator: FormBuilderValidators.compose([
                                  (value){
                                    return (capitalizadoCharacters.hasMatch(value ?? ''))
                                    ? null
                                    : 'Para continuar, ingrese el nombre empezando por mayúscula.';
                                  },
                                  (value){
                                    return (nombreCharacters.hasMatch(value ?? ''))
                                    ? null
                                    : 'Evite usar números o caracteres especiales como diéresis';
                                  }
                              ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                35, 20, 35, 0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: apellidoPController,
                              decoration: InputDecoration(
                                labelText: "Apellido Paterno*",
                                labelStyle:
                                    FlutterFlowTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context).tertiaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(
                                    color: FlutterFlowTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context).white,
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              validator: FormBuilderValidators.compose([
                                (value){
                                  return (capitalizadoCharacters.hasMatch(value ?? ''))
                                  ? null
                                  : 'Para continuar, ingrese el apellido empezando por mayúscula.';
                                },
                                (value){
                                  return (nombreCharacters.hasMatch(value ?? ''))
                                  ? null
                                  : 'Evite usar números o caracteres especiales como diéresis';
                                }
                              ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                35, 20, 35, 0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: apellidoMController,
                              decoration: InputDecoration(
                                labelText: "Apellido Materno",
                                labelStyle:
                                    FlutterFlowTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context).tertiaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context).white,
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                35, 20, 35, 0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: telefonoController,
                              decoration: InputDecoration(
                                labelText: "Teléfono",
                                labelStyle:
                                    FlutterFlowTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context).tertiaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context).white,
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value){
                                if(value != "" && value != null){
                                  return value.length < 10
                                    ? 'Por favor ingrese un número telefónico válido'
                                    : null;
                                }else{
                                return null;
                                }
                              }
                            ),
                          ),
                          FormField(
                            builder: (state) {
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    35, 20, 35, 0),
                                child: DropDown(
                                  initialOption: rolUsuario,
                                  options: listRoles,
                                  onChanged: (val) => setState(() {
                                    rolUsuario = val!;
                                  }),
                                  width: double.infinity,
                                  height: 50,
                                  textStyle:
                                      FlutterFlowTheme.of(context).title3.override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context).tertiaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                  hintText: 'Seleccione un rol',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context).tertiaryColor,
                                    size: 30,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context).white,
                                  elevation: 2,
                                  borderColor: FlutterFlowTheme.of(context).tertiaryColor,
                                  borderWidth: 2,
                                  borderRadius: 8,
                                  margin: const EdgeInsetsDirectional.fromSTEB(
                                      12, 4, 12, 4),
                                  hidesUnderline: true,
                                ),
                              );
                            },
                            validator: (val) {
                              if (rolUsuario == "" || rolUsuario.isEmpty) {
                                return 'Para continuar, seleccione un rol.';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 20, 0, 20),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CambiarPasswordScreen(usuario: widget.usuario,),
                                  ),
                                );
                              },
                              text: 'Cambiar contraseña',
                              icon: const Icon(
                                Icons.password_outlined,
                                size: 15,
                              ),
                              options: FFButtonOptions(
                                width: 180,
                                height: 40,
                                color: FlutterFlowTheme.of(context).secondaryColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).subtitle2Family,
                                      color: FlutterFlowTheme.of(context).white,
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
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}