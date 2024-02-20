import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/inventory_order.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/order_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/order_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/drop_down.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
class ItemFormOrder extends StatefulWidget {
  const ItemFormOrder({
    Key? key,
    required this.order,
  }) : super(key: key);

  final InventoryOrder order;

  @override
  State<ItemFormOrder> createState() => _ItemFormOrderState();
}

class _ItemFormOrderState extends State<ItemFormOrder> {
  final keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      OrderFormProvider provider = Provider.of<OrderFormProvider>(
        context,
        listen: false
      );
      await provider.getShipmentCompanies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderMenuProvider = Provider.of<OrderMenuProvider>(context);
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
              icon: Icons.router_outlined,
              backgroundColor: widget.order.orderActions?.first.status == "Waiting for Equipment Assignment" ? 
              AppTheme.of(context).grayLight
              : 
              AppTheme.of(context).primaryColor,
              foregroundColor: AppTheme.of(context).white,
              borderRadius: BorderRadius.circular(20.0),
              onPressed: (context) async {
                if (!mounted) return;
                if (widget.order.orderActions?.first.status == "Waiting for Equipment Assignment") {
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
                                orderMenuProvider.changeOptionButtonsGC(0, null);
                                orderMenuProvider.changeOptionInventorySection(0);
                                orderFormProvider.clearBundleControllers();
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
                                return orderMenuProvider.optionInventorySection();
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
                        "Bundle already assigned to order with Id. '${widget.order.orderId}'"),
                  ));
                }
              }
            ),
            SlidableAction(
              icon: Icons.beenhere_outlined,
              backgroundColor: AppTheme.of(context).grayLight,
              foregroundColor: AppTheme.of(context).white,
              borderRadius: BorderRadius.circular(20.0),
              onPressed: (context) async {
                if (!mounted) return;
                await showDialog(
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
                              orderFormProvider.clearBundleControllers();
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
                      content: Form(
                        key: keyForm,
                        child: SizedBox( // Need to use container to add size constraint.
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 15, 5, 15),
                                child: Text(
                                  "Please select one provider to continue",
                                  style: AppTheme.of(context).title2,
                                )
                              ),
                              FormField(
                                builder: (state) {
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 5, 20),
                                    child: DropDown(
                                      initialOption: orderFormProvider.shipmentCompany?.name,
                                      options: orderFormProvider.shipmentCompanies.map((e) => e.name).toList(),
                                      onChanged: (value) {
                                        state.setState(() {
                                          orderFormProvider.updateShipmentCompany(value!);
                                        });
                                      },
                                      width: double.infinity,
                                      height: 50,
                                      textStyle: AppTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: AppTheme.of(context).alternate,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      hintText: 'Provider*',
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: AppTheme.of(context).alternate,
                                        size: 30,
                                      ),
                                      fillColor: AppTheme.of(context).white,
                                      elevation: 2,
                                      borderColor: AppTheme.of(context).alternate,
                                      borderWidth: 2,
                                      borderRadius: 8,
                                      margin: const EdgeInsetsDirectional
                                          .fromSTEB(12, 4, 12, 4),
                                      hidesUnderline: true,
                                    ),
                                  );
                                },
                                validator: (val) {
                                  if (orderFormProvider.shipmentCompany == null) {
                                    return 'Provider is required.';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (orderFormProvider
                                        .validateForm(keyForm)) {
                                      if (await orderFormProvider.shippingBundleBundleShipmentProviderV1()) {
                                        if (!context.mounted) return;
                                        orderFormProvider.clearBundleControllers();
                                        Navigator.pop(context);
                                        snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                          backgroundColor: Color(0xFF00B837),
                                          content: Text(
                                              "Assigned Shipment Provider process done successfully."),
                                        ));
                                      } 
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Field empty required.'),
                                            content: const Text(
                                                "Full in the fields to continue."),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(
                                                        alertDialogContext),
                                                child:
                                                    const Text('Okay'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  text: 'Accept',
                                  options: FFButtonOptions(
                                    width: 200,
                                    height: 50,
                                    color: AppTheme.of(context).alternate,
                                    textStyle:
                                        AppTheme.of(context).subtitle1.override(
                                              fontFamily: 'Lexend Deca',
                                              color: AppTheme.of(context).white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                    elevation: 3,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
