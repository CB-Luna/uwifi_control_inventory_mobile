import 'package:diacritic/diacritic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/orden_trabajo_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/orden_trabajo_creada_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/orden_trabajo_no_creada_screen.dart';
import 'package:taller_alex_app_asesor/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:taller_alex_app_asesor/screens/widgets/drop_down.dart';
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
      print(context.read<UsuarioController>().usuarioCurrent!.clientes.toList());
    context.read<UsuarioController>().usuarioCurrent!.clientes.toList().forEach((element) {
        listaClientes.add("${element.nombre} ${element.apellidoP} -- ${element.correo}");
    });
    listaClientes.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    }
  }
  @override
  Widget build(BuildContext context) {
    final ordenTrabajoProvider = Provider.of<OrdenTrabajoController>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
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
                        labelText: 'Usuario*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el usuario...',
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
                  FormField(
                    builder: (state) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                        child: DropDown(
                          options: (cliente == "" &&
                              listaClientes.isEmpty)
                          ? ["Sin clientes"]
                          : listaClientes,
                          onChanged: (val) => setState(() {
                            if (val == "Sin clientes") {
                              snackbarKey.currentState
                                  ?.showSnackBar(
                                      const SnackBar(
                                content: Text(
                                    "Debes agregar clientes al sistema."),
                              ));
                            } else {
                              listaVehiculos.clear();
                              ordenTrabajoProvider.idCliente = -1;
                              cliente = val!;
                              correo = cliente.split("--").last.replaceAll(" ", "");
                              dataBase.clienteBox
                                  .getAll()
                                  .forEach((element) {
                                if (element.correo ==
                                    correo) {
                                  ordenTrabajoProvider.idCliente = 
                                    element.id;
                                }
                              });
                              dataBase.vehiculoBox
                                  .getAll()
                                  .forEach((element) {
                                if (element
                                        .cliente.target?.correo ==
                                    correo) {
                                  listaVehiculos
                                    .add("${element.modelo} ${element.anio} -- ${element.vin}");
                                }
                              });
                              listaVehiculos.sort((a, b) =>
                                  removeDiacritics(a).compareTo(
                                      removeDiacritics(b)));
                            }
                          }),
                          width: double.infinity,
                          height: 60,
                          textStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Cliente*',
                          icon: Icon(
                            Icons
                                .keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            size: 30,
                          ),
                          fillColor: FlutterFlowTheme.of(context).white,
                          elevation: 2,
                          borderColor: FlutterFlowTheme.of(context).grayDark,
                          borderWidth: 2,
                          borderRadius: 8,
                          margin:
                              const EdgeInsetsDirectional
                                  .fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      );
                    },
                    validator: (val) {
                      if (cliente == "" ||
                          cliente.isEmpty) {
                        return 'El cliente es requerido.';
                      }
                      return null;
                    },
                  ),
                  FormField(
                    builder: (state) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                        child: DropDown(
                          options: (vehiculo == "" &&
                              listaVehiculos.isEmpty)
                          ? ["Sin vehículos"]
                          : listaVehiculos,
                          onChanged: (val) => setState(() {
                            if (val == "Sin vehículos") {
                              snackbarKey.currentState
                                  ?.showSnackBar(const SnackBar(
                                content: Text(
                                    "Debes seleccionar un cliente para seleccionar un vehículo."),
                              ));
                            } else {
                              ordenTrabajoProvider.idVehiculo = -1;
                              vehiculo = val!;
                              vin = vehiculo.split("--").last.replaceAll(" ", "");;
                              dataBase.vehiculoBox
                                  .getAll()
                                  .forEach((element) {
                                if (element.vin ==
                                    vin) {
                                  ordenTrabajoProvider.idVehiculo = 
                                    element.id;
                                }
                              });
                            }
                          }),
                          width: double.infinity,
                          height: 60,
                          textStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Vehículo*',
                          icon: Icon(
                            Icons
                                .keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            size: 30,
                          ),
                          fillColor: FlutterFlowTheme.of(context).white,
                          elevation: 2,
                          borderColor: FlutterFlowTheme.of(context).grayDark,
                          borderWidth: 2,
                          borderRadius: 8,
                          margin:
                              const EdgeInsetsDirectional
                                  .fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      );
                    },
                    validator: (val) {
                      if (vehiculo == "" ||
                          vehiculo.isEmpty) {
                        return 'El vehículo es requerido.';
                      }
                      return null;
                    },
                  ),
                  FormField(
                    autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                    builder: (state) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                        child: DropDown(
                          options: const ["Efectivo", "Crédito"],
                          onChanged: (val) => setState(() {
                            formaPago = val!;
                          }),
                          width: double.infinity,
                          height: 60,
                          textStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Forma de Pago*',
                          icon: Icon(
                            Icons
                                .keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            size: 30,
                          ),
                          fillColor: FlutterFlowTheme.of(context).white,
                          elevation: 2,
                          borderColor: FlutterFlowTheme.of(context).grayDark,
                          borderWidth: 2,
                          borderRadius: 8,
                          margin:
                              const EdgeInsetsDirectional
                                  .fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      );
                    },
                    validator: (val) {
                      if (cliente == "" ||
                          cliente.isEmpty) {
                        return 'La Forma de Pago es requerida.';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16, 16, 16, 0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: TextFormField(
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        ordenTrabajoProvider.descripcion = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese la descripción...',
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
                        if (ordenTrabajoProvider.add(usuarioProvider.usuarioCurrent!)) {
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
          )
        ),
      ),
    );
  }
}
