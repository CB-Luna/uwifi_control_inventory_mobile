import 'package:bizpro_app/services/api_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:bizpro_app/services/auth_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/util/custom_functions.dart';
import 'package:bizpro_app/screens/widgets/toggle_icon.dart';
import 'package:bizpro_app/screens/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool contrasenaVisibility = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
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
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //LOGO
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: Image.asset(
                      'assets/images/emlogo.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  //TITULO
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0x00EEEEEE),
                      ),
                      child: Text(
                        'Inicia sesión',
                        style: AppTheme.of(context).title1.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              // fontSize: 15,
                              // fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),

                  //CORREO
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: TextFormField(
                      controller: userState.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El correo es requerido';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Por favor ingresa un correo válido';
                        }
                        return null;
                      },
                      decoration: getInputDecoration(
                        context: context,
                        labelText: 'Correo electrónico',
                      ),
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: const Color(0xFF393838),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),

                  //CONTRASEÑA
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: userState.passwordController,
                      obscureText: !contrasenaVisibility,
                      obscuringCharacter: '*',
                      validator: (value) {
                        final RegExp regex = RegExp(
                            r"^(?=.*[A-Z])(?=.*\d)(?=.*\d)[A-Za-z\d!#\$%&/\(\)=?¡¿+\*\.-_:,;]{8,50}$");
                        if (value == null || value.isEmpty) {
                          return 'La contraseña es requerida';
                        } else if (!regex.hasMatch(value)) {
                          return 'La contraseña debe tener al menos 8 caracteres, una letra mayúscula y dos números.\nLos caracteres especiales válidos son: !#\$%&/()=?¡¿+*.-_:,; y no se permite el uso de\nespacios, tildes o acentos.';
                        }
                        return null;
                      },
                      decoration: getInputDecoration(
                        context: context,
                        labelText: 'Contraseña',
                        inkWell: InkWell(
                          onTap: () => setState(
                            () => contrasenaVisibility = !contrasenaVisibility,
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
                            color: const Color(0xFF393838),
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),

                  //BOTON
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: CustomButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        //TODO: revisar status de red y si es la primera vez
                        //TODO: hacer push a pantalla de loading
                        final connectivityResult =
                            await (Connectivity().checkConnectivity());
                        // if(esPrimeraVez) {} else {}
                        if (connectivityResult == ConnectivityResult.none) {
                          //offline
                          // loginOffline(email, contrasena);
                          if (usuarioProvider.validateUserOffline(
                              prefs.getString("userId") ?? "NONE",
                              userState.passwordController.text)) {
                            print('Usuario ya existente');
                            // usuarioProvider.getUser(
                            //     prefs.getString("userId")!);
                            if (userState.recuerdame == true) {
                              await userState.setEmail();
                              //TODO: quitar?
                              await userState.setPassword();
                            } else {
                              userState.emailController.text = '';
                              userState.passwordController.text = '';
                              await prefs.remove('email');
                              await prefs.remove('password');
                            }

                            if (!mounted) return;
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const EmprendimientosScreen(),
                              ),
                            );
                          } else {
                            print('Usuario no existente');
                            snackbarKey.currentState
                                ?.showSnackBar(const SnackBar(
                              content: Text(
                                  "Credenciales incorrectas o no ha sido registrado al sistema"),
                            ));

                            //TODO Verificar como es el rol
                            // print("Rol ${loginResponse.user.profile.idRolFk.toString()}");
                          }
                        } else {
                          //Proceso online

                          //Login
                          final loginResponse = await AuthService.login(
                            userState.emailController.text,
                            userState.passwordController.text,
                          );
                          if (loginResponse == null) return;
                          await userState.setToken(loginResponse.token);
                          final userId = loginResponse.user.email;

                          prefs.setString("userId", userId);

                          //User Query
                          final emiUser = await ApiService.getEmiUser(
                              loginResponse.user.id);

                          if (emiUser == null) return;

                          if (usuarioProvider.validateUser(userId)) {
                            print('Usuario ya existente');
                            usuarioProvider.getUser(userId);
                          } else {
                            print('Usuario no existente');
                            usuarioProvider.add(
                              emiUser.nombreUsuario,
                              emiUser.apellidoP,
                              emiUser.apellidoM ?? '',
                              emiUser.nacimiento,
                              emiUser.telefono ?? "",
                              emiUser.celular,
                              loginResponse.user.email,
                              userState.passwordController.text,
                              emiUser.avatar ?? "",
                              userState.getRole(emiUser
                                  .idRolFk), //TODO Verificar como es el rol
                            );
                            // print("Rol ${loginResponse.user.profile.idRolFk.toString()}");
                          }
                          if (userState.recuerdame == true) {
                            await userState.setEmail();
                            //TODO: quitar?
                            await userState.setPassword();
                          } else {
                            userState.emailController.text = '';
                            userState.passwordController.text = '';
                            await prefs.remove('email');
                            await prefs.remove('password');
                          }

                          if (!mounted) return;
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EmprendimientosScreen(),
                            ),
                          );
                        }
                      },
                      text: 'Ingresar',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
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
                              'Recordarme',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                              child: FaIcon(
                                FontAwesomeIcons.shieldHalved,
                                color: Color(0xFF4A4949),
                                size: 40,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 5, 0),
                              child: Text(
                                'Acceso\nseguro',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: const Color(0xFF4A4949),
                                      fontSize: 13,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 2,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4A4949),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            'La seguridad es nuestra prioridad, para\n ello utilizamos los estándares mas altos.',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF4A4949),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
