import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/screens/revision/control_form_d_creted.dart';
import 'package:taller_alex_app_asesor/screens/revision/control_form_r_created.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

class ReportEmailScreen extends StatefulWidget {
  final bool form;
  const ReportEmailScreen({Key? key, required this.form}) : super(key: key);

  @override
  State<ReportEmailScreen> createState() => _ReportEmailScreenState();
}

class _ReportEmailScreenState extends State<ReportEmailScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).background,
            ),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
                  TextFormField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Para',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Asunto',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Cuerpo',
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (widget.form) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                ControlFormRCreatedScreen(),
                            ),
                          );
                        } else {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                ControlFormDCreatedScreen(),
                            ),
                          );
                        }
                      },
                      text: 'Send',
                      options: FFButtonOptions(
                        width: 200,
                        height: 50,
                        color: FlutterFlowTheme.of(context).alternate,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: FlutterFlowTheme.of(context).white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                        elevation: 3,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
