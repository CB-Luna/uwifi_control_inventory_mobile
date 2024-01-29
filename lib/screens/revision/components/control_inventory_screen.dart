
import 'dart:io' as libraryIO;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/header_shimmer.dart';

import '../../../providers/system/gateway_menu_provider.dart';

class ControlInventoryScreen extends StatelessWidget {
  
  ControlInventoryScreen({super.key});

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
              text: "Inventory Form",
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