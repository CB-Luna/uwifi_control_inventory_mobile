import 'package:bizpro_app/screens/widgets/toggle_icon.dart';
import 'package:flutter/material.dart';

import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/app_state.dart';
import 'package:easy_debounce/easy_debounce.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController correoElectronicoController =
      TextEditingController(text: AppState().correoElectronico);
  TextEditingController contrasenaController = TextEditingController();
  bool contrasenaVisibility = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    correoElectronicoController =
        TextEditingController(text: AppState().correoElectronico);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFCAEFFE),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Image.asset(
                    'assets/images/emlogo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                  child: TextFormField(
                    controller: correoElectronicoController,
                    onChanged: (_) => EasyDebounce.debounce(
                      'correoElectronicoController',
                      const Duration(milliseconds: 2000),
                      () => setState(() {}),
                    ),
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      labelStyle: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Ingresa correo...',
                      hintStyle: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: const Color(0x52FFFFFF),
                    ),
                    style: AppTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: TextFormField(
                    controller: contrasenaController,
                    onChanged: (_) => EasyDebounce.debounce(
                      'contrasenaController',
                      const Duration(milliseconds: 2000),
                      () => setState(() {}),
                    ),
                    autofocus: true,
                    obscureText: !contrasenaVisibility,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Ingresa contraseña...',
                      hintStyle: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: const Color(0x52FFFFFF),
                      suffixIcon: InkWell(
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
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Container(
                    width: 140,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0x00EEEEEE),
                    ),
                    child: InkWell(
                      onTap: () async {
                        setState(() => AppState().recuerdameOn = false);
                        if (!(AppState().recuerdameOn)) {
                          setState(() {
                            correoElectronicoController.clear();
                            contrasenaController.clear();
                          });
                        }
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
                              setState(() => AppState().recuerdameOn =
                                  !AppState().recuerdameOn);
                            },
                            value: AppState().recuerdameOn,
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
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
    );
  }
}
