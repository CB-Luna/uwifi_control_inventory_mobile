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
        body: SafeArea(
          child: GestureDetector(
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
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 30, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Notify Issues',
                            style:
                            FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyText1Family,
                                  color: FlutterFlowTheme.of(context).tertiaryColor,
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 20),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'From: ',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'employeecry@gmail.com',
                                enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).grayLight,
                                  width: 3,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).alternate,
                                  width: 3,
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                              suffixIcon: Icon(
                                  Icons.account_circle_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  size: 24,
                                ),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            'To: ',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 20),
                            child: TextFormField(
                              controller: TextEditingController(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: false,
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'Input the addressee(s)...',
                                enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).grayLight,
                                  width: 3,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).alternate,
                                  width: 3,
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                              suffixIcon: Icon(
                                  Icons.person_outline,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  size: 24,
                                ),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              textAlign: TextAlign.start,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'The addressee is required.';
                                }
                                return null;
                              }),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            'Subject: ',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 20, 0, 20),
                            child: TextFormField(
                              controller: TextEditingController(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: false,
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'Input the subject...',
                                enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).grayLight,
                                  width: 3,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).alternate,
                                  width: 3,
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                              suffixIcon: Icon(
                                  Icons.title_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  size: 24,
                                ),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              textAlign: TextAlign.start,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Subject is required.';
                                }
                                return null;
                              }),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 20),
                      child: TextFormField(
                        maxLines: 5,
                        controller: TextEditingController(),
                        autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        decoration: InputDecoration(
                          filled: false,
                          hintText: 'Body...',
                          enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayLight,
                            width: 3,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).alternate,
                            width: 3,
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 3,
                          ),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            width: 3,
                          ),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                        suffixIcon: Icon(
                            Icons.subject_outlined,
                            color: FlutterFlowTheme.of(context)
                                .primaryText,
                            size: 24,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                        textAlign: TextAlign.start,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Body is required.';
                          }
                          return null;
                        }),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 32, 16, 0),
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
      ),
    );
  }
}
