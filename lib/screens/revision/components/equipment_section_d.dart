import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/delivered_form_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/receiving_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

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

class _EquipmentSectionDState extends State<EquipmentSectionD> {
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
                  text: "Equipment needed for installers",
                ),
                // Ignition Key
                ItemForm(
                  textItem: "Ignition Key",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.ignitionKeyImages,
                  addImage: (image) {
                    deliveredFormProvider.addIgnitionKeyImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateIgnitionKeyImage(image);
                  },
                  comments: deliveredFormProvider.ignitionKeyComments,
                  report: deliveredFormProvider.ignitionKey,
                  updateReport: (report) {
                    deliveredFormProvider.updateIgnitionKey(report);
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
                  images: deliveredFormProvider.binsBoxKeyImages,
                  addImage: (image) {
                    deliveredFormProvider.addBinsBoxKeyImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateBinsBoxKeyImage(image);
                  },
                  comments: deliveredFormProvider.binsBoxKeyComments,
                  report: deliveredFormProvider.binsBoxKey,
                  updateReport: (report) {
                    deliveredFormProvider.updateBinsBoxKey(report);
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
                  images: deliveredFormProvider.vehicleRegistrationCopyImages,
                  addImage: (image) {
                    deliveredFormProvider.addVehicleRegistrationCopyImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateVehicleRegistrationCopyImage(image);
                  },
                  comments: deliveredFormProvider.vehicleRegistrationCopyComments,
                  report: deliveredFormProvider.vehicleRegistrationCopy,
                  updateReport: (report) {
                    deliveredFormProvider.updateVehicleRegistrationCopy(report);
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
                  images: deliveredFormProvider.vehicleInsuranceCopyImages,
                  addImage: (image) {
                    deliveredFormProvider.addVehicleInsuranceCopyImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateVehicleInsuranceCopyImage(image);
                  },
                  comments: deliveredFormProvider.vehicleInsuranceCopyComments,
                  report: deliveredFormProvider.vehicleInsuranceCopy,
                  updateReport: (report) {
                    deliveredFormProvider.updateVehicleInsuranceCopy(report);
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
                  images: deliveredFormProvider.bucketLiftOperatorManualImages,
                  addImage: (image) {
                    deliveredFormProvider.addBucketLiftOperatorManualImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateBucketLiftOperatorManualImage(image);
                  },
                  comments: deliveredFormProvider.bucketLiftOperatorManualComments,
                  report: deliveredFormProvider.bucketLiftOperatorManual,
                  updateReport: (report) {
                    deliveredFormProvider.updateBucketLiftOperatorManual(report);
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
