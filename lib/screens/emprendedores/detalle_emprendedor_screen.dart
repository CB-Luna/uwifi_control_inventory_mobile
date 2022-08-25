import 'dart:io';
import 'package:bizpro_app/screens/emprendedores/editar_emprendedor.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:page_transition/page_transition.dart';

import 'package:bizpro_app/screens/widgets/bottom_sheet_eliminar_emprendedor_widget.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_expanded_image_view.dart';

class DetallesEmprendedorScreen extends StatefulWidget {
  final Emprendedores emprendedor;
  const DetallesEmprendedorScreen({
    Key? key, 
    required this.emprendedor,
  }) : super(key: key);


  @override
  DetallesEmprendedorScreenState createState() =>
      DetallesEmprendedorScreenState();
}

class DetallesEmprendedorScreenState extends State<DetallesEmprendedorScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final List<Emprendimientos> emprendimientos = [];
    if (widget.emprendedor.emprendimiento.target != null) {
      emprendimientos.add(widget.emprendedor.emprendimiento.target!);
    }
    // print(emprendimientos.length);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
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
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 230, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: const BoxDecoration(
                  color: Color(0x554672FF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 40, 8, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0x554672FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context)
                                      .secondaryText,
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
                                                  AppTheme.of(
                                                          context)
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
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 0, 0),
                                child: Text(
                                  widget.emprendedor.nombre,
                                  style: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily:
                                            AppTheme.of(context)
                                                .bodyText1Family,
                                        color: AppTheme.of(context)
                                            .primaryText,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: Container(
                                    width: 45,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
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
                                                    const BottomSheetEliminarEmprendedor(),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          Icon(
                                            Icons.delete_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditarEmprendedor(emprendedor: widget.emprendedor),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 45,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      borderRadius: BorderRadius.circular(10),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: FlutterFlowExpandedImageView(
                            image: Image.file(
                              File(widget.emprendedor.imagen),
                              fit: BoxFit.contain,
                            ),
                            allowRotation: false,
                            tag: widget.emprendedor.imagen,
                            useHeroAnimation: true,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: widget.emprendedor.imagen,
                      transitionOnUserGestures: true,
                      child: Container(
                        width: 200,
                        height: 200,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.file(
                          File(widget.emprendedor.imagen),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
                        child: Text(
                          widget.emprendedor.nombre,
                          style: AppTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: AppTheme.of(context)
                                    .bodyText1Family,
                                color: AppTheme.of(context)
                                    .primaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                        child: Text(
                          widget.emprendedor.apellidos,
                          style: AppTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: AppTheme.of(context)
                                    .bodyText1Family,
                                color: AppTheme.of(context)
                                    .primaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Container(
                    width: 150,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryText,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 5, 0),
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            Text(
                              'Emprendedor',
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: AppTheme.of(context)
                                        .bodyText1Family,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    widget.emprendedor.comunidad.target?.nombre ?? "SIN COMUNIDAD",
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily:
                              AppTheme.of(context).bodyText1Family,
                          color: AppTheme.of(context).primaryText,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 0, 0),
                      child: Text(
                        'CURP:',
                        style: AppTheme.of(context)
                            .bodyText1
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .bodyText1Family,
                              color:
                                  AppTheme.of(context).primaryText,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                      child: Text(
                        widget.emprendedor.curp,
                        style:
                            AppTheme.of(context).bodyText1.override(
                                  fontFamily: AppTheme.of(context)
                                      .bodyText1Family,
                                  color: AppTheme.of(context)
                                      .secondaryText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 0, 0),
                      child: Text(
                        'Teléfono:',
                        style: AppTheme.of(context)
                            .bodyText1
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .bodyText1Family,
                              color:
                                  AppTheme.of(context).primaryText,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                      child: Text(
                        widget.emprendedor.telefono ?? "TELÉFONO SIN REGISTRAR",
                        style:
                            AppTheme.of(context).bodyText1.override(
                                  fontFamily: AppTheme.of(context)
                                      .bodyText1Family,
                                  color: AppTheme.of(context)
                                      .secondaryText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 0, 0),
                      child: Text(
                        'Familia:',
                        style: AppTheme.of(context)
                            .bodyText1
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .bodyText1Family,
                              color:
                                  AppTheme.of(context).primaryText,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 0, 0),
                      child: Text(
                        widget.emprendedor.integrantesFamilia,
                        style:
                            AppTheme.of(context).bodyText1.override(
                                  fontFamily: AppTheme.of(context)
                                      .bodyText1Family,
                                  color: AppTheme.of(context)
                                      .secondaryText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 0, 0),
                      child: Text(
                        'Emprendimientos liderados por ${widget.emprendedor.nombre}',
                        style: AppTheme.of(context)
                            .bodyText1
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .bodyText1Family,
                              color:
                                  AppTheme.of(context).primaryText,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(
                              emprendimientos.length, (rowIndex) {
                            final emprendimientosEmprendedor =
                                emprendimientos[rowIndex];
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12, 0, 0, 0),
                              child: Container(
                                width: 160,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFAEAEAE),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.file(
                                      File(emprendimientosEmprendedor.imagen),
                                    ).image,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    // await Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         DetalleProyectoWidget(
                                    //       proyectoDocRef:
                                    //           rowProyectosRecord.reference,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        emprendimientosEmprendedor.nombre,
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily:
                                                  AppTheme.of(
                                                          context)
                                                      .bodyText1Family,
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
