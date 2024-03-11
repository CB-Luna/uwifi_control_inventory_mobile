import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:uwifi_control_inventory_mobile/screens/screens.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_button_option.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:uwifi_control_inventory_mobile/screens/main/main_screen_selector.dart';
import 'package:uwifi_control_inventory_mobile/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool contrasenaVisibility = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final rolesSupabaseProvider = Provider.of<RolesSupabaseProvider>(context);
    final networkState = Provider.of<NetworkState>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: AppTheme.of(context).tertiaryColor,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.asset(
                'assets/images/bgFleet@2x.png',
              ).image,
            ),
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 50),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/uwifi.png',
                            width: 220,
                            height: 220,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Control Inventory',
                        style: AppTheme.of(context).title1.override(
                              fontFamily: 'Outfit',
                              color: AppTheme.of(context).white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold
                            ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 24),
                            child: Text(
                              'Daily Operation',
                              style: AppTheme.of(context).title3.override(
                                    fontFamily: 'Outfit',
                                    color: AppTheme.of(context).white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: userState.emailController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: AppTheme.of(context).bodyText1,
                                hintText: 'Input your email...',
                                hintStyle: AppTheme.of(context).bodyText1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:BorderSide(
                                    color: AppTheme.of(context).white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:BorderSide(
                                    color: AppTheme.of(context).white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: AppTheme.of(context).white,
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                                errorStyle: TextStyle(
                                  color: AppTheme.of(context).white,
                                ),
                              ),
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Outfit',
                                    color:
                                        AppTheme.of(context).tertiaryColor,
                                  ),
                              validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              } else if (!EmailValidator.validate(value)) {
                                return 'Please input a valid email';
                              }
                              return null;
                            },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              maxLength: 50,
                              controller: userState.passwordController,
                              obscureText: !contrasenaVisibility,
                              obscuringCharacter: '*',
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: AppTheme.of(context).bodyText1,
                                hintText: 'Input your password...',
                                hintStyle: AppTheme.of(context).bodyText1,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppTheme.of(context).white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: AppTheme.of(context).white,
                                errorStyle: TextStyle(
                                  color: AppTheme.of(context).white,
                                ),
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(16, 24, 24, 24),
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => contrasenaVisibility =
                                        !contrasenaVisibility,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    contrasenaVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppTheme.of(context).primaryColor,
                                    size: 22,
                                  ),
                                ),
                              ),
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color:
                                        AppTheme.of(context).tertiaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              //Se valida que se haya ingresado las credenciales con validadores
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              if (!await networkState.getConnectionStatus()) {
                                // //Proceso Offline
                                // final usuarioActual =
                                //     usuarioProvider.validateUserOffline(
                                //         userState.emailController.text,
                                //         userState.passwordController.text);
                                // if (usuarioActual != null) {
                                //   //Usuario ya existe localmente
                                //   prefs.setBool(
                                //   "boolLogin", true);
                                //   prefs.setString(
                                //       "userId", userState.emailController.text);
                                //   //Se guarda el Password encriptado
                                //   prefs.setString(
                                //       "passEncrypted", userState.passwordController.text);
                                //   usuarioProvider
                                //       .getUser(prefs.getString("userId")!);
              
                                //   if (userState.recuerdame == true) {
                                //     await userState.setEmail();
                                //     await userState.setPassword();
                                //   } else {
                                //     userState.emailController.text = '';
                                //     userState.passwordController.text = '';
                                //     await prefs.remove('email');
                                //     await prefs.remove('password');
                                //   }
                  
                                //   if (!mounted) return;
                                //   await Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           const MainScreenSelector(),
                                //     ),
                                //   );
                                // } else {
                                //   //Usuario no existe localmente
                                //   snackbarKey.currentState
                                //       ?.showSnackBar(const SnackBar(
                                //     content: Text(
                                //         "Wrong credentials! Invalid email or password."),
                                //   ));
                                // }
                              } else {
                                //Proceso Online
                                //Login a Supabase
                                final loginResponseSupabase =
                                    await AuthService.loginSupabase(
                                  userState.emailController.text,
                                  userState.passwordController.text,
                                );
                                if (loginResponseSupabase != null) {
                                  final getUserSupabase =
                                    await AuthService.getUserByUserIDSupabase(
                                    loginResponseSupabase.user.id
                                  );
                                  if (getUserSupabase != null) {
                                    final userId =
                                          loginResponseSupabase.user.email;
                                    //Se guarda el ID DEL USUARIO (correo)
                                    prefs.setString("userId", userId);
                                     //Se descargan los roles desde Supabase
                                    rolesSupabaseProvider.message = "";
                                    rolesSupabaseProvider.procesoCargando(true);
                                    rolesSupabaseProvider.procesoTerminado(false);
                                    rolesSupabaseProvider.procesoExitoso(false);
                                    String messageSupabase =
                                        await rolesSupabaseProvider.getRolesSupabase(getUserSupabase);
                                    if (messageSupabase == "Okay") {
                                      //Se guarda el Password encriptado
                                      prefs.setString(
                                          "passEncrypted", userState.passwordController.text);
                                      //Se valida que el Usuario exista localmente
                                      if (usuarioProvider
                                          .validateUsuario(userId)) {
                                        //print('Usuario ya existente');
                                        usuarioProvider.update(
                                          userState.emailController.text,
                                          getUserSupabase.firstName,
                                          getUserSupabase.lastName,
                                          userState.passwordController.text,
                                          getUserSupabase.image,
                                          [getUserSupabase.role],
                                          getUserSupabase.idRoleFk.toString(),
                                          getUserSupabase.idSecuencial
                                        );
                                        usuarioProvider.getUser(userId);
                                      } else {
                                        usuarioProvider.add(
                                          getUserSupabase.firstName,
                                          getUserSupabase.lastName,
                                          loginResponseSupabase.user.email,
                                          userState.passwordController.text,
                                          getUserSupabase.image,
                                          [getUserSupabase.role],
                                          getUserSupabase.id,
                                          getUserSupabase.idRoleFk.toString(),
                                          getUserSupabase.idSecuencial
                                        );
                                        usuarioProvider.getUser(loginResponseSupabase.user.email);
                                      }
                                      prefs.setBool(
                                        "boolLogin", true);
                                      if (userState.recuerdame == true) {
                                        await userState.setEmail();
                                        await userState.setPassword();
                                      } else {
                                        userState.emailController.text = '';
                                        userState.passwordController.text =
                                            '';
                                        await prefs.remove('email');
                                        await prefs.remove('password');
                                      }
                                      // //Se valida que el Usuario tenga un vehículo Asignado
                                      if (!mounted) return;
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MainScreenSelector(),
                                        ),
                                      );
                                    } else {
                                      switch (messageSupabase) {
                                        case "Not-Data":
                                          snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                          content: Text(
                                              "Fail to recover data from Server about: Status, Company, Services and Roles."),
                                          ));
                                          break;
                                        case "Not-Vehicles":
                                          snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                          content: Text(
                                              "There's not vehicles availables for this User, try later."),
                                          ));
                                          break;
                                        case "Not-Status-Company":
                                          snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                          content: Text(
                                              "Fail to recover the information about Status and Company."),
                                          ));
                                          break;
                                        default:
                                          snackbarKey.currentState
                                            ?.showSnackBar(SnackBar(
                                          content: Text(
                                              "Fail to recover the information from Server, details: $messageSupabase."),
                                          ));
                                          break;
                                      }
                                    }
                                  } else {
                                    snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "'Attempting User Data Recovery from Server' Failed."),
                                    ));
                                  }
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Invalid Credentials! Invalid email or password."),
                                    ));
                                }
                              }
                            },
                            text: 'Log In',
                            options: CustomButtonOption(
                              width: 130,
                              height: 50,
                              color: AppTheme.of(context).primaryColor,
                              textStyle:
                                  AppTheme.of(context).subtitle1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 24),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ResetPasswordScreen()
                                      ),
                                    );
                                  },
                                  text: 'Forget your password?',
                                  options: CustomButtonOption(
                                    width: 170,
                                    height: 30,
                                    color: const Color(0x00FFFFFF),
                                    textStyle: AppTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'Lexend Deca',
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    elevation: 0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
