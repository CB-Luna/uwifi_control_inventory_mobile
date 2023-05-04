import 'dart:convert';
import 'dart:io';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/vehiculo_controller.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/util.dart';

class AgregarVehiculoScreen extends StatefulWidget {
  AgregarVehiculoScreen({Key? key}) : super(key: key);

  @override
  _AgregarVehiculoScreenState createState() =>
      _AgregarVehiculoScreenState();
}

class _AgregarVehiculoScreenState extends State<AgregarVehiculoScreen> {
  XFile? image;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final vehiculoKey = GlobalKey<FormState>();
  final _unfocusNode = FocusNode();

    @override
  void initState() {
    super.initState();
    setState(() {
      dataBase.marcaBox.getAll().forEach((element) {
        context.read<VehiculoController>().listaMarcas.add(element.marca);
      });
      context.read<VehiculoController>().listaMarcas
        .sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    });
  }

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
                                      vehiculoProvider.imagenVehiculo =
                                          base64;
                                      vehiculoProvider.path =
                                          file.path;
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
                                        color: FlutterFlowTheme.of(context).primaryColor.withOpacity(0.5),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: getImage(vehiculoProvider.path),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        validator: (val) {
                          if (vehiculoProvider.path == "" || vehiculoProvider.path == null) {
                            return 'Para continuar, cargue la imagen del vehículo.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                    child: Autocomplete(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return vehiculoProvider.listaMarcas.where((String option) {
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
                              final title = option.toString();
                              return ListTile(
                                leading: Icon(
                                  Icons.label_outline,
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                ),
                                onTap: () {
                                  onSelected(option.toString());
                                },
                                title: SubstringHighlight(
                                  text: title,
                                  term: vehiculoProvider.marcaController.text,
                                  textStyleHighlight: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                hoverColor: Colors.grey[200],
                              );
                            },
                          ),
                        );
                      },
                      onSelected: (String selection) {
                        vehiculoProvider.seleccionarMarca(selection);
                      },
                      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                        vehiculoProvider.marcaController = controller;
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          textCapitalization:
                              TextCapitalization.characters,
                          onChanged: (value) {
                              vehiculoProvider.enCambioMarca(value);
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.label_outlined,
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                            labelText: 'Marca*',
                            labelStyle: FlutterFlowTheme.of(context)
                                .title3
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).grayDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            hintText: 'Ingrese la marca del vehículo...',
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
                              return 'La Marca del vehículo es requerida.';
                            }
                            if (val != vehiculoProvider.marcaSeleccionada) {
                              return 'Seleccione una opción de marca válida.';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                    child: Autocomplete(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return vehiculoProvider.listaModelos.where((String option) {
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
                              final title = option.toString();
                              return ListTile(
                                leading: Icon(
                                  Icons.label_outline,
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                ),
                                onTap: () {
                                  onSelected(option.toString());
                                },
                                title: SubstringHighlight(
                                  text: title,
                                  term: vehiculoProvider.modeloController.text,
                                  textStyleHighlight: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                hoverColor: Colors.grey[200],
                              );
                            },
                          ),
                        );
                      },
                      onSelected: (String selection) {
                        vehiculoProvider.seleccionarModelo(selection);
                      },
                      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                        vehiculoProvider.modeloController = controller;
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          textCapitalization:
                              TextCapitalization.characters,
                          onChanged: (value) {
                              vehiculoProvider.enCambioModelo(value);
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.directions_car_outlined,
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                            labelText: 'Modelo*',
                            labelStyle: FlutterFlowTheme.of(context)
                                .title3
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).grayDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            hintText: 'Ingrese el modelo del vehículo...',
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
                              return 'El Modelo del vehículo es requerido.';
                            }
                            if (val != vehiculoProvider.modeloSeleccionado) {
                              return 'Seleccione una opción de modelo válida.';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                    child: Autocomplete(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return vehiculoProvider.listaAnios.where((String option) {
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
                              final title = option.toString();
                              return ListTile(
                                leading: Icon(
                                  Icons.date_range_outlined,
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                ),
                                onTap: () {
                                  onSelected(option.toString());
                                },
                                title: SubstringHighlight(
                                  text: title,
                                  term: vehiculoProvider.anioController.text,
                                  textStyleHighlight: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                hoverColor: Colors.grey[200],
                              );
                            },
                          ),
                        );
                      },
                      onSelected: (String selection) {
                        vehiculoProvider.seleccionarAnio(selection);
                      },
                      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                        vehiculoProvider.anioController = controller;
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          textCapitalization:
                              TextCapitalization.characters,
                          onChanged: (value) {
                              vehiculoProvider.enCambioAnio(value);
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range_outlined,
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                            labelText: 'Año*',
                            labelStyle: FlutterFlowTheme.of(context)
                                .title3
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).grayDark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            hintText: 'Ingrese el año del vehículo...',
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
                              return 'El Año del vehículo es requerido.';
                            }
                            if (val != vehiculoProvider.anioSeleccionado) {
                              return 'Seleccione una opción de año válida.';
                            }
                            return null;
                          },
                        );
                      },
                    ),
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
                        prefixIcon: Icon(
                          Icons.car_rental_outlined,
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
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
                        prefixIcon: Icon(
                          Icons.pin_outlined,
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
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
                      textCapitalization:
                          TextCapitalization.words,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        vehiculoProvider.color = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.color_lens_outlined,
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                        labelText: 'Color*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el color...',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                            return 'El Color es requerido.';
                          } 
                          return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: TextFormField(
                      textCapitalization:
                          TextCapitalization.characters,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        vehiculoProvider.motor = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.bolt_outlined,
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                        labelText: 'Motor*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Ingrese el motor...',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                            return 'El Motor es requerido.';
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
