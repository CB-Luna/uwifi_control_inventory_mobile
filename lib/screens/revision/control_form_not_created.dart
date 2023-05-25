import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/control_daily_vehicle_screen.dart';

import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

class ControlFormNotCreatedScreen extends StatefulWidget {
  const ControlFormNotCreatedScreen({Key? key}) : super(key: key);

  @override
  State<ControlFormNotCreatedScreen> createState() => _ControlFormNotCreatedScreenState();
}

class _ControlFormNotCreatedScreenState extends State<ControlFormNotCreatedScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFDDEEF8),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Text(
                        '¡Receiving\nControl Form\nNot Created!',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 30,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(                                
                        'Failed to save the data of receiving control form.',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                      child: SizedBox(
                        child: Icon(
                          Icons.cancel_outlined,
                          color: FlutterFlowTheme.of(context).tertiaryColor,
                          size: 250,
                          )
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ControlDailyVehicleScreen(),
                            ),
                          );
                        },
                        text: 'Continue',
                        options: FFButtonOptions(
                          width: 200,
                          height: 45,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
