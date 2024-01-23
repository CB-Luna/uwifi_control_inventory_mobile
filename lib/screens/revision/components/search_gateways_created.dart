import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/checkout_form_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/flutter_flow_animaciones.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/header_shimmer.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/item_form.dart';

class SearchGatewaysCreadted extends StatefulWidget {
  
  const SearchGatewaysCreadted({super.key});

  @override
  State<SearchGatewaysCreadted> createState() => _SearchGatewaysCreadtedState();
}
final scaffoldKey = GlobalKey<ScaffoldState>();
final animationsMap = {
    'moveLoadAnimationLR': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(-79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
        ),
      ],
    ),
    'moveLoadAnimationRL': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
        ),
      ],
    ),
  };

class _SearchGatewaysCreadtedState extends State<SearchGatewaysCreadted> {
  @override
  Widget build(BuildContext context) {
    final checkOutFormProvider = Provider.of<CheckOutFormController>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            // HEADER
            HeaderShimmer(
              width: MediaQuery.of(context).size.width, 
              text: "Search Gateways Created",
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
                                  labelStyle: FlutterFlowTheme.of(
                                          context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context).alternate,
                                        fontSize: 13,
                                        fontWeight:
                                            FontWeight.normal,
                                      ),
                                  enabledBorder:
                                      OutlineInputBorder(
                                    borderSide:
                                        BorderSide(
                                      color: FlutterFlowTheme.of(context).grayLighter,
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
                                      color: FlutterFlowTheme.of(context).grayLighter,
                                      width: 2,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(
                                            8),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search_sharp,
                                    color: FlutterFlowTheme.of(context).alternate,
                                    size: 15,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context).primaryText,
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
                                color: FlutterFlowTheme.of(context)
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
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 2)
                              ),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.search_rounded,
                                  color: FlutterFlowTheme.of(context).alternate,
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
            // HSG4GS5
            ItemForm(
              textItem: "HSG4GS5", 
              onPressed: () {

              }, 
              isRight: false,
              readOnly: false,
              images: checkOutFormProvider.headLightsImages,
              addImage: (image) {
                checkOutFormProvider.addHeadLightsImage(image);
              },
              deleteImage: (image) {
                checkOutFormProvider.deleteHeadLightsImage(image);
              },
              comments: checkOutFormProvider.headLightsComments,
              report: checkOutFormProvider.headLights,
              updateReport: (report) {
                checkOutFormProvider.updateHeadLights(report);
              },
            ),
            Divider(
              height: 4,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: FlutterFlowTheme.of(context).grayLighter,
            ),

            // GSGS243
            ItemForm(
              textItem: "GSGS243", 
              onPressed: () {

              }, 
              isRight: false,
              readOnly: false,
              images: checkOutFormProvider.brakeLightsImages,
              addImage: (image) {
                checkOutFormProvider.addBrakeLightsImage(image);
              },
              deleteImage: (image) {
                checkOutFormProvider.deleteBrakeLightsImage(image);
              },
              comments: checkOutFormProvider.brakeLightsComments,
              report: checkOutFormProvider.brakeLights,
              updateReport: (report) {
                checkOutFormProvider.updateBrakeLights(report);
              }
            ),
            Divider(
              height: 4,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: FlutterFlowTheme.of(context).grayLighter,
            ),

            // HSG4GS5
            ItemForm(
              textItem: "HSG4GS5", 
              onPressed: () {

              }, 
              isRight: false,
              readOnly: false,
              images: checkOutFormProvider.headLightsImages,
              addImage: (image) {
                checkOutFormProvider.addHeadLightsImage(image);
              },
              deleteImage: (image) {
                checkOutFormProvider.deleteHeadLightsImage(image);
              },
              comments: checkOutFormProvider.headLightsComments,
              report: checkOutFormProvider.headLights,
              updateReport: (report) {
                checkOutFormProvider.updateHeadLights(report);
              },
            ),
            Divider(
              height: 4,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: FlutterFlowTheme.of(context).grayLighter,
            ),

