import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/providers/user_provider.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  XFile? image;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.usuario.nombre);
  }

  @override
  Widget build(BuildContext context) {
    //TODO: como manejar imagen?
    const String currentUserPhoto =
        'assets/images/default-user-profile-picture.jpg';

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
                    'assets/images/mesgbluegradient.jpeg',
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
                  color: Color(0xFFF5F5F5),
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
                      color: const Color(0x49EEEEEE),
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
                                  color: const Color(0x72EEEEEE),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  25, 0, 0, 0),
                              child: AutoSizeText(
                                'Perfil de ${'${widget.usuario.nombre} ${widget.usuario.apellidoP}'}',
                                maxLines: 2,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
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
                        child: Image.asset(
                          currentUserPhoto,
                          fit: BoxFit.contain,
                        ),
                        //TODO: manejar imagenes
                        // child: Image.network(
                        //   currentUserPhoto,
                        // ),
                      ),
                    ),
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
                            image: image != null
                                ? FileImage(File(image!.path))
                                : Image.asset(currentUserPhoto).image,
                          ),
                          shape: BoxShape.circle,
                        ),
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
                  ],
                ),
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
                      });
                      // final selectedMedia =
                      //     await selectMediaWithSourceBottomSheet(
                      //   context: context,
                      //   imageQuality: 64,
                      //   allowPhoto: true,
                      // );
                      // if (selectedMedia != null &&
                      //     selectedMedia.every((m) =>
                      //         validateFileFormat(m.storagePath, context))) {
                      //   showUploadMessage(
                      //     context,
                      //     'Uploading file...',
                      //     showLoading: true,
                      //   );
                      //   final downloadUrls = (await Future.wait(
                      //           selectedMedia.map((m) async =>
                      //               await uploadData(m.storagePath, m.bytes))))
                      //       .where((u) => u != null)
                      //       .toList();
                      //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      //   if (downloadUrls != null &&
                      //       downloadUrls.length == selectedMedia.length) {
                      //     setState(() => uploadedFileUrl = downloadUrls.first);
                      //     showUploadMessage(
                      //       context,
                      //       'Success!',
                      //     );
                      //   } else {
                      //     showUploadMessage(
                      //       context,
                      //       'Failed to upload media',
                      //     );
                      //     return;
                      //   }
                      // }
                    },
                    text: 'Agregar Foto',
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Color(0xFF3883E7),
                      size: 15,
                    ),
                    options: ButtonOptions(
                      width: 150,
                      height: 30,
                      color: const Color(0x00FFFFFF),
                      textStyle: AppTheme.of(context).subtitle2.override(
                            fontFamily: AppTheme.of(context).subtitle2Family,
                            color: const Color(0xFF3883E7),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                      borderSide: const BorderSide(
                        color: Color(0xFF3883E7),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    'Nombre completo',
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: AppTheme.of(context).bodyText1Family,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(35, 0, 35, 0),
                  child: TextFormField(
                    controller: textController,
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
                      fillColor: Color(0x653B9FE5),
                    ),
                    style: AppTheme.of(context).bodyText1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    widget.usuario.correo,
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: AppTheme.of(context).bodyText1Family,
                          color: const Color(0xFF5D6061),
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
                      color: const Color(0xFFCBCACA),
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
                      //TODO: agregar funcionalidad
                      // final usersUpdateData = createUsersRecordData(
                      //   photoUrl: uploadedFileUrl,
                      //   displayName: textController.text,
                      // );
                      // await currentUserReference.update(usersUpdateData);
                      // await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MisEmprendimientosWidget(),
                      //   ),
                      // );
                    },
                    text: 'Guardar cambios',
                    icon: const Icon(
                      Icons.check_rounded,
                      color: Color(0xFF3883E7),
                      size: 15,
                    ),
                    options: ButtonOptions(
                      width: 225,
                      height: 45,
                      color: const Color(0x00FFFFFF),
                      textStyle: AppTheme.of(context).subtitle2.override(
                            fontFamily: AppTheme.of(context).subtitle2Family,
                            color: const Color(0xFF3883E7),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                      borderSide: const BorderSide(
                        color: Color(0xFF3883E7),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
