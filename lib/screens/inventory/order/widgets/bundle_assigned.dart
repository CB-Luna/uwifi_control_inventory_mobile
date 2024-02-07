import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/order_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/order_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class BundleAssigned extends StatelessWidget {
  
  BundleAssigned({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final orderMenuProvider = Provider.of<OrderMenuProvider>(context);
    final orderFormProvider = Provider.of<OrderFormProvider>(context);
    return Column(
      children: [
       Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              5, 15, 5, 15),
          child: Text(
            "Bundle Assigned",
            style: AppTheme.of(context).title2,
          )
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              5, 5, 5, 5),
          child: Text(
            "No. Serial ${orderFormProvider.bundleCaptured?.serieNo}",
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
                      orderFormProvider.simCard1?.imei ?? "None Sim Card",
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
                      orderFormProvider.simCard2?.imei ?? "None Sim Card",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      orderMenuProvider.changeOptionButtonsGC(0, null);
                      orderMenuProvider.changeOptionInventorySection(0);
                      orderFormProvider.clearBundleControllers();
                      Navigator.pop(context);
                    },
                    text: 'Close',
                    icon: const Icon(
                      Icons.close_outlined,
                      size: 20,
                    ),
                    options: FFButtonOptions(
                      width: MediaQuery.of(context).size.width * 0.5,
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
