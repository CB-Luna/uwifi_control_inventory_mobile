import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/orders_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/order/widgets/item_form_order.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_button_option.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/header_shimmer.dart';

class SearchOrdersList extends StatefulWidget {
  
  const SearchOrdersList({super.key});

  @override
  State<SearchOrdersList> createState() => _SearchOrdersListState();
}
class _SearchOrdersListState extends State<SearchOrdersList> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      OrdersProvider provider = Provider.of<OrdersProvider>(
        context,
        listen: false
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrdersProvider>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            // HEADER
            HeaderShimmer(
              width: MediaQuery.of(context).size.width, 
              text: "Search Orders",
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  0, 10, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.transparent,
                        )
                      ],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(
                              4, 4, 0, 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional
                                      .fromSTEB(4, 0, 4, 0),
                              child: TextFormField(
                                onChanged: (value) =>
                                    setState(() {}),
                                decoration: InputDecoration(
                                  labelText: 'Search...',
                                  labelStyle: AppTheme.of(
                                          context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context).alternate,
                                        fontSize: 13,
                                        fontWeight:
                                            FontWeight.normal,
                                      ),
                                  enabledBorder:
                                      OutlineInputBorder(
                                    borderSide:
                                        BorderSide(
                                      color: AppTheme.of(context).grayLighter,
                                      width: 2,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(
                                            8),
                                  ),
                                  focusedBorder:
                                      OutlineInputBorder(
                                    borderSide:
                                        BorderSide(
                                      color: AppTheme.of(context).grayLighter,
                                      width: 2,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(
                                            8),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search_sharp,
                                    color: AppTheme.of(context).alternate,
                                    size: 15,
                                  ),
                                ),
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 13,
                                      fontWeight:
                                          FontWeight.normal,
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional
                                .fromSTEB(0, 0, 5, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Are you sure you want to print all ticket orders?'),
                                      content: const Text(
                                          'Check if you save your changes.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child:
                                              const Text('Continue'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child:
                                              const Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return;
                              },
                              text: 'All',
                              icon: const Icon(
                                Icons.print_outlined,
                                size: 20,
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
                  ),
                ],
              ),
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
                        "No. Order",
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
                        "Client",
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
            height: 400,
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
                  scrollDirection: Axis.vertical,
                  itemCount: provider.orders.length,
                  itemBuilder: (context, index) {
                    final order = provider.orders[index];
                    return ItemFormOrder(
                      order: order,
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
