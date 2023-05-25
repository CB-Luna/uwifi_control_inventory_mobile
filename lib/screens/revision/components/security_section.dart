import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/receiving_form_controller.dart';
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
    final receivingFormProvider = Provider.of<ReceivingFormController>(context);
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
                  images: receivingFormProvider.rtaMagnetImages,
                  addImage: (image) {
                    receivingFormProvider.addRTAMagnetImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateRTAMagnetImage(image);
                  },
                  comments: receivingFormProvider.rtaMagnetComments,
                  report: receivingFormProvider.rtaMagnet,
                  updateReport: (report) {
                    receivingFormProvider.updateRTAMagnet(report);
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
                  images: receivingFormProvider.triangleReflectorsImages,
                  addImage: (image) {
                    receivingFormProvider.addTriangleReflectorsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateTriangleReflectorsImage(image);
                  },
                  comments: receivingFormProvider.triangleReflectorsComments,
                  report: receivingFormProvider.triangleReflectors,
                  updateReport: (report) {
                    receivingFormProvider.updateTriangleReflectors(report);
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
                  images: receivingFormProvider.wheelChocksImages,
                  addImage: (image) {
                    receivingFormProvider.addWheelChocksImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateWheelChocksImage(image);
                  },
                  comments: receivingFormProvider.wheelChocksComments,
                  report: receivingFormProvider.wheelChocks,
                  updateReport: (report) {
                    receivingFormProvider.updateWheelChocks(report);
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
                  images: receivingFormProvider.fireExtinguisherImages,
                  addImage: (image) {
                    receivingFormProvider.addFireExtinguisherImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateFireExtinguisherImage(image);
                  },
                  comments: receivingFormProvider.fireExtinguisherComments,
                  report: receivingFormProvider.fireExtinguisher,
                  updateReport: (report) {
                    receivingFormProvider.updateFireExtinguisher(report);
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
                  images: receivingFormProvider.firstAidKitSafetyVestImages,
                  addImage: (image) {
                    receivingFormProvider.addFirstAidKitSafetyVestImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateFirstAidKitSafetyVestImage(image);
                  },
                  comments: receivingFormProvider.firstAidKitSafetyVestComments,
                  report: receivingFormProvider.firstAidKitSafetyVest,
                  updateReport: (report) {
                    receivingFormProvider.updateFirstAidKitSafetyVest(report);
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
                  images: receivingFormProvider.backUpAlarmImages,
                  addImage: (image) {
                    receivingFormProvider.addBackUpAlarmImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateBackUpAlarmImage(image);
                  },
                  comments: receivingFormProvider.backUpAlarmComments,
                  report: receivingFormProvider.backUpAlarm,
                  updateReport: (report) {
                    receivingFormProvider.updateBackUpAlarm(report);
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
                  images: receivingFormProvider.ladderImages,
                  addImage: (image) {
                    receivingFormProvider.addLadderImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateLadderImage(image);
                  },
                  comments: receivingFormProvider.ladderComments,
                  report: receivingFormProvider.ladder,
                  updateReport: (report) {
                    receivingFormProvider.updateLadder(report);
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
                  images: receivingFormProvider.stepLadderImages,
                  addImage: (image) {
                    receivingFormProvider.addStepLadderImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateStepLadderImage(image);
                  },
                  comments: receivingFormProvider.stepLadderComments,
                  report: receivingFormProvider.stepLadder,
                  updateReport: (report) {
                    receivingFormProvider.updateStepLadder(report);
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
                  images: receivingFormProvider.ladderStrapsImages,
                  addImage: (image) {
                    receivingFormProvider.addLadderStrapsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateLadderStrapsImage(image);
                  },
                  comments: receivingFormProvider.ladderStrapsComments,
                  report: receivingFormProvider.ladderStraps,
                  updateReport: (report) {
                    receivingFormProvider.updateLadderStraps(report);
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
                  images: receivingFormProvider.hydraulicFluidForBucketImages,
                  addImage: (image) {
                    receivingFormProvider.addHydraulicFluidForBucketImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateHydraulicFluidForBucketImage(image);
                  },
                  comments: receivingFormProvider.hydraulicFluidForBucketComments,
                  report: receivingFormProvider.hydraulicFluidForBucket,
                  updateReport: (report) {
                    receivingFormProvider.updateHydraulicFluidForBucket(report);
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
                  images: receivingFormProvider.fiberReelRackImages,
                  addImage: (image) {
                    receivingFormProvider.addFiberReelRackImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateFiberReelRackImage(image);
                  },
                  comments: receivingFormProvider.fiberReelRackComments,
                  report: receivingFormProvider.fiberReelRack,
                  updateReport: (report) {
                    receivingFormProvider.updateFiberReelRack(report);
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
                  images: receivingFormProvider.binsLockedAndSecureImages,
                  addImage: (image) {
                    receivingFormProvider.addBinsLockedAndSecureImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateBinsLockedAndSecureImage(image);
                  },
                  comments: receivingFormProvider.binsLockedAndSecureComments,
                  report: receivingFormProvider.binsLockedAndSecure,
                  updateReport: (report) {
                    receivingFormProvider.updateBinsLockedAndSecure(report);
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
                  images: receivingFormProvider.safetyHarnessImages,
                  addImage: (image) {
                    receivingFormProvider.addSafetyHarnessImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateSafetyHarnessImage(image);
                  },
                  comments: receivingFormProvider.safetyHarnessComments,
                  report: receivingFormProvider.safetyHarness,
                  updateReport: (report) {
                    receivingFormProvider.updateSafetyHarness(report);
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
                  images: receivingFormProvider.lanyardSafetyHarnessImages,
                  addImage: (image) {
                    receivingFormProvider.addLanyardSafetyHarnessImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateLanyardSafetyHarnessImage(image);
                  },
                  comments: receivingFormProvider.lanyardSafetyHarnessComments,
                  report: receivingFormProvider.lanyardSafetyHarness,
                  updateReport: (report) {
                    receivingFormProvider.updateLanyardSafetyHarness(report);
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
