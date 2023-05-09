import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_icon_button.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/modelsFormularios/data_draggable.dart';
import 'package:taller_alex_app_asesor/providers/control_form_provider.dart';
import 'package:taller_alex_app_asesor/screens/clientes/background_widget.dart';
import 'package:taller_alex_app_asesor/screens/clientes/calendar_model.dart';
import 'package:taller_alex_app_asesor/screens/clientes/week_days_widget.dart';

import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/control_daily_vehicle_screen.dart';
import 'custom_functions.dart' as functions;
import 'app_state.dart';
import 'flutter_flow_util_local.dart';

class AgregarVehiculoScreen extends StatefulWidget {
  AgregarVehiculoScreen({Key? key}) : super(key: key);

  @override
  _AgregarVehiculoScreenState createState() =>
      _AgregarVehiculoScreenState();
}

class _AgregarVehiculoScreenState extends State<AgregarVehiculoScreen> {
  XFile? image;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  late CalendarModel _model;
  double left = 0.0;
  double top = 0.0;

    @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarModel());
  }

  @override
  Widget build(BuildContext context) {
    final controlFormProvider = Provider.of<ControlFormProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Stack(
              alignment: AlignmentDirectional(0.0, -1.0),
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 235.0, 0.0, 0.0),
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        wrapWithModel(
                          model: _model.backgroundModel,
                          updateCallback: () => setState(() {}),
                          child: BackgroundWidget(
                            height:
                                functions.multiply(FFAppState().hourHeight, 23),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: 235.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x11000000),
                        offset: Offset(0.0, 6.0),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 35.0,
                              height: 35.0,
                              child: Stack(
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Are you sure you want to return main screen?'),
                                            content: const Text(
                                                'The recent input data will be deleted.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  controlFormProvider.cleanData();
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ControlDailyVehicleScreen(),
                                                    ),
                                                  );
                                                },
                                                child:
                                                    const Text('Continue'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child:
                                                    const Text('Cancel'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return;
                                    },
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 3.0, 0.0),
                                            child: Icon(
                                              Icons.chevron_left_rounded,
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                              size: 28.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30.0,
                              borderWidth: 1.0,
                              buttonSize: 40.0,
                              icon: Icon(
                                Icons.calendar_today,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 20.0,
                              ),
                              onPressed: () async {
                                FFAppState().update(() {
                                  FFAppState().selectedDay = getCurrentTimestamp;
                                });
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SelectionArea(
                                  child: Text(
                                getJsonField(
                                  functions.dateInfo(FFAppState().selectedDay!),
                                  r'''$.month''',
                                ).toString(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 32.0,
                                    ),
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 30.0),
                          child: wrapWithModel(
                            model: _model.weekDaysModel,
                            updateCallback: () => setState(() {}),
                            child: WeekDaysWidget(
                              callback: () async {
                                FFAppState().update(() {
                                  FFAppState().selectedDay =
                                      FFAppState().selectedDay;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CarouselSlider(
                    options: CarouselOptions(height: 200),
                    items: [1,2,3,4,5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Draggable(
                            data: DraggableData(
                              text: "text $i", 
                              color: Colors.blue,
                            ),
                            onDraggableCanceled: (velocity, offset) {
                              
                            },
                            feedback: Container(
                              height: 100,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                            ),
                            child: Container(
                              height: 200,
                              width: 290,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Text('text $i', style: TextStyle(fontSize: 16.0),
                                                          ),
                              ),
                          ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
