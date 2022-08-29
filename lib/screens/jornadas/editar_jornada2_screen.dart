import 'dart:io';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/screens/jornadas/jornada_actualizada.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
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


class EditarJornada2Screen extends StatefulWidget {
  final Jornadas jornada;
  
  const EditarJornada2Screen({
    Key? key, 
    required this.jornada, 
  }) : super(key: key);


  @override
  _EditarJornada2ScreenState createState() => _EditarJornada2ScreenState();
}

class _EditarJornada2ScreenState extends State<EditarJornada2Screen> {
  List<String> checkboxGroupValues = [];
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late DateTime fechaRegistro;
  late DateTime fechaRevision;
  late TextEditingController fechaRegistroText;
  late TextEditingController fechaRevisionText;
  late TextEditingController tareaController;
  late TextEditingController comentariosController;
  late bool activoController;
  late String newCirculoEmpresa;
  XFile? image;
  Jornadas? jornada1;

  @override
  void initState() {
    super.initState();
    jornada1 = null;
    newCirculoEmpresa = widget.jornada.tarea.target!.image.target?.imagenes ?? "NO FILE";
    fechaRevision = widget.jornada.fechaRevision;
    fechaRegistro = widget.jornada.fechaRegistro;
    fechaRevisionText = TextEditingController(text: dateTimeFormat('yMMMd', widget.jornada.fechaRevision));
    fechaRegistroText = TextEditingController(text: dateTimeFormat('yMMMd', widget.jornada.fechaRegistro));
    tareaController = TextEditingController(text: widget.jornada.tarea.target!.tarea);
    comentariosController = TextEditingController(text: widget.jornada.tarea.target!.observacion);
    activoController = widget.jornada.tarea.target!.activo;
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
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF4672FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                widget.jornada.emprendimiento.target!.nombre,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.of(context).subtitle2.override(
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
                                          !activoController,
                                      options: '¿Tarea Completada?',
                                      onChanged: (val) => setState(
                                          () {
                                            Emprendimientos emprendimiento = widget.jornada.emprendimiento.target!;
                                            List<Jornadas> listJornadas = emprendimiento.jornadas.toList();
                                            for (var i = 0; i < listJornadas.length; i++) {
                                              switch (listJornadas[i].numJornada) {
                                                case "1":
                                                  jornada1 = listJornadas[i];
                                                  break;
                                                default:
                                                  break;
                                              }
                                            }
                                            if (jornada1 != null) {
                                              if (jornada1!.tarea.target!.activo == false) {
                                                print(val);
                                                activoController = val;
                                                print(activoController);
                                              } else {
                                                snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "No puedes completar esta tarea si tienes tareas previas activas."),
                                                ));
                                              }
                                            }
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
                            FormField(builder: (state){
                              return Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
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
                                                image: newCirculoEmpresa == null ? Image.network(
                                                  'https://picsum.photos/seed/836/600',
                                                  fit: BoxFit.contain,
                                                ) 
                                                :
                                                Image.file(
                                                  File(newCirculoEmpresa),
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
                                            child: newCirculoEmpresa == null ?Image.network(
                                              'https://picsum.photos/seed/836/600',
                                              width: 170,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            )
                                            :
                                            Image.file(
                                              File(newCirculoEmpresa),
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
                                            newCirculoEmpresa = image!.path;
                                          });
                                      },
                                      text: 'Círculo Empresa',
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
                              if (newCirculoEmpresa == null ||
                                  newCirculoEmpresa.isEmpty) {
                                return 'Para continuar, cargue el circulo de la empresa';
                              }
                              return null;
                            }
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (jornadaProvider
                                .validateForm(formKey)) {
                              if (fechaRegistro != widget.jornada.fechaRegistro ||
                                  fechaRevision != widget.jornada.fechaRevision || 
                                  tareaController.text != widget.jornada.tarea.target!.tarea ||
                                  comentariosController.text != widget.jornada.tarea.target!.observacion ||
                                  activoController != widget.jornada.tarea.target!.activo ||
                                  newCirculoEmpresa != widget.jornada.tarea.target!.image.target!.imagenes
                                  ) {
                                  jornadaProvider.updateJornada2(
                                    widget.jornada.id, 
                                    fechaRegistro,
                                    fechaRevision,
                                    tareaController.text,
                                    comentariosController.text,
                                    newCirculoEmpresa,
                                    activoController,
                                    widget.jornada.tarea.target!.id
                                    );
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const JornadaActualizada(),
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
                                        'Para continuar, debe llenar los campos solicitados.'),
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
