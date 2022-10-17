import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/providers/providers.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/helpers/process_encryption.dart';
import 'package:bizpro_app/providers/roles_emi_web_provider.dart';
import 'package:bizpro_app/providers/roles_pocketbase_provider.dart';
import 'package:bizpro_app/services/api_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bizpro_app/helpers/globals.dart';
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
    final rolesPocketbaseProvider = Provider.of<RolesPocketbaseProvider>(context);
    final rolesEmiWebProvider = Provider.of<RolesEmiWebProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFCAEFFE),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: const Color(0xFFD9EEF9),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/bglogin2.png',
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: Image.asset(
                          'assets/images/emlogo.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      //TITULO
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Container(
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0x00EEEEEE),
                          ),
                          child: Text(
                            'Inicia sesión',
                            style: AppTheme.of(context).title1.override(
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF221573),
                                ),
                          ),
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
                            } else if (!EmailValidator.validate(value)) {
                              return 'Por favor ingresa un correo válido';
                            }
                            return null;
                          },
                          decoration: getInputDecoration(
                            context: context,
                            labelText: 'Correo electrónico *',
                          ),
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: const Color(0xFF221573),
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
                            labelText: 'Contraseña *',
                            inkWell: InkWell(
                              onTap: () => setState(
                                () => contrasenaVisibility =
                                    !contrasenaVisibility,
                              ),
                              focusNode: FocusNode(skipTraversal: true),
                              child: Icon(
                                contrasenaVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: const Color(0xFF4672FF),
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

                      //BOTÓN INGRESAR
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: CustomButton(
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            // print("Encrypted: ${encryptAESCryptoJS(userState.passwordController.text, 'HuxR1bZVNumSBLEN')}");
                            //Se revisa el estatus de la Red
                            final connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult == ConnectivityResult.none) {
                              print("Proceso offline");
                              //Proceso Offline
                              if (usuarioProvider.validateUserOffline(
                                  userState.emailController.text,
                                  userState.passwordController.text)) {
                                print('Usuario ya existente');
                                //Se guarda el ID DEL USUARIO (correo electrónico)
                                prefs.setString(
                                    "userId", userState.emailController.text);
                                //Se guarda el Password encriptado
                                prefs.setString(
                                    "passEncrypted", userState.passwordController.text);
                                usuarioProvider
                                    .getUser(prefs.getString("userId")!);

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
                                print('Usuario no existente localmente');
                                snackbarKey.currentState
                                    ?.showSnackBar(const SnackBar(
                                  content: Text(
                                      "Credenciales incorrectas o no ha sido registrado al sistema"),
                                ));
                              }
                            } else {
                              print("Proceso online");
                              //Proceso online
                              //Login a Pocketbase
                              final loginResponsePocketbase = await AuthService.loginPocketbase(
                                userState.emailController.text,
                                userState.passwordController.text,
                              );
                              if (loginResponsePocketbase == null) {
                                //Login a Emi Web
                                final loginResponseEmiWeb = await AuthService.loginEmiWeb(
                                  userState.emailController.text,
                                  userState.passwordController.text,
                                );
                                if (loginResponseEmiWeb != null) {
                                  //Se descargan los roles desde Emi Web
                                  rolesEmiWebProvider.procesoCargando(true);
                                  rolesEmiWebProvider.procesoTerminado(false);
                                  rolesEmiWebProvider.procesoExitoso(false);
                                  Future<bool> booleanoEmiWeb = rolesEmiWebProvider.getRolesEmiWeb(
                                    userState.emailController.text,
                                    userState.passwordController.text);
                                  if (await booleanoEmiWeb) {
                                    //Se descargan los roles desde Pocketbase
                                    print("Se ha realizado con éxito el proceso de Roles Emi Web");
                                    rolesPocketbaseProvider.procesoCargando(true);
                                    rolesPocketbaseProvider.procesoTerminado(false);
                                    rolesPocketbaseProvider.procesoExitoso(false);
                                    Future<bool> booleanoPocketbase = rolesPocketbaseProvider.getRolesPocketbase();
                                    if (await booleanoPocketbase) {
                                      print("Se ha realizado con éxito el proceso de getRolesPocketbase");
                                      //Se postea el Usuario en Pocketbase
                                      if (await AuthService.postUsuarioPocketbase(
                                        loginResponseEmiWeb, 
                                        userState.emailController.text,
                                        userState.passwordController.text)
                                      ) {
                                        //Login a Pocketbase Nuevamente
                                        final loginResponsePocketbase = await AuthService.loginPocketbase(
                                          userState.emailController.text,
                                          userState.passwordController.text,
                                        );
                                        if (loginResponsePocketbase != null) {
                                          await userState.setTokenPocketbase(loginResponsePocketbase.token);
                                          final userId = loginResponsePocketbase.user.email;

                                          //Se guarda el ID DEL USUARIO (correo)
                                          prefs.setString("userId", userId);
                                          //Se guarda el Password encriptado
                                          prefs.setString(
                                              "passEncrypted", userState.passwordController.text);
                                          //User Query
                                          final emiUser = await ApiService.getEmiUserPocketbase(
                                              loginResponsePocketbase.user.id);

                                          final idDBR = await AuthService.userEMIByID(
                                              loginResponsePocketbase.user.id);

                                          print("Hola miro el IdDBR $idDBR");
                                          if (emiUser == null) {
                                            print("Si es null");
                                            return;
                                          }
                                          print("Hola miro el IdDBR post $idDBR");
                                          if (usuarioProvider.validateUser(userId)) {
                                            print('Usuario ya existente');
                                            usuarioProvider.getUser(userId);
                                            usuarioProvider.updatePasswordLocal(
                                                userState.passwordController.text);
                                          } else {
                                            // print('Usuario no existente');
                                            // if (dataBase.catalogoProyectoBox.isEmpty()) {
                                            //   await catalogoPocketbaseProvider.getRoles();
                                            // }
                                            usuarioProvider.add(
                                              emiUser.items![0].nombreUsuario,
                                              emiUser.items![0].apellidoP,
                                              emiUser.items![0].apellidoM,
                                              emiUser.items![0].telefono,
                                              emiUser.items![0].celular,
                                              loginResponsePocketbase.user.email,
                                              userState.passwordController.text,
                                              emiUser.items![0].avatar ?? "",
                                              idDBR,
                                              emiUser.items![0].idRolesFk ?? [],
                                              emiUser.items![0].idEmiWeb
                                            );
                                            usuarioProvider
                                                .getUser(loginResponsePocketbase.user.email);
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
                                        } else {
                                          snackbarKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                            content: Text(
                                                "Usuario ingresado inexistente."),
                                          ));
                                        }
                                      } else {
                                        snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                          content: Text(
                                              "Falló al recuperar Usuario."),
                                        ));
                                      }
                                    } else {
                                      snackbarKey.currentState
                                          ?.showSnackBar(const SnackBar(
                                        content: Text(
                                            "Falló al descargar roles de Pocketbase."),
                                      ));
                                    }
                                  } else{
                                    snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                      content: Text(
                                          "Falló al descargar roles de Emi Web."),
                                    ));
                                  }
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Correo electrónico y/o contraseña incorrectos."),
                                  ));
                                }
                              } else {
                                await userState.setTokenPocketbase(loginResponsePocketbase.token);
                                final userId = loginResponsePocketbase.user.email;

                                //Se guarda el ID DEL USUARIO (correo)
                                prefs.setString("userId", userId);
                                //Se guarda el Password encriptado
                                prefs.setString(
                                    "passEncrypted", userState.passwordController.text);

                                //User Query
                                final emiUser = await ApiService.getEmiUserPocketbase(
                                    loginResponsePocketbase.user.id);

                                final idDBR = await AuthService.userEMIByID(
                                    loginResponsePocketbase.user.id);

                                print("Hola miro el IdDBR $idDBR");
                                if (emiUser == null) {
                                  print("Si es null");
                                  return;
                                }
                                print("Hola miro el IdDBR post $idDBR");
                                if (usuarioProvider.validateUser(userId)) {
                                  print('Usuario ya existente');
                                  usuarioProvider.getUser(userId);
                                  usuarioProvider.updatePasswordLocal(
                                      userState.passwordController.text);
                                } else {
                                  // print('Usuario no existente');
                                  // if (dataBase.catalogoProyectoBox.isEmpty()) {
                                  //   await catalogoPocketbaseProvider.getRoles();
                                  // }
                                  usuarioProvider.add(
                                    emiUser.items![0].nombreUsuario,
                                    emiUser.items![0].apellidoP,
                                    emiUser.items![0].apellidoM,
                                    emiUser.items![0].telefono,
                                    emiUser.items![0].celular,
                                    loginResponsePocketbase.user.email,
                                    userState.passwordController.text,
                                    emiUser.items![0].avatar ?? "",
                                    idDBR,
                                    emiUser.items![0].idRolesFk ?? [],
                                    emiUser.items![0].idEmiWeb
                                  );
                                  usuarioProvider
                                      .getUser(loginResponsePocketbase.user.email);
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
                            }
                          },
                          text: 'Ingresar',
                          options: ButtonOptions(
                            width: 170,
                            height: 50,
                            color: const Color(0xFF4672FF),
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
                            borderRadius: BorderRadius.circular(12),
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
                                  'Recordarme',
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color: const Color(0xFF4672FF),
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
                                    color: Color(0xFF4672FF),
                                    size: 25,
                                  ),
                                  offIcon: const Icon(
                                    Icons.check_box_outline_blank,
                                    color: Color(0xFF4672FF),
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
                                builder: (context) =>
                                    const ResetPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF221573),
                                  fontSize: 15,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ),

                      Flexible(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 5, 0),
                                      child: FaIcon(
                                        FontAwesomeIcons.shieldHalved,
                                        color: Color(0xFF959595),
                                        size: 40,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 5, 0),
                                      child: Text(
                                        'Acceso\nseguro',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0xFF959595),
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
                                    color: Color(0xFF959595),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    "La seguridad es nuestra prioridad,\npara ello utilizamos los estándares\nmás altos.",
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0xFF959595),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}
