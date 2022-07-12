import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/util/custom_functions.dart';
import 'package:bizpro_app/screens/widgets/toggle_icon.dart';
import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool contrasenaVisibility = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final String login = """
    mutation(\$email: String!, \$password: String!) {
      login(input: {identifier: \$email, password: \$password}) {
        jwt
        user {
          id
          email
        }
      }
    }
  """;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFCAEFFE),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: const Color(0xFFD9EEF9),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                'assets/images/mesgbluegradient.jpeg',
              ).image,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //LOGO
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Image.asset(
                        'assets/images/emlogo.png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    //CORREO
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: TextFormField(
                        controller: userState.emailController,
                        decoration: getInputDecoration(
                          context: context,
                          labelText: 'Correo electrónico',
                        ),
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),

                    //CONTRASEÑA
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: TextFormField(
                        controller: userState.passwordController,
                        obscureText: !contrasenaVisibility,
                        decoration: getInputDecoration(
                          context: context,
                          labelText: 'Contraseña',
                          inkWell: InkWell(
                            onTap: () => setState(
                              () =>
                                  contrasenaVisibility = !contrasenaVisibility,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              contrasenaVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),

                    //BOTON
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: CustomButton(
                        onPressed: () async {
                          //TODO: hacer login, agregar pantalla emprendimientos
                          // final user = await signInWithEmail(
                          //   context,
                          //   correoElectronicoController.text,
                          //   contrasenaController.text,
                          // );
                          // if (user == null) {
                          //   return;
                          // }

                          // setState(() =>
                          //     FFAppState().contrasena = contrasenaController.text);
                          // setState(() => FFAppState().correoElectronico =
                          //     correoElectronicoController.text);
                          // await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => MisEmprendimientosWidget(),
                          //   ),
                          // );
                        },
                        text: 'Iniciar sesión',
                        options: ButtonOptions(
                          width: 170,
                          height: 50,
                          color: const Color(0xFF006AFF),
                          textStyle: AppTheme.of(context).subtitle2.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                          elevation: 0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),

                    //Recordar
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Container(
                        width: 146,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            userState.updateRecuerdame();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Recuérdame',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              ToggleIcon(
                                onPressed: () async {
                                  userState.updateRecuerdame();
                                },
                                value: userState.recuerdame,
                                onIcon: const Icon(
                                  Icons.check_box,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                offIcon: const Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Restablecer contraseña
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: InkWell(
                        onTap: () async {
                          //TODO: agregar ResetPassword screen
                          // await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ResetPasswordWidget(),
                          //   ),
                          // );
                        },
                        child: Text(
                          'Olvidé mi contraseña',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ),
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
