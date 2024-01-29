import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/main/main_screen_selector.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class UsuarioActualizado extends StatefulWidget {
  const UsuarioActualizado({Key? key}) : super(key: key);

  @override
  State<UsuarioActualizado> createState() => _UsuarioActualizadoState();
}

class _UsuarioActualizadoState extends State<UsuarioActualizado> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).background,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Text(
                        '¡User\nUpdated!',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: AppTheme.of(context).dark400,
                              fontSize: 30,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'The user was updated \nsuccessfully',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: AppTheme.of(context).dark400,
                              fontSize: 15,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                      child: Lottie.asset(
                        'assets/lottie_animations/elemento-creado.json',
                        width: 250,
                        height: 180,
                        fit: BoxFit.cover,
                        repeat: false,
                        animate: true,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MainScreenSelector(),
                            ),
                          );
                        },
                        text: 'Continue',
                        options: FFButtonOptions(
                          width: 200,
                          height: 45,
                          color: AppTheme.of(context).secondaryColor,
                          textStyle: AppTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: AppTheme.of(context).white,
                              ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
