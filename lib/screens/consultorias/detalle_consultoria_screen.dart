import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:auto_size_text/auto_size_text.dart';

class DetalleConsultoriaScreen extends StatefulWidget {
  final Consultorias consultoria;
  final String numConsultoria;

  const DetalleConsultoriaScreen({
    Key? key, 
    required this.consultoria,
    required this.numConsultoria,
  }) : super(key: key);


  @override
  _DetalleConsultoriaScreenState createState() =>
      _DetalleConsultoriaScreenState();
}

class _DetalleConsultoriaScreenState extends State<DetalleConsultoriaScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Image.file(
                  File(widget.consultoria.emprendimiento.target!.imagen),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0x51000000),
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
                          AppTheme.of(context)
                              .secondaryBackground
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
                                      children:[
                                        const Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        Text(
                                          'Atrás',
                                          style: AppTheme.of(
                                                  context)
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
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 10),
                                child: Container(
                                  width: 45,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    borderRadius:
                                        BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(
                                        Icons.edit_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Consultoría No. ${widget.numConsultoria}',
                            maxLines: 1,
                            style: AppTheme.of(context)
                                .subtitle2
                                .override(
                                  fontFamily:
                                      AppTheme.of(context)
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
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: const Color(0x554672FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Text(
                                'Ámbito',
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily:
                                          AppTheme.of(context)
                                              .bodyText1Family,
                                      fontSize: 15,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: AutoSizeText(
                                widget.consultoria.ambitoConsultoria.target!.nombreAmbito,
                                textAlign: TextAlign.start,
                                maxLines: 4,
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily:
                                          AppTheme.of(context)
                                              .bodyText1Family,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Text(
                                'Área del círculo',
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily:
                                          AppTheme.of(context)
                                              .bodyText1Family,
                                      fontSize: 15,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Text(
                                widget.consultoria.areaCirculo.target!.nombreArea,
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily:
                                          AppTheme.of(context)
                                              .bodyText1Family,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Text(
                                'Avance',
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily:
                                          AppTheme.of(context)
                                              .bodyText1Family,
                                      fontSize: 15,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 5),
                              child: AutoSizeText(
                                'Avance',
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily:
                                          AppTheme.of(context)
                                              .bodyText1Family,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
                              child: Text(
                                'Siguiente visita',
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily:
                                          AppTheme.of(context)
                                              .bodyText1Family,
                                      fontSize: 15,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 5),
                              child: AutoSizeText(
                                DateTime.now().toString(),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily:
                                          AppTheme.of(context)
                                              .bodyText1Family,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
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
          ],
        ),
      ),
    );
  }
}
