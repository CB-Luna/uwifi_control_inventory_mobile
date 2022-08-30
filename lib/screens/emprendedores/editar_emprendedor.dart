import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/providers/database_providers/emprendedor_controller.dart';
import 'package:bizpro_app/screens/emprendedores/emprendedor_actualizado.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';

class EditarEmprendedor extends StatefulWidget {
  final Emprendedores emprendedor;

  const EditarEmprendedor({Key? key, required this.emprendedor})
      : super(key: key);

  @override
  _EditarEmprendedorState createState() => _EditarEmprendedorState();
}

class _EditarEmprendedorState extends State<EditarEmprendedor> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emprendedorKey = GlobalKey<FormState>();
  XFile? image;
  String nombreComunidad = "";
  String nombreMunicipio = "";
  String nombreEstado = "";
  List<String> listComunidades = [];
  List<String> listMunicipios = [];
  List<String> listEstados = [];

  late TextEditingController nombreController;
  late TextEditingController apellidosController;
  late TextEditingController curpController;
  late TextEditingController integrantesController;
  late TextEditingController telefonoController;
  late TextEditingController comentariosController;
  late String newImagen;

  @override
  void initState() {
    super.initState();
    newImagen = widget.emprendedor.imagen;
    nombreController = TextEditingController(text: widget.emprendedor.nombre);
    apellidosController =
        TextEditingController(text: widget.emprendedor.apellidos);
    curpController = TextEditingController(text: widget.emprendedor.curp);
    integrantesController =
        TextEditingController(text: widget.emprendedor.integrantesFamilia);
    telefonoController =
        TextEditingController(text: widget.emprendedor.telefono);
    comentariosController =
        TextEditingController(text: widget.emprendedor.comentarios);
    nombreComunidad =
        widget.emprendedor.comunidad.target?.nombre ?? "SIN COMUNIDAD";
    nombreMunicipio =
        widget.emprendedor.comunidad.target?.municipios.target?.nombre ??
            " SIN MUNICIPIO";
    nombreEstado = widget.emprendedor.comunidad.target?.municipios.target
            ?.estados.target?.nombre ??
        "SIN ESTADO";
    listComunidades = [];
    listMunicipios = [];
    listEstados = [];
    dataBase.estadosBox.getAll().forEach((element) {
      listEstados.add(element.nombre);
    });
    dataBase.municipiosBox.getAll().forEach((element) {
      if (element.estados.target?.nombre == nombreEstado) {
        listMunicipios.add(element.nombre);
      }
    });
    dataBase.comunidadesBox.getAll().forEach((element) {
      if (element.municipios.target?.nombre == nombreMunicipio) {
        listComunidades.add(element.nombre);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final emprendedorProvider = Provider.of<EmprendedorController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFD9EEF9),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).secondaryBackground,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/images/bglogin2.png',
                    ).image,
                  ),
                ),
              ),
              Stack(
                children: [
                  SingleChildScrollView(
                    child: Form(
                      key: emprendedorKey,
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
                                    color: const Color(0xFF4672FF),
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
                                                fontFamily: AppTheme.of(context)
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
                                  'Actualizar Emprendedor',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
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
                                            .fromSTEB(0, 10, 0, 0),
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
                                                imageQuality: 100,
                                              );
                                            } else {
                                              pickedFile =
                                                  await picker.pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 100,
                                              );
                                            }

                                            if (pickedFile == null) {
                                              return;
                                            }

                                            setState(() {
                                              image = pickedFile;
                                              newImagen = image!.path;
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: AppTheme.of(context)
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
                                                color: const Color(0xFF221573),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: getImage(image?.path ??
                                                widget.emprendedor.imagen),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 16, 15, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 10, 5, 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    enabled: false,
                                    initialValue: widget.emprendedor
                                        .emprendimiento.target!.nombre,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Emprendimiento',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    controller: nombreController,
                                    decoration: InputDecoration(
                                      labelText: 'Nombre(s)*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingresa nombre...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: (value) {
                                      return capitalizadoCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Para continuar, ingrese el nombre empezando por mayúscula.';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    controller: apellidosController,
                                    decoration: InputDecoration(
                                      labelText: 'Apellido(s)*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese apellido...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: (value) {
                                      return capitalizadoCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Para continuar, ingrese los apellidos empezando por mayúscula.';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    controller: curpController,
                                    decoration: InputDecoration(
                                      labelText: 'CURP*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese el CURP...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: (value) {
                                      return curpCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Para continuar, ingrese un CURP válido con mayúsculas.';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    controller: integrantesController,
                                    decoration: InputDecoration(
                                      labelText: 'Integrantes*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese integrantes...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    validator: (value) {
                                      return familiaCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Para continuar, ingrese un número de integrantes [0-99].';
                                    },
                                  ),
                                ),
                                FormField(
                                  builder: (state) {
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 5, 10),
                                      child: DropDown(
                                        initialOption: nombreEstado,
                                        options: listEstados,
                                        onChanged: (val) => setState(() {
                                          if (listEstados.isEmpty) {
                                            snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Debes descargar los catálogos desde la sección de tu perfil"),
                                            ));
                                          } else {
                                            listMunicipios.clear();
                                            listComunidades.clear();
                                            nombreEstado = val!;
                                            dataBase.municipiosBox
                                                .getAll()
                                                .forEach((element) {
                                              if (element
                                                      .estados.target?.nombre ==
                                                  nombreEstado) {
                                                listMunicipios
                                                    .add(element.nombre);
                                              }
                                            });
                                            print("Entro a con estados");
                                          }
                                          print("Estado: $nombreEstado");
                                        }),
                                        width: double.infinity,
                                        height: 50,
                                        textStyle: AppTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0xFF221573),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        hintText: 'Seleccione un estado*',
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF221573),
                                          size: 30,
                                        ),
                                        fillColor: Colors.white,
                                        elevation: 2,
                                        borderColor: const Color(0xFF221573),
                                        borderWidth: 2,
                                        borderRadius: 8,
                                        margin: const EdgeInsetsDirectional
                                            .fromSTEB(12, 4, 12, 4),
                                        hidesUnderline: true,
                                      ),
                                    );
                                  },
                                  validator: (val) {
                                    if (nombreEstado == "" ||
                                        nombreEstado.isEmpty) {
                                      return 'Para continuar, seleccione un estado.';
                                    }
                                    return null;
                                  },
                                ),
                                FormField(
                                  builder: (state) {
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 5, 10),
                                      child: DropDown(
                                        initialOption: nombreMunicipio,
                                        options: (nombreEstado == "" ||
                                                listMunicipios.isEmpty)
                                            ? ["Sin municipios"]
                                            : listMunicipios,
                                        onChanged: (val) => setState(() {
                                          if (val == "Sin municipios") {
                                            snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Debes seleccionar un estado para seleccionar un municipio"),
                                            ));
                                          } else {
                                            listComunidades.clear();
                                            nombreMunicipio = val!;
                                            dataBase.comunidadesBox
                                                .getAll()
                                                .forEach((element) {
                                              if (element.municipios.target
                                                      ?.nombre ==
                                                  nombreMunicipio) {
                                                listComunidades
                                                    .add(element.nombre);
                                              }
                                            });
                                            print("Entro a con municipios");
                                          }
                                          print("Municipio: $nombreMunicipio");
                                        }),
                                        width: double.infinity,
                                        height: 50,
                                        textStyle: AppTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0xFF221573),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        hintText: 'Seleccione un municipio*',
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF221573),
                                          size: 30,
                                        ),
                                        fillColor: Colors.white,
                                        elevation: 2,
                                        borderColor: const Color(0xFF221573),
                                        borderWidth: 2,
                                        borderRadius: 8,
                                        margin: const EdgeInsetsDirectional
                                            .fromSTEB(12, 4, 12, 4),
                                        hidesUnderline: true,
                                      ),
                                    );
                                  },
                                  validator: (val) {
                                    if (nombreMunicipio == "" ||
                                        nombreMunicipio.isEmpty) {
                                      return 'Para continuar, seleccione un municipio.';
                                    }
                                    return null;
                                  },
                                ),
                                FormField(
                                  builder: (state) {
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5, 0, 5, 10),
                                      child: DropDown(
                                        initialOption: nombreComunidad,
                                        options: (nombreMunicipio == "" ||
                                                listComunidades.isEmpty)
                                            ? ["Sin comunidades"]
                                            : listComunidades,
                                        onChanged: (val) => setState(() {
                                          if (val == "Sin comunidades") {
                                            snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Debes seleccionar un municipio para seleccionar una comunidad"),
                                            ));
                                          } else {
                                            nombreComunidad = val!;
                                            print("Entro a con comunidades");
                                          }
                                          print("Comunidad: $nombreComunidad");
                                        }),
                                        width: double.infinity,
                                        height: 50,
                                        textStyle: AppTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0xFF221573),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        hintText: 'Seleccione una comunidad*',
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF221573),
                                          size: 30,
                                        ),
                                        fillColor: Colors.white,
                                        elevation: 2,
                                        borderColor: const Color(0xFF221573),
                                        borderWidth: 2,
                                        borderRadius: 8,
                                        margin: const EdgeInsetsDirectional
                                            .fromSTEB(12, 4, 12, 4),
                                        hidesUnderline: true,
                                      ),
                                    );
                                  },
                                  validator: (val) {
                                    if (nombreComunidad == "" ||
                                        nombreComunidad.isEmpty) {
                                      return 'Para continuar, seleccione una comunidad.';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    controller: telefonoController,
                                    decoration: InputDecoration(
                                      labelText: 'Numero telefónico',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese número telefónico...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF4672FF),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFF221573),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: const Color(0xFF221573),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(12),
                                      telefonoFormat
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    controller: comentariosController,
                                    decoration: InputDecoration(
                                      labelText: 'Comentarios',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingresa comentarios...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    maxLines: 5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 15),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (newImagen !=
                                                    widget.emprendedor.imagen ||
                                                nombreController.text !=
                                                    widget.emprendedor.nombre ||
                                                apellidosController.text !=
                                                    widget.emprendedor
                                                        .apellidos ||
                                                curpController.text !=
                                                    widget.emprendedor.curp ||
                                                integrantesController.text !=
                                                    widget.emprendedor
                                                        .integrantesFamilia ||
                                                telefonoController.text !=
                                                    widget
                                                        .emprendedor.telefono ||
                                                comentariosController.text !=
                                                    widget.emprendedor
                                                        .comentarios ||
                                                nombreComunidad !=
                                                    widget.emprendedor.comunidad
                                                        .target!.nombre ||
                                                nombreMunicipio !=
                                                    widget
                                                        .emprendedor
                                                        .comunidad
                                                        .target!
                                                        .municipios
                                                        .target!
                                                        .nombre ||
                                                nombreEstado !=
                                                    widget
                                                        .emprendedor
                                                        .comunidad
                                                        .target!
                                                        .municipios
                                                        .target!
                                                        .estados
                                                        .target!
                                                        .nombre) {
                                              if (emprendedorProvider
                                                  .validateForm(
                                                      emprendedorKey)) {
                                                final idEstado = dataBase
                                                    .estadosBox
                                                    .query(Estados_.nombre
                                                        .equals(nombreEstado))
                                                    .build()
                                                    .findFirst()
                                                    ?.id;
                                                if (idEstado != null) {
                                                  final idMunicipio = dataBase
                                                      .municipiosBox
                                                      .query(Municipios_.estados
                                                          .equals(idEstado)
                                                          .and(Municipios_
                                                              .nombre
                                                              .equals(
                                                                  nombreMunicipio)))
                                                      .build()
                                                      .findFirst()
                                                      ?.id;
                                                  if (idMunicipio != null) {
                                                    final idComunidad = dataBase
                                                        .comunidadesBox
                                                        .query(Comunidades_
                                                            .municipios
                                                            .equals(idMunicipio)
                                                            .and(Comunidades_
                                                                .nombre
                                                                .equals(
                                                                    nombreComunidad)))
                                                        .build()
                                                        .findFirst()
                                                        ?.id;
                                                    if (idComunidad != null) {
                                                      print(
                                                          "Antes de actualizar");
                                                      emprendedorProvider.update(
                                                          widget.emprendedor.id,
                                                          newImagen,
                                                          nombreController.text,
                                                          apellidosController
                                                              .text,
                                                          curpController.text,
                                                          integrantesController
                                                              .text,
                                                          telefonoController
                                                              .text,
                                                          comentariosController
                                                              .text,
                                                          idComunidad);
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const EmprendedorActualizado(),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                }
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Campos vacíos'),
                                                      content: const Text(
                                                          'Para continuar, debe llenar todos los campos solicitados.'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: const Text(
                                                              'Bien'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                return;
                                              }
                                            }
                                          },
                                          text: 'Actualizar',
                                          icon: const Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          options: FFButtonOptions(
                                            width: 150,
                                            height: 50,
                                            color: AppTheme.of(context)
                                                .secondaryText,
                                            textStyle: AppTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                            elevation: 3,
                                            borderSide: BorderSide(
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              width: 0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
