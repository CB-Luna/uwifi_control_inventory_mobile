import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_icon_button.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/vehiculo_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/control_daily_vehicle_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_model.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:taller_alex_app_asesor/util/util.dart';

import 'app_state.dart';

class AgregarVehiculoScreen extends StatefulWidget {
  AgregarVehiculoScreen({Key? key}) : super(key: key);

  @override
  _AgregarVehiculoScreenState createState() =>
      _AgregarVehiculoScreenState();
}

class _AgregarVehiculoScreenState extends State<AgregarVehiculoScreen> {
  XFile? image;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final vehiculoKey = GlobalKey<FormState>();
  final _unfocusNode = FocusNode();

    @override
  void initState() {
    super.initState();
    setState(() {
      dataBase.marcaBox.getAll().forEach((element) {
        context.read<VehiculoController>().listaMarcas.add(element.marca);
      });
      context.read<VehiculoController>().listaMarcas
        .sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    });
  }

  @override
  Widget build(BuildContext context) {
    final vehiculoProvider = Provider.of<VehiculoController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
      // child: Scaffold(
      //   key: scaffoldKey,
      //   backgroundColor: FlutterFlowTheme.of(context).white,
      //   body: GestureDetector(
      //     onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      //     child: Scaffold(
      //       key: scaffoldKey,
      //       backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      //       floatingActionButton: FloatingActionButton(
      //         onPressed: () async {
      //         },
      //         backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
      //         elevation: 8.0,
      //         child: Icon(
      //           Icons.add,
      //           color: FlutterFlowTheme.of(context).white,
      //           size: 24.0,
      //         ),
      //       ),
      //       body: Stack(
      //         alignment: AlignmentDirectional(0.0, -1.0),
      //         children: [
      //           Padding(
      //             padding: EdgeInsetsDirectional.fromSTEB(0.0, 235.0, 0.0, 0.0),
      //             child: SingleChildScrollView(
      //               controller: ScrollController(),
      //               child: Column(
      //                 mainAxisSize: MainAxisSize.max,
      //                 children: [
      //                   Stack(
      //                     children: [
      //                       wrapWithModel(
      //                         model: _model.backgroundModel,
      //                         updateCallback: () => setState(() {}),
      //                         child: BackgroundWidget(
      //                           height:
      //                               functions.multiply(FFAppState().hourHeight, 23),
      //                         ),
      //                       ),
      //                       if (dateTimeFormat('d/M/y', FFAppState().selectedDay) ==
      //                           dateTimeFormat('d/M/y', getCurrentTimestamp))
      //                         Container(
      //                           width: MediaQuery.of(context).size.width * 1.0,
      //                           decoration: BoxDecoration(),
      //                           child: wrapWithModel(
      //                             model: _model.nowLineModel,
      //                             updateCallback: () => setState(() {}),
      //                             child: NowLineWidget(
      //                               height: functions
      //                                   .nowHeight(FFAppState().hourHeight),
      //                             ),
      //                           ),
      //                         ),
      //                       Padding(
      //                         padding: EdgeInsetsDirectional.fromSTEB(
      //                             0.0, 15.0, 0.0, 0.0),
      //                         child: wrapWithModel(
      //                           model: _model.eventsModel,
      //                           updateCallback: () => setState(() {}),
      //                           child: EventsWidget(
      //                             height: functions.multiply(
      //                                 FFAppState().hourHeight, 24),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           Container(
      //             width: MediaQuery.of(context).size.width * 1.0,
      //             height: 235.0,
      //             decoration: BoxDecoration(
      //               color: FlutterFlowTheme.of(context).secondaryBackground,
      //               boxShadow: [
      //                 BoxShadow(
      //                   blurRadius: 4.0,
      //                   color: Color(0x11000000),
      //                   offset: Offset(0.0, 6.0),
      //                 )
      //               ],
      //               borderRadius: BorderRadius.only(
      //                 bottomLeft: Radius.circular(20.0),
      //                 bottomRight: Radius.circular(20.0),
      //                 topLeft: Radius.circular(0.0),
      //                 topRight: Radius.circular(0.0),
      //               ),
      //             ),
      //             child: Padding(
      //               padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      //               child: Column(
      //                 mainAxisSize: MainAxisSize.max,
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [
      //                   Row(
      //                     mainAxisSize: MainAxisSize.max,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Container(
      //                         width: 35.0,
      //                         height: 35.0,
      //                         child: Stack(
      //                           children: [
      //                             InkWell(
      //                               splashColor: Colors.transparent,
      //                               focusColor: Colors.transparent,
      //                               hoverColor: Colors.transparent,
      //                               highlightColor: Colors.transparent,
      //                               onTap: () async {
      //                               },
      //                               child: Container(
      //                                 width: 100.0,
      //                                 height: 100.0,
      //                                 decoration: BoxDecoration(
      //                                   color: FlutterFlowTheme.of(context).accent1,
      //                                   shape: BoxShape.circle,
      //                                 ),
      //                                 child: Column(
      //                                   mainAxisSize: MainAxisSize.max,
      //                                   mainAxisAlignment: MainAxisAlignment.center,
      //                                   children: [
      //                                     Padding(
      //                                       padding: EdgeInsetsDirectional.fromSTEB(
      //                                           0.0, 0.0, 3.0, 0.0),
      //                                       child: Icon(
      //                                         Icons.chevron_left_rounded,
      //                                         color: FlutterFlowTheme.of(context)
      //                                             .primaryBackground,
      //                                         size: 28.0,
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       FlutterFlowIconButton(
      //                         borderColor: Colors.transparent,
      //                         borderRadius: 30.0,
      //                         borderWidth: 1.0,
      //                         buttonSize: 40.0,
      //                         icon: Icon(
      //                           Icons.calendar_today,
      //                           color: FlutterFlowTheme.of(context).secondaryText,
      //                           size: 20.0,
      //                         ),
      //                         onPressed: () async {
      //                         },
      //                       ),
      //                     ],
      //                   ),
      //                   Padding(
      //                     padding:
      //                         EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
      //                     child: Row(
      //                       mainAxisSize: MainAxisSize.max,
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         SelectionArea(
      //                             child: Text(
      //                           getJsonField(
      //                             functions.dateInfo(FFAppState().selectedDay!),
      //                             r'''$.month''',
      //                           ).toString(),
      //                           style: FlutterFlowTheme.of(context)
      //                               .bodyMedium
      //                               .override(
      //                                 fontFamily: 'Inter',
      //                                 color: FlutterFlowTheme.of(context)
      //                                     .secondaryText,
      //                                 fontSize: 32.0,
      //                               ),
      //                         )),
      //                       ],
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding:
      //                         EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 30.0),
      //                     child: wrapWithModel(
      //                       model: _model.weekDaysModel,
      //                       updateCallback: () => setState(() {}),
      //                       child: WeekDaysWidget(
      //                         callback: () async {
      //                           FFAppState().update(() {
      //                             FFAppState().selectedDay =
      //                                 FFAppState().selectedDay;
      //                           });
      //                         },
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           Align(
      //             alignment: AlignmentDirectional(-0.85, 0.95),
      //             child: ClipRRect(
      //               child: BackdropFilter(
      //                 filter: ImageFilter.blur(
      //                   sigmaX: 4.0,
      //                   sigmaY: 4.0,
      //                 ),
      //                 child: Container(
      //                   width: 100.0,
      //                   height: 60.0,
      //                   decoration: BoxDecoration(
      //                     color: FlutterFlowTheme.of(context).overlayWhite,
      //                     borderRadius: BorderRadius.circular(30.0),
      //                   ),
      //                   child: Row(
      //                     mainAxisSize: MainAxisSize.max,
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       FlutterFlowIconButton(
      //                         borderColor: Colors.transparent,
      //                         borderRadius: 30.0,
      //                         borderWidth: 1.0,
      //                         buttonSize: 50.0,
      //                         icon: FaIcon(
      //                           FontAwesomeIcons.minus,
      //                           color: FlutterFlowTheme.of(context).primaryText,
      //                           size: 10.0,
      //                         ),
      //                         onPressed: () async {
      //                         },
      //                       ),
      //                       FlutterFlowIconButton(
      //                         borderColor: Colors.transparent,
      //                         borderRadius: 30.0,
      //                         borderWidth: 1.0,
      //                         buttonSize: 50.0,
      //                         icon: Icon(
      //                           Icons.add,
      //                           color: FlutterFlowTheme.of(context).primaryText,
      //                           size: 15.0,
      //                         ),
      //                         onPressed: () async {
      //                         },
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
        // ),
      ),
    );
  }
}
