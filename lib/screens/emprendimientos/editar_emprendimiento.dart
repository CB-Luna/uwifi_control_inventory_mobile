import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/database/entitys.dart';

import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class EditarProyectoWidget extends StatefulWidget {

  final Emprendimientos emprendimiento;

  const EditarProyectoWidget({
    Key? key,
    required this.emprendimiento,
  }) : super(key: key);

  @override
  _EditarProyectoWidgetState createState() => _EditarProyectoWidgetState();
}

class _EditarProyectoWidgetState extends State<EditarProyectoWidget> {
  String uploadedFileUrl = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final emprendimientoProvider =
        Provider.of<EmprendimientoController>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color(0xFF008DD4),
            automaticallyImplyLeading: true,
            leading: InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            title: Text(
              'Emprendimiento',
              style: AppTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 22,
                  ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 4,
          ),
          backgroundColor: AppTheme.of(context).primaryBackground,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Actualizar Emprendimiento',
                            style:
                                AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: InkWell(
                            onTap: ()  {

                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                    'assets/images/animation_500_l3ur8tqa.gif',
                                  ).image,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFF2CC3F4),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(8),
                                  //   child: Image.network(
                                  //     editarProyectoProyectosRecord.imagen,
                                  //     width: MediaQuery.of(context).size.width *
                                  //         0.9,
                                  //     height: 180,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                            child: TextFormField(
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Nombre de emprendimiento',
                                labelStyle: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                hintText: 'Ingresa el nombre...',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9EEF9),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFDBE2E7),
                                  offset: Offset(0, 0),
                                )
                              ],
                              border: Border.all(
                                color: Color(0x0025232E),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                            child: TextFormField(
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Descripción de emprendimiento',
                                labelStyle: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                hintText: 'Descripción del emprendimiento...',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF060606),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF060606),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF060606),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              maxLines: 5,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                            child: TextFormField(
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Comunidad',
                                labelStyle: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                hintText: 'Ingresa comunidad...',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                            child: null,
                          ),
                          // Padding(
                          //   padding:
                          //       EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          //   child: StreamBuilder<List<EmprendedoresRecord>>(
                          //     stream: queryEmprendedoresRecord(),
                          //     builder: (context, snapshot) {
                          //       // Customize what your widget looks like when it's loading.
                          //       if (!snapshot.hasData) {
                          //         return Center(
                          //           child: SizedBox(
                          //             width: 50,
                          //             height: 50,
                          //             child: SpinKitRipple(
                          //               color: AppTheme.of(context)
                          //                   .primaryColor,
                          //               size: 50,
                          //             ),
                          //           ),
                          //         );
                          //       }
                          //       List<EmprendedoresRecord>
                          //           dropDownEmprendedoresRecordList =
                          //           snapshot.data;
                          //       return FlutterFlowDropDown(
                          //         options: dropDownEmprendedoresRecordList
                          //             .map((e) => e.nombre)
                          //             .toList()
                          //             .toList(),
                          //         onChanged: (val) =>
                          //             setState(() => dropDownValue2 = val),
                          //         width: MediaQuery.of(context).size.width,
                          //         height: 55,
                          //         textStyle: AppTheme.of(context)
                          //             .bodyText1
                          //             .override(
                          //               fontFamily: 'Poppins',
                          //               color: Colors.black,
                          //               fontSize: 15,
                          //               fontWeight: FontWeight.normal,
                          //             ),
                          //         hintText: 'Emprendedor...',
                          //         fillColor: Colors.white,
                          //         elevation: 2,
                          //         borderColor: Colors.transparent,
                          //         borderWidth: 0,
                          //         borderRadius: 8,
                          //         margin: EdgeInsetsDirectional.fromSTEB(
                          //             12, 4, 12, 4),
                          //         hidesUnderline: true,
                          //       );
                          //     },
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FFButtonWidget(
                                  onPressed: ()  {

                                  },
                                  text: 'Actualizar Emprendimiento',
                                  options: FFButtonOptions(
                                    width: 290,
                                    height: 50,
                                    color: Color(0xFF2CC3F4),
                                    textStyle: AppTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                    elevation: 3,
                                    borderSide: BorderSide(
                                      color: Color(0xFF2CC3F4),
                                      width: 0,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async  {
                                    usuarioProvider.removeEmprendimiento(widget.emprendimiento);
                                     await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const EmprendimientosScreen(),
                                      ),
                                    );
                                  },
                                  text: 'Eliminar Emprendimiento',
                                  options: FFButtonOptions(
                                    width: 290,
                                    height: 50,
                                    color: Color.fromARGB(242, 213, 35, 35),
                                    textStyle: AppTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                    elevation: 3,
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(242, 213, 35, 35),
                                      width: 0,
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
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
