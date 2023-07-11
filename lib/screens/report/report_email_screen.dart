import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/checkin_form_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/checkout_form_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/revision/control_form_d_created.dart';
import 'package:taller_alex_app_asesor/screens/revision/control_form_r_created.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportEmailScreen extends StatefulWidget {
  final bool form;
  const ReportEmailScreen({Key? key, required this.form}) : super(key: key);

  @override
  State<ReportEmailScreen> createState() => _ReportEmailScreenState();
}

class _ReportEmailScreenState extends State<ReportEmailScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool contrasenaVisibility = false;


  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.form) {
        context.read<CheckOutFormController>().from.text = "${context.read<UsuarioController>().usuarioCurrent?.correo}";
        context.read<CheckOutFormController>().to.text = "admincv@rtacv.com";
        context.read<CheckOutFormController>().subject.text = "Check Out Form Issues in Vehicle: '${
          context.read<UsuarioController>().usuarioCurrent?.vehicle.target?.licensePlates}' with Employee '${
          context.read<UsuarioController>().usuarioCurrent?.name} ${context.read<UsuarioController>().usuarioCurrent?.lastName}'";
        context.read<CheckOutFormController>().body.text = context.read<CheckOutFormController>().issues.join(", ");
      } else {
        context.read<CheckInFormController>().from.text = "${context.read<UsuarioController>().usuarioCurrent?.correo}";
        context.read<CheckInFormController>().to.text = "admincv@rtacv.com";
        context.read<CheckInFormController>().subject.text = "Check In Form Issues in Vehicle: '${
          context.read<UsuarioController>().usuarioCurrent?.vehicle.target?.licensePlates}' with Employee '${
          context.read<UsuarioController>().usuarioCurrent?.name} ${context.read<UsuarioController>().usuarioCurrent?.lastName}'";
        context.read<CheckInFormController>().body.text = "Issues with ${context.read<CheckInFormController>().issues.join(", ")}.";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final checkOutFormProvider = Provider.of<CheckOutFormController>(context);
    final checkInFormProvider = Provider.of<CheckInFormController>(context);
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
                            width: 100,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'From: ',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: widget.form ? 
                              checkOutFormProvider.from
                              :
                              checkInFormProvider.from,
                              decoration: InputDecoration(
                                filled: false,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required.";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsetsDirectional.fromSTEB(
                    //           0, 20, 0, 20),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         width: 100,
                    //         padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //         child: Text(
                    //           'Password: ',
                    //           style: FlutterFlowTheme.of(context).bodyText1,
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: TextFormField(
                    //           maxLength: 50,
                    //           controller: widget.form ? 
                    //           checkOutFormProvider.password 
                    //           :
                    //           checkInFormProvider.password ,
                    //           obscureText: !contrasenaVisibility,
                    //           obscuringCharacter: '*',
                    //           autovalidateMode:
                    //               AutovalidateMode.onUserInteraction,
                    //           decoration: InputDecoration(
                    //             filled: false,
                    //             hintText: 'Input the password...',
                    //             enabledBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(
                    //               color:
                    //                   FlutterFlowTheme.of(context).grayLight,
                    //               width: 3,
                    //             ),
                    //           ),
                    //           focusedBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(
                    //               color:
                    //                   FlutterFlowTheme.of(context).alternate,
                    //               width: 3,
                    //             ),
                    //           ),
                    //           errorBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(
                    //               color: FlutterFlowTheme.of(context).primaryColor,
                    //               width: 3,
                    //             ),
                    //           ),
                    //           focusedErrorBorder: UnderlineInputBorder(
                    //             borderSide: BorderSide(
                    //               color: FlutterFlowTheme.of(context).primaryColor,
                    //               width: 3,
                    //             ),
                    //           ),
                    //           contentPadding:
                    //               const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                    //           suffixIcon: InkWell(
                    //               onTap: () => setState(
                    //                 () => contrasenaVisibility =
                    //                     !contrasenaVisibility,
                    //               ),
                    //               focusNode: FocusNode(skipTraversal: true),
                    //               child: Icon(
                    //                 contrasenaVisibility
                    //                     ? Icons.visibility_outlined
                    //                     : Icons.visibility_off_outlined,
                    //                 color: FlutterFlowTheme.of(context).primaryColor,
                    //                 size: 22,
                    //               ),
                    //             )
                    //           ),
                    //           style: FlutterFlowTheme.of(context).bodyText1,
                    //           validator: (value) {
                    //             if (value == null || value.isEmpty) {
                    //               return "Password is required.";
                    //             }
                    //             return null;
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Row(
                      children: [
                        Container(
                          width: 100,
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
                              controller: widget.form ? 
                              checkOutFormProvider.to
                              :
                              checkInFormProvider.to,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: false,
                              decoration: InputDecoration(
                                filled: false,
                                hintText: 'Input the recipient...',
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
                                  return 'The recipient is required.';
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
                          width: 100,
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
                              controller: widget.form ? 
                              checkOutFormProvider.subject
                              :
                              checkInFormProvider.subject,
                              maxLines: 2,
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
                        controller: widget.form ? 
                          checkOutFormProvider.body
                          :
                          checkInFormProvider.body,
                        maxLines: 5,
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
                            if (checkOutFormProvider.from.text.isNotEmpty &
                              // checkOutFormProvider.password.text.isNotEmpty &
                              checkOutFormProvider.to.text.isNotEmpty &
                              checkOutFormProvider.subject.text.isNotEmpty &
                              checkOutFormProvider.body.text.isNotEmpty) {
                                String? encodeQueryParameters(Map<String, String> params) {
                                  return params.entries
                                      .map((MapEntry<String, String> e) =>
                                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                      .join('&');
                                }
                                final Uri emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: checkOutFormProvider.to.text,
                                  query: encodeQueryParameters(<String, String>{
                                    'subject': checkOutFormProvider.subject.text,
                                    'body': checkOutFormProvider.body.text
                                  }),
                                );
                                if (await canLaunchUrl(emailLaunchUri)) {
                                  if (await launchUrl(emailLaunchUri)) {
                                    // ignore: use_build_context_synchronously
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                          const ControlFormRCreatedScreen(),
                                      ),
                                    );
                                  } else {
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Failed to send email, try again."),
                                    ));
                                  }
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Incorrect input data, please review your credentials and the recipient."),
                                  ));
                                }
                            }
                          } else {
                            if (checkInFormProvider.from.text.isNotEmpty &
                              // checkInFormProvider.password.text.isNotEmpty &
                              checkInFormProvider.to.text.isNotEmpty &
                              checkInFormProvider.subject.text.isNotEmpty &
                              checkInFormProvider.body.text.isNotEmpty) {
                                String? encodeQueryParameters(Map<String, String> params) {
                                  return params.entries
                                      .map((MapEntry<String, String> e) =>
                                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                      .join('&');
                                }
                                final Uri emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: checkInFormProvider.to.text,
                                  query: encodeQueryParameters(<String, String>{
                                    'subject': checkInFormProvider.subject.text,
                                    'body': checkInFormProvider.body.text
                                  }),
                                );
                                if (await canLaunchUrl(emailLaunchUri)) {
                                  if (await launchUrl(emailLaunchUri)) {
                                     // ignore: use_build_context_synchronously
                                     await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                            const ControlFormDCreatedScreen(),
                                        ),
                                      );
                                  } else {
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Failed to send email, try again."),
                                    ));
                                  }
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Incorrect input data, please review your credentials and the recipient."),
                                  ));
                                }
                            } 
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
