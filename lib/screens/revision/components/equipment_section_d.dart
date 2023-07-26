import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:fleet_management_tool_rta/flutter_flow/flutter_flow_theme.dart';
import 'package:fleet_management_tool_rta/providers/database_providers/checkin_form_controller.dart';
import 'package:fleet_management_tool_rta/screens/control_form/flutter_flow_animaciones.dart';
import 'package:fleet_management_tool_rta/screens/revision/components/header_shimmer.dart';
import 'package:fleet_management_tool_rta/screens/revision/components/item_form.dart';

class EquipmentSectionD extends StatefulWidget {
  
  const EquipmentSectionD({super.key});

  @override
  State<EquipmentSectionD> createState() => _EquipmentSectionDState();
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
          begin: const Offset(1, 0),
          end:  const Offset(1, 0),
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
          begin: const Offset(1, 0),
          end:  const Offset(1, 0),
        ),
      ],
    ),
  };

class _EquipmentSectionDState extends State<EquipmentSectionD> {
  @override
  Widget build(BuildContext context) {
    final checkInFormProvider = Provider.of<CheckInFormController>(context);
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
                  text: "Equipment needed for installers",
                ),
                // Ignition Key
                ItemForm(
                  textItem: "Ignition Key",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.ignitionKeyImages,
                  addImage: (image) {
                    checkInFormProvider.addIgnitionKeyImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteIgnitionKeyImage(image);
                  },
                  comments: checkInFormProvider.ignitionKeyComments,
                  report: checkInFormProvider.ignitionKey,
                  updateReport: (report) {
                    checkInFormProvider.updateIgnitionKey(report);
                  },
                  reportYesNo: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Bins/Box Key(s)
                ItemForm(
                  textItem: "Bins/Box Key(s)",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.binsBoxKeyImages,
                  addImage: (image) {
                    checkInFormProvider.addBinsBoxKeyImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteBinsBoxKeyImage(image);
                  },
                  comments: checkInFormProvider.binsBoxKeyComments,
                  report: checkInFormProvider.binsBoxKey,
                  updateReport: (report) {
                    checkInFormProvider.updateBinsBoxKey(report);
                  },
                  reportYesNo: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Vehicle Registration Copy (Glovebox)
                ItemForm(
                  textItem: "Vehicle Registration Copy (Glovebox)",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.vehicleRegistrationCopyImages,
                  addImage: (image) {
                    checkInFormProvider.addVehicleRegistrationCopyImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteVehicleRegistrationCopyImage(image);
                  },
                  comments: checkInFormProvider.vehicleRegistrationCopyComments,
                  report: checkInFormProvider.vehicleRegistrationCopy,
                  updateReport: (report) {
                    checkInFormProvider.updateVehicleRegistrationCopy(report);
                  },
                  reportYesNo: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Vehicle Insurance Copy (Glovebox)
                ItemForm(
                  textItem: "Vehicle Insurance Copy (Glovebox)",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.vehicleInsuranceCopyImages,
                  addImage: (image) {
                    checkInFormProvider.addVehicleInsuranceCopyImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteVehicleInsuranceCopyImage(image);
                  },
                  comments: checkInFormProvider.vehicleInsuranceCopyComments,
                  report: checkInFormProvider.vehicleInsuranceCopy,
                  updateReport: (report) {
                    checkInFormProvider.updateVehicleInsuranceCopy(report);
                  },
                  reportYesNo: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Bucket / Lift Operator Manual
                ItemForm(
                  textItem: "Bucket / Lift Operator Manual",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.bucketLiftOperatorManualImages,
                  addImage: (image) {
                    checkInFormProvider.addBucketLiftOperatorManualImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteBucketLiftOperatorManualImage(image);
                  },
                  comments: checkInFormProvider.bucketLiftOperatorManualComments,
                  report: checkInFormProvider.bucketLiftOperatorManual,
                  updateReport: (report) {
                    checkInFormProvider.updateBucketLiftOperatorManual(report);
                  },
                  reportYesNo: true,
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
                  text: "Bucket Inspection",
                ),
                // Insulated
                ItemForm(
                  textItem: "Insulated",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.insulatedImages,
                  addImage: (image) {
                    checkInFormProvider.addInsulatedImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteInsulatedImage(image);
                  },
                  comments: checkInFormProvider.insulatedComments,
                  report: checkInFormProvider.insulated,
                  updateReport: (report) {
                    checkInFormProvider.updateInsulated(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearInsulated();
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Holes Drilled
                ItemForm(
                  textItem: "Holes Drilled",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.holesDrilledImages,
                  addImage: (image) {
                    checkInFormProvider.addHolesDrilledImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteHolesDrilledImage(image);
                  },
                  comments: checkInFormProvider.holesDrilledComments,
                  report: checkInFormProvider.holesDrilled,
                  updateReport: (report) {
                    checkInFormProvider.updateHolesDrilled(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearHolesDrilled();
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Bucket liner
                ItemForm(
                  textItem: "Bucker Liner",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.bucketLinerImages,
                  addImage: (image) {
                    checkInFormProvider.addBucketLinerImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteBucketLinerImage(image);
                  },
                  comments: checkInFormProvider.bucketLinerComments,
                  report: checkInFormProvider.bucketLiner,
                  updateReport: (report) {
                    checkInFormProvider.updateBucketLiner(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearBucketLiner();
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
