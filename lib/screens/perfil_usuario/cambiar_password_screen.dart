import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/helpers/process_encryption.dart';
import 'package:taller_alex_app_asesor/providers/user_provider.dart';
import 'package:taller_alex_app_asesor/screens/perfil_usuario/password_actualizado_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/theme/theme.dart';
import 'package:provider/provider.dart';

class CambiarPasswordScreen extends StatefulWidget {
  const CambiarPasswordScreen({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  final Usuarios usuario;

  @override
  State<CambiarPasswordScreen> createState() => _CambiarPasswordScreenState();
}

class _CambiarPasswordScreenState extends State<CambiarPasswordScreen> {
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/bglogin2.png',
                      ).image,
                    ),
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
                          color: const Color(0x554672FF),
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
                                      color: AppTheme.of(context).secondaryText,
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
                                          const Icon(
                                            Icons.arrow_back_ios_rounded,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          Text(
                                            'Atrás',
                                            style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      AppTheme.of(context)
                                                          .bodyText1Family,
                                                  color: Colors.white,
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
                                        "Perfil de ${maybeHandleOverflow('${widget.usuario.nombre} ${widget.usuario.apellidoP}', 25, '...')}",
                                        maxLines: 2,
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              color: AppTheme.of(context)
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
                        'Cambiar Contraseña',
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: AppTheme.of(context).bodyText1Family,
                              fontSize: 20,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  AppTheme.of(context).bodyText1Family),
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
                          labelText: "Correo electrónico",
                          labelStyle: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: const Color(0xFF221573),
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF221573),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF221573),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: AppTheme.of(context).bodyText1,
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
                                  labelText: 'Contraseña Actual',
                                  labelStyle: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: AppTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            AppTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(AppTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  hintText: 'Contraseña actual...',
                                  hintStyle: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: AppTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            AppTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(AppTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryText,
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
                                  fillColor: Colors.white,
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
                                      color: const Color(0xFF006AFF),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(AppTheme.of(context)
                                              .bodyText1Family),
                                    ),
                                validator: (value) {
                                  if (value != null) {
                                    if (value == "") {
                                      return "Ingrese la contraseña actual, por favor.";
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
                                  labelText: 'Contraseña Nueva',
                                  labelStyle: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: AppTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            AppTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(AppTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  hintText: 'Contraseña Nueva...',
                                  hintStyle: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: AppTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            AppTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(AppTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryText,
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
                                  fillColor: Colors.white,
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
                                      color: const Color(0xFF006AFF),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(AppTheme.of(context)
                                              .bodyText1Family),
                                    ),
                                validator: (value) {
                                  final RegExp regex = RegExp(
                                      r"^(?=.*[A-Z])(?=.*\d)(?=.*\d)[A-Za-z\d!#\$%&/\(\)=?¡¿+\*\.\-_:,;]{8,50}$");
                                  if (value == null || value.isEmpty) {
                                    return 'La contraseña es requerida';
                                  } else if (!regex.hasMatch(value)) {
                                    return 'La contraseña debe tener al menos 8 caracteres, una letra \nmayúscula y dos números. Los caracteres especiales válidos \nson: !#\$%&/()=?¡¿+*.-_:,; y no se permite el uso de\nespacios, tildes o acentos.';
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
                                  labelText: 'Confirmar Contraseña',
                                  labelStyle: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: AppTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            AppTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(AppTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  hintText: 'Confirma Contraseña...',
                                  hintStyle: AppTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: AppTheme.of(context)
                                            .bodyText1Family,
                                        color:
                                            AppTheme.of(context).secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(AppTheme.of(context)
                                                .bodyText1Family),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryText,
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
                                  fillColor: Colors.white,
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
                                      color: const Color(0xFF006AFF),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(AppTheme.of(context)
                                              .bodyText1Family),
                                    ),
                                validator: (value) {
                                  if (value != null) {
                                    if (value !=
                                        contrasenaNuevaController!.text) {
                                      return "La confirmación no coincide con la contraseña nueva.";
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
                                  final actualPasswordEncrypted =
                                      processEncryption(
                                          contrasenaActualController!.text);
                                  if (actualPasswordEncrypted == null) {
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Falló al encriptar la Contraseña Actual."),
                                    ));
                                    return;
                                  }
                                  final newPasswordEncrypted =
                                      processEncryption(
                                          contrasenaNuevaController!.text);
                                  if (newPasswordEncrypted == null) {
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Falló al encriptar la Contraseña Nueva."),
                                    ));
                                    return;
                                  }
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PasswordActualizadoScreen(),
                                      ),
                                    );
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: const Text('Campos incorrectos'),
                                        content: const Text(
                                            'Para continuar, debe llenar los campos solicitados correctamente.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: const Text('Bien'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return;
                                }
                              },
                              text: 'Cambiar contraseña',
                              icon: const Icon(
                                Icons.check_outlined,
                                size: 15,
                              ),
                              options: FFButtonOptions(
                                width: 200,
                                height: 50,
                                color: AppTheme.of(context).secondaryText,
                                textStyle:
                                    AppTheme.of(context).subtitle2.override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(AppTheme.of(context)
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
