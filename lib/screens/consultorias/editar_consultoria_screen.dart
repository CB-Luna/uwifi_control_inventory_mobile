import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/providers/database_providers/consultoria_controller.dart';
import 'package:bizpro_app/screens/consultorias/consultoria_actualizada.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';

import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class EditarConsultoriaScreen extends StatefulWidget {
  final Consultorias consultoria;
  final String numConsultoria;

  const EditarConsultoriaScreen({
    Key? key,
    required this.consultoria,
    required this.numConsultoria,
  }) : super(key: key);

  @override
  State<EditarConsultoriaScreen> createState() =>
      _EditarConsultoriaScreenState();
}

class _EditarConsultoriaScreenState extends State<EditarConsultoriaScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String ambito = "";
  String areaCirculo = "";
  String emprendedor = "";
  List<String> listAmbitos = [];
  List<String> listAreaCirculo = [];

  @override
  void initState() {
    super.initState();
    ambito = widget.consultoria.ambitoConsultoria.target!.nombreAmbito;
    areaCirculo = widget.consultoria.areaCirculo.target!.nombreArea;
    listAmbitos = [];
    listAreaCirculo = [];
    dataBase.ambitoConsultoriaBox.getAll().forEach((element) {
      listAmbitos.add(element.nombreAmbito);
    });
    dataBase.areaCirculoBox.getAll().forEach((element) {
      listAreaCirculo.add(element.nombreArea);
    });
  }

  @override
  Widget build(BuildContext context) {
    final consultoriaProvider = Provider.of<ConsultoriaController>(context);
    String emprendedor = "";
    if (widget.consultoria.emprendimiento.target!.emprendedor.target != null) {
      emprendedor =
          "${widget.consultoria.emprendimiento.target!.emprendedor.target!.nombre} ${widget.consultoria.emprendimiento.target!.emprendedor.target!.apellidos}";
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
                          image: FileImage(File(widget
                              .consultoria.emprendimiento.target!.imagen)),
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
                                  widget.consultoria.emprendimiento.target!
                                      .nombre,
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
                                          "Consultoría ${widget.numConsultoria}",
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
                                          widget.consultoria.emprendimiento
                                              .target!.nombre,
                                          style: AppTheme.of(context).bodyText1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FormField(
                                builder: (state) {
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 5, 10),
                                    child: DropDown(
                                      initialOption: ambito,
                                      options: listAmbitos,
                                      onChanged: (val) => setState(() {
                                        if (listAmbitos.isEmpty) {
                                          snackbarKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                            content: Text(
                                                "Debes descargar los catálogos desde la sección de tu perfil"),
                                          ));
                                        } else {
                                          ambito = val!;
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
                                      margin:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 4, 12, 4),
                                      hidesUnderline: true,
                                    ),
                                  );
                                },
                                validator: (val) {
                                  if (ambito == "" || ambito.isEmpty) {
                                    return 'Para continuar, seleccione un ámbito.';
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
                                      initialOption: areaCirculo,
                                      options: listAreaCirculo,
                                      onChanged: (val) => setState(() {
                                        if (listAreaCirculo.isEmpty) {
                                          snackbarKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                            content: Text(
                                                "Debes descargar los catálogos desde la sección de tu perfil"),
                                          ));
                                        } else {
                                          areaCirculo = val!;
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
                                      margin:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 4, 12, 4),
                                      hidesUnderline: true,
                                    ),
                                  );
                                },
                                validator: (val) {
                                  if (areaCirculo == "" ||
                                      areaCirculo.isEmpty) {
                                    return 'Para continuar, seleccione un área del círculo.';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (consultoriaProvider.validateForm(formKey)) {
                                // comunidadProvider.add();
                                print(
                                    "Fecha revision ${consultoriaProvider.fechaRevision}");
                                print("Tarea ${consultoriaProvider.tarea}");
                                final idAmbito = dataBase.ambitoConsultoriaBox
                                    .query(AmbitoConsultoria_.nombreAmbito
                                        .equals(ambito))
                                    .build()
                                    .findFirst()
                                    ?.id;
                                final idAreaCirculo = dataBase.areaCirculoBox
                                    .query(AreaCirculo_.nombreArea
                                        .equals(areaCirculo))
                                    .build()
                                    .findFirst()
                                    ?.id;
                                if (ambito !=
                                        widget.consultoria.ambitoConsultoria
                                            .target!.nombreAmbito ||
                                    areaCirculo !=
                                        widget.consultoria.areaCirculo.target!
                                            .nombreArea) {
                                  consultoriaProvider.updateConsultoria(
                                    widget.consultoria.id,
                                    idAmbito!,
                                    idAreaCirculo!,
                                  );
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ConsultoriaActualizada(),
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
                                          'Para continuar, debe llenar los campos solicitados.'),
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
