import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/image_evidence.dart';
import 'package:uwifi_control_inventory_mobile/models/inventory_order.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/order_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

import '../../../../providers/database/order_form_provider.dart';
class ItemFormOrderDelivery extends StatefulWidget {
  const ItemFormOrderDelivery({
    Key? key,
    required this.order,
  }) : super(key: key);

  final InventoryOrder order;

  @override
  State<ItemFormOrderDelivery> createState() => _ItemFormOrderDeliveryState();
}

class _ItemFormOrderDeliveryState extends State<ItemFormOrderDelivery> {
  List<ImageEvidence> imagesTemp = [];
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                icon: Icons.document_scanner_outlined,
                backgroundColor: widget.order.orderActions?.first.status == "Waiting for Tracking Number" ? 
                AppTheme.of(context).grayLight
                : 
                AppTheme.of(context).primaryColor,
                foregroundColor: AppTheme.of(context).white,
                borderRadius: BorderRadius.circular(20.0),
                onPressed: (context) async {
                  if (!mounted) return;
                  if (widget.order.orderActions?.first.status == "Waiting for Tracking Number") {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        orderFormProvider.order = widget.order;
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Row(
                                  children: [
                                    const Text("No Order: "),
                                    Text("${widget.order.orderId}"),
                                  ],
                                )
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ClayContainer(
                                  height: 30,
                                  width: 30,
                                  depth: 15,
                                  spread: 1,
                                  borderRadius: 15,
                                  curveType: CurveType.concave,
                                  color:
                                  AppTheme.of(context).secondaryColor,
                                  surfaceColor:
                                  AppTheme.of(context).secondaryColor,
                                  parentColor:
                                  AppTheme.of(context).secondaryColor,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: AppTheme.of(context).white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          content: SizedBox( // Need to use container to add size constraint.
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Consumer<OrderMenuProvider>(
                              builder: (context, orderMenuProvider, _) {
                                return orderMenuProvider.optionOrdersDelivery();
                              },
                            ),
                          ),
                        ),
                        );
                      },
                    );
                  } else {
                    snackbarKey.currentState
                        ?.showSnackBar(SnackBar(
                      content: Text(
                          "Tracking number have already assigned to order with Id. '${widget.order.orderId}'"),
                    ));
                  }
                }
              ),
              SlidableAction(
                icon: Icons.print_outlined,
                backgroundColor: AppTheme.of(context).secondaryColor,
                foregroundColor: AppTheme.of(context).white,
                borderRadius: BorderRadius.circular(20.0),
                onPressed: (context) async {
                  if (!mounted) return;
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Ticket Order"),
                                  Text("Order Id: ${widget.order.orderId}",
                                  style: AppTheme.of(context).bodyText2,),
                                ],
                              )
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: ClayContainer(
                                height: 30,
                                width: 30,
                                depth: 15,
                                spread: 1,
                                borderRadius: 15,
                                curveType: CurveType.concave,
                                color:
                                AppTheme.of(context).secondaryColor,
                                surfaceColor:
                                AppTheme.of(context).secondaryColor,
                                parentColor:
                                AppTheme.of(context).secondaryColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: AppTheme.of(context).white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        content: Container( // Need to use container to add size constraint.
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.of(context).dark400,
                              width: 1.5,
                            )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                child: Text("Ship to:",
                                style: AppTheme.of(context).subtitle1,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text("${widget.order.fullName}",
                                style: AppTheme.of(context).bodyText2,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text("${widget.order.customerPhone}",
                                style: AppTheme.of(context).bodyText2,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text("MILO DR",
                                style: AppTheme.of(context).bodyText2,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text("BEAUMONT TX ${widget.order.customerZipcode}",
                                style: AppTheme.of(context).bodyText1,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text("US",
                                style: AppTheme.of(context).bodyText1,),
                              ),
                              Divider(
                                height: 4,
                                thickness: 4,
                                indent: 0,
                                endIndent: 0,
                                color: AppTheme.of(context).dark400,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppTheme.of(context).dark400,
                                        width: 1.5,
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/qrcode.jpg',
                                        ).image,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.asset(
                                              'assets/images/barcode.png',
                                            ).image,
                                          ),
                                          borderRadius: BorderRadius.circular(0)),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 8,
                                thickness: 8,
                                indent: 0,
                                endIndent: 0,
                                color: AppTheme.of(context).dark400,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("UPS SAVER",
                                    style: AppTheme.of(context).title1,),
                                    Text("1P",
                                    style: AppTheme.of(context).title1,),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text("TRACKING #: 1ZA668990495524105",
                                style: AppTheme.of(context).subtitle2,),
                              ),
                              Divider(
                                height: 4,
                                thickness: 2,
                                indent: 0,
                                endIndent: 0,
                                color: AppTheme.of(context).dark400,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/images/barcode.png',
                                        ).image,
                                      ),
                                      borderRadius: BorderRadius.circular(0)),
                                ),
                              ),
                              Divider(
                                height: 8,
                                thickness: 6,
                                indent: 0,
                                endIndent: 0,
                                color: AppTheme.of(context).dark400,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text("BILLING: P/P:",
                                style: AppTheme.of(context).bodyText2,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text("DESC: 1 X test",
                                style: AppTheme.of(context).bodyText2,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                child: Text("Reference No.1: ESHK35431948",
                                style: AppTheme.of(context).bodyText1,),
                              ),
                            ],
                          ),
                        ),
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
                Text(
                  widget.order.orderId == null ? "NOT ID" : widget.order.orderId.toString(),
                  style: AppTheme.of(context)
                  .bodyText1.override(
                    fontFamily:
                          AppTheme.of(context).bodyText1Family,
                    color: AppTheme.of(context).tertiaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
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
      ),
    );
  }
}
