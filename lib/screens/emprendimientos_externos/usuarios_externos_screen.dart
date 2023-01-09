import 'dart:io';

import 'package:bizpro_app/modelsPocketbase/temporals/usuario_proyectos_temporal.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:bizpro_app/screens/emprendimientos_externos/perfil_usuario_externo_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_icon_button.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:flutter/material.dart';

class UsuariosExternosScreen extends StatefulWidget {

  final List<UsuarioProyectosTemporal> listUsuariosProyectosTemp;

  const UsuariosExternosScreen({
    Key? key, 
    required this.listUsuariosProyectosTemp,
  }) : super(key: key);

  @override
  _UsuariosExternosScreenState createState() =>
      _UsuariosExternosScreenState();
}

class _UsuariosExternosScreenState extends State<UsuariosExternosScreen>
    with TickerProviderStateMixin {

  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: FlutterIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF4672FF),
            size: 30,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                      const EmprendimientosScreen(),
              ),
            );
          },
        ),
        title: Text(
          'Usuarios Registrados',
          style: AppTheme.of(context).title3.override(
                fontFamily: 'Outfit',
                color: const Color(0xFF1D2429),
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                child: TextFormField(
                  controller: textController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Buscar usuario registrado...',
                    labelStyle: AppTheme.of(context).bodyText2.override(
                          fontFamily: 'Outfit',
                          color: const Color(0xFF57636C),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF1F4F8),
                    prefixIcon: const Icon(
                      Icons.search_outlined,
                      color: Color(0xFF57636C),
                    ),
                  ),
                  style: AppTheme.of(context).bodyText1.override(
                        fontFamily: 'Outfit',
                        color: const Color(0xFF1D2429),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                  maxLines: null,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    controller: ScrollController(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.listUsuariosProyectosTemp.length,
                    itemBuilder: (context, index) {
                      final usuarioProyectoTemp = widget.listUsuariosProyectosTemp[index];
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 15, 15, 10),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    elevation: 10,
                                    shape: const CircleBorder(),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF4672FF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: 
                                      usuarioProyectoTemp.pathImagenPerfil == null ?
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            3, 3, 3, 3),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: Center(
                                              child: Text(
                                                "${usuarioProyectoTemp.usuarioTemp.nombre
                                                .substring(0, 1)} ${usuarioProyectoTemp
                                                .usuarioTemp.apellidoPaterno.substring(0, 1)}",
                                                style:
                                                  AppTheme.of(context).bodyText1.override(
                                                        fontFamily: AppTheme.of(context)
                                                            .bodyText1Family,
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      :
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            3, 3, 3, 3),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: const Color(0x00EEEEEE),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(usuarioProyectoTemp.pathImagenPerfil!))),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  12, 0, 0, 0),
                                          child: Text(
                                            "${usuarioProyectoTemp
                                              .usuarioTemp.nombre} ${
                                              usuarioProyectoTemp
                                              .usuarioTemp.apellidoPaterno} ${
                                              usuarioProyectoTemp
                                              .usuarioTemp.apellidoMaterno}",
                                            style: AppTheme.of(context)
                                                .subtitle1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: const Color(0xFF1D2429),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(12, 0, 0, 0),
                                                child: Text(
                                                  'Celular: ${
                                                  usuarioProyectoTemp
                                                  .usuarioTemp
                                                  .celular ?? "Sin celular"}',
                                                  style: AppTheme.of(
                                                          context)
                                                      .bodyText2
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color:
                                                            const Color(0xFF57636C),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                                PerfilUsuarioExternoScreen(
                                                  listUsuariosProyectosTemp: 
                                                    widget.listUsuariosProyectosTemp,
                                                  usuarioProyectosTemporal:
                                                    usuarioProyectoTemp,
                                                ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: const Color(0xFF4672FF),
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 4, 4),
                                        child: Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
