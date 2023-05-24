import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/delivery_form_controller.dart';
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
                  text: "Equipment needed for installers",
                ),
                // Ignition Key
                ItemForm(
                  textItem: "Ignition Key",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.ignitionKeyImages,
                  addImage: (image) {
                    deliveryFormProvider.addIgnitionKeyImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateIgnitionKeyImage(image);
                  },
                  comments: deliveryFormProvider.ignitionKeyComments,
                  report: deliveryFormProvider.ignitionKey,
                  updateReport: (report) {
                    deliveryFormProvider.updateIgnitionKey(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.binsBoxKeyImages,
                  addImage: (image) {
                    deliveryFormProvider.addBinsBoxKeyImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateBinsBoxKeyImage(image);
                  },
                  comments: deliveryFormProvider.binsBoxKeyComments,
                  report: deliveryFormProvider.binsBoxKey,
                  updateReport: (report) {
                    deliveryFormProvider.updateBinsBoxKey(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.vehicleRegistrationCopyImages,
                  addImage: (image) {
                    deliveryFormProvider.addVehicleRegistrationCopyImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateVehicleRegistrationCopyImage(image);
                  },
                  comments: deliveryFormProvider.vehicleRegistrationCopyComments,
                  report: deliveryFormProvider.vehicleRegistrationCopy,
                  updateReport: (report) {
                    deliveryFormProvider.updateVehicleRegistrationCopy(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.vehicleInsuranceCopyImages,
                  addImage: (image) {
                    deliveryFormProvider.addVehicleInsuranceCopyImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateVehicleInsuranceCopyImage(image);
                  },
                  comments: deliveryFormProvider.vehicleInsuranceCopyComments,
                  report: deliveryFormProvider.vehicleInsuranceCopy,
                  updateReport: (report) {
                    deliveryFormProvider.updateVehicleInsuranceCopy(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.bucketLiftOperatorManualImages,
                  addImage: (image) {
                    deliveryFormProvider.addBucketLiftOperatorManualImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateBucketLiftOperatorManualImage(image);
                  },
                  comments: deliveryFormProvider.bucketLiftOperatorManualComments,
                  report: deliveryFormProvider.bucketLiftOperatorManual,
                  updateReport: (report) {
                    deliveryFormProvider.updateBucketLiftOperatorManual(report);
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
