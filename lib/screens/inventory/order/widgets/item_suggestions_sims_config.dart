import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/order_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/order_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
class ItemSuggestionsSimsConfig extends StatefulWidget {
  const ItemSuggestionsSimsConfig({
    Key? key,
    required this.sku,
    required this.index,
  }) : super(key: key);

  final List<String> sku;
  final int index;

  @override
  State<ItemSuggestionsSimsConfig> createState() => _ItemSuggestionsSimsConfigState();
}

class _ItemSuggestionsSimsConfigState extends State<ItemSuggestionsSimsConfig> {
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final orderMenuProvider = Provider.of<OrderMenuProvider>(context);
    final orderFormProvider = Provider.of<OrderFormProvider>(context);
    return Form(
      key: keyForm,
      child: Column(
        children: [
          Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
          child: Slidable(
            endActionPane: ActionPane(
            motion: const DrawerMotion(), 
            children: [
              SlidableAction(
                icon: Icons.check_circle_outline,
                backgroundColor: AppTheme.of(context).primaryColor,
                foregroundColor: AppTheme.of(context).white,
                borderRadius: BorderRadius.circular(20.0),
                onPressed: (contextList) async {
                  if (!mounted) return;
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: const Text(
                          'Are you sure you want to make this chance?'),
                      content: Text(
                          'The SKU for order number "${orderFormProvider.order?.orderId}" will be "${widget.sku[0]}/${widget.sku[1]}".',
                          textAlign: TextAlign.center,),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            if (await orderFormProvider.shippingBundleBundleAssignedCarriersAssignedV1(widget.sku)) {
                              if (!mounted) return;
                              Navigator.pop(context);
                              orderMenuProvider.changeOptionOrders(6);
                            } 
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
                }
              ),
            ]),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SKU-${widget.index}",
                  style: AppTheme.of(context)
                  .bodyText1.override(
                    fontFamily:
                          AppTheme.of(context).bodyText1Family,
                    color: AppTheme.of(context).tertiaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  "${widget.sku[0]}/${widget.sku[1]}",
                  style: AppTheme.of(context)
                  .bodyText1.override(
                    fontFamily:
                          AppTheme.of(context).bodyText1Family,
                    color: AppTheme.of(context).secondaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(
                      Icons.double_arrow_rounded,
                      size: 35,
                      color: AppTheme.of(context).alternate,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 4,
          thickness: 4,
          indent: 20,
          endIndent: 20,
          color: AppTheme.of(context).grayLighter,
        ),
        ],
      ),
    );
  }
}
