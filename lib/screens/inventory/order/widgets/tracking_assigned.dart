import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/order_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/order_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class TrackingAssigned extends StatelessWidget {
  
  TrackingAssigned({super.key});

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
            "Tracking Id Assigned",
            style: AppTheme.of(context).title2,
          )
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              5, 5, 5, 5),
          child: Text(
            "No. Serial ${orderFormProvider.bundleCaptured?.serieNo}",
            style: AppTheme.of(context).subtitle2,
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
          child: Text(
            "Id Tracking: '${orderFormProvider.trackingNumberTextController.text}'",
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (!context.mounted) return;
                        orderMenuProvider.changeOptionOrdersDelivery(0);
                        orderFormProvider.clearBundleControllers();
                        Navigator.pop(context);
                      },
                      text: 'Accept',
                      icon: const Icon(
                        Icons.check_outlined,
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
