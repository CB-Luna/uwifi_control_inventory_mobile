
import 'dart:io' as libraryIO;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/vehiculo_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class OptionsAddProducts extends StatelessWidget {
  
  OptionsAddProducts({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehiculoController>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FFButtonWidget(
                onPressed: () async {
                  vehicleProvider.changeOptionInventorySection(2);
                },
                text: 'OCR',
                icon: const Icon(
                  Icons.photo_camera_outlined,
                  size: 15,
                ),
                options: FFButtonOptions(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 40,
                  color: FlutterFlowTheme.of(context)
                      .white,
                  textStyle: FlutterFlowTheme.of(context)
                      .subtitle2
                      .override(
                        fontFamily: FlutterFlowTheme.of(context)
                            .subtitle2Family,
                        color: FlutterFlowTheme.of(context).alternate,
                        fontSize: 15,
                      ),
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FFButtonWidget(
                onPressed: () async {
                  vehicleProvider.changeOptionInventorySection(3);
                },
                text: 'QR',
                icon: const Icon(
                  Icons.qr_code_scanner_outlined,
                  size: 15,
                ),
                options: FFButtonOptions(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 40,
                  color: FlutterFlowTheme.of(context)
                      .white,
                  textStyle: FlutterFlowTheme.of(context)
                      .subtitle2
                      .override(
                        fontFamily: FlutterFlowTheme.of(context)
                            .subtitle2Family,
                        color: FlutterFlowTheme.of(context).alternate,
                        fontSize: 15,
                      ),
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FFButtonWidget(
                onPressed: () async {
                  vehicleProvider.changeOptionInventorySection(4);
                },
                text: 'SKU',
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 15,
                ),
                options: FFButtonOptions(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 40,
                  color: FlutterFlowTheme.of(context)
                      .white,
                  textStyle: FlutterFlowTheme.of(context)
                      .subtitle2
                      .override(
                        fontFamily: FlutterFlowTheme.of(context)
                            .subtitle2Family,
                        color: FlutterFlowTheme.of(context).alternate,
                        fontSize: 15,
                      ),
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
