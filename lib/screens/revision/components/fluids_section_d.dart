import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/delivered_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class FluidsSectionD extends StatefulWidget {
  
  const FluidsSectionD({super.key});

  @override
  State<FluidsSectionD> createState() => _FluidsSectionDState();
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

class _FluidsSectionDState extends State<FluidsSectionD> {
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
                  text: "Fluids Check",
                ),
                // Engine Oil
                ItemForm(
                  textItem: "Engine Oil",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.engineOilImages,
                  addImage: (image) {
                    deliveredFormProvider.addEngineOilImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateEngineOilImage(image);
                  },
                  comments: deliveredFormProvider.engineOilComments,
                  report: deliveredFormProvider.engineOil,
                  updateReport: (report) {
                    deliveredFormProvider.updateEngineOil(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Transmission
                ItemForm(
                  textItem: "Transmission",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.transmissionImages,
                  addImage: (image) {
                    deliveredFormProvider.addTransmissionImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateTransmissionImage(image);
                  },
                  comments: deliveredFormProvider.transmissionComments,
                  report: deliveredFormProvider.transmission,
                  updateReport: (report) {
                    deliveredFormProvider.updateTransmission(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Coolant
                ItemForm(
                  textItem: "Coolant",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.coolantImages,
                  addImage: (image) {
                    deliveredFormProvider.addCoolantImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateCoolantImage(image);
                  },
                  comments: deliveredFormProvider.coolantComments,
                  report: deliveredFormProvider.coolant,
                  updateReport: (report) {
                    deliveredFormProvider.updateCoolant(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Power Steering
                ItemForm(
                  textItem: "Power Steering",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.powerSteeringImages,
                  addImage: (image) {
                    deliveredFormProvider.addPowerSteeringImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updatePowerSteeringImage(image);
                  },
                  comments: deliveredFormProvider.powerSteeringComments,
                  report: deliveredFormProvider.powerSteering,
                  updateReport: (report) {
                    deliveredFormProvider.updatePowerSteering(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Diesel Exhaust Fluid
                ItemForm(
                  textItem: "Diesel Exhaust Fluid",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.dieselExhaustFluidImages,
                  addImage: (image) {
                    deliveredFormProvider.addDieselExhaustFluidImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateDieselExhaustFluidImage(image);
                  },
                  comments: deliveredFormProvider.dieselExhaustFluidComments,
                  report: deliveredFormProvider.dieselExhaustFluid,
                  updateReport: (report) {
                    deliveredFormProvider.updateDieselExhaustFluid(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Windshield Washer Fluid
                ItemForm(
                  textItem: "Windshield Washer Fluid",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.windshieldWasherFluidImages,
                  addImage: (image) {
                    deliveredFormProvider.addWindshieldWasherFluidImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateWindshieldWasherFluidImage(image);
                  },
                  comments: deliveredFormProvider.windshieldWasherFluidComments,
                  report: deliveredFormProvider.windshieldWasherFluid,
                  updateReport: (report) {
                    deliveredFormProvider.updateWindshieldWasherFluid(report);
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
                  text: "Bucket Inspection",
                ),
                // Insulated
                ItemForm(
                  textItem: "Insulated",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.insulatedImages,
                  addImage: (image) {
                    deliveredFormProvider.addInsulatedImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateInsulatedImage(image);
                  },
                  comments: deliveredFormProvider.insulatedComments,
                  report: deliveredFormProvider.insulated,
                  updateReport: (report) {
                    deliveredFormProvider.updateInsulated(report);
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
                  images: deliveredFormProvider.holesDrilledImages,
                  addImage: (image) {
                    deliveredFormProvider.addHolesDrilledImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateHolesDrilledImage(image);
                  },
                  comments: deliveredFormProvider.holesDrilledComments,
                  report: deliveredFormProvider.holesDrilled,
                  updateReport: (report) {
                    deliveredFormProvider.updateHolesDrilled(report);
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
                  images: deliveredFormProvider.bucketLinerImages,
                  addImage: (image) {
                    deliveredFormProvider.addBucketLinerImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateBucketLinerImage(image);
                  },
                  comments: deliveredFormProvider.bucketLinerComments,
                  report: deliveredFormProvider.bucketLiner,
                  updateReport: (report) {
                    deliveredFormProvider.updateBucketLiner(report);
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
