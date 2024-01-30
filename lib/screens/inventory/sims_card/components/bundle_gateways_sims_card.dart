import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/util/animations.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/header_shimmer.dart';

class BundleGatewaysSIMSCard extends StatefulWidget {
  
  const BundleGatewaysSIMSCard({super.key});

  @override
  State<BundleGatewaysSIMSCard> createState() => _BundleGatewaysSIMSCardState();
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

class _BundleGatewaysSIMSCardState extends State<BundleGatewaysSIMSCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            // HEADER
            HeaderShimmer(
              width: MediaQuery.of(context).size.width, 
              text: "Bundle Gateways to SIMS Card",
            ),
            // Searcher
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
               padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
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
                        "Serial No.",
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
                        "Date Created",
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
                        "SIMS Card",
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
            // Container(
            //   height: 400,
            //   clipBehavior: Clip.antiAlias,
            //     decoration: ShapeDecoration(
            //       shape: RoundedRectangleBorder(
            //       side: BorderSide(
            //         width: 2.0,
            //         color: AppTheme.of(context).grayLighter,
            //         ),
            //       borderRadius: BorderRadius.circular(8.0),
            //       ),
            //     ),
            //   child: SingleChildScrollView(
            //     controller: ScrollController(),
            //     child: Padding(
            //       padding: const EdgeInsets.all(5.0),
            //       child: Column(
            //         children: [
            //           // HSG4GS5
            //           ItemFormBundleGatewaySIMSCard(
            //             textItem: "HSG4GS5", 
            //             onPressed: () {
                            
            //             }, 
            //             isRight: false,
            //             readOnly: false,
            //             images: checkOutFormProvider.headLightsImages,
            //             addImage: (image) {
            //               checkOutFormProvider.addHeadLightsImage(image);
            //             },
            //             deleteImage: (image) {
            //               checkOutFormProvider.deleteHeadLightsImage(image);
            //             },
            //             comments: checkOutFormProvider.headLightsComments,
            //             report: checkOutFormProvider.headLights,
            //             updateReport: (report) {
            //               checkOutFormProvider.updateHeadLights(report);
            //             },
            //           ),
            //           Divider(
            //             height: 4,
            //             thickness: 4,
            //             indent: 20,
            //             endIndent: 20,
            //             color: AppTheme.of(context).grayLighter,
            //           ),
                            
            //           // GSGS243
            //           ItemFormBundleGatewaySIMSCard(
            //             textItem: "GSGS243", 
            //             onPressed: () {
                            
            //             }, 
            //             isRight: false,
            //             readOnly: false,
            //             images: checkOutFormProvider.brakeLightsImages,
            //             addImage: (image) {
            //               checkOutFormProvider.addBrakeLightsImage(image);
            //             },
            //             deleteImage: (image) {
            //               checkOutFormProvider.deleteBrakeLightsImage(image);
            //             },
            //             comments: checkOutFormProvider.brakeLightsComments,
            //             report: checkOutFormProvider.brakeLights,
            //             updateReport: (report) {
            //               checkOutFormProvider.updateBrakeLights(report);
            //             }
            //           ),
            //           Divider(
            //             height: 4,
            //             thickness: 4,
            //             indent: 20,
            //             endIndent: 20,
            //             color: AppTheme.of(context).grayLighter,
            //           ),
                            
            //           // HSG4GS5
            //           ItemFormBundleGatewaySIMSCard(
            //             textItem: "HSG4GS5", 
            //             onPressed: () {
                            
            //             }, 
            //             isRight: false,
            //             readOnly: false,
            //             images: checkOutFormProvider.headLightsImages,
            //             addImage: (image) {
            //               checkOutFormProvider.addHeadLightsImage(image);
            //             },
            //             deleteImage: (image) {
            //               checkOutFormProvider.deleteHeadLightsImage(image);
            //             },
            //             comments: checkOutFormProvider.headLightsComments,
            //             report: checkOutFormProvider.headLights,
            //             updateReport: (report) {
            //               checkOutFormProvider.updateHeadLights(report);
            //             },
            //           ),
            //           Divider(
            //             height: 4,
            //             thickness: 4,
            //             indent: 20,
            //             endIndent: 20,
            //             color: AppTheme.of(context).grayLighter,
            //           ),
                            
            //           // GSGS243
            //           ItemFormBundleGatewaySIMSCard(
            //             textItem: "GSGS243", 
            //             onPressed: () {
                            
