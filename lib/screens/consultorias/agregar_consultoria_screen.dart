import 'dart:io';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/providers/database_providers/consultoria_controller.dart';
import 'package:bizpro_app/screens/consultorias/consultoria_creada.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';

import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class AgregarConsultoriaScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;
  final int numConsultoria;
  
  const AgregarConsultoriaScreen({
    Key? key, 
    required this.emprendimiento, 
    required this.numConsultoria,
  }) : super(key: key);


  @override
  AgregarConsultoriaScreenState createState() => AgregarConsultoriaScreenState();
}

class AgregarConsultoriaScreenState extends State<AgregarConsultoriaScreen> {
  TextEditingController fechaRevision = TextEditingController();
  List<String> checkboxGroupValues = [];
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String ambito = "";
  String areaCirculo= "";

  @override
  void initState() {
    super.initState();
    fechaRevision = TextEditingController();
    ambito = "";
    areaCirculo = "";
  }

  @override
  Widget build(BuildContext context) {
    final consultoriaProvider = Provider.of<ConsultoriaController>(context);
    String emprendedor = "";
    List<String> listAmbitos = [];
    dataBase.ambitoConsultoriaBox.getAll().forEach((element) {listAmbitos.add(element.nombreAmbito);});
    List<String> listAreaCirculo = [];
    dataBase.areaCirculoBox.getAll().forEach((element) {listAreaCirculo.add(element.nombreArea);});
    if (widget.emprendimiento.emprendedor.target != null) {
      emprendedor =
          "${widget.emprendimiento.emprendedor.target!.nombre} ${widget.emprendimiento.emprendedor.target!.apellidos}";
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
                                        "Consultoría ${widget.numConsultoria}",
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
                                        widget.emprendimiento.nombre,
                                        style: AppTheme.of(context)
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FormField(builder: (state) {
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                   5, 0, 5, 10),
                              child: DropDown(
                                options: listAmbitos,
                                onChanged: (val) => setState((){
                                  if (listAmbitos.isEmpty) {
                                    snackbarKey.currentState
                                    ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Debes descargar los catálogos desde la sección de tu perfil"),
                                    ));
                                  }
                                  else{
                                    ambito = val!;
                                  }
                                  }),
                                width: double.infinity,
                                height: 50,
                                textStyle: AppTheme.of(context).title3.override(
                                      fontFamily: 'Poppins',
                                      color: const Color(0xFF221573),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                hintText: 'Ámbito*',
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
                                if ( ambito == "" ||
                                    ambito.isEmpty) {
                                  return 'Para continuar, seleccione un ámbito.';
                                }
                                return null;
                              },
                            ),
                            FormField(builder: (state) {
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                   5, 0, 5, 10),
                              child: DropDown(
                                options: listAreaCirculo,
                                onChanged: (val) => setState((){
                                  if (listAreaCirculo.isEmpty) {
                                    snackbarKey.currentState
                                    ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Debes descargar los catálogos desde la sección de tu perfil"),
                                    ));
                                  }
                                  else{
                                    areaCirculo = val!;
                                  }
                                  }),
                                width: double.infinity,
                                height: 50,
                                textStyle: AppTheme.of(context).title3.override(
                                      fontFamily: 'Poppins',
                                      color: const Color(0xFF221573),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                hintText: 'Área del círculo*',
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
                                if ( areaCirculo == "" ||
                                    areaCirculo.isEmpty) {
                                  return 'Para continuar, seleccione un área del círculo.';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 5, 10),
                              child: TextFormField(
                                textCapitalization: TextCapitalization.sentences,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                  consultoriaProvider.tarea = value;
                                },
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
                                child: TextFormField(
                                  controller: fechaRevision,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onTap: () async {
                                    await DatePicker.showDatePicker(
                                      context,
                                      showTitleActions: true,
                                      onConfirm: (date) {
                                        setState(() {
                                          consultoriaProvider.fechaRevision = date;
                                          fechaRevision.text = dateTimeFormat('yMMMd', date);
                                        });
                                      },
                                      currentTime: getCurrentTimestamp,
                                      // minTime: getCurrentTimestamp,
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (consultoriaProvider
                                .validateForm(formKey)) {
                              // comunidadProvider.add();
                              // print("Fecha revision ${consultoriaProvider.fechaRevision}");
                              // print("Tarea ${consultoriaProvider.tarea}");
                              final idAmbito = dataBase.ambitoConsultoriaBox.query(AmbitoConsultoria_.nombreAmbito.equals(ambito)).build().findFirst()?.id;
                              final idAreaCirculo = dataBase.areaCirculoBox.query(AreaCirculo_.nombreArea.equals(areaCirculo)).build().findFirst()?.id;
                              if (idAmbito != null && idAreaCirculo != null) {
                                consultoriaProvider.add(widget.emprendimiento.id, widget.numConsultoria, idAmbito, idAreaCirculo);
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ConsultoriaCreada(),
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
