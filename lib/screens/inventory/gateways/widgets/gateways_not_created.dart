import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class GatewaysNotCreated extends StatelessWidget {
  
  GatewaysNotCreated({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final gatewayMenuProvider = Provider.of<GatewayMenuProvider>(context);
    return Column(
      children: [
       Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              5, 15, 5, 15),
          child: Text(
            "Failed Adding Gateways",
            style: AppTheme.of(context).title2,
          )
        ),
        Padding(
          padding:
              const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
          child: Icon(
            Icons.error_outline_outlined,
            size: 120,
            color: AppTheme.of(context).secondaryColor,
          ),
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
                      gatewayMenuProvider.changeOptionInventorySection(1);
                    },
                    text: 'Try Again',
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
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