            // GSGS243
            ItemForm(
              textItem: "GSGS243", 
              onPressed: () {

              }, 
              isRight: false,
              readOnly: false,
              images: checkOutFormProvider.brakeLightsImages,
              addImage: (image) {
                checkOutFormProvider.addBrakeLightsImage(image);
              },
              deleteImage: (image) {
                checkOutFormProvider.deleteBrakeLightsImage(image);
              },
              comments: checkOutFormProvider.brakeLightsComments,
              report: checkOutFormProvider.brakeLights,
              updateReport: (report) {
                checkOutFormProvider.updateBrakeLights(report);
              }
            ),
            Divider(
              height: 4,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: FlutterFlowTheme.of(context).grayLighter,
            ),

            // HSG4GS5
            ItemForm(
              textItem: "HSG4GS5", 
              onPressed: () {

              }, 
              isRight: false,
              readOnly: false,
              images: checkOutFormProvider.headLightsImages,
              addImage: (image) {
                checkOutFormProvider.addHeadLightsImage(image);
              },
              deleteImage: (image) {
                checkOutFormProvider.deleteHeadLightsImage(image);
              },
              comments: checkOutFormProvider.headLightsComments,
              report: checkOutFormProvider.headLights,
              updateReport: (report) {
                checkOutFormProvider.updateHeadLights(report);
              },
            ),
            Divider(
              height: 4,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: FlutterFlowTheme.of(context).grayLighter,
            ),

            // GSGS243
            ItemForm(
              textItem: "GSGS243", 
              onPressed: () {

              }, 
              isRight: false,
              readOnly: false,
              images: checkOutFormProvider.brakeLightsImages,
              addImage: (image) {
                checkOutFormProvider.addBrakeLightsImage(image);
              },
              deleteImage: (image) {
                checkOutFormProvider.deleteBrakeLightsImage(image);
              },
              comments: checkOutFormProvider.brakeLightsComments,
              report: checkOutFormProvider.brakeLights,
              updateReport: (report) {
                checkOutFormProvider.updateBrakeLights(report);
              }
            ),
            Divider(
              height: 4,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: FlutterFlowTheme.of(context).grayLighter,
            ),

            // HSG4GS5
            ItemForm(
              textItem: "HSG4GS5", 
              onPressed: () {

              }, 
              isRight: false,
              readOnly: false,
              images: checkOutFormProvider.headLightsImages,
              addImage: (image) {
                checkOutFormProvider.addHeadLightsImage(image);
              },
              deleteImage: (image) {
                checkOutFormProvider.deleteHeadLightsImage(image);
              },
              comments: checkOutFormProvider.headLightsComments,
              report: checkOutFormProvider.headLights,
              updateReport: (report) {
                checkOutFormProvider.updateHeadLights(report);
              },
            ),
            Divider(
              height: 4,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: FlutterFlowTheme.of(context).grayLighter,
            ),

            // GSGS243
            ItemForm(
              textItem: "GSGS243", 
              onPressed: () {

              }, 
              isRight: false,
              readOnly: false,
              images: checkOutFormProvider.brakeLightsImages,
              addImage: (image) {
                checkOutFormProvider.addBrakeLightsImage(image);
              },
              deleteImage: (image) {
                checkOutFormProvider.deleteBrakeLightsImage(image);
              },
              comments: checkOutFormProvider.brakeLightsComments,
              report: checkOutFormProvider.brakeLights,
              updateReport: (report) {
                checkOutFormProvider.updateBrakeLights(report);
              }
            ),
            Divider(
              height: 4,
              thickness: 4,
              indent: 20,
              endIndent: 20,
              color: FlutterFlowTheme.of(context).grayLighter,
            ),
        ]),
      ),
    );
  }
}
