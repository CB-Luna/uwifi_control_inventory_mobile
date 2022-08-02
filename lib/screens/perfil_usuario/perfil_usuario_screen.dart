import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/perfil_usuario/device_information_widget.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:bizpro_app/screens/widgets/expanded_image_view.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PerfilUsuarioScreen extends StatefulWidget {
  const PerfilUsuarioScreen({Key? key}) : super(key: key);

  @override
  State<PerfilUsuarioScreen> createState() => _PerfilUsuarioScreenState();
}

class _PerfilUsuarioScreenState extends State<PerfilUsuarioScreen> {
  String? dropDownValue = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);

    if (usuarioProvider.usuarioCurrent == null) {
      return const Scaffold(
        body: Center(
          child: Text('Error al leer información'),
        ),
      );
    }

    final Usuarios currentUser = usuarioProvider.usuarioCurrent!;

    //TODO: almacenar imagen?
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
                                              fontFamily: 'Poppins',
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
                                    'Perfil de ${currentUser.nombre}',
                                    maxLines: 2,
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 5, 0),
                            child: InkWell(
                              onTap: () async {
                                //TODO: agregar pantalla
                                // await Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => EditarUsuarioWidget(),
                                //   ),
                                // );
                              },
                              child: const Icon(
                                Icons.edit_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: ExpandedImageView(
                            //TODO: manejar imagenes de red
                            image: Image.asset(
                              currentUserPhoto,
                              fit: BoxFit.contain,
                            ),
                            allowRotation: false,
                            tag: currentUserPhoto,
                            useHeroAnimation: true,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: currentUserPhoto,
                      transitionOnUserGestures: true,
                      child: Container(
                        width: 200,
                        height: 200,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        //TODO: manejar imagen de red
                        child: Image.asset(
                          currentUserPhoto,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
                        child: Text(
                          currentUser.nombre,
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    currentUser.correo,
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Container(
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBCACA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dropDownValue ?? '',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                  child: DropDown(
                    options: const [
                      'Emprendedor',
                      'Promotor',
                      'Staff logística',
                      'Staff dirección',
                      'Amigo del cambio',
                      'Voluntario estratégico',
                      'Administrador'
                    ],
                    onChanged: (val) => setState(() => dropDownValue = val),
                    width: 280,
                    height: 50,
                    textStyle: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                    hintText: 'Tipo de usuario...',
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF0ECFFC),
                      size: 30,
                    ),
                    fillColor: Colors.white,
                    elevation: 2,
                    borderColor: const Color(0xFF0ECFFC),
                    borderWidth: 2,
                    borderRadius: 8,
                    margin: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                    hidesUnderline: true,
                  ),
                ),
                const Flexible(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DeviceInformationWidget(),
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
