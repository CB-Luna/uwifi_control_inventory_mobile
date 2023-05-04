import 'dart:io';

import 'package:diacritic/diacritic.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/suspension_direccion_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/detalle_orden_trabajo_screen.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:taller_alex_app_asesor/screens/revision/suspension_direccion/suspension_direcciona_asignada_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_expanded_image_view.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';

class AsignacionSuspensionDireccionScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const AsignacionSuspensionDireccionScreen({
    Key? key, 
    required this.ordenTrabajo,
  }) : super(key: key);

  @override
  _AsignacionSuspensionDireccionScreenState createState() => _AsignacionSuspensionDireccionScreenState();
}

class _AsignacionSuspensionDireccionScreenState extends State<AsignacionSuspensionDireccionScreen> {
  String? dropDownValue = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> listaOpcionesTecnicosMecanicos = [];

  @override
  void initState() {
    super.initState();
    listaOpcionesTecnicosMecanicos = [];
    //Se recuperan los técnicos-mecánicos internos
    listaOpcionesTecnicosMecanicos = context.read<UsuarioController>().obtenerTecnicosMecanicosInternos();
    listaOpcionesTecnicosMecanicos.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
  }

  @override
  Widget build(BuildContext context) {
    final suspensionDireccionProvider = Provider.of<SuspensionDireccionController>(context);
    listaOpcionesTecnicosMecanicos = context.read<UsuarioController>().obtenerTecnicosMecanicosInternos();
    listaOpcionesTecnicosMecanicos.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 40, 8, 0),
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
                                    color: FlutterFlowTheme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      suspensionDireccionProvider.limpiarInformacion();
                                      await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetalleOrdenTrabajoScreen(
                                              ordenTrabajo: widget.ordenTrabajo,
                                              pantalla: "pantallaRevision",
                                            ),
                                      ),
                                    );
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
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: FlutterFlowTheme.of(context)
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
                                      "Suspensión/Dirección del Vehículo",
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
                  suspensionDireccionProvider.tecnicoMecanicoInterno?.path == null ?
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
                          color: FlutterFlowTheme.of(context).primaryColor,
                          child: Center(
                            child: Text(
                              suspensionDireccionProvider.tecnicoMecanicoInterno == null ?
                              "T M"
                              :
                              "${suspensionDireccionProvider.tecnicoMecanicoInterno!.nombre.substring(0, 1)} ${
                                suspensionDireccionProvider.tecnicoMecanicoInterno!.apellidoP.substring(0, 1)}",
                              style:
                                  FlutterFlowTheme.of(context).bodyText1.override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyText1Family,
                                        color: Colors.white,
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
                                  File(suspensionDireccionProvider.tecnicoMecanicoInterno!.path!),
                                  fit: BoxFit.contain,
                                ),
                                allowRotation: false,
                                tag: suspensionDireccionProvider.tecnicoMecanicoInterno!.nombre,
                                useHeroAnimation: true,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: suspensionDireccionProvider.tecnicoMecanicoInterno!.nombre,
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
                              File(suspensionDireccionProvider.tecnicoMecanicoInterno!.path!),
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
                            suspensionDireccionProvider.tecnicoMecanicoInterno == null ?
                            "Correo del Técnico/Mécanico Interno"
                            :
                            suspensionDireccionProvider.tecnicoMecanicoInterno!.correo,
                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily:
                                      FlutterFlowTheme.of(context).bodyText1Family,
                                  color: FlutterFlowTheme.of(context).primaryText,
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
                      suspensionDireccionProvider.tecnicoMecanicoInterno == null ?
                      "Celular del Técnico/Mécanico Interno"
                      :
                      suspensionDireccionProvider.tecnicoMecanicoInterno!.celular,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: FlutterFlowTheme.of(context).bodyText1Family,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: Container(
                      width: 250,
                      height: 30,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryColor,
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
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                child: Icon(
                                  Icons.person_rounded,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              Text(
                                suspensionDireccionProvider.tecnicoMecanicoInterno == null ?
                                "Nombre Técnico/Mecánico Interno"
                                :
                                maybeHandleOverflow('${suspensionDireccionProvider.tecnicoMecanicoInterno!.nombre} ${
                                  suspensionDireccionProvider.tecnicoMecanicoInterno!.apellidoP} ${
                                  suspensionDireccionProvider.tecnicoMecanicoInterno!.apellidoM}', 30, '...'),
                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).bodyText1Family,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                    child: Autocomplete(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return listaOpcionesTecnicosMecanicos.where((String option) {
                          return option
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      optionsViewBuilder: (context, Function(String) onSelected, options) {
                        return Material(
                          elevation: 4,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            separatorBuilder:(context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);
                              final title = option.toString().split(" ").last;
                              List<String> listSubtitle = option.toString().split(" ");
                              listSubtitle.removeLast();
                              final subtitle = listSubtitle.join(" ");
                              return ListTile(
                                leading: Icon(
                                  Icons.car_rental,
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                ),
                                onTap: () {
                                  onSelected(option.toString());
                                },
                                title: SubstringHighlight(
                                  text: title,
                                  term: suspensionDireccionProvider.tecnicoMecanicoCelularCorreoController.text,
                                  textStyleHighlight: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: SubstringHighlight(
                                  text: subtitle,
                                  term: suspensionDireccionProvider.tecnicoMecanicoCelularCorreoController.text,
                                  textStyleHighlight: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                hoverColor: Colors.grey[200],
                              );
                            },
                          ),
                        );
                      },
                      onSelected: (String selection) {
                        suspensionDireccionProvider.seleccionarTecnicoMecanicoCelularCorreo(selection);
                      },
                      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                        suspensionDireccionProvider.tecnicoMecanicoCelularCorreoController = controller;
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          textCapitalization:
                              TextCapitalization.characters,
                          onChanged: (value) {
                              suspensionDireccionProvider.enCambioTecnicoMecanicoCelularCorreo(value);
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.construction_outlined,
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                            labelText: 'Nombre, RFC, Correo Técnico-Mecánico Interno*',
                            labelStyle: FlutterFlowTheme.of(context)
                                .title3
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).grayDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            hintText: 'Ingrese el nombre, rfc o correo del técnico-mecánico...',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor.withOpacity(0.5),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          validator: (val) {
                            if (val == "" ||
                                val == null) {
                              return 'El Nombre, RFC o Correo del técnico-mecánico es requerido.';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: suspensionDireccionProvider.tecnicoMecanicoCelularCorreoSeleccionado == suspensionDireccionProvider.tecnicoMecanicoCelularCorreoIngresado,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (suspensionDireccionProvider.asignarTecnicoMecanicoInterno(widget.ordenTrabajo)) {
                            suspensionDireccionProvider.limpiarInformacion();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SuspensionDireccionAsignadaScreen(
                                      ordenTrabajo: widget.ordenTrabajo,
                                    ),
                              ),
                            );
                          } else {
                            snackbarKey.currentState?.showSnackBar(const SnackBar(
                              content: Text("No se pudo asignar la revisión de la Suspensión/Dirección del vehículo al técnico-mecánico seleccionado, intente más tarde."),
                            ));
                          }
                        },
                        text: 'Aceptar',
                        options: FFButtonOptions(
                          width: 200,
                          height: 50,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle1.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                          elevation: 3,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
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
