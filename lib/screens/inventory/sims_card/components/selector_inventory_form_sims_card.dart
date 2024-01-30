import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/header_shimmer.dart';

class SelectorInventorySIMSCard extends StatelessWidget {
  
  SelectorInventorySIMSCard({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final simsCardMenuProvider = Provider.of<SIMSCardMenuProvider>(context);
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
              text: "Inventory Form SIMS Card",
            ),
            Builder(
              builder: (context) {
                return simsCardMenuProvider.optionInventorySection();
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