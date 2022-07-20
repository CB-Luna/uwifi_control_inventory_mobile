import 'package:bizpro_app/screens/emprendedor_screen.dart/agregar_emprendedor_screen.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/screens/widgets/flutter_expanded_image_view.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/flutter_icon_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class DetalleProyectoScreen extends StatefulWidget {
  const DetalleProyectoScreen({
    Key? key,
  }) : super(key: key);


  @override
  _DetalleProyectoScreenState createState() => _DetalleProyectoScreenState();
}

class _DetalleProyectoScreenState extends State<DetalleProyectoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color(0xFF28BFFA),
            automaticallyImplyLeading: false,
            leading: FlutterIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Proyecto",
              style: AppTheme.of(context).title2.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                child: InkWell(
                  onTap: () {
                    //TODO: agregar pantalla
                    // await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => EditarProyectoWidget(
                    //       editarProyecto:
                    //           detalleProyectoProyectosRecord.reference,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Icon(
                    Icons.mode_edit,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
            centerTitle: true,
            elevation: 2,
          ),
          backgroundColor: AppTheme.of(context).primaryBackground,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: FlutterExpandedImageView(
                                  image: Image.network(
                                    "https://www.amo-alebrijes.com/wp-content/uploads/2016/08/Tutoriales-tipos-de-alebrijes.jpg",
                                    fit: BoxFit.contain,
                                  ),
                                  allowRotation: false,
                                  tag: "https://www.amo-alebrijes.com/wp-content/uploads/2016/08/Tutoriales-tipos-de-alebrijes.jpg",
                                  useHeroAnimation: true,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: "https://www.amo-alebrijes.com/wp-content/uploads/2016/08/Tutoriales-tipos-de-alebrijes.jpg",
                            transitionOnUserGestures: true,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "https://www.amo-alebrijes.com/wp-content/uploads/2016/08/Tutoriales-tipos-de-alebrijes.jpg",
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                    child: Text(
                      'Nombre del proyecto',
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(23, 10, 0, 0),
                    child: Text(
                      "Nombre Proyecto",
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(23, 10, 0, 0),
                    child: Text(
                      'Descripción',
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(23, 10, 0, 0),
                    child: AutoSizeText(
                      "Descripcion Proyecto",
                      textAlign: TextAlign.start,
                      maxLines: 4,
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(23, 10, 0, 0),
                    child: Text(
                      'Emprendedor',
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(23, 10, 0, 0),
                    child: Text(
                      'Fecha de creación',
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(23, 10, 0, 0),
                    child: AutoSizeText(
                      DateTime.now().toString(),
                      textAlign: TextAlign.start,
                      maxLines: 4,
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () {
                            //TODO: agregar pantalla
                            // await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => JornadasWidget(
                            //       infoProyecto:
                            //           detalleProyectoProyectosRecord.reference,
                            //     ),
                            //   ),
                            // );
                          },
                          text: 'Jornadas',
                          options: FFButtonOptions(
                            width: 150,
                            height: 40,
                            color: Color(0xFF28BFFA),
                            textStyle:
                                AppTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AgregarEmprendedorScreen(),
                              ),
                            );
                          },
                          text: 'Emprendedor',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: AppTheme.of(context).primaryColor,
                            textStyle:
                                AppTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
