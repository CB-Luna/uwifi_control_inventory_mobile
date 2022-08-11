import 'dart:io';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/providers/database_providers/consultoria_controller.dart';
import 'package:bizpro_app/screens/consultorias/consultoria_creada.dart';
import 'package:flutter/material.dart';

import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class AgregarConsultoriaScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;
  
  const AgregarConsultoriaScreen({
    Key? key, required this.emprendimiento,
  }) : super(key: key);


  @override
  _AgregarConsultoriaScreenState createState() =>
      _AgregarConsultoriaScreenState();
}

class _AgregarConsultoriaScreenState
    extends State<AgregarConsultoriaScreen> {
  TextEditingController fechaRegistro = TextEditingController();
  List<String> checkboxGroupValues = [];
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fechaRegistro = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final consultoriaaProvider = Provider.of<ConsultoriaController>(context);
    String emprendedor = "";
    String numConsultoria = "";
    if (widget.emprendimiento.emprendedor.target != null) {
      emprendedor =
          "${widget.emprendimiento.emprendedor.target!.nombre} ${widget.emprendimiento.emprendedor.target!.apellidos}";
    }
    if (widget.emprendimiento.consultorias.isEmpty) {
      numConsultoria = "1";
    }
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
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
            Positioned(
              left: 16,
              top: 45,
              right: 16,
              child: Row(
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
                ],
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
              top: 250,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            5, 0, 5, 10),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: numConsultoria == '' ? "SIN CONSULTORIA" : numConsultoria,
                          decoration: InputDecoration(
                            labelText: 'Número de consultoría',
                            labelStyle: AppTheme.of(context)
                                .title3
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: AppTheme.of(context)
                                      .secondaryText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            hintText: 'Ingresa número de consultoría...',
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
                            fillColor: Colors.white,
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            5, 0, 5, 10),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: emprendedor == '' ? "SIN EMPRENDEDOR" : emprendedor,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Emprendedor',
                            labelStyle: AppTheme.of(context)
                                .title3
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: AppTheme.of(context)
                                      .secondaryText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            hintText: 'Ingresa emprendedor...',
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
                            fillColor: Colors.white,
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
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Ámbito*',
                            labelStyle: AppTheme.of(context)
                                .title3
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: AppTheme.of(context)
                                      .secondaryText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            hintText: 'Ingresa ámbito..',
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
                            fillColor: Colors.white,
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
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Field is required';
                            }
                              
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Área del círculo*',
                            labelStyle: AppTheme.of(context)
                                .title3
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: AppTheme.of(context)
                                      .secondaryText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            hintText: 'area de circulo..',
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
                            fillColor: Colors.white,
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
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Field is required';
                            }
                              
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            5, 0, 5, 10),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: widget.emprendimiento.nombre,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Emprendimiento',
                            labelStyle: AppTheme.of(context)
                                .title3
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: AppTheme.of(context)
                                      .secondaryText,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            hintText: 'Ingresa emprendimiento...',
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
                            fillColor: Colors.white,
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            5, 0, 5, 10),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                          
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
                            fillColor: Colors.white,
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
                          readOnly: true,
                          initialValue: dateTimeFormat('yMMMd', DateTime.now()),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Fecha registro',
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
                            fillColor: Colors.white,
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
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                        
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConsultoriaCreada(),
                            ),
                          );
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
