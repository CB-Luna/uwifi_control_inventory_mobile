import 'dart:io';
import 'package:badges/badges.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';

import 'package:bizpro_app/screens/inversiones/agregar_registro_proyecto.dart';
import 'package:bizpro_app/screens/jornadas/jornada_creada.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_expanded_image_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';

import 'package:bizpro_app/providers/database_providers/jornada_controller.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_checkbox_group.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class EditarJornada3Screen extends StatefulWidget {
  final Jornadas jornada;
  
  const EditarJornada3Screen({
    Key? key, 
    required this.jornada,
  }) : super(key: key);


  @override
  _EditarJornada3ScreenState createState() => _EditarJornada3ScreenState();
}

class _EditarJornada3ScreenState extends State<EditarJornada3Screen> {
  List<String> checkboxGroupValues = [];
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late DateTime fechaRegistro;
  late DateTime fechaRevision;
  late TextEditingController fechaRegistroText;
  late TextEditingController fechaRevisionText;
  late TextEditingController tareaController;
  late TextEditingController comentariosController;
  late TextEditingController descController;
  late bool activoController;
  XFile? image;
  String tipoProyecto = "";
  String proyecto = "";
  String emprendedor = "";
  List<String> listTipoProyecto = [];
  List<String> listProyectos = [];

  @override
  void initState() {
    super.initState();
    fechaRevision = widget.jornada.fechaRevision;
    fechaRegistro = widget.jornada.fechaRegistro;
    fechaRevisionText = TextEditingController(text: dateTimeFormat('yMMMd', widget.jornada.fechaRevision));
    fechaRegistroText = TextEditingController(text: dateTimeFormat('yMMMd', widget.jornada.fechaRegistro));
    tareaController = TextEditingController(text: widget.jornada.tarea.target!.tarea);
    comentariosController = TextEditingController(text: widget.jornada.tarea.target!.observacion);
    descController = TextEditingController(text: widget.jornada.tarea.target!.descripcion);
    activoController = widget.jornada.tarea.target!.activo;
    tipoProyecto = widget.jornada.emprendimiento.target!.catalogoProyecto.target!.clasificacionEmp.target!.clasificacion;
    proyecto = widget.jornada.emprendimiento.target!.catalogoProyecto.target!.nombre;
    listProyectos = [];
    listTipoProyecto = [];
    // dataBase.clasificacionesEmpBox.getAll().forEach((element) {listTipoProyecto.add(element.clasificacion);});
    dataBase.clasificacionesEmpBox.getAll().forEach((element) {listTipoProyecto.add(element.clasificacion);});
    dataBase.catalogoProyectoBox.getAll().forEach((element) {
    if (element.clasificacionEmp.target?.clasificacion == tipoProyecto) {
      listProyectos.add(element.nombre);
    }                                    
    });
  }

