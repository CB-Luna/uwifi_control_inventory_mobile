
import 'dart:async';
import 'dart:io' as libraryIO;
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/vehiculo_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/checkout_form_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class InventoryFormOCR extends StatelessWidget {
  
  const InventoryFormOCR({super.key});
  
  @override
  Widget build(BuildContext context) {
    final checkOutProvider = Provider.of<CheckOutFormController>(context);
    final vehicleProvider = Provider.of<VehiculoController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: SizedBox( // Need to use container to add size constraint.
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5, 5, 5, 5),
                child: Text(
                  "Place the text to scan in the blue container",
                  style: FlutterFlowTheme.of(context).subtitle2,
                )
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5, 5, 5, 5),
                child: Text(
                  "It will be redirect to form, once detect all values",
                  style: FlutterFlowTheme.of(context).bodyText2,
                )
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5, 0, 5, 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      ScalableOCR(
                          paintboxCustom: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 5.0
                            ..color = FlutterFlowTheme.of(context).primaryColor,
                          boxHeight: MediaQuery.of(context).size.width * 0.7,
                          getScannedText: (value) async {
                            if (await checkOutProvider.autofillFieldsOCR(value)) {
                              vehicleProvider.changeOptionInventorySection(4);
                            }
                          }),
                      FFButtonWidget(
                        onPressed: () async {
                          checkOutProvider.clearControllers();
                          vehicleProvider.changeOptionInventorySection(1);
                        },
                        text: 'Close',
                        icon: const Icon(
                          Icons.cancel_outlined,
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
          ),
        ),
      ),
    );
  }
}