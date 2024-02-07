import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/order_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/order_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class BundleFormOCR extends StatelessWidget {
  
  const BundleFormOCR({super.key});
  
  @override
  Widget build(BuildContext context) {
    final orderFormProvider = Provider.of<OrderFormProvider>(context);
    final orderMenuProvider = Provider.of<OrderMenuProvider>(context);
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
                  style: AppTheme.of(context).subtitle2,
                )
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5, 5, 5, 5),
                child: Text(
                  "It will be redirect to form, once detect all values",
                  style: AppTheme.of(context).bodyText2,
                )
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5, 0, 5, 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      ScalableOCR(
                        boxTopOff: 5,
                        boxBottomOff: 5,
                        boxLeftOff: 7,
                        boxRightOff: 7,
                          paintboxCustom: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 5.0
                            ..color = AppTheme.of(context).primaryColor,
                          boxHeight: MediaQuery.of(context).size.width * 0.7,
                          getScannedText: (value) async {
                            if (await orderFormProvider.autofillFieldsBundleOCR(value)) {
                              orderMenuProvider.changeOptionInventorySection(4);
                            }
                          }),
                      FFButtonWidget(
                        onPressed: () async {
                          orderFormProvider.clearBundleControllers();
                          orderMenuProvider.changeOptionInventorySection(0);
                        },
                        text: 'Back',
                        icon: const Icon(
                          Icons.arrow_back_outlined,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 40,
                          color: AppTheme.of(context)
                              .white,
                          textStyle: AppTheme.of(context)
                              .subtitle2
                              .override(
                                fontFamily: AppTheme.of(context)
                                    .subtitle2Family,
                                color: AppTheme.of(context).alternate,
                                fontSize: 15,
                              ),
                          borderSide: BorderSide(
                            color: AppTheme.of(context).alternate,
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