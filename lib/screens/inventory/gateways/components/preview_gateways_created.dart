import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/batch_gateway_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/gateway_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/gateways/widgets/item_gateway_batch.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_button_option.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

class PreviewGatewaysCreated extends StatefulWidget {
  
  const PreviewGatewaysCreated({super.key});

  @override
  State<PreviewGatewaysCreated> createState() => _PreviewGatewaysCreatedState();
}
class _PreviewGatewaysCreatedState extends State<PreviewGatewaysCreated> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BatchGatewayProvider>(context);
    final gatewayMenuProvider = Provider.of<GatewayMenuProvider>(context);
    final batchGatewayProvider = Provider.of<BatchGatewayProvider>(context);
    final userProvider = Provider.of<UsuarioController>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 10, 5, 10),
                  child: FFButtonWidget(
                    onPressed: () async {
                      batchGatewayProvider.clearData();
                      gatewayMenuProvider.changeOptionInventorySection(3);
                    },
                    text: 'Back',
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      size: 15,
                    ),
                    options: CustomButtonOption(
                      width: MediaQuery.of(context).size.width * 0.18,
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
                Text(
                  "Rows: ${provider.gatewaysBatch.length}",
                  style: AppTheme.of(context)
                  .subtitle2
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 10, 5, 10),
                  child: FFButtonWidget(
                    onPressed: () async {
                      gatewayMenuProvider.changeOptionInventorySection(9);
                    },
                    text: 'Add',
                    icon: const Icon(
                      Icons.add_outlined,
                      size: 15,
                    ),
                    options: CustomButtonOption(
                      width: MediaQuery.of(context).size.width * 0.18,
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 10, 5, 10),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (batchGatewayProvider.gatewaysBatch.isNotEmpty) {
                        if (await provider.addGatewaysBatchCreated(userProvider.usuarioCurrent)) {
                          gatewayMenuProvider.changeOptionInventorySection(6);
                        } else {
                          gatewayMenuProvider.changeOptionInventorySection(7);
                        }
                      } else {
                        if (!context.mounted) return;
                        snackbarKey.currentState
                            ?.showSnackBar(const SnackBar(
                          content: Text(
                              "Batch empty, please add at least one gateway to continue."),
                        ));
                      }
                    },
                    text: 'Upload',
                    icon: const Icon(
                      Icons.check_outlined,
                      size: 15,
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
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context)
                                    .white,
                                borderRadius:
                                    const BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(8),
                                  bottomRight:
                                      Radius.circular(30),
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(30),
                                ),
                                border: Border.all(
                                  color: AppTheme.of(context).alternate,
                                  width: 2)
                              ),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.search_rounded,
                                  color: AppTheme.of(context).alternate,
                                  size: 24,
                                ),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          "S/N.",
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context)
                          .bodyText1.override(
                            fontFamily:
                                  AppTheme.of(context).bodyText1Family,
                            color: AppTheme.of(context).alternate,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          "MAC",
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context)
                          .bodyText1.override(
                            fontFamily:
                                  AppTheme.of(context).bodyText1Family,
                            color: AppTheme.of(context).alternate,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Text(
                          "Options",
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context)
                          .bodyText1.override(
                            fontFamily:
                                  AppTheme.of(context).bodyText1Family,
                            color: AppTheme.of(context).alternate,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
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
                  scrollDirection: Axis.vertical,
                  itemCount: provider.gatewaysBatch.length,
                  itemBuilder: (context, index) {
                    final gatewayBatch = provider.gatewaysBatch[index];
                    return ItemGatewayBatch(
                      gatewayBatch: gatewayBatch,
                      index: index + 1,
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
