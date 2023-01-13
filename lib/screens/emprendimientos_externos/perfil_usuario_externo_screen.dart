import 'dart:io';
import 'dart:ui';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/modelsEmiWeb/temporals/get_emp_externo_emi_web_temp.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_emp_externo_pocketbase_temp.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/usuario_proyectos_temporal.dart';
import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/emprendimientos_externos/usuarios_externos_screen.dart';
import 'package:bizpro_app/screens/sync/descarga_proyectos_externos_emi_web.screen.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_mensaje_pop_up_usuario.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/toggle_icon.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilUsuarioExternoScreen extends StatefulWidget {
  final List<UsuarioProyectosTemporal> listUsuariosProyectosTemp;
  final UsuarioProyectosTemporal usuarioProyectosTemporal;

  const PerfilUsuarioExternoScreen({
    Key? key,
    required this.listUsuariosProyectosTemp,
    required this.usuarioProyectosTemporal,
  }) : super(key: key);

  @override
  _PerfilUsuarioExternoScreenState createState() =>
      _PerfilUsuarioExternoScreenState();
}

class _PerfilUsuarioExternoScreenState extends State<PerfilUsuarioExternoScreen>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  String emprendimientoSelected = "";
  List<Payload> listProyectoTemp = [];
  @override
  void initState() {
    emprendimientoSelected = "";
    listProyectoTemp =
        widget.usuarioProyectosTemporal.emprendimientosTemp.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);

    listProyectoTemp =
        widget.usuarioProyectosTemporal.emprendimientosTemp.toList();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.41,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UsuariosExternosScreen(
                                              listUsuariosProyectosTemp: widget
                                                  .listUsuariosProyectosTemp,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 20,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: const [
                                              Icon(
                                                Icons.arrow_back_outlined,
                                                color: Color(0xFF4672FF),
                                                size: 25,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 50, 0, 0),
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 10,
                                    shape: const CircleBorder(),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF4672FF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: widget.usuarioProyectosTemporal
                                                  .pathImagenPerfil ==
                                              null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(3, 3, 3, 3),
                                              child: Container(
                                                width: 130,
                                                height: 130,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    width: 3.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(5, 5, 5, 5),
                                                  child: SizedBox(
                                                    width: 80,
                                                    height: 80,
                                                    child: Center(
                                                      child: Text(
                                                        "${widget.usuarioProyectosTemporal.usuarioTemp.nombre.substring(0, 1)} ${widget.usuarioProyectosTemporal.usuarioTemp.apellidoPaterno.substring(0, 1)}",
                                                        style:
                                                            AppTheme.of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily: AppTheme.of(
                                                                          context)
                                                                      .bodyText1Family,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 50,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(3, 3, 3, 3),
                                              child: Container(
                                                width: 130,
                                                height: 130,
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0x00EEEEEE),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(File(widget
                                                          .usuarioProyectosTemporal
                                                          .pathImagenPerfil!))),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 5, 0),
                              child: Text(
                                widget.usuarioProyectosTemporal.usuarioTemp
                                    .nombre,
                                style: AppTheme.of(context).title1.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Text(
                              "${widget.usuarioProyectosTemporal.usuarioTemp.apellidoPaterno} ${widget.usuarioProyectosTemporal.usuarioTemp.apellidoMaterno}",
                              style: AppTheme.of(context).title1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Teléfono:',
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                        textAlign: TextAlign.justify,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: Text(
                          widget.usuarioProyectosTemporal.usuarioTemp
                                      .telefono ==
                                  "Vacío"
                              ? "Sin teléfono"
                              : widget.usuarioProyectosTemporal.usuarioTemp
                                  .telefono,
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Celular:',
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: Text(
                          widget.usuarioProyectosTemporal.usuarioTemp.celular ??
                              "Sin celular",
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Fecha Nacimiento:',
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: Text(
                          widget.usuarioProyectosTemporal.usuarioTemp
                                      .fechaNacimiento !=
                                  null
                              ? dateTimeFormat(
                                  "dd-MM-yyyy",
                                  widget.usuarioProyectosTemporal.usuarioTemp
                                      .fechaNacimiento!)
                              : "",
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Emprendimientos de ${widget.usuarioProyectosTemporal.usuarioTemp.nombre}',
                      style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: const Color(0xFF4672FF),
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Buscar Emprendimiento/Emprendedor...',
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
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 10),
            child: FFButtonWidget(
              onPressed: () async {
                if (emprendimientoSelected != "") {
                  print("Emprendimiento: $emprendimientoSelected");

                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: BottomSheetMensajeWidget(
                              isVisible: true,
                              idEmprendimiento: emprendimientoSelected,
                              usuario: usuarioProvider.usuarioCurrent!,
                              usuarioProyectosTemporal:
                                  widget.usuarioProyectosTemporal),
                        ),
                      );
                    },
                  );
                } else {
                  await showDialog(
                    context: context,
                    builder: (alertDialogContext) {
                      return AlertDialog(
                        title: const Text('Campos vacíos'),
                        content: const Text(
                            'Para continuar, debes seleccionar un emprendimiento de la lista.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(alertDialogContext),
                            child: const Text('Bien'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              text: 'Descargar Proyecto',
              icon: const Icon(
                Icons.check_rounded,
                size: 20,
              ),
              options: FFButtonOptions(
                width: 200,
                height: 40,
                color: AppTheme.of(context).secondaryText,
                textStyle: AppTheme.of(context).subtitle2.override(
                      fontFamily: AppTheme.of(context).subtitle2Family,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(builder: (context) {
              if (searchController.text != '') {
                listProyectoTemp.removeWhere((element) {
                  final nombreEmprendimiento =
                      removeDiacritics(element.proyecto.emprendimiento)
                          .toLowerCase();
                  final nombreEmprendedor = removeDiacritics(
                          '${element.proyecto.emprendedor.nombre} ${element.proyecto.emprendedor.apellidos}')
                      .toLowerCase();
                  final tempBusqueda =
                      removeDiacritics(searchController.text).toLowerCase();
                  if (nombreEmprendimiento.contains(tempBusqueda) ||
                      nombreEmprendedor.contains(tempBusqueda)) {
                    return false;
                  }
                  return true;
                });
              }
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: SingleChildScrollView(
                  child: ListView.builder(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                    shrinkWrap: true,
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: listProyectoTemp.length,
                    itemBuilder: (context, index) {
                      final emprendimientoTemp = listProyectoTemp[index];
                      return Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: Row(
                          children: [
                            ToggleIcon(
                              onPressed: () {
                                setState(() {
                                  // emprendimientoTemp.proyecto.selected =
                                  //     !emprendimientoTemp.proyecto.selected;
                                  print(
                                      "****Selected de ${emprendimientoTemp.proyecto.emprendimiento} es ${emprendimientoTemp.proyecto.selected}");
                                  // Cuando se selecciona por segunda vez el mismo item entonces se mandaria una cadena vacia. EmprendimientoSelected
                                  if (emprendimientoTemp.proyecto.selected) {
                                    emprendimientoSelected = "";
                                    // Cambia el estado.
                                    emprendimientoTemp.proyecto.selected =
                                        !emprendimientoTemp.proyecto.selected;
                                  } else {
                                    // Cuando se selecciona por primera vez el item
                                    for (var element in widget
                                        .usuarioProyectosTemporal
                                        .emprendimientosTemp) {
                                      element.proyecto.selected = false;
                                    }
                                    emprendimientoSelected = emprendimientoTemp
                                        .proyecto.idProyecto
                                        .toString();
                                    emprendimientoTemp.proyecto.selected =
                                        !emprendimientoTemp.proyecto.selected;
                                  }
                                });
                              },
                              value: emprendimientoTemp.proyecto.selected,
                              onIcon: const Icon(
                                Icons.radio_button_checked_outlined,
                                color: Color(0xFF4672FF),
                                size: 40,
                              ),
                              offIcon: const Icon(
                                Icons.radio_button_off_outlined,
                                color: Color(0xFF4672FF),
                                size: 40,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(5)),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.76,
                              height: 165,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // image: DecorationImage(
                                //   fit: BoxFit.cover,
                                //   image: Image.asset(
                                //     'assets/images/mesgbluegradient.jpeg',
                                //   ).image,
                                // ),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Color(0x2B202529),
                                    offset: Offset(0, 3),
                                    spreadRadius: 5,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 16, 16, 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ClipRRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 10,
                                          sigmaY: 5,
                                        ),
                                        child: Container(
                                          width: 350,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            color: const Color(0x6CFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 10, 10, 10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  maybeHandleOverflow(
                                                      emprendimientoTemp
                                                          .proyecto
                                                          .emprendimiento,
                                                      25,
                                                      "..."),
                                                  style: AppTheme.of(context)
                                                      .title2
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        color: Colors.black,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 4, 0, 4),
                                                  child: Text(
                                                    maybeHandleOverflow(
                                                        "${emprendimientoTemp.proyecto.emprendedor.nombre} ${emprendimientoTemp.proyecto.emprendedor.apellidos}",
                                                        40,
                                                        "..."),
                                                    style: AppTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 4, 0, 4),
                                                  child: Text(
                                                    maybeHandleOverflow(
                                                        emprendimientoTemp
                                                                    .proyecto
                                                                    .emprendedor
                                                                    .comentarios ==
                                                                ""
                                                            ? "Sin Comentarios"
                                                            : emprendimientoTemp
                                                                .proyecto
                                                                .emprendedor
                                                                .comentarios!,
                                                        40,
                                                        "..."),
                                                    style: AppTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
