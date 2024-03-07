import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/batch_sim_card_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/sims_card/widgets/item_sim_card_batch_temp.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class SimsCardAdded extends StatelessWidget {
  
  SimsCardAdded({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final simsCardMenuProvider = Provider.of<SIMSCardMenuProvider>(context);
    final batchSimCardProvider = Provider.of<BatchSimCardProvider>(context);
    return Column(
      children: [
       Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              5, 15, 5, 15),
          child: Text(
            "Sims Card Added Status",
            style: AppTheme.of(context).title2,
          )
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
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
                                    onChanged: (value) {
                                      
                                    },
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
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              "IMEI",
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
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              "Status",
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
                height: 250,
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
                      itemCount: batchSimCardProvider.simsCardBatchTemp.length,
                      itemBuilder: (context, index) {
                        final simCardBatchTemp = batchSimCardProvider.simsCardBatchTemp[index];
                        return ItemSimCardBatchTemp(
                          simCardBatchTemp: simCardBatchTemp,
                          index: index + 1,
                        );
                      });
                    },
                  ),
                ),
            ]),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      batchSimCardProvider.clearData();
                      simsCardMenuProvider.changeOptionInventorySection(1);
                    },
                    text: 'Accept',
                    icon: const Icon(
                      Icons.check_outlined,
                      size: 20,
                    ),
                    options: FFButtonOptions(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 40,
                      color: AppTheme.of(context)
                          .white,
                      textStyle: AppTheme.of(context)
                          .subtitle2
                          .override(
                            fontFamily: AppTheme.of(context)
                                .subtitle2Family,
                            color: AppTheme.of(context)
                          .alternate,
                            fontSize: 15,
                          ),
                      borderSide: BorderSide(
                        color: AppTheme.of(context)
                          .alternate,
                        width: 2,
                      ),
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
