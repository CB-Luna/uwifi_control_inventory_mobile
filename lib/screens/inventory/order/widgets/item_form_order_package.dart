import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/inventory_order.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/order_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
class ItemFormOrderPackage extends StatefulWidget {
  const ItemFormOrderPackage({
    Key? key,
    required this.order,
  }) : super(key: key);

  final InventoryOrder order;

  @override
  State<ItemFormOrderPackage> createState() => _ItemFormOrderPackageState();
}

class _ItemFormOrderPackageState extends State<ItemFormOrderPackage> {
  final keyForm = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final orderFormProvider = Provider.of<OrderFormProvider>(context);
    return Column(
      children: [
        Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
        child: Slidable(
          endActionPane: ActionPane(
          motion: const DrawerMotion(), 
          children: [
            SlidableAction(
              icon: Icons.send_outlined,
              backgroundColor:AppTheme.of(context).secondaryColor,
              foregroundColor: AppTheme.of(context).white,
              borderRadius: BorderRadius.circular(20.0),
              onPressed: (context) async {
                if (!mounted) return;
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    orderFormProvider.order = widget.order;
                    return AlertDialog(
                      title: Text(
                          'Are you sure you want to packaging the order with Id. "${widget.order.orderId}"?'),
                      content: const Text(
                          'This action can not be undone.'),
                      actions: [
                        TextButton(
                          onPressed: () async {        
                            if (await orderFormProvider.shippingBundleBundlePackagedV1()) {
                              if(!mounted) return;
                              Navigator.pop(alertDialogContext);
                              snackbarKey.currentState
                                  ?.showSnackBar(const SnackBar(
                                backgroundColor: Color(0xFF00B837),
                                content: Text(
                                    "Packaging order proccess successfully."),
                              ));
                            } else {
                              if(!mounted) return;
                              Navigator.pop(alertDialogContext);
                              snackbarKey.currentState
                                  ?.showSnackBar(SnackBar(
                                content: Text(
                                    "Falied to packaging the order with id. '${widget.order.orderId}', try again."),
                              ));
                            }
                          },
                          child:
                              const Text('Continue'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(alertDialogContext); 
                          },
                          child:
                              const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              }
            ),
          ]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    widget.order.orderId == null ? "NOT ID" : widget.order.orderId.toString(),
                    style: AppTheme.of(context)
                    .bodyText1.override(
                      fontFamily:
                            AppTheme.of(context).bodyText1Family,
                      color: AppTheme.of(context).tertiaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "AT&T/T-Mobile",
                    style: AppTheme.of(context)
                    .bodyText1.override(
                      fontFamily:
                            AppTheme.of(context).bodyText1Family,
                      color: AppTheme.of(context).tertiaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.order.customerFirstName} ${widget.order.customerLastName}",
                style: AppTheme.of(context)
                .bodyText1.override(
                  fontFamily:
                        AppTheme.of(context).bodyText1Family,
                  color: AppTheme.of(context).secondaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
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
    );
  }
}
