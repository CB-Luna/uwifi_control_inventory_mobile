import 'dart:convert';
import 'dart:io';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/save_imagenes_local.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/save_instruccion_imagen_temporal.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_imagenes_completas.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_validacion_eliminar_imagen.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_eliminar_imagen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/providers/database_providers/jornada_controller.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/jornadas/jornada_actualizada.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_checkbox_group.dart';

class EditarJornada4Screen extends StatefulWidget {
  final Jornadas jornada;
  final Emprendimientos emprendimiento;
  const EditarJornada4Screen({Key? key, required this.jornada, required this.emprendimiento})
      : super(key: key);

  @override
  _EditarJornada4ScreenState createState() => _EditarJornada4ScreenState();
}

class _EditarJornada4ScreenState extends State<EditarJornada4Screen> {
  List<String> checkboxGroupValues = [];
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late DateTime fechaRegistro;
  late DateTime fechaRevision;
  late TextEditingController fechaRegistroText;
  late TextEditingController fechaRevisionText;
  late TextEditingController comentariosController;
  late bool activoController;
  List<SaveImagenesLocal> newConvenio = [];
  List<SaveImagenesLocal> oldConvenio = [];
  List<SaveInstruccionImagenTemporal> listInstruccionesImagenesTemp = [];
  List<String> imagenesCarrousel = [];
  List<XFile> imagenesTemp = [];

  @override
  void initState() {
    super.initState();
    fechaRevision = widget.jornada.fechaRevision;
    fechaRegistro = widget.jornada.fechaRegistro;
    fechaRevisionText = TextEditingController(
        text: dateTimeFormat('yMMMd', widget.jornada.fechaRevision));
    fechaRegistroText = TextEditingController(
        text: dateTimeFormat('yMMMd', widget.jornada.fechaRegistro));
    comentariosController =
        TextEditingController(text: widget.jornada.tarea.target!.comentarios);
    imagenesTemp =[];
    newConvenio = [];
    for (var element in widget.jornada.tarea.target!.imagenes.toList()) {
      var newSaveImagenLocal = SaveImagenesLocal(
        id: element.id,
        nombre: element.nombre!, 
        path: element.path!, 
        base64: element.base64!,
      );
      newConvenio.add(newSaveImagenLocal);
      oldConvenio.add(newSaveImagenLocal);
      imagenesCarrousel.add(element.imagenes);
    }
    activoController = !widget.jornada.completada;
  }

