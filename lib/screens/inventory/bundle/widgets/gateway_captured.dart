import 'package:uwifi_control_inventory_mobile/providers/database/bundle_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/bundle_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/indicator_filter_button.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class GatewayCaptured extends StatelessWidget {
  
  const GatewayCaptured({super.key});
  
  @override
  Widget build(BuildContext context) {
    final bundleFormProvider = Provider.of<BundleFormProvider>(context);
    final bundleMenuProvider = Provider.of<BundleMenuProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: SizedBox( // Need to use container to add size constraint.
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
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
                    5, 5, 5, 5),
                child: Text(
                  "No. Serial ${bundleFormProvider.gatewayCaptured?.serialNo}",
                  style: AppTheme.of(context).subtitle1,
                )
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5, 5, 5, 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/images/gateway.png',
                        ).image,
                      ),
                      borderRadius: BorderRadius.circular(0)),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5, 5, 5, 5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sim_card_outlined,
                            size: 15,
                            color: AppTheme.of(context).alternate,
                          ),
                          Text(
                            "1: ",
                            style: AppTheme.of(context)
                            .subtitle2
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .subtitle2Family,
                              color: AppTheme.of(context).alternate,
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            bundleFormProvider.simCard1?.imei ?? "None Sim Card",
                            style: AppTheme.of(context)
                            .subtitle2
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .subtitle2Family,
                              color: AppTheme.of(context).alternate,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sim_card_outlined,
                            size: 15,
                            color: AppTheme.of(context).alternate,
                          ),
                          Text(
                            "2: ",
                            style: AppTheme.of(context)
                            .subtitle2
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .subtitle2Family,
                              color: AppTheme.of(context).alternate,
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            bundleFormProvider.simCard2?.imei ?? "None Sim Card",
                            style: AppTheme.of(context)
                            .subtitle2
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .subtitle2Family,
                              color: AppTheme.of(context).alternate,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ),
              Builder(
                builder: (context) {
                  final section = bundleMenuProvider.optionButtonsGC(); 
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: section,
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    5, 0, 5, 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      FFButtonWidget(
                        onPressed: () async {
                          bundleFormProvider.clearGatewayControllers();
                          bundleMenuProvider.changeOptionInventorySection(1);
                          bundleMenuProvider.changeOptionButtonsGC(0 ,null);
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