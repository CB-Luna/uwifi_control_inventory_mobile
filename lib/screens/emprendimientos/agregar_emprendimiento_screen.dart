import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/providers/database_providers/emprendedor_controller.dart';
import 'package:bizpro_app/screens/emprendedores/agregar_emprendedor_screen.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimiento_creado.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/theme/theme.dart';

class AgregarEmprendimientoScreen extends StatefulWidget {
  const AgregarEmprendimientoScreen({Key? key}) : super(key: key);

  @override
  State<AgregarEmprendimientoScreen> createState() =>
      _AgregarEmprendimientoScreenState();
}

class _AgregarEmprendimientoScreenState
    extends State<AgregarEmprendimientoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  XFile? image;
  String nombreComunidad = "";
  String nombreMunicipio = "";
  String nombreEstado = "";
  List<String> listComunidades = [];
  List<String> listMunicipios = [];
  List<String> listEstados = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      nombreComunidad = "";
      nombreMunicipio = "";
      nombreEstado = "";
      listComunidades = [];
      listMunicipios = [];
      listEstados = [];
      dataBase.comunidadesBox.getAll().forEach((element) {
        listComunidades.add(element.nombre);
      });
      dataBase.estadosBox.getAll().forEach((element) {
        listEstados.add(element.nombre);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final emprendimientoProvider =
        Provider.of<EmprendimientoController>(context);
    final emprendedorProvider = Provider.of<EmprendedorController>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFD9EEF9),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/bglogin2.png',
                      ).image,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 45, 20, 0),
                            child: Container(
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
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Registro de Emprendimiento',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: const Color(0xFF221573),
                                      fontSize: 20,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        FormField(builder: (state) {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 0),
                                child: InkWell(
                                  onTap: () async {
                                    String? option = await showModalBottomSheet(
                                      context: context,
                                      builder: (_) => const CustomBottomSheet(),
                                    );

                                    if (option == null) return;

                                    final picker = ImagePicker();

                                    late final XFile? pickedFile;

                                    if (option == 'camera') {
                                      pickedFile = await picker.pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 100,
                                      );
                                    } else {
                                      pickedFile = await picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 100,
                                      );
                                    }

                                    if (pickedFile == null) {
                                      return;
                                    }

                                    setState(() {
                                      image = pickedFile;
                                      emprendimientoProvider.imagen =
                                          image!.path;
                                    });
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: const Color(0xFF221573),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Lottie.asset(
                                          'assets/lottie_animations/75669-animation-for-the-photo-optimization-process.json',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 180,
                                          fit: BoxFit.contain,
                                          animate: true,
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: getImage(image?.path),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }, validator: (val) {
                          if (emprendimientoProvider.imagen == null ||
                              emprendimientoProvider.imagen.isEmpty) {
                            return 'Para continuar, cargue una imagen';
                          }
                          return null;
                        }),
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
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    emprendimientoProvider.nombre = value;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Nombre de emprendimiento*',
                                    labelStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
                                              color: const Color(0xFF4672FF),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    hintText: 'Ingresa el nombre...',
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
                                        : 'Para continuar, ingrese el nombre empezando por mayúscula';
                                  },
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
                                  onChanged: (value) {
                                    emprendimientoProvider.descripcion = value;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Descripción de emprendimiento*',
                                    labelStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
                                              color: const Color(0xFF4672FF),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    hintText:
                                        'Descripción del emprendimiento...',
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
                                  maxLines: 5,
                                  validator: (value) {
                                    return capitalizadoCharacters
                                            .hasMatch(value ?? '')
                                        ? null
                                        : 'Para continuar, ingrese la descripción empezando por mayúscula';
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
                                      textStyle:
                                          AppTheme.of(context).title3.override(
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
                                      margin:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 4, 12, 4),
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
                                      textStyle:
                                          AppTheme.of(context).title3.override(
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
                                      margin:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 4, 12, 4),
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
                                      textStyle:
                                          AppTheme.of(context).title3.override(
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
                                      margin:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 4, 12, 4),
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
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        if (emprendedorProvider.asociado) {
                                          snackbarKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                            content: Text(
                                                "Ya se ha asociado un emprendedor, no puedes agregar más."),
                                          ));
                                        } else {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const AgregarEmprendedorScreen(),
                                            ),
                                          );
                                        }
                                      },
                                      text: emprendedorProvider.asociado
                                          ? 'Emprendedor Asociado'
                                          : 'Asociar Emprendedor',
                                      options: FFButtonOptions(
                                        width: 160,
                                        height: 50,
                                        color: emprendedorProvider.asociado
                                            ? AppTheme.of(context).grayIcon
                                            : AppTheme.of(context)
                                                .secondaryText,
                                        textStyle: AppTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        elevation: 2,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        if (emprendimientoProvider
                                                .validateForm(formKey) &&
                                            emprendedorProvider.asociado) {
                                          // comunidadProvider.add();
                                          final idEstado = dataBase.estadosBox
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
                                                    .and(Municipios_.nombre
                                                        .equals(
                                                            nombreMunicipio)))
                                                .build()
                                                .findFirst()
                                                ?.id;
                                            if (idMunicipio != null) {
                                              final idComunidad = dataBase
                                                  .comunidadesBox
                                                  .query(Comunidades_.municipios
                                                      .equals(idMunicipio)
                                                      .and(Comunidades_.nombre
                                                          .equals(
                                                              nombreComunidad)))
                                                  .build()
                                                  .findFirst()
                                                  ?.id;
                                              if (idComunidad != null) {
                                                emprendimientoProvider
                                                    .add(idComunidad);
                                                usuarioProvider
                                                    .addEmprendimiento(
                                                        emprendimientoProvider
                                                            .emprendimiento!);
                                                if (emprendimientoProvider
                                                        .idEmprendimiento !=
                                                    null) {
                                                  emprendedorProvider.add(
                                                      emprendimientoProvider
                                                          .idEmprendimiento!,
                                                      idComunidad);
                                                }
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const EmprendimientoCreado(),
                                                  ),
                                                );
                                              }
                                            }
                                          }
                                        } else {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Campos vacíos'),
                                                content: const Text(
                                                    'Para continuar, debe llenar todos los campos, asociar un emprendedor e incluír una imagen.'),
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
                                      text: 'Agregar ',
                                      icon: const Icon(
                                        Icons.check_rounded,
                                        size: 15,
                                      ),
                                      options: FFButtonOptions(
                                        width: 150,
                                        height: 50,
                                        color: const Color(0xFF4672FF),
                                        textStyle: AppTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                        elevation: 3,
                                        borderSide: const BorderSide(
                                          color: Color(0x002CC3F4),
                                          width: 0,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
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
          ),
        ),
      ),
    );
  }
}
