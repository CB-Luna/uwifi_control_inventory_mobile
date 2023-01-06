import 'dart:convert';
import 'dart:io' as libraryIO;
import 'package:bizpro_app/modelsPocketbase/temporals/productos_solicitados_temporal.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/save_imagenes_local.dart';
import 'package:bizpro_app/screens/emprendimientos/detalle_emprendimiento_screen.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:badges/badges.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/providers/database_providers/producto_inversion_jornada_controller.dart';
import 'package:bizpro_app/screens/jornadas/jornada_creada.dart';
import 'package:bizpro_app/screens/jornadas/registros/inversion_jornada_temporal_screen.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_imagenes_completas.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_carousel.dart';

import 'package:bizpro_app/providers/database_providers/jornada_controller.dart';
import 'package:bizpro_app/providers/database_providers/inversion_jornada_controller.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AgregarJornada3Screen extends StatefulWidget {
  final Emprendimientos emprendimiento;
  final int numJornada;

  const AgregarJornada3Screen({
    Key? key,
    required this.emprendimiento,
    required this.numJornada,
  }) : super(key: key);

  @override
  _AgregarJornada3ScreenState createState() => _AgregarJornada3ScreenState();
}

class _AgregarJornada3ScreenState extends State<AgregarJornada3Screen> {
  TextEditingController fechaRevision = TextEditingController();
  TextEditingController tareaController = TextEditingController();
  TextEditingController fechaRegistro = TextEditingController();
  TextEditingController comentariosController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  List<String> checkboxGroupValues = [];
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<XFile> imagenesTemp = [];
  String tipoProyecto = "";
  String proyecto = "";
  String emprendedor = "";
  List<String> listTipoProyecto = [];
  List<String> listProyectos = [];

