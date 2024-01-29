import 'dart:io';

import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/main.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/main_screen_selector.dart';
import 'package:uwifi_control_inventory_mobile/screens/user_profile/device_information_widget.dart';
import 'package:uwifi_control_inventory_mobile/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart' as BDO;
import 'package:uwifi_control_inventory_mobile/providers/database/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/user_profile/editar_usuario_screen.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_expanded_image_view.dart';

import 'package:auto_size_text/auto_size_text.dart';

class PerfilUsuarioScreen extends StatefulWidget {
  const PerfilUsuarioScreen({Key? key}) : super(key: key);

  @override
  _PerfilUsuarioScreenState createState() => _PerfilUsuarioScreenState();
}

class _PerfilUsuarioScreenState extends State<PerfilUsuarioScreen> {
  String? dropDownValue = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> listRoles = [];

  @override
  void initState() {
    super.initState();
    listRoles = [];
    dataBase.roleBox.getAll().forEach((element) {
      listRoles.add(element.role);
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    if (usuarioProvider.usuarioCurrent == null) {
      return WillPopScope(
        onWillPop: () async => false,
        child: const Scaffold(
          body: Center(
            child: Text('Error al leer información'),
          ),
        ),
      );
    }

    final BDO.Users currentUser = usuarioProvider.usuarioCurrent!;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 230, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).secondaryColor.withOpacity(0.4),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 40, 8, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).secondaryColor.withOpacity(0.4),
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
                                              const MainScreenSelector(),
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
                                                fontFamily: AppTheme.of(context)
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
                                      "Profile of ${maybeHandleOverflow('${currentUser.firstName} ${currentUser.lastName}', 18, '...')}",
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
                            Container(
                              width: 45,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context).secondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditarUsuarioScreen(
                                                  usuario: currentUser),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit_rounded,
                                      color: AppTheme.of(context).white,
                                      size: 20,
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
                  currentUser.image.target == null
                      ? Padding(
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
                              color: AppTheme.of(context).secondaryColor,
                              child: Center(
                                child: Text(
                                  "${currentUser.firstName.substring(0, 1)} ${currentUser.lastName.substring(0, 1)}",
                                  style:
                                      AppTheme.of(context).bodyText1.override(
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
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: FlutterFlowExpandedImageView(
                                    image: Image.file(
                                      File(currentUser.image.target!.path),
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: currentUser.firstName,
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: currentUser.firstName,
                              transitionOnUserGestures: true,
                              child: Container(
                                width: 200,
                                height: 200,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: //TODO: manejar imagen de red
                                    Image.file(
                                  File(currentUser.image.target!.path),
                                  fit: BoxFit.cover,
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
                            "${currentUser.firstName} ${currentUser.lastName}",
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily:
                                      AppTheme.of(context).bodyText1Family,
                                  color: AppTheme.of(context).primaryText,
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
                      currentUser.email,
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: AppTheme.of(context).bodyText1Family,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Container(
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                child: Icon(
                                  Icons.person_rounded,
                                  color: AppTheme.of(context).white,
                                  size: 15,
                                ),
                              ),
                              Text(
                                currentUser.role.target!.role,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).white,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
      ),
    );
  }
}
