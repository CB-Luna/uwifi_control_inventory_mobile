import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/header_shimmer.dart';

import '../../../../providers/system/gateway_menu_provider.dart';

class SelectorInventoryFormGateway extends StatelessWidget {
  
  SelectorInventoryFormGateway({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final gatewayMenuProvider = Provider.of<GatewayMenuProvider>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // HEADER
            HeaderShimmer(
              width: MediaQuery.of(context).size.width, 
              text: "Inventory Form Gateway",
            ),
            Builder(
              builder: (context) {
                return gatewayMenuProvider.optionInventorySection();
              },
            ),
            Divider(
              height: 4,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: AppTheme.of(context).grayLighter,
            ),
        ]),
      ),
    );
  }
}