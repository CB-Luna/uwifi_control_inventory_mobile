import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/helpers/process_encryption.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/providers/user_provider.dart';
import 'package:taller_alex_app_asesor/screens/user_profile/password_not_updated_screen.dart';
import 'package:taller_alex_app_asesor/screens/user_profile/password_updated_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:provider/provider.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final Users usuario;

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController? contrasenaActualController;
  late bool contrasenaActualVisibility;
  TextEditingController? contrasenaNuevaController;
  late bool contrasenaNuevaVisibility;
  TextEditingController? contrasenaConfirmarController;
  late bool contrasenaConfirmarVisibility;

  @override
  void initState() {
    super.initState();
    contrasenaActualController = TextEditingController();
    contrasenaActualVisibility = false;
    contrasenaNuevaController = TextEditingController();
    contrasenaNuevaVisibility = false;
    contrasenaConfirmarController = TextEditingController();
    contrasenaConfirmarVisibility = false;
  }

  @override
  void dispose() {
    contrasenaActualController?.dispose();
    contrasenaNuevaController?.dispose();
    contrasenaConfirmarController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userStateProvider = Provider.of<UserState>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).white,
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8, 40, 8, 50),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).grayLighter,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryColor,
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
                                                  fontFamily:
                                                      FlutterFlowTheme.of(context)
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
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              25, 0, 0, 0),
                                      child: AutoSizeText(
                                        "Password of ${maybeHandleOverflow('${widget.usuario.name} ${widget.usuario.lastName}', 25, '...')}",
                                        maxLines: 2,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(context)
                                                  .bodyText1Family,
                                              color: FlutterFlowTheme.of(context)
                                                  .primaryText,
                                              fontSize: 15,
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 35, 0, 50),
                      child: Text(
                        'Update Password',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: FlutterFlowTheme.of(context).bodyText1Family,
                              fontSize: 20,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyText1Family),
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(35, 20, 35, 0),
                      child: TextFormField(
                        initialValue: widget.usuario.correo,
                        readOnly: true,
                        enabled: false,
                        textCapitalization: TextCapitalization.words,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).alternate,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: FlutterFlowTheme.of(context).white,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                35, 20, 35, 0),
                            child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: contrasenaActualController,
                                onChanged: (_) => EasyDebounce.debounce(
                                      'contrasenaActualController',
                                      const Duration(milliseconds: 2000),
                                      () => setState(() {}),
                                    ),
                                obscureText: !contrasenaActualVisibility,
                                decoration: InputDecoration(
                                  labelText: 'Actual Password',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(FlutterFlowTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  hintText: 'Actual password...',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(FlutterFlowTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).white,
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => contrasenaActualVisibility =
                                          !contrasenaActualVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      contrasenaActualVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).bodyText1Family,
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(FlutterFlowTheme.of(context)
                                              .bodyText1Family),
                                    ),
                                validator: (value) {
                                  if (value != null) {
                                    if (value == "") {
                                      return "Input your actual password.";
                                    }
                                  }
                                  return null;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                35, 20, 35, 0),
                            child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: contrasenaNuevaController,
                                onChanged: (_) => EasyDebounce.debounce(
                                      'contrasenaNuevaController',
                                      const Duration(milliseconds: 2000),
                                      () => setState(() {}),
                                    ),
                                obscureText: !contrasenaNuevaVisibility,
                                decoration: InputDecoration(
                                  labelText: 'New Password',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(FlutterFlowTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  hintText: 'New password...',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(FlutterFlowTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).white,
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => contrasenaNuevaVisibility =
                                          !contrasenaNuevaVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      contrasenaNuevaVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).bodyText1Family,
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(FlutterFlowTheme.of(context)
                                              .bodyText1Family),
                                    ),
                                validator: (value) {
                                  final RegExp regex = RegExp(
                                      r"^[A-Za-z\d!#\$%&/\(\)=?¡¿+\*\.\-_:,;]{6,50}$");
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required.';
                                  } else if (!regex.hasMatch(value)) {
                                    return "Password should be with a length of 6 characters. Valid special characters: !#\$%&/()=?¡¿+*.-_:,; Spaces and apostrophes-\naren't allowed.";
                                  }
                                  return null;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                35, 20, 35, 0),
                            child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: contrasenaConfirmarController,
                                onChanged: (_) => EasyDebounce.debounce(
                                      'contrasenaConfirmarController',
                                      const Duration(milliseconds: 2000),
                                      () => setState(() {}),
                                    ),
                                obscureText: !contrasenaConfirmarVisibility,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(FlutterFlowTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  hintText: 'Confirm password...',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            FlutterFlowTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(FlutterFlowTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).white,
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => contrasenaConfirmarVisibility =
                                          !contrasenaConfirmarVisibility,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      contrasenaConfirmarVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: FlutterFlowTheme.of(context).secondaryColor,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).bodyText1Family,
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(FlutterFlowTheme.of(context)
                                              .bodyText1Family),
                                    ),
                                validator: (value) {
                                  if (value != null) {
                                    if (value !=
                                        contrasenaNuevaController!.text) {
                                      return "The confirm password is not the same like the actual password.";
                                    }
                                  }
                                  return null;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 15, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (userStateProvider.validateForm(formKey)) {
                                  if (usuarioProvider.validatePassword(contrasenaActualController!.text)) {
                                    if (usuarioProvider.updatePassword(contrasenaActualController!.text, contrasenaNuevaController!.text)) {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PasswordUpdatedScreen(),
                                        ),
                                      );
                                    } else {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PasswordNotUpdatedScreen(),
                                        ),
                                      );
                                    }
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: const Text('Incorrect Password'),
                                          content: const Text(
                                              "The input password isn't the actual password, verify this data."),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: const Text('Okay'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return;
                                  }
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: const Text('Incorrect Fields'),
                                        content: const Text(
                                            "To continue, is required input all the fields."),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: const Text('Okay'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return;
                                }
                              },
                              text: 'Update Password',
                              icon: const Icon(
                                Icons.check_outlined,
                                size: 15,
                              ),
                              options: FFButtonOptions(
                                width: 200,
                                height: 50,
                                color: FlutterFlowTheme.of(context).secondaryColor,
                                textStyle:
                                    FlutterFlowTheme.of(context).subtitle2.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(FlutterFlowTheme.of(context)
                                                  .subtitle2Family),
                                        ),
                                elevation: 0,
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
                    )
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
