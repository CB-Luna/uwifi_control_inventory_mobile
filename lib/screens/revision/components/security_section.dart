import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/delivery_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class SecuritySection extends StatefulWidget {
  
  const SecuritySection({super.key});

  @override
  State<SecuritySection> createState() => _SecuritySectionState();
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
          begin: 1,
          end: 1,
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
          begin: 1,
          end: 1,
        ),
      ],
    ),
  };

class _SecuritySectionState extends State<SecuritySection> {
  @override
  Widget build(BuildContext context) {
    final deliveryFormProvider = Provider.of<DeliveryFormController>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              children: [
                // HEADER
                HeaderShimmer(
                  width: MediaQuery.of(context).size.width, 
                  text: "Security",
                ),
                // RTA Magnet
                ItemForm(
                  textItem: "RTA Magnet",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.rtaMagnetImages,
                  addImage: (image) {
                    deliveryFormProvider.addRTAMagnetImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateRTAMagnetImage(image);
                  },
                  comments: deliveryFormProvider.rtaMagnetComments,
                  report: deliveryFormProvider.rtaMagnet,
                  updateReport: (report) {
                    deliveryFormProvider.updateRTAMagnet(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Triangle Reflectors
                ItemForm(
                  textItem: "Triangle Reflectors",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.triangleReflectorsImages,
                  addImage: (image) {
                    deliveryFormProvider.addTriangleReflectorsImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateTriangleReflectorsImage(image);
                  },
                  comments: deliveryFormProvider.triangleReflectorsComments,
                  report: deliveryFormProvider.triangleReflectors,
                  updateReport: (report) {
                    deliveryFormProvider.updateTriangleReflectors(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Wheel Chocks
                ItemForm(
                  textItem: "Wheel Chocks",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.wheelChocksImages,
                  addImage: (image) {
                    deliveryFormProvider.addWheelChocksImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateWheelChocksImage(image);
                  },
                  comments: deliveryFormProvider.wheelChocksComments,
                  report: deliveryFormProvider.wheelChocks,
                  updateReport: (report) {
                    deliveryFormProvider.updateWheelChocks(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Fire Extinguisher
                ItemForm(
                  textItem: "Fire Extinguisher",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.fireExtinguisherImages,
                  addImage: (image) {
                    deliveryFormProvider.addFireExtinguisherImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateFireExtinguisherImage(image);
                  },
                  comments: deliveryFormProvider.fireExtinguisherComments,
                  report: deliveryFormProvider.fireExtinguisher,
                  updateReport: (report) {
                    deliveryFormProvider.updateFireExtinguisher(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // First Ait Kit Safesty Vest
                ItemForm(
                  textItem: "First Ait Kit Safesty Vest",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.firstAidKitSafetyVestImages,
                  addImage: (image) {
                    deliveryFormProvider.addFirstAidKitSafetyVestImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateFirstAidKitSafetyVestImage(image);
                  },
                  comments: deliveryFormProvider.firstAidKitSafetyVestComments,
                  report: deliveryFormProvider.firstAidKitSafetyVest,
                  updateReport: (report) {
                    deliveryFormProvider.updateFirstAidKitSafetyVest(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Back Up Alarm
                ItemForm(
                  textItem: "Back Up Alarm",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.backUpAlarmImages,
                  addImage: (image) {
                    deliveryFormProvider.addBackUpAlarmImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateBackUpAlarmImage(image);
                  },
                  comments: deliveryFormProvider.backUpAlarmComments,
                  report: deliveryFormProvider.backUpAlarm,
                  updateReport: (report) {
                    deliveryFormProvider.updateBackUpAlarm(report);
                  },
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

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              children: [
                // HEADER
                HeaderShimmer(
                  width: MediaQuery.of(context).size.width, 
                  text: "Extra",
                ),
                // Ladder
                ItemForm(
                  textItem: "Ladder",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.ladderImages,
                  addImage: (image) {
                    deliveryFormProvider.addLadderImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateLadderImage(image);
                  },
                  comments: deliveryFormProvider.ladderComments,
                  report: deliveryFormProvider.ladder,
                  updateReport: (report) {
                    deliveryFormProvider.updateLadder(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Step Ladder
                ItemForm(
                  textItem: "Step Ladder",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.stepLadderImages,
                  addImage: (image) {
                    deliveryFormProvider.addStepLadderImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateStepLadderImage(image);
                  },
                  comments: deliveryFormProvider.stepLadderComments,
                  report: deliveryFormProvider.stepLadder,
                  updateReport: (report) {
                    deliveryFormProvider.updateStepLadder(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Ladder Straps (J-hook)
                ItemForm(
                  textItem: "Ladder Straps",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.ladderStrapsImages,
                  addImage: (image) {
                    deliveryFormProvider.addLadderStrapsImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateLadderStrapsImage(image);
                  },
                  comments: deliveryFormProvider.ladderStrapsComments,
                  report: deliveryFormProvider.ladderStraps,
                  updateReport: (report) {
                    deliveryFormProvider.updateLadderStraps(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Hydraulic Fluid For Bucket
                ItemForm(
                  textItem: "Hydraulic Fluid For Bucket",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.hydraulicFluidForBucketImages,
                  addImage: (image) {
                    deliveryFormProvider.addHydraulicFluidForBucketImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateHydraulicFluidForBucketImage(image);
                  },
                  comments: deliveryFormProvider.hydraulicFluidForBucketComments,
                  report: deliveryFormProvider.hydraulicFluidForBucket,
                  updateReport: (report) {
                    deliveryFormProvider.updateHydraulicFluidForBucket(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Fiber Reel Rack	
                ItemForm(
                  textItem: "Fiber Reel Rack",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.fiberReelRackImages,
                  addImage: (image) {
                    deliveryFormProvider.addFiberReelRackImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateFiberReelRackImage(image);
                  },
                  comments: deliveryFormProvider.fiberReelRackComments,
                  report: deliveryFormProvider.fiberReelRack,
                  updateReport: (report) {
                    deliveryFormProvider.updateFiberReelRack(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                //Bins Locked And Secure
                ItemForm(
                  textItem: "Bins Locked And Secure",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.binsLockedAndSecureImages,
                  addImage: (image) {
                    deliveryFormProvider.addBinsLockedAndSecureImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateBinsLockedAndSecureImage(image);
                  },
                  comments: deliveryFormProvider.binsLockedAndSecureComments,
                  report: deliveryFormProvider.binsLockedAndSecure,
                  updateReport: (report) {
                    deliveryFormProvider.updateBinsLockedAndSecure(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Safety Harness
                ItemForm(
                  textItem: "Safety Harness",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.safetyHarnessImages,
                  addImage: (image) {
                    deliveryFormProvider.addSafetyHarnessImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateSafetyHarnessImage(image);
                  },
                  comments: deliveryFormProvider.safetyHarnessComments,
                  report: deliveryFormProvider.safetyHarness,
                  updateReport: (report) {
                    deliveryFormProvider.updateSafetyHarness(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Lanyard Safety Harness
                ItemForm(
                  textItem: "Layard Safety Harness",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.lanyardSafetyHarnessImages,
                  addImage: (image) {
                    deliveryFormProvider.addLanyardSafetyHarnessImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateLanyardSafetyHarnessImage(image);
                  },
                  comments: deliveryFormProvider.lanyardSafetyHarnessComments,
                  report: deliveryFormProvider.lanyardSafetyHarness,
                  updateReport: (report) {
                    deliveryFormProvider.updateLanyardSafetyHarness(report);
                  },
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

        ],
      ),
    );
  }
}
