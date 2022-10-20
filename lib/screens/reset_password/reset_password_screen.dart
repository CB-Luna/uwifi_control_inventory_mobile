import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:bizpro_app/services/auth_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:bizpro_app/theme/theme.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, this.email}) : super(key: key);

  final String? email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController emailAddressController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.email != null) {
      emailAddressController = TextEditingController(text: widget.email);
    } else {
      emailAddressController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B75F5),
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          title: Text(
            'Recuperar Contraseña',
            style: AppTheme.of(context).bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 18,
                ),
          ),
          leading: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(
                        15, 0, 0, 0),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 4,
        ),
        backgroundColor: const Color(0xFFEBEFF3),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/lottie_animations/forgot_password.json',
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                        animate: true,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: Text(
                          '¿Problemas para entrar?',
                          style: AppTheme.of(context).title1.override(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                          child: Text(
                            'Ingresa tu dirección de correo\nelectrónico. Te enviaremos un enlace\npara reestablecer tu contraseña.',
                            textAlign: TextAlign.center,
                            style: AppTheme.of(context).bodyText2.override(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x4D101213),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: emailAddressController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El correo es requerido';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Por favor ingresa un correo válido';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        labelStyle: AppTheme.of(context).bodyText2,
                        hintText: 'Ingresa tu correo electrónico...',
                        hintStyle: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: const Color(0xFF57636C),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x00000000),
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: AppTheme.of(context).secondaryBackground,
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(
                            24, 24, 20, 24),
                      ),
                      style: AppTheme.of(context).bodyText1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: CustomButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      final connectivityResult =
                        await (Connectivity().checkConnectivity());
                      if(connectivityResult == ConnectivityResult.none) {
                        snackbarKey.currentState
                          ?.showSnackBar(const SnackBar(
                        content: Text(
                            "Necesitas conexión a internet para validar el estado de la Inversión."),
                        ));
                      }
                      else {
                        final res = await AuthService.requestPasswordReset(
                          emailAddressController.text,
                        );
                        
                        if (res == false) return;

                        if (!mounted) return;
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PasswordEmailSentScreen(),
                          ),
                        );
                      }
                    },
                    text: 'Enviar enlace de acceso',
                    options: ButtonOptions(
                      width: 270,
                      height: 50,
                      color: const Color(0xFF2CC3F4),
                      textStyle: AppTheme.of(context).subtitle2.override(
                            fontFamily: 'Poppins',
                            color: AppTheme.of(context).secondaryBackground,
                          ),
                      elevation: 3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
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
