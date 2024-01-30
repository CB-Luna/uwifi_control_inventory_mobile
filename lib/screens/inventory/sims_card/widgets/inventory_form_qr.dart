import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/sims_card_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_button_option.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

class InventoryFormQR extends StatelessWidget {
  
  const InventoryFormQR({super.key});


  @override
  Widget build(BuildContext context) {
    final simsCardMenuProvider = Provider.of<SIMSCardMenuProvider>(context);
    final simsCardFormProvider = Provider.of<SIMSCardFormProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: SizedBox( // Need to use container to add size constraint.
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  5, 5, 5, 5),
              child: Text(
                "Place the QR Code in the area",
                style: AppTheme.of(context).subtitle2,
              )
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  5, 5, 5, 5),
              child: Text(
                "Scanning will be started automatically",
                style: AppTheme.of(context).bodyText2,
              )
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  5, 5, 5, 5),
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Stack(
                  children: [
                    MobileScanner(
                      allowDuplicates: true,
                      onDetect: ((barcode, args) {
                        simsCardFormProvider.autofillFieldsQR(barcode.rawValue ?? "");
                        simsCardMenuProvider.changeOptionInventorySection(4);
                      }),
                    ),
                    QRScannerOverlay(
                      borderColor: AppTheme.of(context).primaryColor,
                    ),
                  ],
                ),
              )
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  5, 15, 5, 15),
              child: FFButtonWidget(
                onPressed: () async {
                  simsCardFormProvider.clearControllers();
                  simsCardMenuProvider.changeOptionInventorySection(1);
                },
                text: 'Close',
                icon: const Icon(
                  Icons.cancel_outlined,
                  size: 15,
                ),
                options: CustomButtonOption(
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
            ),
          ],
        ),
      ),
    );
  }
}
