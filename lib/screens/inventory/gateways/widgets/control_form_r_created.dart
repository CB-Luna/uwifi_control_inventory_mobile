import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/gateway_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/main/main_screen_selector.dart';

import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class ControlFormRCreatedScreen extends StatefulWidget {
  const ControlFormRCreatedScreen({Key? key}) : super(key: key);

  @override
  State<ControlFormRCreatedScreen> createState() => _ControlFormRCreatedScreenState();
}

class _ControlFormRCreatedScreenState extends State<ControlFormRCreatedScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final gatewayFormProvider = Provider.of<GatewayFormProvider>(context);
    final userProvider = Provider.of<UsuarioController>(context);
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
                        '¡Check Out\nControl Form\nCreated!',
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).bodyText1.override(
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
                        style: AppTheme.of(context).bodyText1.override(
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
                          color: AppTheme.of(context).secondaryColor,
                          size: 250,
                          )
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (!mounted) return;
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
