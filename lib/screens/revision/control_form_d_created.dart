import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/checkin_form_controller.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/main_screen_selector.dart';

import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class ControlFormDCreatedScreen extends StatefulWidget {
  const ControlFormDCreatedScreen({Key? key}) : super(key: key);

  @override
  State<ControlFormDCreatedScreen> createState() => _ControlFormDCreatedScreenState();
}

class _ControlFormDCreatedScreenState extends State<ControlFormDCreatedScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final checkInFormProvider = Provider.of<CheckInFormController>(context);
    final userProvider = Provider.of<UsuarioController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).background,
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
                        '¡Check In\nForm\nCreated!',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 30,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(                                
                        'The form has been saved successfully.',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: SizedBox(
                        child: Icon(
                          Icons.check_circle_outline,
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          size: 250,
                          )
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (!await checkInFormProvider.sendEmail(userProvider.usuarioCurrent!)) {
                            snackbarKey.currentState
                                ?.showSnackBar(const SnackBar(
                              content: Text(
                                  "The email wasn't send successfully."),
                            ));
                          }
                          if (!mounted) return;
                          checkInFormProvider.cleanInformation();
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
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
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