            //             }, 
            //             isRight: false,
            //             readOnly: false,
            //             images: checkOutFormProvider.brakeLightsImages,
            //             addImage: (image) {
            //               checkOutFormProvider.addBrakeLightsImage(image);
            //             },
            //             deleteImage: (image) {
            //               checkOutFormProvider.deleteBrakeLightsImage(image);
            //             },
            //             comments: checkOutFormProvider.brakeLightsComments,
            //             report: checkOutFormProvider.brakeLights,
            //             updateReport: (report) {
            //               checkOutFormProvider.updateBrakeLights(report);
            //             }
            //           ),
            //           Divider(
            //             height: 4,
            //             thickness: 4,
            //             indent: 20,
            //             endIndent: 20,
            //             color: AppTheme.of(context).grayLighter,
            //           ),
                            
            //           // HSG4GS5
            //           ItemFormBundleGatewaySIMSCard(
            //             textItem: "HSG4GS5", 
            //             onPressed: () {
                            
            //             }, 
            //             isRight: false,
            //             readOnly: false,
            //             images: checkOutFormProvider.headLightsImages,
            //             addImage: (image) {
            //               checkOutFormProvider.addHeadLightsImage(image);
            //             },
            //             deleteImage: (image) {
            //               checkOutFormProvider.deleteHeadLightsImage(image);
            //             },
            //             comments: checkOutFormProvider.headLightsComments,
            //             report: checkOutFormProvider.headLights,
            //             updateReport: (report) {
            //               checkOutFormProvider.updateHeadLights(report);
            //             },
            //           ),
            //           Divider(
            //             height: 4,
            //             thickness: 4,
            //             indent: 20,
            //             endIndent: 20,
            //             color: AppTheme.of(context).grayLighter,
            //           ),
                            
            //           // GSGS243
            //           ItemFormBundleGatewaySIMSCard(
            //             textItem: "GSGS243", 
            //             onPressed: () {
                            
            //             }, 
            //             isRight: false,
            //             readOnly: false,
            //             images: checkOutFormProvider.brakeLightsImages,
            //             addImage: (image) {
            //               checkOutFormProvider.addBrakeLightsImage(image);
            //             },
            //             deleteImage: (image) {
            //               checkOutFormProvider.deleteBrakeLightsImage(image);
            //             },
            //             comments: checkOutFormProvider.brakeLightsComments,
            //             report: checkOutFormProvider.brakeLights,
            //             updateReport: (report) {
            //               checkOutFormProvider.updateBrakeLights(report);
            //             }
            //           ),
            //           Divider(
            //             height: 4,
            //             thickness: 4,
            //             indent: 20,
            //             endIndent: 20,
            //             color: AppTheme.of(context).grayLighter,
            //           ),
                            
            //           // HSG4GS5
            //           ItemFormBundleGatewaySIMSCard(
            //             textItem: "HSG4GS5", 
            //             onPressed: () {
                            
            //             }, 
            //             isRight: false,
            //             readOnly: false,
            //             images: checkOutFormProvider.headLightsImages,
            //             addImage: (image) {
            //               checkOutFormProvider.addHeadLightsImage(image);
            //             },
            //             deleteImage: (image) {
            //               checkOutFormProvider.deleteHeadLightsImage(image);
            //             },
            //             comments: checkOutFormProvider.headLightsComments,
            //             report: checkOutFormProvider.headLights,
            //             updateReport: (report) {
            //               checkOutFormProvider.updateHeadLights(report);
            //             },
            //           ),
            //           Divider(
            //             height: 4,
            //             thickness: 4,
            //             indent: 20,
            //             endIndent: 20,
            //             color: AppTheme.of(context).grayLighter,
            //           ),
                            
            //           // GSGS243
            //           ItemFormBundleGatewaySIMSCard(
            //             textItem: "GSGS243", 
            //             onPressed: () {
                            
            //             }, 
            //             isRight: false,
            //             readOnly: false,
            //             images: checkOutFormProvider.brakeLightsImages,
            //             addImage: (image) {
            //               checkOutFormProvider.addBrakeLightsImage(image);
            //             },
            //             deleteImage: (image) {
            //               checkOutFormProvider.deleteBrakeLightsImage(image);
            //             },
            //             comments: checkOutFormProvider.brakeLightsComments,
            //             report: checkOutFormProvider.brakeLights,
            //             updateReport: (report) {
            //               checkOutFormProvider.updateBrakeLights(report);
            //             }
            //           ),
            //           Divider(
            //             height: 4,
            //             thickness: 4,
            //             indent: 20,
            //             endIndent: 20,
            //             color: AppTheme.of(context).grayLighter,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
        ]),
      ),
    );
  }
}
