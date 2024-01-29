import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';

import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class BottomSheetSincronizarWidget extends StatefulWidget {
  final bool isVisible;
  const BottomSheetSincronizarWidget({Key? key, required this.isVisible})
      : super(key: key);

  @override
  State<BottomSheetSincronizarWidget> createState() =>
      _BottomSheetSincronizarWidgetState();
}

class _BottomSheetSincronizarWidgetState
    extends State<BottomSheetSincronizarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: 3,
                        indent: 150,
                        endIndent: 150,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 4, 0, 0),
                              child: Text(
                                'Are you sure you want to sync?',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).title2.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).title2Family,
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 19,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 8, 0, 0),
                              child: Text(
                                'All the input data in the control forms are going to saved in the cloud (Intenet Conection is required).',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).bodyText2Family,
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie_animations/lf30_editor_uguzblhq.json',
                              height: 100,
                              fit: BoxFit.cover,
                              animate: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              text: 'CANCEL',
                              options: FFButtonOptions(
                                width: 150,
                                height: 50,
                                color: const Color(0xFF8C8C8C),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily:
                                          FlutterFlowTheme.of(context).subtitle2Family,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 2,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: widget.isVisible,
                              child: FFButtonWidget(
                                onPressed: () async {
                                },
                                text: 'SYNC',
                                options: FFButtonOptions(
                                  width: 150,
                                  height: 50,
                                  color: FlutterFlowTheme.of(context).secondaryColor,
                                  textStyle:
                                    FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  elevation: 2,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
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
          ],
        ),
      ),
    );
  }
}
