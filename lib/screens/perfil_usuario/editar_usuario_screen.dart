import 'dart:io';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/providers/user_provider.dart';
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
  late TextEditingController nombreController;
  late TextEditingController apellidoPController;
  late TextEditingController apellidoMController;
  late TextEditingController telefonoController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  late String? fotoPerfil;
  XFile? image;

  @override
  void initState() {
    super.initState();
    fotoPerfil = widget.usuario.image.target?.imagenes;
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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
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
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 40, 8, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0x554672FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
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
                                  color: AppTheme.of(context)
                                      .secondaryText,
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      25, 0, 0, 0),
                                  child: AutoSizeText(
                                    'Perfil de ${widget.usuario.nombre} ${widget.usuario.apellidoP}',
                                    maxLines: 2,
                                    style: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily:
                                            AppTheme.of(context)
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
                      fotoPerfil == null ?
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
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
                                "${widget.usuario.nombre.substring(0,1)} ${widget.usuario.apellidoP.substring(0,1)}",
                              style: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily:
                                              AppTheme.of(context)
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
                      :
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: const Color(0x00EEEEEE),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(fotoPerfil!))
                            ),
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
                          return  Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: CustomButton(
                                  onPressed: () async {
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
                                    textStyle: AppTheme.of(context).subtitle2.override(
                                          fontFamily: AppTheme.of(context).subtitle2Family,
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
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Nombre(s)',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: AppTheme.of(context).bodyText1Family,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(35, 0, 35, 0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: nombreController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: AppTheme.of(context).bodyText1,
                          validator: (value) {
                            return capitalizadoCharacters.hasMatch(value ?? '')
                                ? null
                                : 'Para continuar, ingrese el nombre empezando por mayúscula.';
                            },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Apellido Paterno',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: AppTheme.of(context).bodyText1Family,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(35, 0, 35, 0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: apellidoPController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: AppTheme.of(context).bodyText1,
                          validator: (value) {
                            return capitalizadoCharacters.hasMatch(value ?? '')
                                ? null
                                : 'Para continuar, ingrese el nombre empezando por mayúscula.';
                            },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Apellido Materno',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: AppTheme.of(context).bodyText1Family,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(35, 0, 35, 0),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: apellidoMController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          style: AppTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Teléfono',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: AppTheme.of(context).bodyText1Family,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(35, 0, 35, 0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: telefonoController,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
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
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          widget.usuario.correo,
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: AppTheme.of(context).bodyText1Family,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              UserState.getRoleAsString(widget.usuario.rol),
                              style: AppTheme.of(context).bodyText1,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: CustomButton(
                          onPressed: () async {
                            if (usuarioProvider.validateForm(formKey)) {
                              if (nombreController.text != widget.usuario.nombre ||
                                  apellidoPController.text != widget.usuario.apellidoP || 
                                  apellidoMController.text != widget.usuario.apellidoM ||
                                  telefonoController.text != widget.usuario.telefono ||
                                  fotoPerfil != widget.usuario.image.target?.imagenes
                                  ) {
                                  usuarioProvider.update(
                                    widget.usuario.id,
                                    fotoPerfil,
                                    nombreController.text,
                                    apellidoPController.text,
                                    apellidoMController.text,
                                    telefonoController.text,
                                    );
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const UsuarioActualizado(),
                                    ),
                                  );
                              }
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
                          text: 'Guardar cambios',
                          icon: const Icon(
                            Icons.check_rounded,
                            color: Color(0xFF221573),
                            size: 15,
                          ),
                          options: ButtonOptions(
                            width: 225,
                            height: 45,
                            color: Colors.white,
                            textStyle: AppTheme.of(context).subtitle2.override(
                                  fontFamily: AppTheme.of(context).subtitle2Family,
                                  color: const Color(0xFF221573),
                                  fontSize: 15,
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
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