  @override
  void initState() {
    super.initState();
    imagenesTemp = [];
    fechaRevision = TextEditingController(
        text: context.read<JornadaController>().fechaRevision != null
            ? dateTimeFormat(
                'yMMMd', context.read<JornadaController>().fechaRevision!)
            : "");
    tareaController =
        TextEditingController(text: context.read<JornadaController>().tarea);
    fechaRegistro = TextEditingController();
    comentariosController = TextEditingController(
        text: context.read<JornadaController>().comentarios);
    fechaRegistro.text = dateTimeFormat('yMMMd', DateTime.now());
    tipoProyecto = context.read<JornadaController>().tipoProyecto;
    proyecto = context.read<JornadaController>().proyecto;
    descripcionController = TextEditingController(
        text: context.read<JornadaController>().descripcion);
    listProyectos = [];
    listTipoProyecto = [];
    dataBase.tipoProyectoBox.getAll().forEach((element) {
      listTipoProyecto.add(element.tipoProyecto);
    });
    listTipoProyecto
        .sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    dataBase.catalogoProyectoBox.getAll().forEach((element) {
      if (element.tipoProyecto.target?.tipoProyecto == tipoProyecto) {
        listProyectos.add(element.nombre);
      }
    });
    listProyectos
        .sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    emprendedor = "";
    if (widget.emprendimiento.emprendedor.target != null) {
      emprendedor =
          "${widget.emprendimiento.emprendedor.target!.nombre} ${widget.emprendimiento.emprendedor.target!.apellidos}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final jornadaProvider = Provider.of<JornadaController>(context);
    final inversionJornadaProvider =
        Provider.of<InversionJornadaController>(context);
    final productoInversionJornadaController =
        Provider.of<ProductoInversionJornadaController>(context);
    String totalProductos = productoInversionJornadaController
        .productosSolicitados.length
        .toString();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: widget.emprendimiento.imagen.target != null
                              ? FileImage(libraryIO.File(
                                  widget.emprendimiento.imagen.target!.path!))
                              : Image.asset(
                                  "assets/images/default_image_placeholder.jpeg",
                                ).image,
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
                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Container(
                        width: double.infinity,
                        height: 200,
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
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 45, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 10),
                                    child: Container(
                                      width: 80,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            AppTheme.of(context).secondaryText,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          inversionJornadaProvider
                                              .clearInformation();
                                          productoInversionJornadaController
                                              .clearInformation();
                                          jornadaProvider.clearInformation();
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetalleEmprendimientoScreen(
                                                idEmprendimiento:
                                                    widget.emprendimiento.id,
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
                                              style: AppTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily:
                                                        AppTheme.of(context)
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
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4672FF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  widget.emprendimiento.nombre,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      AppTheme.of(context).subtitle2.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
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
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: const Color(0x554672FF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 5, 0, 0),
                                        child: Text(
                                          "Jornada ${widget.numJornada}",
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: AppTheme.of(context)
                                                    .bodyText1Family,
                                                color: AppTheme.of(context)
                                                    .primaryText,
                                                fontSize: 18,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 5, 0, 0),
                                        child: Text(
                                          emprendedor == ""
                                              ? "SIN EMPRENDEDOR"
                                              : emprendedor,
                                          style: AppTheme.of(context).bodyText1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 5, 0, 5),
                                        child: Text(
                                          widget.emprendimiento.nombre,
                                          style: AppTheme.of(context).bodyText1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                    controller: fechaRegistro,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onTap: () async {
                                      await DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                          setState(() {
                                            jornadaProvider.fechaRegistro =
                                                date;
                                            fechaRegistro.text =
                                                dateTimeFormat('yMMMd', date);
                                          });
                                        },
                                        currentTime: getCurrentTimestamp,
                                        // minTime: getCurrentTimestamp.subtract(const Duration(days: 7)),
                                      );
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Fecha de registro*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingresa fecha de registro...',
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
                                    keyboardType: TextInputType.none,
                                    showCursor: false,
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Para continuar, ingrese la fecha de registro';
                                      }

                                      return null;
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  maxLength: 500,
                                  controller: tareaController,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    jornadaProvider.tarea = value;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Registrar Tarea*',
                                    labelStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    hintText: 'Registro de tarea...',
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
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0x49FFFFFF),
                                  ),
                                  style: AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  maxLines: 2,
                                  validator: (value) {
                                    return capitalizadoCharacters
                                            .hasMatch(value ?? '')
                                        ? null
                                        : 'Para continuar, ingrese la tarea empezando por mayúscula';
                                  },
                                ),
                              ),
                              FormField(builder: (state) {
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 10, 0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFEEEEEE),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: SizedBox(
                                                  width: 180,
                                                  height: 100,
                                                  child: FlutterFlowCarousel(
                                                      width: 180,
                                                      height: 100,
                                                      listaImagenes:
                                                          jornadaProvider
                                                              .imagenes)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 0, 0),
                                              child: Text(
                                                "Total imágenes: ${jornadaProvider.imagenes.length}",
                                                style: AppTheme.of(context)
                                                    .title3
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color:
                                                          AppTheme.of(context)
                                                              .secondaryText,
                                                      fontSize: 12.5,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          String? option =
                                              await showModalBottomSheet(
                                            context: context,
                                            builder: (_) =>
                                                const CustomBottomSheet(),
                                          );

                                          if (option == null) return;

                                          final picker = ImagePicker();
                                          imagenesTemp = [];
                                          XFile? pickedFile;
                                          List<XFile>? pickedFiles;
                                          if (option == 'camera') {
                                            if (jornadaProvider
                                                    .imagenes.length <
                                                3) {
                                              pickedFile =
                                                  await picker.pickImage(
                                                source: ImageSource.camera,
                                                imageQuality: 50,
                                              );
                                              if (pickedFile != null) {
                                                imagenesTemp.add(pickedFile);
                                              }
                                            } else {
                                              bool? booleano =
                                                  await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return Padding(
                                                    padding:
                                                        MediaQuery.of(context)
                                                            .viewInsets,
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.45,
                                                      child:
                                                          const BottomSheetImagenesCompletas(),
                                                    ),
                                                  );
                                                },
                                              );
                                              if (booleano != null &&
                                                  booleano == true) {
                                                pickedFile =
                                                    await picker.pickImage(
                                                  source: ImageSource.camera,
                                                  imageQuality: 50,
                                                );
                                                if (pickedFile != null) {
                                                  setState(() {
                                                    jornadaProvider.imagenes
                                                        .removeLast();
                                                    jornadaProvider.imagenes
                                                        .add(pickedFile!.path);
                                                  });
                                                }
                                                return;
                                              }
                                            }
                                          } else {
                                            //Se selecciona galería
                                            if (jornadaProvider
                                                    .imagenes.length <
                                                3) {
                                              pickedFiles =
                                                  await picker.pickMultiImage(
                                                imageQuality: 50,
                                              );
                                              if (pickedFiles == null) {
                                                return;
                                              }
                                              if (pickedFiles.length > 3) {
                                                snackbarKey.currentState
                                                    ?.showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "No se permite cargar más de 3 imágenes."),
                                                ));
                                                return;
                                              }
                                              switch (jornadaProvider
                                                  .imagenes.length) {
                                                case 0:
                                                  for (int i = 0;
                                                      i < pickedFiles.length;
                                                      i++) {
                                                    imagenesTemp
                                                        .add(pickedFiles[i]);
                                                  }
                                                  break;
                                                case 1:
                                                  if (pickedFiles.length <= 2) {
                                                    for (int i = 0;
                                                        i < pickedFiles.length;
                                                        i++) {
                                                      imagenesTemp
                                                          .add(pickedFiles[i]);
                                                    }
                                                  } else {
                                                    snackbarKey.currentState
                                                        ?.showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          "No se permite cargar más de 3 imágenes."),
                                                    ));
                                                    return;
                                                  }
                                                  break;
                                                case 2:
                                                  if (pickedFiles.length <= 1) {
                                                    for (int i = 0;
                                                        i < pickedFiles.length;
                                                        i++) {
                                                      imagenesTemp
                                                          .add(pickedFiles[i]);
                                                    }
                                                  } else {
                                                    snackbarKey.currentState
                                                        ?.showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          "No se permite cargar más de 3 imágenes."),
                                                    ));
                                                    return;
                                                  }
                                                  break;
                                                default:
                                                  break;
                                              }
                                            } else {
                                              bool? booleano =
                                                  await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return Padding(
                                                    padding:
                                                        MediaQuery.of(context)
                                                            .viewInsets,
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.45,
                                                      child:
                                                          const BottomSheetImagenesCompletas(),
                                                    ),
                                                  );
                                                },
                                              );
                                              if (booleano != null &&
                                                  booleano == true) {
                                                pickedFile =
                                                    await picker.pickImage(
                                                  source: ImageSource.gallery,
                                                  imageQuality: 50,
                                                );
                                                if (pickedFile != null) {
                                                  setState(() {
                                                    jornadaProvider.imagenes
                                                        .removeLast();
                                                    jornadaProvider.imagenes
                                                        .add(pickedFile!.path);
                                                  });
                                                }
                                                return;
                                              }
                                            }
                                          }
                                          setState(() {
                                            for (var i = 0;
                                                i < imagenesTemp.length;
                                                i++) {
                                              libraryIO.File file =
                                                  libraryIO.File(
                                                      imagenesTemp[i].path);
                                              List<int> fileInByte =
                                                  file.readAsBytesSync();
                                              String base64 =
                                                  base64Encode(fileInByte);
                                              var newImagenLocal =
                                                  SaveImagenesLocal(
                                                      nombre:
                                                          imagenesTemp[i].name,
                                                      path:
                                                          imagenesTemp[i].path,
                                                      base64: base64);
                                              jornadaProvider.imagenesLocal
                                                  .add(newImagenLocal);
                                              jornadaProvider.imagenes
                                                  .add(imagenesTemp[i].path);
                                            }
                                          });
                                        },
                                        text: 'Análisis Financiero',
                                        icon: const Icon(
                                          Icons.add_a_photo,
                                          size: 15,
                                        ),
                                        options: FFButtonOptions(
                                          width: 160,
                                          height: 40,
                                          color: AppTheme.of(context)
                                              .secondaryText,
                                          textStyle: AppTheme.of(context)
                                              .subtitle2
                                              .override(
                                                fontFamily: AppTheme.of(context)
                                                    .subtitle2Family,
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }, validator: (val) {
                                if (jornadaProvider.imagenes.isEmpty ||
                                    jornadaProvider.imagenes == []) {
                                  return 'Para continuar, cargue el Analisis Financiero';
                                }
                                return null;
                              }),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 10, 5, 10),
                                child: TextFormField(
                                    controller: fechaRevision,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onTap: () async {
                                      await DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                          setState(() {
                                            jornadaProvider.fechaRevision =
                                                date;
                                            fechaRevision.text =
                                                dateTimeFormat('yMMMd', date);
                                          });
                                        },
                                        currentTime: getCurrentTimestamp,
                                        // minTime: getCurrentTimestamp,
                                      );
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Fecha de revisión*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingresa fecha de revisión...',
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
                                    keyboardType: TextInputType.none,
                                    showCursor: false,
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Para continuar, ingrese la fecha de revisión';
                                      }

                                      return null;
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  maxLength: 500,
                                  controller: comentariosController,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    jornadaProvider.comentarios = value;
                                  },
                                  obscureText: false,
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
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0x49FFFFFF),
                                  ),
                                  style: AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  maxLines: 3,
                                ),
                              ),
                              FormField(
                                builder: (state) {
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 5, 10),
                                    child: DropDown(
                                      initialOption: tipoProyecto,
                                      options: listTipoProyecto,
                                      onChanged: (val) => setState(() {
                                        if (listTipoProyecto.isEmpty) {
                                          snackbarKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                            content: Text(
                                                "Debes descargar los catálogos desde la sección de tu perfil"),
                                          ));
                                        } else {
                                          listProyectos.clear();
                                          tipoProyecto = val!;
                                          jornadaProvider.tipoProyecto = val;
                                          dataBase.catalogoProyectoBox
                                              .getAll()
                                              .forEach((element) {
                                            if (element.tipoProyecto.target!
                                                    .tipoProyecto ==
                                                tipoProyecto) {
                                              listProyectos.add(element.nombre);
                                            }
                                          });
                                          listProyectos.sort((a, b) =>
                                              removeDiacritics(a).compareTo(
                                                  removeDiacritics(b)));
                                          print("Entro a tipo proyecto");
                                        }
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
                                      hintText: 'Tipo proyecto*',
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
                                  if (tipoProyecto == "" ||
                                      tipoProyecto.isEmpty) {
                                    return 'Para continuar, seleccione un tipo de proyecto.';
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
                                      initialOption: proyecto,
                                      options: (tipoProyecto == "" ||
                                              listProyectos.isEmpty)
                                          ? ["Sin proyectos"]
                                          : listProyectos,
                                      onChanged: (val) => setState(() {
                                        if (val == "Sin proyectos") {
                                          snackbarKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                            content: Text(
                                                "Debes seleccionar un tipo de proyecto para seleccionar un proyecto"),
                                          ));
                                        } else {
                                          proyecto = val!;
                                          jornadaProvider.proyecto = val;
                                          print("Entro a proyectos");
                                        }
                                        print("Proyecto: $proyecto");
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
                                      hintText: 'Proyecto*',
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
                                  if (proyecto == "" || proyecto.isEmpty) {
                                    return 'Para continuar, seleccione un proyecto.';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  maxLength: 500,
                                  controller: descripcionController,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (value) {
                                    jornadaProvider.descripcion = value;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Descripción*',
                                    labelStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    hintText: 'Descripción...',
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
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0x49FFFFFF),
                                  ),
                                  style: AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  maxLines: 3,
                                  validator: (value) {
                                    return capitalizadoCharacters
                                            .hasMatch(value ?? '')
                                        ? null
                                        : 'Para continuar, ingrese la descripción empezando por mayúscula';
                                  },
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 5, 10),
                                    child: Badge(
                                      badgeContent: Text(totalProductos,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      showBadge: true,
                                      badgeColor: const Color(0xFFD20030),
                                      position: BadgePosition.topEnd(),
                                      elevation: 4,
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          if (productoInversionJornadaController
                                              .productosSolicitados.isEmpty) {
                                            if (proyecto != "" &&
                                                tipoProyecto != "") {
                                              final actualProyecto = dataBase
                                                  .catalogoProyectoBox
                                                  .query(CatalogoProyecto_
                                                      .nombre
                                                      .equals(proyecto))
                                                  .build()
                                                  .findFirst();
                                              if (actualProyecto != null &&
                                                  actualProyecto.prodProyecto
                                                      .isNotEmpty) {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Productos precargados'),
                                                      content: const Text(
                                                          '¿Deseas agregar productos precargados?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            List<ProdProyecto>
                                                                listProdProyecto =
                                                                actualProyecto
                                                                    .prodProyecto
                                                                    .toList();
                                                            inversionJornadaProvider
                                                                    .porcentajePago =
                                                                "50";
                                                            inversionJornadaProvider
                                                                .addTemporal(widget
                                                                    .emprendimiento
                                                                    .id);
                                                            for (var element
                                                                in listProdProyecto) {
                                                              var nuevoProdSolicitadoTemporal = ProductosSolicitadosTemporal(
                                                                  id: element
                                                                      .idDBR!,
                                                                  producto: element
                                                                      .producto,
                                                                  marcaSugerida:
                                                                      element
                                                                          .marcaSugerida,
                                                                  descripcion: element
                                                                      .descripcion,
                                                                  proveedorSugerido:
                                                                      element
                                                                          .proveedorSugerido,
                                                                  costoEstimado:
                                                                      element.costoEstimado ??
                                                                          0.0,
                                                                  cantidad: element
                                                                      .cantidad,
                                                                  idFamiliaProd: element
                                                                      .familiaProducto
                                                                      .target!
                                                                      .id,
                                                                  familiaProd: element
                                                                      .familiaProducto
                                                                      .target!
                                                                      .nombre,
                                                                  idTipoEmpaques: element
                                                                      .tipoEmpaque
                                                                      .target!
                                                                      .id,
                                                                  tipoEmpaques:
                                                                      element
                                                                          .tipoEmpaque
                                                                          .target!
                                                                          .tipo,
                                                                  fechaRegistro:
                                                                      DateTime
                                                                          .now());
                                                              productoInversionJornadaController
                                                                  .productosSolicitados
                                                                  .add(
                                                                      nuevoProdSolicitadoTemporal);
                                                            }
                                                            Navigator.pop(
                                                                alertDialogContext);
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        InversionJornadaTemporalScreen(
                                                                  emprendimiento:
                                                                      widget
                                                                          .emprendimiento,
                                                                  numJornada: widget
                                                                      .numJornada,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child:
                                                              const Text('Sí'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                alertDialogContext);
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        InversionJornadaTemporalScreen(
                                                                  emprendimiento:
                                                                      widget
                                                                          .emprendimiento,
                                                                  numJornada: widget
                                                                      .numJornada,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child:
                                                              const Text('No'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        InversionJornadaTemporalScreen(
                                                      emprendimiento:
                                                          widget.emprendimiento,
                                                      numJornada:
                                                          widget.numJornada,
                                                    ),
                                                  ),
                                                );
                                              }
                                            } else {
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Campos vacíos'),
                                                    content: const Text(
                                                        "Para agregar registros, es necesario que selecciones Tipo de Proyecto y un Proyecto"),
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
                                          } else {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InversionJornadaTemporalScreen(
                                                  emprendimiento:
                                                      widget.emprendimiento,
                                                  numJornada: widget.numJornada,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        text: 'Agregar Inversión',
                                        options: FFButtonOptions(
                                          width: 150,
                                          height: 50,
                                          color: AppTheme.of(context)
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
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (jornadaProvider.validateForm(formKey) &&
                                  totalProductos != "0") {
                                final idProyecto = dataBase.catalogoProyectoBox
                                    .query(CatalogoProyecto_.nombre
                                        .equals(proyecto))
                                    .build()
                                    .findFirst()
                                    ?.id;
                                if (idProyecto != null) {
                                  productoInversionJornadaController.add(
                                      widget.emprendimiento.id,
                                      inversionJornadaProvider
                                          .add(widget.emprendimiento.id));
                                  jornadaProvider.addJornada3(
                                      widget.emprendimiento.id,
                                      idProyecto,
                                      widget.numJornada);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JornadaCreada(
                                        idEmprendimiento:
                                            widget.emprendimiento.id,
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('Campos vacíos'),
                                      content: const Text(
                                          'Para continuar, debe llenar los campos solicitados, agregar un registro e incluir una imagen del análisis financiero.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: const Text('Bien'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return;
                              }
                            },
                            text: 'Crear',
                            icon: const Icon(
                              Icons.check_rounded,
                              size: 15,
                            ),
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: AppTheme.of(context).secondaryText,
                              textStyle: AppTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily:
                                        AppTheme.of(context).subtitle2Family,
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        )
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
