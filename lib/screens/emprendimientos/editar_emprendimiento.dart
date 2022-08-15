import 'dart:io';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimiento_actualizado.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class EditarEmprendimientoScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;

  const EditarEmprendimientoScreen({
    Key? key,
    required this.emprendimiento,
  }) : super(key: key);

  @override
  State<EditarEmprendimientoScreen> createState() =>
      _EditarEmprendimientoScreenState();
}

class _EditarEmprendimientoScreenState
    extends State<EditarEmprendimientoScreen> {
  String uploadedFileUrl = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  XFile? image;
  String nombreComunidad = "";
  String nombreMunicipio= "";
  String nombreEstado = "";
  List<String> listComunidades = [];
  List<String> listMunicipios = [];
  List<String> listEstados = [];

  late TextEditingController nombreController;
  late TextEditingController descController;

  late String newImagen;
  @override
  void initState() {
    super.initState();
    newImagen = widget.emprendimiento.imagen;
    nombreController =
        TextEditingController(text: widget.emprendimiento.nombre);
    descController =
        TextEditingController(text: widget.emprendimiento.descripcion);
    nombreComunidad = widget.emprendimiento.comunidad.target!.nombre;
    nombreMunicipio = widget.emprendimiento.comunidad.target!.municipios.target!.nombre;
    nombreEstado = widget.emprendimiento.comunidad.target!.municipios.target!.estados.target!.nombre;
    listComunidades = [];
    listMunicipios = [];
    listEstados = [];
    dataBase.estadosBox.getAll().forEach((element) {listEstados.add(element.nombre);});
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
    final emprendimientoProvider =
        Provider.of<EmprendimientoController>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              //Imagen de fondo
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

              //Imagen de emprendimiento
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(widget.emprendimiento.imagen)),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0x0014181B),
                        AppTheme.of(context).secondaryBackground
                      ],
                      stops: const [0, 1],
                      begin: const AlignmentDirectional(0, -1),
                      end: const AlignmentDirectional(0, 1),
                    ),
                  ),
                ),
              ),

              //Flecha atras
              Positioned(
                left: 16,
                top: 45,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        Text(
                          'Atrás',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
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

              //Titulo de emprendimiento
              Positioned.fill(
                top: 100,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    widget.emprendimiento.nombre,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),

              //Formulario
              Positioned(
                top: 200,
                left: 20,
                right: 20,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Actualizar Emprendimiento',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily:
                                    AppTheme.of(context).bodyText1Family,
                                color: const Color(0xFF0D0E0F),
                                fontSize: 16,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                              newImagen = image!.path;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF221573),
                                width: 2,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Lottie.asset(
                                  'assets/lottie_animations/75669-animation-for-the-photo-optimization-process.json',
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 180,
                                  fit: BoxFit.contain,
                                  animate: true,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: getImage(
                                    image?.path ?? widget.emprendimiento.imagen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 16, 5, 0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.sentences,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  controller: nombreController,
                                  decoration: InputDecoration(
                                    labelText: 'Nombre de emprendimiento',
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
                                  return capitalizadoCharacters.hasMatch(value ?? '')
                                      ? null
                                      : 'Para continuar, ingrese el nombre empezando por mayúscula';
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.sentences,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  controller: descController,
                                  decoration: InputDecoration(
                                    labelText: 'Descripción de emprendimiento',
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
                                  return capitalizadoCharacters.hasMatch(value ?? '')
                                      ? null
                                      : 'Para continuar, ingrese la descripción empezando por mayúscula';
                                  },
                                ),
                              ),
                              FormField(builder: (state) {
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: DropDown(
                                    initialOption: nombreEstado,
                                    options: listEstados,
                                    onChanged: (val) => setState((){
                                        listMunicipios.clear();
                                        listComunidades.clear();
                                        nombreEstado = val!;
                                        dataBase.municipiosBox.getAll().forEach((element) {
                                          if (element.estados.target?.nombre == nombreEstado) {
                                            listMunicipios.add(element.nombre);
                                          }                                    
                                          });
                                        print("Entro a con estados");
                                      print("Estado: $nombreEstado");
                                      
                                      }),
                                    width: double.infinity,
                                    height: 50,
                                    textStyle: AppTheme.of(context).title3.override(
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
                                    margin: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
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
                                FormField(builder: (state) {
                                  return Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 5, 10),
                                    child: DropDown(
                                      initialOption: nombreMunicipio,
                                      options: (nombreEstado == "" || listMunicipios.isEmpty) ? ["Sin municipios"] : listMunicipios,
                                      onChanged: (val) => setState((){
                                        if (val == "Sin municipios") {
                                          snackbarKey.currentState
                                          ?.showSnackBar(const SnackBar(
                                            content: Text(
                                                "Debes seleccionar un estado para seleccionar un municipio"),
                                          ));
                                        } else {
                                          listComunidades.clear();
                                          nombreMunicipio = val!;
                                          dataBase.comunidadesBox.getAll().forEach((element) {
                                            if (element.municipios.target?.nombre == nombreMunicipio) {
                                              listComunidades.add(element.nombre);
                                            }                                    
                                          });
                                          print("Entro a con municipios");
                                        }
                                        print("Municipio: $nombreMunicipio");
                                      }),
                                      width: double.infinity,
                                      height: 50,
                                      textStyle: AppTheme.of(context).title3.override(
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
                                      margin: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
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
                                FormField(builder: (state) {
                                  return Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 5, 10),
                                    child: DropDown(
                                      initialOption: nombreComunidad,
                                      options: (nombreMunicipio == "" || listComunidades.isEmpty) ? ["Sin comunidades"] : listComunidades,
                                      onChanged: (val) => setState((){
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
                                      textStyle: AppTheme.of(context).title3.override(
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
                                      margin: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
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

                              // Padding(
                              //   padding:
                              //       EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                              //   child: StreamBuilder<List<EmprendedoresRecord>>(
                              //     stream: queryEmprendedoresRecord(),
                              //     builder: (context, snapshot) {
                              //       // Customize what your widget looks like when it's loading.
                              //       if (!snapshot.hasData) {
                              //         return Center(
                              //           child: SizedBox(
                              //             width: 50,
                              //             height: 50,
                              //             child: SpinKitRipple(
                              //               color: AppTheme.of(context)
                              //                   .primaryColor,
                              //               size: 50,
                              //             ),
                              //           ),
                              //         );
                              //       }
                              //       List<EmprendedoresRecord>
                              //           dropDownEmprendedoresRecordList =
                              //           snapshot.data;
                              //       return FlutterFlowDropDown(
                              //         options: dropDownEmprendedoresRecordList
                              //             .map((e) => e.nombre)
                              //             .toList()
                              //             .toList(),
                              //         onChanged: (val) =>
                              //             setState(() => dropDownValue2 = val),
                              //         width: MediaQuery.of(context).size.width,
                              //         height: 55,
                              //         textStyle: AppTheme.of(context)
                              //             .bodyText1
                              //             .override(
                              //               fontFamily: 'Poppins',
                              //               color: Colors.black,
                              //               fontSize: 15,
                              //               fontWeight: FontWeight.normal,
                              //             ),
                              //         hintText: 'Emprendedor...',
                              //         fillColor: Colors.white,
                              //         elevation: 2,
                              //         borderColor: Colors.transparent,
                              //         borderWidth: 0,
                              //         borderRadius: 8,
                              //         margin: EdgeInsetsDirectional.fromSTEB(
                              //             12, 4, 12, 4),
                              //         hidesUnderline: true,
                              //       );
                              //     },
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 10),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (nombreController.text != widget.emprendimiento.nombre || 
                                        descController.text != widget.emprendimiento.descripcion ||
                                        nombreComunidad != widget.emprendimiento.comunidad.target!.nombre ||
                                        nombreMunicipio != widget.emprendimiento.comunidad.target!.municipios.target!.nombre ||
                                        nombreEstado != widget.emprendimiento.comunidad.target!.municipios.target!.estados.target!.nombre) {
                                      if (emprendimientoProvider
                                          .validateForm(formKey)) {
                                        print("Se puede actualizar");
                                        final idEstado = dataBase.estadosBox.query(Estados_.nombre.equals(nombreEstado)).build().findFirst()?.id;
                                        if (idEstado != null) {
                                          final idMunicipio = dataBase.municipiosBox.query(Municipios_.estados.equals(idEstado).and(Municipios_.nombre.equals(nombreMunicipio))).build().findFirst()?.id;
                                          if (idMunicipio != null) {
                                            final idComunidad = dataBase.comunidadesBox.query(Comunidades_.municipios.equals(idMunicipio).and(Comunidades_.nombre.equals(nombreComunidad))).build().findFirst()?.id;
                                            if (idComunidad != null) {
                                              emprendimientoProvider.update(
                                              widget.emprendimiento.id,
                                              newImagen,
                                              nombreController.text,
                                              descController.text,
                                              idComunidad
                                              );
                                              await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const EmprendimientoActualizado(),
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
                                                  'Para continuar, debe llenar todos los campos e incluír una imagen.'),
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
                                      } 
                                  },
                                  text: 'Actualizar ',
                                  icon: const Icon(
                                    Icons.check,
                                    size: 15,
                                  ),
                                  options: FFButtonOptions(
                                    width: 150,
                                    height: 50,
                                    color: const Color(0xFF4672FF),
                                    textStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
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
                              ),
                              // Padding(
                              //   padding: const EdgeInsetsDirectional.fromSTEB(
                              //       0, 5, 0, 10),
                              //   child: Row(
                              //     mainAxisSize: MainAxisSize.max,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       FFButtonWidget(
                              //         onPressed: () async {
                              //           usuarioProvider.removeEmprendimiento(
                              //               widget.emprendimiento);
                              //           await Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //               builder: (context) =>
                              //                   const EmprendimientosScreen(),
                              //             ),
                              //           );
                              //         },
                              //         text: 'Eliminar Emprendimiento',
                              //         options: FFButtonOptions(
                              //           width: 290,
                              //           height: 50,
                              //           color: const Color.fromARGB(
                              //               242, 213, 35, 35),
                              //           textStyle: AppTheme.of(context)
                              //               .title3
                              //               .override(
                              //                 fontFamily: 'Montserrat',
                              //                 color: Colors.white,
                              //                 fontSize: 16,
                              //                 fontWeight: FontWeight.w300,
                              //               ),
                              //           elevation: 3,
                              //           borderSide: const BorderSide(
                              //             color:
                              //                 Color.fromARGB(242, 213, 35, 35),
                              //             width: 0,
                              //           ),
                              //           borderRadius: BorderRadius.circular(8),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
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
    );
  }
}
