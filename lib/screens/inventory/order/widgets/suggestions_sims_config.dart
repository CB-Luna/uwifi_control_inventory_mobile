import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/order_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/item_suggestions_sims_config.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/header_shimmer.dart';

class SuggestionsSimsConfig extends StatefulWidget {
  
  const SuggestionsSimsConfig({super.key});

  @override
  State<SuggestionsSimsConfig> createState() => _SuggestionsSimsConfigState();
}
final scaffoldKey = GlobalKey<ScaffoldState>();

class _SuggestionsSimsConfigState extends State<SuggestionsSimsConfig> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // OrdersProvider provider = Provider.of<OrderFormProvider>(
      //   context,
      //   listen: false
      // );
      // await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderFormProvider = Provider.of<OrderFormProvider>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // HEADER
            HeaderShimmer(
              width: MediaQuery.of(context).size.width, 
              text: "Suggestions Sims Config",
            ),
            Padding(
               padding: const EdgeInsetsDirectional.fromSTEB(0, 8.0, 0, 8.0),
               child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3.0,
                    color: AppTheme.of(context).alternate,
                    ),
                  borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                   child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "No.",
                        style: AppTheme.of(context)
                        .bodyText1.override(
                          fontFamily:
                                AppTheme.of(context).bodyText1Family,
                          color: AppTheme.of(context).alternate,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "SIM1/SIM2",
                        style: AppTheme.of(context)
                        .bodyText1.override(
                          fontFamily:
                                AppTheme.of(context).bodyText1Family,
                          color: AppTheme.of(context).alternate,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Options",
                        style: AppTheme.of(context)
                        .bodyText1.override(
                          fontFamily:
                                AppTheme.of(context).bodyText1Family,
                          color: AppTheme.of(context).alternate,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                   ),
                 ),
               ),
            ),
            Container(
            height: 300,
            clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2.0,
                  color: AppTheme.of(context).grayLighter,
                  ),
                borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Builder(
                builder: (context) {
                  return ListView.builder(
                  padding: const EdgeInsets.all(5.0),
                  shrinkWrap: true,
                  controller: ScrollController(),
                  scrollDirection: Axis.vertical,
                  itemCount: orderFormProvider.suggestionsSimsConfig.length,
                  itemBuilder: (context, index) {
                    final sku = orderFormProvider.suggestionsSimsConfig[index];
                    return ItemSuggestionsSimsConfig(
                      sku: sku, 
                      index: index + 1
                    );
                  });
                },
              ),
            ),
        ]),
      ),
    );
  }
}