  @override
  Widget build(BuildContext context) {
    final jornadaProvider = Provider.of<JornadaController>(context);
    String emprendedor = "";
    if (widget.jornada.emprendimiento.target!.emprendedor.target != null) {
      emprendedor =
          "${widget.jornada.emprendimiento.target!.emprendedor.target!.nombre} ${widget.jornada.emprendimiento.target!.emprendedor.target!.apellidos}";
    }
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
                          image: FileImage(File(
                              widget.jornada.emprendimiento.target!.imagen.target!.path!)),
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
                                  widget.jornada.emprendimiento.target!.nombre,
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
                                          "Jornada ${widget.jornada.numJornada}",
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
                                          widget.jornada.emprendimiento.target!
                                              .nombre,
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
                                    controller: fechaRegistroText,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onTap: () async {
                                      await DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                          setState(() {
                                            fechaRegistro = date;
                                            fechaRegistroText.text =
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
                                  controller: comentariosController,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                              FormField(builder: (state) {
                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 0),
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
                                                  child: CarouselSlider(
                                                    options: CarouselOptions(height: 400.0),
                                                    items: imagenesCarrousel.map((i) {
                                                      return Builder(
                                                        builder: (BuildContext context) {
                                                          return InkWell(
                                                            onTap: () async {
                                                              String? option =
                                                                  await showModalBottomSheet(
                                                                context: context,
                                                                builder: (_) =>
                                                                    const CustomBottomEliminarImagen(),
                                                              );
                                                              if (option == 'eliminar') {
                                                                var booleano = await showModalBottomSheet(
                                                                  isScrollControlled: true,
                                                                  backgroundColor: Colors.transparent,
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return Padding(
                                                                      padding: MediaQuery.of(context).viewInsets,
                                                                      child: SizedBox(
                                                                        height:
                                                                            MediaQuery.of(context).size.height * 0.45,
                                                                        child: BottomSheetValidacionEliminarImagen(imagen: i,),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                                if (booleano) {
                                                                  for (var element in newConvenio) {
                                                                    if (element.path == i) {
                                                                      var newInstruccionImagen = SaveInstruccionImagenTemporal(
                                                                        instruccion: "syncDeleteImagenJornada",
                                                                        instruccionAdicional: "Imagen Jornada 4",
                                                                        imagenLocal: element,
                                                                        );
                                                                      newConvenio.remove(element);
                                                                      listInstruccionesImagenesTemp.add(newInstruccionImagen);
                                                                      imagenesCarrousel.remove(element.path);
                                                                      break;
                                                                    }
                                                                  }
                                                                }
                                                              } else { //Se aborta la opción
                                                                return;
                                                              }
                                                              setState(() {
                                                              });
                                                            },
                                                            child: Container(
                                                                width: MediaQuery.of(context).size.width,
                                                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                                                child: Image.file(
                                                                    File(i),
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      }).toList(),
                                                    ),
                                                ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 0, 0),
                                              child: Text(
                                                "Total imágenes: ${imagenesCarrousel.length}",
                                                style: AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    AppTheme.of(context).secondaryText,
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.normal,
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
                                            if (imagenesCarrousel.length < 3) {
                                              pickedFile = await picker.pickImage(
                                                source: ImageSource.camera,
                                                imageQuality: 100,
                                              );
                                              if (pickedFile != null) {
                                                imagenesTemp.add(pickedFile);
                                              }
                                            } else {
                                                bool? booleano = await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor: Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return Padding(
                                                    padding: MediaQuery.of(context).viewInsets,
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context).size.height * 0.45,
                                                      child: const BottomSheetImagenesCompletas(),
                                                    ),
                                                  );
                                                },
                                              );  
                                              if (booleano != null && booleano == true) {
                                                pickedFile = await picker.pickImage(
                                                source: ImageSource.camera,
                                                imageQuality: 100,
                                                );
                                                if (pickedFile != null) {
                                                  setState(() {
                                                    File file = File(pickedFile!.path);
                                                    List<int> fileInByte = file.readAsBytesSync();
                                                    String base64 = base64Encode(fileInByte);
                                                    var updateImagenLocal = SaveImagenesLocal(
                                                      nombre: pickedFile.name, 
                                                      path: pickedFile.path, 
                                                      base64: base64,
                                                    );
                                                    imagenesCarrousel.removeLast();
                                                    imagenesCarrousel.add(pickedFile.path);
                                                    newConvenio.removeLast();
                                                    newConvenio.add(updateImagenLocal);
                                                  });
                                                }
                                                return;
                                              }        
                                            }
                                          } else { //Se selecciona galería
                                            if (imagenesCarrousel.length < 3) {
                                              pickedFiles = await picker.pickMultiImage(
                                              imageQuality: 100,
                                              );
                                              if (pickedFiles == null) {
                                                return;
                                              }
                                              if (pickedFiles.length > 3) {
                                                snackbarKey.currentState
                                                  ?.showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "No se permite cargar más de 3 imágenes."),
                                                ));
                                                return;
                                              }
                                              switch (imagenesCarrousel.length) {
                                                case 0:
                                                  for(int i = 0; i < pickedFiles.length; i++)
                                                  {
                                                    imagenesTemp.add(pickedFiles[i]);
                                                    File file = File(pickedFiles[i].path);
                                                    List<int> fileInByte = file.readAsBytesSync();
                                                    String base64 = base64Encode(fileInByte);
                                                    var newImagenLocal = SaveImagenesLocal(
                                                      nombre: pickedFiles[i].name, 
                                                      path: pickedFiles[i].path, 
                                                      base64: base64,
                                                      );
                                                    var newInstruccionImagen = SaveInstruccionImagenTemporal(
                                                      instruccion: "syncAddImagenJornada4",
                                                      imagenLocal: newImagenLocal,
                                                      );
                                                    newConvenio.add(newImagenLocal);
                                                    listInstruccionesImagenesTemp.add(newInstruccionImagen);
                                                  }
                                                  break;
                                                case 1:
                                                  if(pickedFiles.length <= 2){
                                                    for(int i = 0; i < pickedFiles.length; i++)
                                                    {
                                                      imagenesTemp.add(pickedFiles[i]);
                                                      File file = File(pickedFiles[i].path);
                                                      List<int> fileInByte = file.readAsBytesSync();
                                                      String base64 = base64Encode(fileInByte);
                                                      var newImagenLocal = SaveImagenesLocal(
                                                        nombre: pickedFiles[i].name, 
                                                        path: pickedFiles[i].path, 
                                                        base64: base64,
                                                        );
                                                      var newInstruccionImagen = SaveInstruccionImagenTemporal(
                                                        instruccion: "syncAddImagenJornada4",
                                                        imagenLocal: newImagenLocal,
                                                        );
                                                      newConvenio.add(newImagenLocal);
                                                      listInstruccionesImagenesTemp.add(newInstruccionImagen);
                                                    }
                                                  }
                                                  else{
                                                    snackbarKey.currentState
                                                    ?.showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "No se permite cargar más de 3 imágenes."),
                                                    ));
                                                    return;
                                                  }
                                                  break;
                                                case 2:
                                                  if(pickedFiles.length <= 1){
                                                    for(int i = 0; i < pickedFiles.length; i++)
                                                    {
                                                      imagenesTemp.add(pickedFiles[i]);
                                                      File file = File(pickedFiles[i].path);
                                                      List<int> fileInByte = file.readAsBytesSync();
                                                      String base64 = base64Encode(fileInByte);
                                                      var newImagenLocal = SaveImagenesLocal(
                                                        nombre: pickedFiles[i].name, 
                                                        path: pickedFiles[i].path, 
                                                        base64: base64,
                                                        );
                                                      var newInstruccionImagen = SaveInstruccionImagenTemporal(
                                                        instruccion: "syncAddImagenJornada4",
                                                        imagenLocal: newImagenLocal,
                                                        );
                                                      newConvenio.add(newImagenLocal);
                                                      listInstruccionesImagenesTemp.add(newInstruccionImagen);
                                                    }
                                                  }
                                                  else{
                                                    snackbarKey.currentState
                                                    ?.showSnackBar(const SnackBar(
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
                                              bool? booleano = await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor: Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return Padding(
                                                    padding: MediaQuery.of(context).viewInsets,
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context).size.height * 0.45,
                                                      child: const BottomSheetImagenesCompletas(),
                                                    ),
                                                  );
                                                },
                                              );
                                              if (booleano != null && booleano == true) {
                                                pickedFile = await picker.pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 100,
                                                );
                                                if (pickedFile != null) {
                                                  setState(() {
                                                    if (newConvenio[imagenesCarrousel.length - 1].id != null) {
                                                      // La imagen anterior ya ha sido registrada
                                                      File file = File(pickedFile!.path);
                                                      List<int> fileInByte = file.readAsBytesSync();
                                                      String base64 = base64Encode(fileInByte);
                                                      var updateImagenLocal = SaveImagenesLocal(
                                                        id: newConvenio[imagenesCarrousel.length - 1].id,
                                                        nombre: pickedFile.name, 
                                                        path: pickedFile.path, 
                                                        base64: base64,
                                                        );
                                                      var newInstruccionImagen = SaveInstruccionImagenTemporal(
                                                        instruccion: "syncUpdateImagenJornada4",
                                                        imagenLocal: updateImagenLocal,
                                                        );
                                                      newConvenio.removeLast();
                                                      newConvenio.add(updateImagenLocal);
                                                      imagenesCarrousel.removeLast();
                                                      imagenesCarrousel.add(pickedFile.path);
                                                      listInstruccionesImagenesTemp.add(newInstruccionImagen);
                                                    } else {
                                                      // La imagen no ha sido registrada
                                                      File file = File(pickedFile!.path);
                                                      List<int> fileInByte = file.readAsBytesSync();
                                                      String base64 = base64Encode(fileInByte);
                                                      var updateImagenLocal = SaveImagenesLocal(
                                                        nombre: pickedFile.name, 
                                                        path: pickedFile.path, 
                                                        base64: base64,
                                                      );
                                                      newConvenio.removeLast();
                                                      newConvenio.add(updateImagenLocal);
                                                      imagenesCarrousel.removeLast();
                                                      imagenesCarrousel.add(pickedFile.path);
                                                    }
                                                  }
                                                  );
                                                }
                                                return;
                                              }     
                                            }
                                          }
                                          setState(() {
                                            for (var i = 0; i < imagenesTemp.length; i++) {
                                              imagenesCarrousel.add(imagenesTemp[i].path);
                                            }
                                          });
                                        },
                                        text: 'Convenio',
                                        icon: const Icon(
                                          Icons.add_a_photo,
                                          size: 15,
                                        ),
                                        options: FFButtonOptions(
                                          width: 140,
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
                                if (imagenesCarrousel.isEmpty ||
                                    imagenesCarrousel == []) {
                                  return 'Para continuar, cargue el convenio.';
                                }
                                return null;
                              }),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: FlutterFlowCheckboxGroup(
                                        initiallySelected: !activoController,
                                        options: '¿Tarea Completada?',
                                        onChanged: (val) => setState(() {
                                          activoController = val;
                                        }),
                                        activeColor:
                                            AppTheme.of(context).primaryColor,
                                        checkColor: Colors.white,
                                        checkboxBorderColor:
                                            const Color(0xFF95A1AC),
                                        textStyle: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (jornadaProvider.validateForm(formKey)) {
                                if (fechaRegistro !=
                                        widget.jornada.fechaRegistro ||
                                    comentariosController.text !=
                                        widget.jornada.tarea.target!
                                            .comentarios ||
                                    activoController !=
                                        !widget.jornada.completada) {
                                  if (newConvenio !=
                                        oldConvenio) {
                                    jornadaProvider.updateImagenesJornada(
                                      widget.jornada.tarea.target!, 
                                      listInstruccionesImagenesTemp,
                                      );
                                  } 
                                  jornadaProvider.updateJornada4(
                                      widget.jornada.id,
                                      fechaRegistro,
                                      comentariosController.text,
                                      !activoController,
                                      widget.jornada.tarea.target!.id);
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                             JornadaActualizada(emprendimientoId: widget.emprendimiento.id,),
                                      ));
                                } else {
                                  if (newConvenio !=
                                        oldConvenio) {
                                    jornadaProvider.updateImagenesJornada(
                                      widget.jornada.tarea.target!, 
                                      listInstruccionesImagenesTemp,
                                      );
                                  } 
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                           JornadaActualizada(emprendimientoId: widget.emprendimiento.id,),
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
                                          'Para continuar, debe llenar los campos solicitados e incluir una imagen del convenio.'),
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
                            text: 'Actualizar',
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
