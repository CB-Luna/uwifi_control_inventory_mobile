import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    Key? key,
    required this.token,
  }) : super(key: key);

  final String token;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController contrasenaController = TextEditingController();
  bool contrasenaVisibility = false;
  TextEditingController correoElectronicoController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/emlogo.png',
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 30),
                    child: Text(
                      'Cambiar Contraseña',
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'correoElectrónico',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: const Color(0xFF006AFF),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: TextFormField(
                        controller: correoElectronicoController,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: 'Nueva Contraseña',
                          labelStyle: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                          hintText: 'Ingresa contraseña...',
                          hintStyle: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF006AFF),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF006AFF),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: TextFormField(
                      controller: contrasenaController,
                      autofocus: true,
                      obscureText: !contrasenaVisibility,
                      decoration: InputDecoration(
                        labelText: 'Confirmar Contraseña',
                        labelStyle: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Confirma la contraseña...',
                        hintStyle: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF006AFF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF006AFF),
                            width: 2,
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
                            color: const Color(0xFF006AFF),
                            size: 22,
                          ),
                        ),
                      ),
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: CustomButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        // final user = await signInWithEmail(
                        //   context,
                        //   correoElectronicoController.text,
                        //   contrasenaController.text,
                        // );
                        // if (user == null) {
                        //   return;
                        // }

                        // setState(() => FFAppState().contrasena =
                        //     contrasenaController.text);
                        // setState(() => FFAppState().correoElectronico =
                        //     correoElectronicoController.text);
                        // await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ElegirRolesWidget(),
                        //   ),
                        // );
                      },
                      text: 'Cambiar contraseña',
                      options: ButtonOptions(
                        width: 250,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
