import 'dart:io' as libraryIO;

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:uwifi_control_inventory_mobile/models/image_evidence.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/screens/user_profile/perfil_usuario_screen.dart';
import 'package:uwifi_control_inventory_mobile/screens/user_profile/update_password.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/drop_down.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';
import 'package:uwifi_control_inventory_mobile/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart' as DBO;
import 'package:uwifi_control_inventory_mobile/providers/database/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/user_profile/usuario_actualizado.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_bottom_sheet.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_button.dart';

class EditarUsuarioScreen extends StatefulWidget {
  const EditarUsuarioScreen({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final DBO.Users usuario;

  @override
  State<EditarUsuarioScreen> createState() => _EditarUsuarioScreenState();
}

class _EditarUsuarioScreenState extends State<EditarUsuarioScreen> {
  String uploadedFileUrl = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController homePhoneController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  XFile? image;
  String rolUsuario = "";
  List<String> listRoles = [];
  ImageEvidence? newImage;
  String? imageTemp;

  @override
  void initState() {
    super.initState();
    rolUsuario = widget.usuario.role.target!.role;
    listRoles = [];
    for (var element in widget.usuario.roles) {
      listRoles.add(element.role);
    }
    newImage = null;
    imageTemp = widget.usuario.image.target?.path;
    nameController = TextEditingController(text: widget.usuario.firstName);
    lastNameController = TextEditingController(text: widget.usuario.lastName);
  }

  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
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
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).grayLighter,
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
                          color: AppTheme.of(context).grayLighter,
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
                                      color: AppTheme.of(context).secondaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PerfilUsuarioScreen(),
                                        ),
                                      );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.arrow_back_ios_rounded,
                                            color: AppTheme.of(context).white,
                                            size: 16,
                                          ),
                                          Text(
                                            'Back',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      AppTheme.of(context)
                                                          .bodyText1Family,
                                                  color: AppTheme.of(context).white,
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
                                        "Profile of ${maybeHandleOverflow('${widget.usuario.firstName} ${widget.usuario.lastName}', 25, '...')}",
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
                          imageTemp == null
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
                                      color: AppTheme.of(context).secondaryColor,
                                      child: Center(
                                        child: Text(
                                          "${widget.usuario.firstName.substring(0, 1)} ${widget.usuario.lastName.substring(0, 1)}",
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: AppTheme.of(context)
                                                    .bodyText1Family,
                                                color: AppTheme.of(context).white,
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
                                          image: FileImage(libraryIO.File(imageTemp!))),
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
                                        // imagesTemp = [];
                                        XFile? pickedFile;
                                        Uint8List? compressImage;
                                        if (option == 'camera') {
                                          pickedFile =
                                              await picker.pickImage(
                                            source: ImageSource.camera,
                                            maxHeight: 1080,
                                            maxWidth: 1080,
                                            imageQuality: 80,
                                          );
                                          if (pickedFile != null) {
                                            if (await pickedFile.length() >= 1000000) {
                                              int quality = 70;
                                              libraryIO.File file =
                                              libraryIO.File(
                                                  pickedFile.path);
                                              do {
                                                compressImage = await FlutterImageCompress.compressWithFile(
                                                  file.absolute.path,
                                                  minWidth: 1920,
                                                  minHeight: 1080,
                                                  quality: quality,
                                                );
                                                if (compressImage != null) {
                                                  if (compressImage.lengthInBytes >= 1000000) {
                                                    quality -= 10;
                                                  } else {
                                                    quality = 0;
                                                  }
                                                } else {
                                                  snackbarKey.currentState
                                                      ?.showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Failed to compress this picture."),
                                                  ));
                                                  return;
                                                }
                                              } while (quality > 0);
                                              setState(() {
                                                imageTemp = file.path;
                                              });
                                              newImage =
                                              ImageEvidence(
                                                  path:
                                                      file.path,
                                                  uint8List: compressImage,
                                                  name: pickedFile.name);
                                            } else {
                                              libraryIO.File file =
                                              libraryIO.File(
                                                  pickedFile.path);
                                              setState(() {
                                                imageTemp = file.path;
                                              });
                                              newImage =
                                              ImageEvidence(
                                                  path: file.path,
                                                  uint8List: file.readAsBytesSync(),
                                                  name: pickedFile.name);
                                            }
                                          } else {
                                            snackbarKey.currentState
                                                ?.showSnackBar(
                                                    const SnackBar(
                                              content: Text(
                                                  "Failed to upload this Picture."),
                                            ));
                                            return;
                                          }
                                        } else {
                                          //Se selecciona galería
                                          pickedFile =
                                              await picker.pickImage(
                                                source: ImageSource.gallery
                                          );
                                          if (pickedFile != null) {
                                            if (await pickedFile.length() >= 1000000) {
                                              int quality = 70;
                                              libraryIO.File file =
                                              libraryIO.File(
                                                  pickedFile.path);
                                              do {
                                                compressImage = await FlutterImageCompress.compressWithFile(
                                                  file.absolute.path,
                                                  minWidth: 1920,
                                                  minHeight: 1080,
                                                  quality: quality,
                                                );
                                                if (compressImage != null) {
                                                  if (compressImage.lengthInBytes >= 1000000) {
                                                    quality -= 10;
                                                  } else {
                                                    quality = 0;
                                                  }
                                                } else {
                                                  snackbarKey.currentState
                                                      ?.showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Failed to compress this picture."),
                                                  ));
                                                  return;
                                                }
                                              } while (quality > 0);
                                              setState(() {
                                                imageTemp = file.path;
                                              });
                                              newImage =
                                                  ImageEvidence(
                                                      path:
                                                          file.path,
                                                      uint8List: compressImage,
                                                      name: pickedFile.name);
                                            } else {
                                              libraryIO.File file =
                                              libraryIO.File(
                                                  pickedFile.path);
                                              setState(() {
                                                imageTemp = file.path;
                                              });
                                              newImage =
                                                ImageEvidence(
                                                    path: file.path,
                                                    uint8List: file.readAsBytesSync(),
                                                    name: pickedFile.name);
                                            }
                                          } else {
                                            snackbarKey.currentState
                                                ?.showSnackBar(
                                                    const SnackBar(
                                              content: Text(
                                                  "Failed to upload this Image."),
                                            ));
                                            return;
                                          }
                                        }
                                      },
                                      text: 'Update Photo',
                                      icon: Icon(
                                        Icons.add_a_photo,
                                        color: AppTheme.of(context).tertiaryColor,
                                        size: 15,
                                      ),
                                      options: ButtonOptions(
                                        width: 150,
                                        height: 30,
                                        color: AppTheme.of(context).white,
                                        textStyle: AppTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .subtitle2Family,
                                              color: AppTheme.of(context).tertiaryColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context).tertiaryColor,
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
                              widget.usuario.email,
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily:
                                        AppTheme.of(context).bodyText1Family,
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
                                        // if (nameController.text !=
                                        //       widget.usuario.name ||
                                        //   lastNameController.text !=
                                        //       widget.usuario.lastName ||
                                        //   middleNameController.text !=
                                        //       widget.usuario.middleName ||
                                        //   homePhoneController.text !=
                                        //       widget.usuario.homePhone ||
                                        //   mobilePhoneController.text !=
                                        //       widget.usuario.mobilePhone ||
                                        //   imageTemp != widget.usuario.path) {
                                        //   if (usuarioProvider.validateForm(formKey)) {
                                        //       usuarioProvider.updateData(
                                        //         widget.usuario,
                                        //         nameController.text,
                                        //         lastNameController.text,
                                        //         middleNameController.text,
                                        //         homePhoneController.text,
                                        //         mobilePhoneController.text,
                                        //         addressController.text,
                                        //         newImage,
                                        //         imageTemp,
                                        //       );
                                        //       await Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               const UsuarioActualizado(),
                                        //         ),
                                        //       );
                                        //   } else {
                                        //     await showDialog(
                                        //       context: context,
                                        //       builder: (alertDialogContext) {
                                        //         return AlertDialog(
                                        //           title: const Text('Empty Fields'),
                                        //           content: const Text(
                                        //               'To continue, you have to write all required fields.'),
                                        //           actions: [
                                        //             TextButton(
                                        //               onPressed: () => Navigator.pop(
                                        //                   alertDialogContext),
                                        //               child: const Text('Okay'),
                                        //             ),
                                        //           ],
                                        //         );
                                        //       },
                                        //     );
                                        //     return;
                                        //   }
                                        // } 
                                      },
                                      text: 'Save changes',
                                      icon: Icon(
                                        Icons.check_rounded,
                                        color: AppTheme.of(context).tertiaryColor,
                                        size: 15,
                                      ),
                                      options: ButtonOptions(
                                        width: 150,
                                        height: 30,
                                        color: AppTheme.of(context).white,
                                        textStyle: AppTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .subtitle2Family,
                                              color: AppTheme.of(context).tertiaryColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context).tertiaryColor,
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
                              controller: nameController,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                labelText: "Name*",
                                labelStyle:
                                    AppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: AppTheme.of(context).tertiaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: AppTheme.of(context).white,
                              ),
                              style: AppTheme.of(context).bodyText1,
                              validator: FormBuilderValidators.compose([
                                  (value){
                                    return (capitalizadoCharacters.hasMatch(value ?? ''))
                                    ? null
                                    : 'Input your Last Name to continue, the last name should be capitalized.';
                                  },
                                  (value){
                                    return (nombreCharacters.hasMatch(value ?? ''))
                                    ? null
                                    : 'Wrtiting numbers is not allowed.';
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
                              controller: lastNameController,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                labelText: "Last Name*",
                                labelStyle:
                                    AppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: AppTheme.of(context).tertiaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: AppTheme.of(context).white,
                              ),
                              style: AppTheme.of(context).bodyText1,
                              validator: FormBuilderValidators.compose([
                                (value){
                                  return (capitalizadoCharacters.hasMatch(value ?? ''))
                                  ? null
                                  : 'Input your Last Name to continue, the last name should be capitalized.';
                                },
                                (value){
                                  return (nombreCharacters.hasMatch(value ?? ''))
                                  ? null
                                  : 'Wrtiting numbers is not allowed.';
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
                              controller: middleNameController,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                labelText: "Middle Name",
                                labelStyle:
                                    AppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: AppTheme.of(context).tertiaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: AppTheme.of(context).white,
                              ),
                              style: AppTheme.of(context).bodyText1,
                              validator: (value) {
                                if (value != "" && value != null) {
                                  return (capitalizadoCharacters.hasMatch(value) && nombreCharacters.hasMatch(value))
                                  ? null
                                  : 'The middle name should be capitalized and digits are not allowed.';
                                }
                                return null;
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
                              controller: addressController,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                labelText: "Address",
                                labelStyle:
                                    AppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: AppTheme.of(context).tertiaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: AppTheme.of(context).white,
                              ),
                              style: AppTheme.of(context).bodyText1,
                              validator: (value) {
                                return (value == "" || value == null)
                                  ? 'Address is required.'
                                  : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                35, 20, 35, 0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: homePhoneController,
                              decoration: InputDecoration(
                                labelText: "Home Phone",
                                labelStyle:
                                    AppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: AppTheme.of(context).tertiaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: AppTheme.of(context).white,
                              ),
                              style: AppTheme.of(context).bodyText1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if(value != "" && value != null){
                                  return value.length < 10
                                    ? 'Input a valid number.'
                                    : null;
                                }
                                return null;
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                35, 20, 35, 0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: mobilePhoneController,
                              decoration: InputDecoration(
                                labelText: "Mobile Phone",
                                labelStyle:
                                    AppTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: AppTheme.of(context).tertiaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).tertiaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: AppTheme.of(context).white,
                              ),
                              style: AppTheme.of(context).bodyText1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if(value != "" && value != null){
                                  return value.length < 10
                                    ? 'Input a valid number.'
                                    : null;
                                }
                                return null;
                              },
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
                                  onChanged: (val) {},
                                  width: double.infinity,
                                  height: 50,
                                  textStyle:
                                      AppTheme.of(context).title3.override(
                                            fontFamily: 'Poppins',
                                            color: AppTheme.of(context).tertiaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                  hintText: 'Rol',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: AppTheme.of(context).tertiaryColor,
                                    size: 30,
                                  ),
                                  fillColor: AppTheme.of(context).white,
                                  elevation: 2,
                                  borderColor: AppTheme.of(context).tertiaryColor,
                                  borderWidth: 2,
                                  borderRadius: 8,
                                  margin: const EdgeInsetsDirectional.fromSTEB(
                                      12, 4, 12, 4),
                                  hidesUnderline: true,
                                ),
                              );
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
                                        UpdatePasswordScreen(usuario: widget.usuario,),
                                  ),
                                );
                              },
                              text: 'Update password',
                              icon: const Icon(
                                Icons.password_outlined,
                                size: 15,
                              ),
                              options: FFButtonOptions(
                                width: 180,
                                height: 40,
                                color: AppTheme.of(context).secondaryColor,
                                textStyle: AppTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily:
                                          AppTheme.of(context).subtitle2Family,
                                      color: AppTheme.of(context).white,
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