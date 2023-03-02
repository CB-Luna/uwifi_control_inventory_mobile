import 'package:diacritic/diacritic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
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
  const AgregarOrdenTrabajoScreen({Key? key}) : super(key: key);

  @override
  _AgregarOrdenTrabajoScreenState createState() =>
      _AgregarOrdenTrabajoScreenState();
}

class _AgregarOrdenTrabajoScreenState extends State<AgregarOrdenTrabajoScreen> {
  XFile? image;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ordenTrabajoFormKey = GlobalKey<FormState>();
  final _unfocusNode = FocusNode();
  List<String> listaClientes = [];
  String cliente = "";
  String correo = "";
  String formaPago = "";
  List<String> listaVehiculos = [];
  List<String> listaMedidas = ["Km", "Millas"];
  String medida = "Km";
  String vehiculo = "";
  String vin = "";
  

  @override
  void initState() {
    super.initState();
    listaClientes = [];
    listaVehiculos = [];
    cliente = "";
    correo = "";
    vehiculo = "";
    vin = "";
    formaPago = "";
    if (context.read<UsuarioController>().usuarioCurrent != null) {
    listaVehiculos = context.read<UsuarioController>().obtenerVehiculos();
    listaVehiculos.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    print(listaVehiculos);
    }
  }
  @override
  Widget build(BuildContext context) {
    final ordenTrabajoProvider = Provider.of<OrdenTrabajoController>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
    if (usuarioProvider.usuarioCurrent != null) {
      listaVehiculos = usuarioProvider.obtenerVehiculos();
      listaVehiculos.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
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
                                                  const EmprendimientosScreen(),
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
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
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
                            // minTime: getCurrentTimestamp.subtract(const Duration(days: 7)),
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
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                        suffixIcon: Icon(
                            Icons.date_range_outlined,
                            color: FlutterFlowTheme.of(context)
                                .secondaryText,
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
                    child: TextFormField(
                      controller: ordenTrabajoProvider.vinController,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      textCapitalization:
                          TextCapitalization.characters,
                      onChanged: (value) {
                          print("Lista de vehiculos antes de enviar: $listaVehiculos");
                          ordenTrabajoProvider.enCambioVIN(value, listaVehiculos);
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'VIN*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el VIN del vehículo...',
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
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
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
                          return 'El VIN del vehículo es requerido.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Visibility(
                    visible: ordenTrabajoProvider.vinController.text.length >= 3 && ordenTrabajoProvider.opcionesVehiculos.isNotEmpty ? true : false,
                    child: SizedBox(
                      height: 100,
                      child: Material(
                        child: ListView.builder(
                          controller: ScrollController(),
                          itemCount: ordenTrabajoProvider.opcionesVehiculos.length,
                          itemBuilder: (_, index) {
                            final vin = ordenTrabajoProvider.opcionesVehiculos[index];
                            return ListTile(
                              leading: Icon(
                                Icons.car_rental,
                                color: FlutterFlowTheme.of(context).primaryColor,
                              ),
                              title: Text(vin),
                              onTap: () {
                                  ordenTrabajoProvider.seleccionarVIN(vin);
                              },
                              hoverColor: Colors.grey[200],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                  //   child: Builder(
                  //   builder: (context) {
                  //     //Busqueda
                  //     if (searchController.text != '') {
                  //       ordenesTrabajo.removeWhere((element) {
                  //         final nombreCliente =
                  //             removeDiacritics("${element.cliente.target!.nombre} ${element.cliente.target!.apellidoP} ${element.cliente.target?.apellidoM}")
                  //                 .toLowerCase();
                  //         final modelo = removeDiacritics(
                  //                 element.vehiculo.target!.modelo)
                  //             .toLowerCase();
                  //         final marca = removeDiacritics(
                  //                 element.vehiculo.target!.marca)
                  //             .toLowerCase();
                  //         final descripcion = removeDiacritics(
                  //                 element.descripcion)
                  //             .toLowerCase();
                  //         final tempBusqueda =
                  //             removeDiacritics(searchController.text)
                  //                 .toLowerCase();
                  //         if (nombreCliente.contains(tempBusqueda) ||
                  //             modelo.contains(tempBusqueda) ||
                  //             marca.contains(tempBusqueda) ||
                  //             descripcion.contains(tempBusqueda)) {
                  //           return false;
                  //         }
                  //         return true;
                  //       });
                  //     }
                  //     return SingleChildScrollView(
                  //       child: ListView.builder(
                  //         reverse: true,
                  //         padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                  //         shrinkWrap: true,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         scrollDirection: Axis.vertical,
                  //         itemCount: ordenesTrabajo.length,
                  //         itemBuilder: (context, resultadoIndex) {
                  //           final ordenTrabajo =
                  //               ordenesTrabajo[resultadoIndex];
                  //             return  TargetaOrdenTrabajoDescripcion(
                  //                 ordenTrabajo: ordenTrabajo);
                  //         },
                  //       ),
                  //     );
                  //   },
                  // )
                  // ),
                  // FormField(
                  //   builder: (state) {
                  //     return Padding(
                  //       padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                  //       child: DropDown(
                  //         options: (cliente == "" &&
                  //             listaClientes.isEmpty)
                  //         ? ["Sin clientes"]
                  //         : listaClientes,
                  //         onChanged: (val) => setState(() {
                  //           if (val == "Sin clientes") {
                  //             snackbarKey.currentState
                  //                 ?.showSnackBar(
                  //                     const SnackBar(
                  //               content: Text(
                  //                   "Debes agregar clientes al sistema."),
                  //             ));
                  //           } else {
                  //             listaVehiculos.clear();
                  //             ordenTrabajoProvider.idCliente = -1;
                  //             cliente = val!;
                  //             correo = cliente.split("--").last.replaceAll(" ", "");
                  //             dataBase.clienteBox
                  //                 .getAll()
                  //                 .forEach((element) {
                  //               if (element.correo ==
                  //                   correo) {
                  //                 ordenTrabajoProvider.idCliente = 
                  //                   element.id;
                  //               }
                  //             });
                  //             dataBase.vehiculoBox
                  //                 .getAll()
                  //                 .forEach((element) {
                  //               if (element
                  //                       .cliente.target?.correo ==
                  //                   correo) {
                  //                 listaVehiculos
                  //                   .add("${element.modelo} ${element.anio} -- ${element.vin}");
                  //               }
                  //             });
                  //             listaVehiculos.sort((a, b) =>
                  //                 removeDiacritics(a).compareTo(
                  //                     removeDiacritics(b)));
                  //           }
                  //         }),
                  //         width: double.infinity,
                  //         height: 60,
                  //         textStyle: FlutterFlowTheme.of(context)
                  //           .title3
                  //           .override(
                  //             fontFamily: 'Montserrat',
                  //             color: FlutterFlowTheme.of(context).grayDark,
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.normal,
                  //         ),
                  //         hintText: 'Cliente*',
                  //         icon: Icon(
                  //           Icons
                  //               .keyboard_arrow_down_rounded,
                  //           color: FlutterFlowTheme.of(context).primaryColor,
                  //           size: 30,
                  //         ),
                  //         fillColor: FlutterFlowTheme.of(context).white,
                  //         elevation: 2,
                  //         borderColor: FlutterFlowTheme.of(context).grayDark,
                  //         borderWidth: 2,
                  //         borderRadius: 8,
                  //         margin:
                  //             const EdgeInsetsDirectional
                  //                 .fromSTEB(12, 4, 12, 4),
                  //         hidesUnderline: true,
                  //       ),
                  //     );
                  //   },
                  //   validator: (val) {
                  //     if (cliente == "" ||
                  //         cliente.isEmpty) {
                  //       return 'El cliente es requerido.';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // FormField(
                  //   builder: (state) {
                  //     return Padding(
                  //       padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                  //       child: DropDown(
                  //         options: (vehiculo == "" &&
                  //             listaVehiculos.isEmpty)
                  //         ? ["Sin vehículos"]
                  //         : listaVehiculos,
                  //         onChanged: (val) => setState(() {
                  //           if (val == "Sin vehículos") {
                  //             snackbarKey.currentState
                  //                 ?.showSnackBar(const SnackBar(
                  //               content: Text(
                  //                   "Debes seleccionar un cliente para seleccionar un vehículo."),
                  //             ));
                  //           } else {
                  //             ordenTrabajoProvider.idVehiculo = -1;
                  //             vehiculo = val!;
                  //             vin = vehiculo.split("--").last.replaceAll(" ", "");;
                  //             dataBase.vehiculoBox
                  //                 .getAll()
                  //                 .forEach((element) {
                  //               if (element.vin ==
                  //                   vin) {
                  //                 ordenTrabajoProvider.idVehiculo = 
                  //                   element.id;
                  //               }
                  //             });
                  //           }
                  //         }),
                  //         width: double.infinity,
                  //         height: 60,
                  //         textStyle: FlutterFlowTheme.of(context)
                  //           .title3
                  //           .override(
                  //             fontFamily: 'Montserrat',
                  //             color: FlutterFlowTheme.of(context).grayDark,
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.normal,
                  //         ),
                  //         hintText: 'Vehículo*',
                  //         icon: Icon(
                  //           Icons
                  //               .keyboard_arrow_down_rounded,
                  //           color: FlutterFlowTheme.of(context).primaryColor,
                  //           size: 30,
                  //         ),
                  //         fillColor: FlutterFlowTheme.of(context).white,
                  //         elevation: 2,
                  //         borderColor: FlutterFlowTheme.of(context).grayDark,
                  //         borderWidth: 2,
                  //         borderRadius: 8,
                  //         margin:
                  //             const EdgeInsetsDirectional
                  //                 .fromSTEB(12, 4, 12, 4),
                  //         hidesUnderline: true,
                  //       ),
                  //     );
                  //   },
                  //   validator: (val) {
                  //     if (vehiculo == "" ||
                  //         vehiculo.isEmpty) {
                  //       return 'El vehículo es requerido.';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // FormField(
                  //   autovalidateMode:
                  //           AutovalidateMode.onUserInteraction,
                  //   builder: (state) {
                  //     return Padding(
                  //       padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                  //       child: DropDown(
                  //         options: const ["Efectivo", "Crédito"],
                  //         onChanged: (val) => setState(() {
                  //           formaPago = val!;
                  //         }),
                  //         width: double.infinity,
                  //         height: 60,
                  //         textStyle: FlutterFlowTheme.of(context)
                  //           .title3
                  //           .override(
                  //             fontFamily: 'Montserrat',
                  //             color: FlutterFlowTheme.of(context).grayDark,
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.normal,
                  //         ),
                  //         hintText: 'Forma de Pago*',
                  //         icon: Icon(
                  //           Icons
                  //               .keyboard_arrow_down_rounded,
                  //           color: FlutterFlowTheme.of(context).primaryColor,
                  //           size: 30,
                  //         ),
                  //         fillColor: FlutterFlowTheme.of(context).white,
                  //         elevation: 2,
                  //         borderColor: FlutterFlowTheme.of(context).grayDark,
                  //         borderWidth: 2,
                  //         borderRadius: 8,
                  //         margin:
                  //             const EdgeInsetsDirectional
                  //                 .fromSTEB(12, 4, 12, 4),
                  //         hidesUnderline: true,
                  //       ),
                  //     );
                  //   },
                  //   validator: (val) {
                  //     if (cliente == "" ||
                  //         cliente.isEmpty) {
                  //       return 'La Forma de Pago es requerida.';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  Visibility(
                    visible: ordenTrabajoProvider.vinSeleccionado == ordenTrabajoProvider.vinController.text,
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
                                    ordenTrabajoProvider.vehiculo?.imagen.target?.path,
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
                                                  FlutterFlowTheme.of(context).grayDark,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context).grayDark,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0x00000000),
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
                                      FlutterFlowTheme.of(context).grayDark,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).grayDark,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
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
                                      FlutterFlowTheme.of(context).grayDark,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
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
