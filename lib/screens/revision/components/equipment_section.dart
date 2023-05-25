import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/receiving_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class EquipmentSection extends StatefulWidget {
  
  const EquipmentSection({super.key});

  @override
  State<EquipmentSection> createState() => _EquipmentSectionState();
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

class _EquipmentSectionState extends State<EquipmentSection> {
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
                  text: "Equipment needed for installers",
                ),
                // Ignition Key
                ItemForm(
                  textItem: "Ignition Key",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: receivingFormProvider.ignitionKeyImages,
                  addImage: (image) {
                    receivingFormProvider.addIgnitionKeyImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateIgnitionKeyImage(image);
                  },
                  comments: receivingFormProvider.ignitionKeyComments,
                  report: receivingFormProvider.ignitionKey,
                  updateReport: (report) {
                    receivingFormProvider.updateIgnitionKey(report);
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
                  images: receivingFormProvider.binsBoxKeyImages,
                  addImage: (image) {
                    receivingFormProvider.addBinsBoxKeyImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateBinsBoxKeyImage(image);
                  },
                  comments: receivingFormProvider.binsBoxKeyComments,
                  report: receivingFormProvider.binsBoxKey,
                  updateReport: (report) {
                    receivingFormProvider.updateBinsBoxKey(report);
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
                  images: receivingFormProvider.vehicleRegistrationCopyImages,
                  addImage: (image) {
                    receivingFormProvider.addVehicleRegistrationCopyImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateVehicleRegistrationCopyImage(image);
                  },
                  comments: receivingFormProvider.vehicleRegistrationCopyComments,
                  report: receivingFormProvider.vehicleRegistrationCopy,
                  updateReport: (report) {
                    receivingFormProvider.updateVehicleRegistrationCopy(report);
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
                  images: receivingFormProvider.vehicleInsuranceCopyImages,
                  addImage: (image) {
                    receivingFormProvider.addVehicleInsuranceCopyImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateVehicleInsuranceCopyImage(image);
                  },
                  comments: receivingFormProvider.vehicleInsuranceCopyComments,
                  report: receivingFormProvider.vehicleInsuranceCopy,
                  updateReport: (report) {
                    receivingFormProvider.updateVehicleInsuranceCopy(report);
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
                  images: receivingFormProvider.bucketLiftOperatorManualImages,
                  addImage: (image) {
                    receivingFormProvider.addBucketLiftOperatorManualImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateBucketLiftOperatorManualImage(image);
                  },
                  comments: receivingFormProvider.bucketLiftOperatorManualComments,
                  report: receivingFormProvider.bucketLiftOperatorManual,
                  updateReport: (report) {
                    receivingFormProvider.updateBucketLiftOperatorManual(report);
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
        ],
      ),
    );
  }
}
