import 'dart:convert';
import 'dart:io';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/vehiculo_controller.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';

class AgregarVehiculoScreen extends StatefulWidget {
  const AgregarVehiculoScreen({Key? key}) : super(key: key);

  @override
  _AgregarVehiculoScreenState createState() =>
      _AgregarVehiculoScreenState();
}

class _AgregarVehiculoScreenState extends State<AgregarVehiculoScreen> {
  XFile? image;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final vehiculoKey = GlobalKey<FormState>();
  final _unfocusNode = FocusNode();
  var dateTimeSelected = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final vehiculoProvider = Provider.of<VehiculoController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Form(
              key: vehiculoKey,
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
                                          vehiculoProvider.limpiarInformacion();
                                          //Se colocan dos pop para salir del ALertDiaglog y Regresar a la pantalla anterior
                                          Navigator.pop(context);
                                          Navigator.pop(context);
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
                        0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Registro de Vehículo',
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormField(
                        builder: (state) {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional
                                    .fromSTEB(0, 10, 0, 16),
                                child: InkWell(
                                  onTap: () async {
                                    String? option =
                                        await showModalBottomSheet(
                                      context: context,
                                      builder: (_) =>
                                          const CustomBottomSheet(),
                                    );

                                    if (option == null) return;

                                    final picker = ImagePicker();

                                    late final XFile? pickedFile;

                                    if (option == 'camera') {
                                      pickedFile =
                                          await picker.pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 50,
                                      );
                                    } else {
                                      pickedFile =
                                          await picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                    }

                                    if (pickedFile == null) {
                                      return;
                                    }

                                    setState(() {
                                      image = pickedFile;
                                      File file = File(image!.path);
                                      List<int> fileInByte =
                                          file.readAsBytesSync();
                                      String base64 =
                                          base64Encode(fileInByte);
                                      var newImagenLocal = Imagenes(
                                          imagenes: image!.path,
                                          nombre: image!.name,
                                          path: image!.path,
                                          base64: base64,
                                          idEmprendimiento: 0);
                                      vehiculoProvider.imagenVehiculo =
                                          newImagenLocal;
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context)
                                            .size
                                            .width *
                                        0.9,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/animation_500_l3ur8tqa.gif',
                                        ).image,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(8),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context).tertiaryColor,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: getImage(vehiculoProvider.imagenVehiculo?.path),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        validator: (val) {
                          if (vehiculoProvider.imagenVehiculo?.path == null || vehiculoProvider.imagenVehiculo?.path == "") {
                            return 'Para continuar, cargue la imagen del vehículo.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                    child: TextFormField(
                      textCapitalization:
                          TextCapitalization.words,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        vehiculoProvider.marca = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Marca*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese marca...',
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
                      validator: FormBuilderValidators.compose([
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'La Marca es requerida.';
                          } 
                          return null;
                        }
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: TextFormField(
                      textCapitalization:
                          TextCapitalization.words,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        vehiculoProvider.modelo = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Modelo*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese modelo...',
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
                      validator: FormBuilderValidators.compose([
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'El Modelo es requerido.';
                          } 
                          return null;
                        }
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16, 16, 16, 0),
                    child: TextFormField(
                        controller: vehiculoProvider.anioController,
                        autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                        onTap: () async {
                         showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Selecciona el Año"),
                              content: SizedBox( // Need to use container to add size constraint.
                                width: 300,
                                height: 300,
                                child: YearPicker(
                                  currentDate: DateTime(DateTime.now().year + 1, 1),
                                  firstDate: DateTime(DateTime.now().year - 44, 1),
                                  lastDate: DateTime(DateTime.now().year, 1),
                                  selectedDate: DateTime(dateTimeSelected, 1),
                                  onChanged: (DateTime dateTime) {
                                    setState(() {
                                      dateTimeSelected = dateTime.year;
                                      vehiculoProvider.anio = dateTimeSelected.toString();
                                      vehiculoProvider.anioController = TextEditingController(text: dateTimeSelected.toString());
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Año*',
                          labelStyle:
                              FlutterFlowTheme.of(context).title3.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context)
                                        .grayDark,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                          hintText: 'Ingresa el Año del vehículo...',
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
                            return 'El Año es requerido.';
                          }
                          return null;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: TextFormField(
                      maxLength: 18,
                      textCapitalization:
                          TextCapitalization.characters,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        vehiculoProvider.vin = value;
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
                        hintText: 'Ingrese VIN...',
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
                      validator: FormBuilderValidators.compose([
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'El VIN es requerido.';
                          } 
                          return null;
                        }
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                    child: TextFormField(
                      textCapitalization:
                          TextCapitalization.characters,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        vehiculoProvider.placas = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Placas*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el número de Placas...',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                            return 'El número de Placa es requerido.';
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
                        vehiculoProvider.kilometraje = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Kilometraje*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el kilometraje...',
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
                        suffixText: 'Km',
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                            return 'El Kilometraje es requerido.';
                          } 
                          return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: TextFormField(
                      controller: vehiculoProvider.gasolinaController,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onTap: () async {
                         await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            final vehiculoProvider = Provider.of<VehiculoController>(context);
                            return AlertDialog(
                              title: const Text("Porcentaje de Gasolina"),
                              content: SizedBox( // Need to use container to add size constraint.
                                width: 300,
                                height: 300,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SemicircularIndicator(
                                        progress: vehiculoProvider.valor * 0.01,
                                        radius: 100,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        backgroundColor: FlutterFlowTheme.of(context).grayLighter,
                                        strokeWidth: 13,
                                        bottomPadding: 0,
                                        contain: true,
                                        child: Text(
                                          "${vehiculoProvider.valor} %",
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
                                            value: vehiculoProvider.valor, 
                                            stepSize: 1.0,
                                            activeColor: FlutterFlowTheme.of(context).secondaryColor,
                                            inactiveColor: FlutterFlowTheme.of(context).grayLighter,
                                            onChanged: ((value) {
                                              vehiculoProvider.actualizarValor(value.truncate());
                                            })
                                          ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            setState(() {
                                              vehiculoProvider.gasolinaController = TextEditingController(
                                                text: vehiculoProvider.valor.toString()
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
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (vehiculoProvider
                            .validateForm(vehiculoKey)) {
                          final vehiculo = dataBase
                              .vehiculoBox
                              .query(Vehiculo_.vin
                                  .equals(
                                      vehiculoProvider
                                          .vin))
                              .build()
                              .findFirst();
                          if (vehiculo != null) {
                            snackbarKey.currentState
                                ?.showSnackBar(
                                    const SnackBar(
                              content: Text(
                                  "El Vehículo ya se encuentra registrado."),
                            ));
                          } else {
                            vehiculoProvider.addTemporal();
                            Navigator.pop(context);
                            snackbarKey.currentState
                                ?.showSnackBar(
                                    const SnackBar(
                              content: Text(
                                  "¡Vehículo asocidado éxitosamente!"),
                            ));
                          }
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: const Text(
                                    'Campos requeridos vacíos.'),
                                content: const Text(
                                    'Para continuar, debe llenar todos los campos solicitados e incluir una imagen del vehículo.'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(
                                            alertDialogContext),
                                    child:
                                        const Text('Bien'),
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
