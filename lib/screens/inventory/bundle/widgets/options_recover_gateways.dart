import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/indicator_filter_button.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class OptionsRecoverGateways extends StatelessWidget {
  
  OptionsRecoverGateways({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bundleMenuProvider = Provider.of<BundleMenuProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Center(
            child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            child: IndicatorFilterButton(
              text: "${bundleMenuProvider.valueSimCarrier}. ${
                bundleMenuProvider.simCarriers[
                bundleMenuProvider.valueSimCarrier -1
              ].name}",
              onPressed: () {},
              isTaped: true,
            ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              5, 25, 5, 25),
          child: Text(
            "Please select one option to recover the Gateway.",
            style: AppTheme.of(context).title2,
            textAlign: TextAlign.center,
          )
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      bundleMenuProvider.changeOptionInventorySection(2);
                    },
                    text: 'OCR',
                    icon: const Icon(
                      Icons.photo_camera_outlined,
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
                            color: AppTheme.of(context)
                          .alternate,
                            fontSize: 15,
                          ),
                      borderSide: BorderSide(
                        color: AppTheme.of(context)
                          .alternate,
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
                      bundleMenuProvider.changeOptionInventorySection(3);
                    },
                    text: 'SKU',
                    icon: const Icon(
                      Icons.edit_outlined,
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
                            color: AppTheme.of(context)
                          .alternate,
                            fontSize: 15,
                          ),
                      borderSide: BorderSide(
                        color: AppTheme.of(context)
                          .alternate,
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
                      bundleMenuProvider.changeOptionInventorySection(0);
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
                            color: AppTheme.of(context)
                          .alternate,
                            fontSize: 15,
                          ),
                      borderSide: BorderSide(
                        color: AppTheme.of(context)
                          .alternate,
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
      ],
    );
  }
}
