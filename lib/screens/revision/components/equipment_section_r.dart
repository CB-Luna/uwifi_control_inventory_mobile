import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/checkout_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class EquipmentSectionR extends StatefulWidget {
  
  const EquipmentSectionR({super.key});

  @override
  State<EquipmentSectionR> createState() => _EquipmentSectionRState();
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

class _EquipmentSectionRState extends State<EquipmentSectionR> {
  @override
  Widget build(BuildContext context) {
    final checkOutFormProvider = Provider.of<CheckOutFormController>(context);
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
                  images: checkOutFormProvider.ignitionKeyImages,
                  addImage: (image) {
                    checkOutFormProvider.addIgnitionKeyImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateIgnitionKeyImage(image);
                  },
                  comments: checkOutFormProvider.ignitionKeyComments,
                  report: checkOutFormProvider.ignitionKey,
                  updateReport: (report) {
                    checkOutFormProvider.updateIgnitionKey(report);
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
                  images: checkOutFormProvider.binsBoxKeyImages,
                  addImage: (image) {
                    checkOutFormProvider.addBinsBoxKeyImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateBinsBoxKeyImage(image);
                  },
                  comments: checkOutFormProvider.binsBoxKeyComments,
                  report: checkOutFormProvider.binsBoxKey,
                  updateReport: (report) {
                    checkOutFormProvider.updateBinsBoxKey(report);
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
                  images: checkOutFormProvider.vehicleRegistrationCopyImages,
                  addImage: (image) {
                    checkOutFormProvider.addVehicleRegistrationCopyImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateVehicleRegistrationCopyImage(image);
                  },
                  comments: checkOutFormProvider.vehicleRegistrationCopyComments,
                  report: checkOutFormProvider.vehicleRegistrationCopy,
                  updateReport: (report) {
                    checkOutFormProvider.updateVehicleRegistrationCopy(report);
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
                  images: checkOutFormProvider.vehicleInsuranceCopyImages,
                  addImage: (image) {
                    checkOutFormProvider.addVehicleInsuranceCopyImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateVehicleInsuranceCopyImage(image);
                  },
                  comments: checkOutFormProvider.vehicleInsuranceCopyComments,
                  report: checkOutFormProvider.vehicleInsuranceCopy,
                  updateReport: (report) {
                    checkOutFormProvider.updateVehicleInsuranceCopy(report);
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
                  images: checkOutFormProvider.bucketLiftOperatorManualImages,
                  addImage: (image) {
                    checkOutFormProvider.addBucketLiftOperatorManualImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateBucketLiftOperatorManualImage(image);
                  },
                  comments: checkOutFormProvider.bucketLiftOperatorManualComments,
                  report: checkOutFormProvider.bucketLiftOperatorManual,
                  updateReport: (report) {
                    checkOutFormProvider.updateBucketLiftOperatorManual(report);
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
