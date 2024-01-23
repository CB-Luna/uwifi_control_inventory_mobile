import 'package:uwifi_control_inventory_mobile/screens/employees/widget/app_state.dart';
import 'package:uwifi_control_inventory_mobile/screens/employees/widget/background_widget.dart';
import 'package:uwifi_control_inventory_mobile/screens/employees/widget/calendar_model.dart';
import 'package:uwifi_control_inventory_mobile/screens/employees/widget/flutter_flow_util_local.dart';
import 'package:uwifi_control_inventory_mobile/screens/employees/widget/week_days_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_icon_button.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:uwifi_control_inventory_mobile/providers/control_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/usuario_controller.dart';

import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/main_screen_selector.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/get_image_widget.dart';
import 'package:uwifi_control_inventory_mobile/screens/employees/widget/custom_functions.dart' as functions;

class AgregarVehiculoScreen extends StatefulWidget {
  final bool typeForm;
  const AgregarVehiculoScreen({
    Key? key, 
    required this.typeForm,
  }) : super(key: key);

  @override
  _AgregarVehiculoScreenState createState() =>
      _AgregarVehiculoScreenState();
}

class _AgregarVehiculoScreenState extends State<AgregarVehiculoScreen> {
  XFile? image;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  late CalendarModel _model;
  Vehicle? vehicleAssigned;
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
    final usuarioProvider = Provider.of<UsuarioController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Stack(
              alignment: const AlignmentDirectional(0.0, -1.0),
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 235.0, 0.0, 0.0),
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
                                functions.multiply(FFAppState().hourHeight, 34),
                            typeForm: widget.typeForm,
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
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x11000000),
                        offset: Offset(0.0, 6.0),
                      )
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
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
                                                    const MainScreenSelector(),
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
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x39000000),
                                      offset: Offset(-4, 8),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: FlutterFlowTheme.of(context).white,
                                      size: 16,
                                    ),
                                    Text(
                                      'Back',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .bodyText1Family,
                                            color: FlutterFlowTheme.of(context).white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ],
                                ),
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
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SelectionArea(
                                  child: Text(
                                getJsonField(
                                  functions.dateInfo(DateTime.now()),
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
                              const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 30.0),
                          child: wrapWithModel(
                            model: _model.weekDaysModel,
                            updateCallback: () => setState(() {}),
                            child: WeekDaysWidget(
                              callback: () async {
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
                  child: Draggable(
                    feedbackOffset: const Offset(100,3),
                  data: vehicleAssigned,
                  onDraggableCanceled: (velocity, offset) {
                  },
                  feedback: Container(
                    height: 100,
                    width: 180,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: FlutterFlowTheme.of(context).alternate,
                          offset: const Offset(3, 3),
                        )
                      ],
                      gradient: purpleRadial,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: getImageContainer(
                              vehicleAssigned!.path,
                              height: 80,
                              width: 80,
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: 200,
                          color: FlutterFlowTheme.of(context).grayDark.withOpacity(0.5),
                        ),
                        Container(
                        height: 200,
                        width: 290,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: FlutterFlowTheme.of(context).alternate,
                              offset: const Offset(3, 3),
                            )
                          ],
                          gradient: purpleRadial,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: getImageContainer(
                                  vehicleAssigned!.path,
                                  height: 120,
                                  width: 200,
                                  ),
                              ),
                              Text(
                                "License Plates: ${vehicleAssigned!.licensePlates}", 
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).white,
                                  fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                ),
                      ],
                    ),
              ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
