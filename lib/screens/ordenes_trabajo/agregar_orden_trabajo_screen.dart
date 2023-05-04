import 'package:diacritic/diacritic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/orden_trabajo_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/orden_trabajo_creada_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/orden_trabajo_no_creada_screen.dart';
import 'package:taller_alex_app_asesor/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';

class AgregarOrdenTrabajoScreen extends StatefulWidget {
  AgregarOrdenTrabajoScreen({Key? key}) : super(key: key);

  @override
  _AgregarOrdenTrabajoScreenState createState() =>
      _AgregarOrdenTrabajoScreenState();
}

class _AgregarOrdenTrabajoScreenState extends State<AgregarOrdenTrabajoScreen> {
  XFile? image;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ordenTrabajoFormKey = GlobalKey<FormState>();
  final _unfocusNode = FocusNode();
  List<String> listaOpcionesVehiculos = [];
  List<String> listaMedidas = ["Km", "Millas"];
  String medida = "Km";
  

  @override
  void initState() {
    super.initState();
    listaOpcionesVehiculos = [];
    if (context.read<UsuarioController>().usuarioCurrent != null) {
    listaOpcionesVehiculos = context.read<UsuarioController>().obtenerOpcionesVehiculos();
    listaOpcionesVehiculos.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    print(listaOpcionesVehiculos);
    }
  }
  @override
  Widget build(BuildContext context) {
    final ordenTrabajoProvider = Provider.of<OrdenTrabajoController>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
    if (usuarioProvider.usuarioCurrent != null) {
      listaOpcionesVehiculos = usuarioProvider.obtenerOpcionesVehiculos();
      listaOpcionesVehiculos.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Form(
              key: ordenTrabajoFormKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20, 45, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text(
                                        '¿Seguro que quieres abandonar esta pantalla?'),
                                    content: const Text(
                                        'La información ingresada se perderá.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          ordenTrabajoProvider.limpiarInformacion();
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrdenesTrabajoScreen(),
                                            ),
                                          );
                                        },
                                        child:
                                            const Text('Abandonar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:
                                            const Text('Cancelar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
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
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, 15, 0, 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Registro Orden de Trabajo',
                          style:
                              FlutterFlowTheme.of(context).title1.override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText1Family,
                                    fontSize: 18,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: "${usuarioProvider.usuarioCurrent?.nombre} ${usuarioProvider.usuarioCurrent?.apellidoP} ${usuarioProvider.usuarioCurrent?.apellidoM}",
                      textCapitalization:
                          TextCapitalization.words,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                        labelText: 'Asesor*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el asesor...',
                        hintStyle: FlutterFlowTheme.of(context).bodyText2,
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16, 6, 16, 16),
                    child: TextFormField(
                        controller: ordenTrabajoProvider.fechaOrdenController,
                        autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                        onTap: () async {
                          await DatePicker.showDatePicker(
                            context,
                            locale: LocaleType.es,
                            showTitleActions: true,
                            onConfirm: (date) {
                              setState(() {
                                ordenTrabajoProvider.fechaOrden = date;
                                ordenTrabajoProvider.fechaOrdenController = TextEditingController(text: dateTimeFormat('d/MMMM/y', date));
                              });
                            },
                            currentTime: getCurrentTimestamp,
                            // minTime: getCurrentTimestamp.subtract(Duration(days: 7)),
                          );
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Fecha Orden de Trabajo*',
                          labelStyle:
                              FlutterFlowTheme.of(context).title3.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .grayDark,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                          hintText: 'Ingresa la Fecha de la Orden de Trabajo...',
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
                        prefixIcon: Icon(
                            Icons.date_range_outlined,
                            color: FlutterFlowTheme.of(context)
                                .primaryColor,
                            size: 24,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.none,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'La Fecha de la Orden de Trabajo es requerida.';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                    child: Autocomplete(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return listaOpcionesVehiculos.where((String option) {
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
                                  term: ordenTrabajoProvider.clienteVINPlacasController.text,
                                  textStyleHighlight: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: SubstringHighlight(
                                  text: subtitle,
                                  term: ordenTrabajoProvider.clienteVINPlacasController.text,
                                  textStyleHighlight: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                hoverColor: Colors.grey[200],
                              );
                            },
                          ),
                        );
                      },
                      onSelected: (String selection) {
                        ordenTrabajoProvider.seleccionarClienteVINPlacas(selection);
                      },
                      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                        ordenTrabajoProvider.clienteVINPlacasController = controller;
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          textCapitalization:
                              TextCapitalization.characters,
                          onChanged: (value) {
                              ordenTrabajoProvider.enCambioClienteVINPlacas(value);
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.car_rental_outlined,
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                            labelText: 'Cliente, VIN, Placas*',
                            labelStyle: FlutterFlowTheme.of(context)
                                .title3
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).grayDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            hintText: 'Ingrese el Nombre del cliente, VIN o placas del vehículo...',
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
                              return 'El Nombre del cliente, VIN o placas del vehículo son requeridas.';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: ordenTrabajoProvider.clienteVINPlacasSeleccionado == ordenTrabajoProvider.clienteVINPlacasIngresado,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 200,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).grayLighter,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x32000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child:
                                  getImageEmprendimiento(
                                    ordenTrabajoProvider.vehiculo?.path,
                                    height: 200
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).grayLighter,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x43000000),
                                      offset: Offset(-4, 8),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional
                                            .all(8),
                                    child: Column(
                                      mainAxisSize:
                                          MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets
                                                  .symmetric(
                                              vertical: 5),
                                          child: Text(
                                            maybeHandleOverflow(
                                                "${ordenTrabajoProvider
                                                  .vehiculo?.
                                                  cliente.target?.nombre} ${
                                                  ordenTrabajoProvider.vehiculo?.
                                                  cliente.target?.apellidoP} ${
                                                  ordenTrabajoProvider.vehiculo?.
                                                  cliente.target?.apellidoM}",
                                                25,
                                                "..."),
                                            style:
                                                FlutterFlowTheme.of(
                                                        context)
                                                    .subtitle1
                                                    .override(
                                                      fontFamily: FlutterFlowTheme.of(
                                                              context)
                                                          .subtitle1Family,
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight
                                                              .w600,
                                                    ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets
                                                  .symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisSize:
                                                MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                maybeHandleOverflow("${ordenTrabajoProvider
                                                .vehiculo?.marca} - ${ordenTrabajoProvider
                                                .vehiculo?.modelo}", 40, "..."),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .subtitle1
                                                    .override(
                                                      fontFamily: FlutterFlowTheme.of(
                                                              context)
                                                          .subtitle1Family,
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight
                                                              .w600,
                                                    ),
                                              ),
                                              Text(
                                                "${ordenTrabajoProvider
                                                .vehiculo?.anio}",
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .subtitle1
                                                    .override(
                                                      fontFamily: FlutterFlowTheme.of(
                                                              context)
                                                          .subtitle1Family,
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight
                                                              .w600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets
                                                  .symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisSize:
                                                MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                "${ordenTrabajoProvider
                                                .vehiculo?.placas}",
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyText1Family,
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .grayDark,
                                                      fontSize: 14,
                                                    ),
                                              ),
                                              Text(
                                                "${ordenTrabajoProvider
                                                .vehiculo?.motor}",
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyText1Family,
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .grayDark,
                                                      fontSize: 14,
                                                    ),
                                              ),
                                              Text(
                                                "${ordenTrabajoProvider
                                                .vehiculo?.color}",
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyText1Family,
                                                      color: FlutterFlowTheme.of(
                                                              context)
                                                          .grayDark,
                                                      fontSize: 14,
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
                            ],
                          ),
                        ),
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Row(
                                  children: [
                                    PopupMenuButton(
                                      onSelected: ((e) {
                                        setState(() {
                                          medida = e.toString();
                                        });
                                      }),
                                      itemBuilder: ((context) {
                                        return listaMedidas.map((e) => PopupMenuItem(value: e, child: Text(e))).toList();
                                      }),
                                      child: Row(
                                        children: [
                                          Text(medida),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: FlutterFlowTheme.of(context).primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          ordenTrabajoProvider.kilometrajeMillaje = value;
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.speed_outlined,
                                            color: FlutterFlowTheme.of(context).primaryColor,
                                          ),
                                          labelText: medida == "Millas" ? 'Millaje*' : 'Kilometraje*',
                                          labelStyle: FlutterFlowTheme.of(context)
                                              .title3
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: FlutterFlowTheme.of(context).grayDark,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                          hintText: medida == "Millas" ? 'Ingrese el millaje...' : 'Ingrese el kilometraje...',
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
                                          suffixText: medida,
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyText1,
                                        textAlign: TextAlign.start,
                                        keyboardType: const TextInputType.numberWithOptions(decimal: false),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                              return medida == "Millas" ? 'El Millaje es requerido.' : 'El Kilometraje es requerido.';
                                            } 
                                            return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: TextFormField(
                            controller: ordenTrabajoProvider.gasolinaController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onTap: () async {
                              await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  final ordenTrabajoProvider = Provider.of<OrdenTrabajoController>(context);
                                  return AlertDialog(
                                    title: const Text("Porcentaje de Gasolina"),
                                    content: SizedBox( // Need to use container to add size constraint.
                                      width: 300,
                                      height: 300,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            SemicircularIndicator(
                                              progress: ordenTrabajoProvider.porcentajeGasolina * 0.01,
                                              radius: 100,
                                              color: FlutterFlowTheme.of(context).primaryColor,
                                              backgroundColor: FlutterFlowTheme.of(context).grayLighter,
                                              strokeWidth: 13,
                                              bottomPadding: 0,
                                              contain: true,
                                              child: Text(
                                                "${ordenTrabajoProvider.porcentajeGasolina} %",
                                                style: TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.w600,
                                                    color: FlutterFlowTheme.of(context).primaryColor),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 250,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                Icon(
                                                  Icons.local_gas_station_outlined,
                                                  color: FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                                  size: 40,
                                                ),
                                                Icon(
                                                  Icons.local_gas_station_rounded,
                                                  color: FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                                  size: 40,
                                                )
                                              ],),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SfSlider(
                                                  min: 0.0,
                                                  max: 100.0,
                                                  interval: 1.0,
                                                  value: ordenTrabajoProvider.porcentajeGasolina, 
                                                  stepSize: 1.0,
                                                  activeColor: FlutterFlowTheme.of(context).secondaryColor,
                                                  inactiveColor: FlutterFlowTheme.of(context).grayLighter,
                                                  onChanged: ((value) {
                                                    ordenTrabajoProvider.actualizarPorcentajeGasolina(value.truncate());
                                                  })
                                                ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  setState(() {
                                                    ordenTrabajoProvider.gasolinaController = TextEditingController(
                                                      text: ordenTrabajoProvider.porcentajeGasolina.toString()
                                                    );
                                                  });
                                                  Navigator.pop(context);
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                              },
                            obscureText: false,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.local_gas_station_outlined,
                                color: FlutterFlowTheme.of(context).primaryColor,
                              ),
                              labelText: 'Gasolina*',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .title3
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).grayDark,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              hintText: 'Ingrese la gasolina...',
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
                              suffixText: '%',
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.none,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                  return 'El porcentaje de Gasolina es requerido.';
                                } 
                                return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              ordenTrabajoProvider.descripcionFalla = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.info_outlined,
                                color: FlutterFlowTheme.of(context).dark400,
                              ),
                              labelText: 'Descripción de la Falla',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .title3
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).grayDark,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              hintText: 'Ingrese la descripción de la falla...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).grayDark,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).dark400,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).dark400,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).dark400,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                            textAlign: TextAlign.start,
                            maxLines: 4,
                            textCapitalization:
                                TextCapitalization.sentences,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (ordenTrabajoProvider
                                    .validateForm(ordenTrabajoFormKey)) {
                              //Se crea la orden de Trabajo
                              if (ordenTrabajoProvider.add(usuarioProvider.usuarioCurrent!, medida)) {
                                //Se limpia la información del Provider
                                ordenTrabajoProvider
                                    .limpiarInformacion();
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrdenTrabajoCreadaScreen(),
                                  ),
                                );
                              } else {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrdenTrabajoNoCreadaScreen(),
                                  ),
                                );
                              }
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title:
                                        const Text('Campos requeridos vacíos.'),
                                    content: const Text(
                                        'Para continuar, debe llenar todos los campos requeridos.'),
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
                            text: 'Registrar',
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
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
