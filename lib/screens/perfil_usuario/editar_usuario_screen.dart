import 'dart:io';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/perfil_usuario/usuario_actualizado.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:bizpro_app/theme/theme.dart';

class EditarUsuarioScreen extends StatefulWidget {
  const EditarUsuarioScreen({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final Usuarios usuario;

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
  late String fotoPerfil;
  XFile? image;
  String rolUsuario = "";
  List<String> listRoles = [];

  @override
  void initState() {
    super.initState();
    rolUsuario = widget.usuario.rol.target!.rol;
    listRoles = [];
    dataBase.rolesBox.getAll().forEach((element) {
      listRoles.add(element.rol);
    });
    fotoPerfil = widget.usuario.image.target?.imagenes ?? "";
    nombreController = TextEditingController(text: widget.usuario.nombre);
    apellidoPController = TextEditingController(text: widget.usuario.apellidoP);
    apellidoMController = TextEditingController(text: widget.usuario.apellidoM);
    telefonoController = TextEditingController(text: widget.usuario.telefono);
  }

  @override
  Widget build(BuildContext context) {
    //TODO: como manejar imagen?
    const String currentUserPhoto =
        'assets/images/default-user-profile-picture.jpg';
    final usuarioProvider = Provider.of<UsuarioController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
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
                    decoration: const BoxDecoration(
                      color: Color(0x554672FF),
                      borderRadius: BorderRadius.only(
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
                          color: const Color(0x554672FF),
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
                                      color: AppTheme.of(context).secondaryText,
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
                                        'Perfil de ${widget.usuario.nombre} ${widget.usuario.apellidoP}',
                                        maxLines: 2,
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              color: AppTheme.of(context)
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
                          fotoPerfil == ""
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
                                      color: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          "${widget.usuario.nombre.substring(0, 1)} ${widget.usuario.apellidoP.substring(0, 1)}",
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: AppTheme.of(context)
                                                    .bodyText1Family,
                                                color: Colors.white,
                                                fontSize: 70,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ),
                                    ),
                                    //TODO: manejar imagenes
                                    // child: Image.network(
                                    //   currentUserPhoto,
                                    // ),
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
                                          image: FileImage(File(fotoPerfil))),
                                      shape: BoxShape.circle,
                                    ),
                                    // Imagen cuadrada
                                    // child: Stack(
                                    //   children: [
                                    //     ClipRRect(
                                    //       borderRadius: BorderRadius.circular(20),
                                    //       child: getImage(
                                    //         image?.path ?? currentUserPhoto,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
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
                                          fotoPerfil = image!.path;
                                        });
                                      },
                                      text: 'Agregar Foto',
                                      icon: const Icon(
                                        Icons.add_a_photo,
                                        color: Color(0xFF221573),
                                        size: 15,
                                      ),
                                      options: ButtonOptions(
                                        width: 150,
                                        height: 30,
                                        color: Colors.white,
                                        textStyle: AppTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .subtitle2Family,
                                              color: const Color(0xFF221573),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
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
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily:
                                        AppTheme.of(context).bodyText1Family,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
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
                                labelText: "Nombre(s)",
                                labelStyle:
                                    AppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF221573),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF221573),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: AppTheme.of(context).bodyText1,
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
                                35, 20, 35, 0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: apellidoPController,
                              decoration: InputDecoration(
                                labelText: "Apellido Paterno",
                                labelStyle:
                                    AppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF221573),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF221573),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: AppTheme.of(context).bodyText1,
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
                                35, 20, 35, 0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: apellidoMController,
                              decoration: InputDecoration(
                                labelText: "Apellido Materno",
                                labelStyle:
                                    AppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF221573),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF221573),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: AppTheme.of(context).bodyText1,
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
                                    AppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF221573),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF221573),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: AppTheme.of(context).bodyText1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(12),
                                telefonoFormat
                              ],
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
                                      AppTheme.of(context).title3.override(
                                            fontFamily: 'Poppins',
                                            color: const Color(0xFF221573),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                  hintText: 'Seleccione un rol',
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xFF221573),
                                    size: 30,
                                  ),
                                  fillColor: Colors.white,
                                  elevation: 2,
                                  borderColor: const Color(0xFF221573),
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
                                0, 50, 0, 20),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (nombreController.text !=
                                        widget.usuario.nombre ||
                                    apellidoPController.text !=
                                        widget.usuario.apellidoP ||
                                    apellidoMController.text !=
                                        widget.usuario.apellidoM ||
                                    telefonoController.text !=
                                        widget.usuario.telefono ||
                                    fotoPerfil !=
                                        widget.usuario.image.target?.imagenes ||
                                    rolUsuario !=
                                        widget.usuario.rol.target!.rol) {
                                  if (usuarioProvider.validateForm(formKey)) {
                                    final idRol = dataBase.rolesBox
                                        .query(Roles_.rol.equals(rolUsuario))
                                        .build()
                                        .findFirst()
                                        ?.id;
                                    if (idRol != null) {
                                      usuarioProvider.update(
                                        widget.usuario.id,
                                        idRol,
                                        fotoPerfil,
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
                                    }
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
                                }
                              },
                              text: 'Guardar cambios',
                              icon: const Icon(
                                Icons.check_rounded,
                                size: 15,
                              ),
                              options: FFButtonOptions(
                                width: 160,
                                height: 40,
                                color: AppTheme.of(context).secondaryText,
                                textStyle: AppTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily:
                                          AppTheme.of(context).subtitle2Family,
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