  @override
  Widget build(BuildContext context) {
    final jornadaProvider = Provider.of<JornadaController>(context);
    String emprendedor = "";
    if (widget.jornada.emprendimiento.target!.emprendedor.target != null) {
      emprendedor =
          "${widget.jornada.emprendimiento.target!.emprendedor.target!.nombre} ${widget.jornada.emprendimiento.target!.emprendedor.target!.apellidos}";
    }
    return Scaffold(
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
                      image: FileImage(File(widget.jornada.emprendimiento.target!.imagen)),
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 45, 16, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      borderRadius:
                                          BorderRadius.circular(10),
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
                                            style:
                                                AppTheme.of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily:
                                                          AppTheme.of(
                                                                  context)
                                                              .bodyText1Family,
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.jornada.emprendimiento.target!.nombre,
                              maxLines: 1,
                              style: AppTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: AppTheme.of(context)
                                        .subtitle2Family,
                                    color: Colors.white,
                                    fontSize: 18,
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
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
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 0, 0),
                                      child: Text(
                                        "Jornada ${widget.jornada.numJornada}",
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  AppTheme.of(context)
                                                      .bodyText1Family,
                                              color:
                                                  AppTheme.of(context)
                                                      .primaryText,
                                              fontSize: 18,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 0, 0),
                                      child: Text(
                                        emprendedor == "" ? "SIN EMPRENDEDOR" : emprendedor,
                                        style: AppTheme.of(context)
                                            .bodyText1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 0, 5),
                                      child: Text(
                                        widget.jornada.emprendimiento.target!.nombre,
                                        style: AppTheme.of(context)
                                            .bodyText1,
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
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onTap: () async {
                                  await DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    onConfirm: (date) {
                                      setState(() {
                                        fechaRegistro = date;
                                        fechaRegistroText.text = dateTimeFormat('yMMMd', date);
                                      });
                                    },
                                    currentTime: getCurrentTimestamp,
                                    // minTime: getCurrentTimestamp.subtract(const Duration(days: 7)),
                                  );
                                  
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Fecha de registro*',
                                  labelStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Ingresa fecha de registro...',
                                  hintStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0x49FFFFFF),
                                ),
                                keyboardType: TextInputType.none,
                                showCursor: false,
                                style: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Para continuar, ingrese la fecha de registro';
                                  }
                
                                  return null;
                                }
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 5, 10),
                              child: TextFormField(
                                controller: tareaController,
                                textCapitalization: TextCapitalization.sentences,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Registrar Tarea*',
                                  labelStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Registro de tarea...',
                                  hintStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0x49FFFFFF),
                                ),
                                style: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                maxLines: 2,
                                validator: (value) {
                                return capitalizadoCharacters.hasMatch(value ?? '')
                                    ? null
                                    : 'Para continuar, ingrese la tarea empezando por mayúscula';
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 5, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: FlutterFlowCheckboxGroup(
                                      initiallySelected:
                                          !jornadaProvider.activo,
                                      options: '¿Tarea Completada?',
                                      onChanged: (val) => setState(
                                          () {
                                            jornadaProvider.activo = val;
                                            }),
                                      activeColor: AppTheme.of(context)
                                          .primaryColor,
                                      checkColor: Colors.white,
                                      checkboxBorderColor: const Color(0xFF95A1AC),
                                      textStyle: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily:
                                                AppTheme.of(context)
                                                    .bodyText1Family,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FormField(builder: (state){
                              return Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppTheme.of(context)
                                            .primaryText,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1.5,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              child:
                                                  FlutterFlowExpandedImageView(
                                                image: image == null ? Image.network(
                                                  'https://picsum.photos/seed/836/600',
                                                  fit: BoxFit.contain,
                                                ) 
                                                :
                                                Image.file(
                                                  File(image!.path),
                                                  fit: BoxFit.contain,
                                                ),
                                                allowRotation: false,
                                                tag: 'imageTag2',
                                                useHeroAnimation: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: 'imageTag2',
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: image == null ?Image.network(
                                              'https://picsum.photos/seed/836/600',
                                              width: 170,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            )
                                            :
                                            Image.file(
                                              File(image!.path),
                                              width: 170,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
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
                                            jornadaProvider.imagen = image!.path;
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
                                              fontFamily:
                                                  AppTheme.of(context)
                                                      .subtitle2Family,
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
                                  ],
                                ),
                              );
                            },
                            validator: (val) {
                              if (jornadaProvider.imagen == null ||
                                  jornadaProvider.imagen.isEmpty) {
                                return 'Para continuar, cargue una imagen';
                              }
                              return null;
                            }),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 5, 10),
                              child: TextFormField(
                                controller: fechaRevisionText,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onTap: () async {
                                  await DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    onConfirm: (date) {
                                      setState(() {
                                        fechaRevision = date;
                                        fechaRevisionText.text = dateTimeFormat('yMMMd', date);
                                      });
                                    },
                                    currentTime: getCurrentTimestamp,
                                    // minTime: getCurrentTimestamp.subtract(const Duration(days: 7)),
                                  );
                                  
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Fecha de revisión*',
                                  labelStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Ingresa fecha de revisión...',
                                  hintStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0x49FFFFFF),
                                ),
                                keyboardType: TextInputType.none,
                                showCursor: false,
                                style: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Para continuar, ingrese la fecha de revisión';
                                  }
                
                                  return null;
                                }
                              ),
                            ),            
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                              child: TextFormField(
                                controller: comentariosController,
                                textCapitalization: TextCapitalization.sentences,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Comentarios',
                                  labelStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Ingresa comentarios...',
                                  hintStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0x49FFFFFF),
                                ),
                                style: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                maxLines: 3,
                              ),
                            ),
                            FormField(builder: (state) {
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                   5, 0, 5, 10),
                              child: DropDown(
                                options: listTipoProyecto,
                                onChanged: (val) => setState((){
                                  if (listTipoProyecto.isEmpty) {
                                    snackbarKey.currentState
                                    ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Debes descargar los catálogos desde la sección de tu perfil"),
                                    ));
                                  }
                                  else{
                                    listProyectos.clear();
                                    tipoProyecto = val!;
                                    dataBase.catalogoProyectoBox.getAll().forEach((element) {
                                      if (element.clasificacionEmp.target!.clasificacion == tipoProyecto) {
                                        listProyectos.add(element.nombre);
                                      }                                    
                                      });
                                      print("Entro a tipo proyecto");
                                    }
                                    print("Tipo Proyecto: $tipoProyecto");
                                    print("List proyectos: ${listProyectos.length}");

                                  }),
                                width: double.infinity,
                                height: 50,
                                textStyle: AppTheme.of(context).title3.override(
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
                                margin: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            );
                            }, 
                            validator: (val) {
                                if ( tipoProyecto == "" ||
                                    tipoProyecto.isEmpty) {
                                  return 'Para continuar, seleccione un tipo de proyecto.';
                                }
                                return null;
                              },
                            ),
                            FormField(builder: (state) {
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                   5, 0, 5, 10),
                              child: DropDown(
                                options: (tipoProyecto == "" || listProyectos.isEmpty) ? ["Sin proyectos"] : listProyectos,
                                onChanged: (val) => setState((){
                                  if (val == "Sin proyectos") {
                                    snackbarKey.currentState
                                    ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Debes seleccionar un tipo de proyecto para seleccionar un proyecto"),
                                    ));
                                  } else {
                                    proyecto = val!;
                                    print("Entro a proyectos");
                                  }
                                  print("Proyecto: $proyecto");

                                  }),
                                width: double.infinity,
                                height: 50,
                                textStyle: AppTheme.of(context).title3.override(
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
                                margin: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            );
                            }, 
                            validator: (val) {
                                if ( proyecto == "" ||
                                    proyecto.isEmpty) {
                                  return 'Para continuar, seleccione un proyecto.';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                              child: TextFormField(
                                textCapitalization: TextCapitalization.sentences,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                  jornadaProvider.descripcion = value;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Descripción*',
                                  labelStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Descripción...',
                                  hintStyle: AppTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0x49FFFFFF),
                                ),
                                style: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AppTheme.of(context)
                                          .primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                maxLines: 3,
                                validator: (value) {
                                  return capitalizadoCharacters.hasMatch(value ?? '')
                                      ? null
                                      : 'Para continuar, ingrese la descripción empezando por mayúscula';
                                  },
                              ),
                            ),
                            Padding(
                              padding:
                                const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                              child: Badge(
                                badgeContent: const Text("3", style: TextStyle(color: Colors.white)),
                                showBadge: true,
                                badgeColor: const Color(0xFFD20030),
                                position: BadgePosition.topEnd(),
                                elevation: 4,
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AgregarRegistroProyectoSreen(emprendimiento: widget.jornada.emprendimiento.target!,),
                                      ),
                                    );
                                  },
                                  text: 'Agregar Registro',
                                  options: FFButtonOptions(
                                    width: 150,
                                    height: 50,
                                    color: AppTheme.of(context).secondaryText,
                                    textStyle:
                                        AppTheme.of(context).subtitle2.override(
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
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (jornadaProvider
                                .validateForm(formKey)) {
                              print("Fecha revision ${jornadaProvider.fechaRevision}");
                              print("Tarea ${jornadaProvider.tarea}");
                              final idProyecto = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.nombre.equals(proyecto)).build().findFirst()?.id;
                              if (idProyecto != null) {
                                // jornadaProvider.addJornada3(widget.emprendimiento.id, idProyecto, widget.numJornada);
                                await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const JornadaCreada(),
                                ),
                              );
                              }
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title:
                                        const Text('Campos vacíos'),
                                    content: const Text(
                                        'Para continuar, debe llenar los campos solicitados e incluir una imagen del análisis financiero.'),
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
                                  fontFamily: AppTheme.of(context)
                                      .subtitle2Family,
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
    );
  }
}
