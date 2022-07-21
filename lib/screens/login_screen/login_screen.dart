import 'package:bizpro_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/screens.dart';
import 'package:bizpro_app/util/custom_functions.dart';
import 'package:bizpro_app/screens/widgets/toggle_icon.dart';
import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:bizpro_app/theme/theme.dart';

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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El correo es requerido';
                          }
                          return null;
                        },
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
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'La contraseña es requerida';
                          }
                          return null;
                        },
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
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          //TODO: revisar status de red y si es la primera vez
                          //TODO: hacer push a pantalla de loading
                          final loginResponse = await AuthService.login(
                            userState.emailController.text,
                            userState.passwordController.text,
                          );
                          if (loginResponse == null) return;

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

                          await userState.setToken(loginResponse.token);
                          final userId = loginResponse.user.id;

                          prefs.setString("userId", userId);

                          // userState.usuarioActivo =
                          //     UsuarioActivo.fromMap(userData);

                          //TODO: check user roles

                          //TODO: Conseguir password y rol en entero
                          //Modo OnLine
                          // if (usuarioProvider.validateUser(
                          //     userData['attributes']['email'] ??
                          //         'NONE')) {
                          //   print('Usuario ya existente');
                          //   usuarioProvider.getUserID(
                          //       userData['attributes']['email']);
                          // } else {
                          //   print('Usuario no existente');
                          //   usuarioProvider.add(
                          //       userData['attributes']['username'],
                          //       userData['attributes']['apellidoP'],
                          //       '',
                          //       DateTime.parse(userData['attributes']
                          //           ['nacimiento']),
                          //       userData['attributes']['telefono'],
                          //       userData['attributes']['celular'],
                          //       userData['attributes']['email'],
                          //       "CBLuna2022",
                          //       userData['attributes']?['imagen']
                          //                   ?['data']?['attributes']
                          //               ?['url'] ??
                          //           '',
                          //       userState.getRole(userData['attributes']
                          //                   ['role']['data']
                          //               ['attributes']['name']
                          //           .toString()));
                          //   // print(userState.getRole(userData['attributes']['role']['data']
                          //   //     ['attributes']['name'].toString()));
                          // }

                          // currentUserId = usuarioProvider.usuarios.last.id;

                          // print("USER: $userData");
                          // print("USERNAME: ${user['attributes']['username']}");
                          // print("APELLIDOP: ${user['attributes']['apellidoP']}");
                          // print("APELLIDOM: ${user['attributes']['apellidoM']}");
                          // print("NACIMIENTO: ${user['attributes']['nacimiento']}");
                          // print("TELEFONO: ${user['attributes']['telefono']}");
                          // print("CELULAR: ${user['attributes']['celular']}");
                          // print("CORREO: ${user['attributes']['email']}");
                          // print("IMAGEN: ${user['attributes']['imagen']['data']['attributes']['url']}");

                          if (!mounted) return;
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EmprendimientosScreen(),
                            ),
                          );
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
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPasswordScreen(),
                            ),
                          );
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
