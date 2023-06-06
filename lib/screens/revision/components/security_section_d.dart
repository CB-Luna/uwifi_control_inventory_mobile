import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/delivered_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class SecuritySectionD extends StatefulWidget {
  
  const SecuritySectionD({super.key});

  @override
  State<SecuritySectionD> createState() => _SecuritySectionDState();
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

class _SecuritySectionDState extends State<SecuritySectionD> {
  @override
  Widget build(BuildContext context) {
    final deliveredFormProvider = Provider.of<DeliveredFormController>(context);
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
                  readOnly: false,
                  images: deliveredFormProvider.rtaMagnetImages,
                  addImage: (image) {
                    deliveredFormProvider.addRTAMagnetImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateRTAMagnetImage(image);
                  },
                  comments: deliveredFormProvider.rtaMagnetComments,
                  report: deliveredFormProvider.rtaMagnet,
                  updateReport: (report) {
                    deliveredFormProvider.updateRTAMagnet(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.triangleReflectorsImages,
                  addImage: (image) {
                    deliveredFormProvider.addTriangleReflectorsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateTriangleReflectorsImage(image);
                  },
                  comments: deliveredFormProvider.triangleReflectorsComments,
                  report: deliveredFormProvider.triangleReflectors,
                  updateReport: (report) {
                    deliveredFormProvider.updateTriangleReflectors(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.wheelChocksImages,
                  addImage: (image) {
                    deliveredFormProvider.addWheelChocksImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateWheelChocksImage(image);
                  },
                  comments: deliveredFormProvider.wheelChocksComments,
                  report: deliveredFormProvider.wheelChocks,
                  updateReport: (report) {
                    deliveredFormProvider.updateWheelChocks(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.fireExtinguisherImages,
                  addImage: (image) {
                    deliveredFormProvider.addFireExtinguisherImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateFireExtinguisherImage(image);
                  },
                  comments: deliveredFormProvider.fireExtinguisherComments,
                  report: deliveredFormProvider.fireExtinguisher,
                  updateReport: (report) {
                    deliveredFormProvider.updateFireExtinguisher(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.firstAidKitSafetyVestImages,
                  addImage: (image) {
                    deliveredFormProvider.addFirstAidKitSafetyVestImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateFirstAidKitSafetyVestImage(image);
                  },
                  comments: deliveredFormProvider.firstAidKitSafetyVestComments,
                  report: deliveredFormProvider.firstAidKitSafetyVest,
                  updateReport: (report) {
                    deliveredFormProvider.updateFirstAidKitSafetyVest(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.backUpAlarmImages,
                  addImage: (image) {
                    deliveredFormProvider.addBackUpAlarmImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateBackUpAlarmImage(image);
                  },
                  comments: deliveredFormProvider.backUpAlarmComments,
                  report: deliveredFormProvider.backUpAlarm,
                  updateReport: (report) {
                    deliveredFormProvider.updateBackUpAlarm(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.ladderImages,
                  addImage: (image) {
                    deliveredFormProvider.addLadderImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateLadderImage(image);
                  },
                  comments: deliveredFormProvider.ladderComments,
                  report: deliveredFormProvider.ladder,
                  updateReport: (report) {
                    deliveredFormProvider.updateLadder(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.stepLadderImages,
                  addImage: (image) {
                    deliveredFormProvider.addStepLadderImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateStepLadderImage(image);
                  },
                  comments: deliveredFormProvider.stepLadderComments,
                  report: deliveredFormProvider.stepLadder,
                  updateReport: (report) {
                    deliveredFormProvider.updateStepLadder(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.ladderStrapsImages,
                  addImage: (image) {
                    deliveredFormProvider.addLadderStrapsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateLadderStrapsImage(image);
                  },
                  comments: deliveredFormProvider.ladderStrapsComments,
                  report: deliveredFormProvider.ladderStraps,
                  updateReport: (report) {
                    deliveredFormProvider.updateLadderStraps(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.hydraulicFluidForBucketImages,
                  addImage: (image) {
                    deliveredFormProvider.addHydraulicFluidForBucketImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateHydraulicFluidForBucketImage(image);
                  },
                  comments: deliveredFormProvider.hydraulicFluidForBucketComments,
                  report: deliveredFormProvider.hydraulicFluidForBucket,
                  updateReport: (report) {
                    deliveredFormProvider.updateHydraulicFluidForBucket(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.fiberReelRackImages,
                  addImage: (image) {
                    deliveredFormProvider.addFiberReelRackImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateFiberReelRackImage(image);
                  },
                  comments: deliveredFormProvider.fiberReelRackComments,
                  report: deliveredFormProvider.fiberReelRack,
                  updateReport: (report) {
                    deliveredFormProvider.updateFiberReelRack(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.binsLockedAndSecureImages,
                  addImage: (image) {
                    deliveredFormProvider.addBinsLockedAndSecureImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateBinsLockedAndSecureImage(image);
                  },
                  comments: deliveredFormProvider.binsLockedAndSecureComments,
                  report: deliveredFormProvider.binsLockedAndSecure,
                  updateReport: (report) {
                    deliveredFormProvider.updateBinsLockedAndSecure(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.safetyHarnessImages,
                  addImage: (image) {
                    deliveredFormProvider.addSafetyHarnessImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateSafetyHarnessImage(image);
                  },
                  comments: deliveredFormProvider.safetyHarnessComments,
                  report: deliveredFormProvider.safetyHarness,
                  updateReport: (report) {
                    deliveredFormProvider.updateSafetyHarness(report);
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
                  readOnly: false,
                  images: deliveredFormProvider.lanyardSafetyHarnessImages,
                  addImage: (image) {
                    deliveredFormProvider.addLanyardSafetyHarnessImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateLanyardSafetyHarnessImage(image);
                  },
                  comments: deliveredFormProvider.lanyardSafetyHarnessComments,
                  report: deliveredFormProvider.lanyardSafetyHarness,
                  updateReport: (report) {
                    deliveredFormProvider.updateLanyardSafetyHarness(report);
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
