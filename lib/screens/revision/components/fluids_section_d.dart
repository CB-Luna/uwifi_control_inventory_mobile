import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/checkin_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
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
                  text: "Fluids Check",
                ),
                // Engine Oil
                ItemForm(
                  textItem: "Engine Oil",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.engineOilImages,
                  addImage: (image) {
                    checkInFormProvider.addEngineOilImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateEngineOilImage(image);
                  },
                  comments: checkInFormProvider.engineOilComments,
                  report: checkInFormProvider.engineOil,
                  updateReport: (report) {
                    checkInFormProvider.updateEngineOil(report);
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
                  images: checkInFormProvider.transmissionImages,
                  addImage: (image) {
                    checkInFormProvider.addTransmissionImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateTransmissionImage(image);
                  },
                  comments: checkInFormProvider.transmissionComments,
                  report: checkInFormProvider.transmission,
                  updateReport: (report) {
                    checkInFormProvider.updateTransmission(report);
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
                  images: checkInFormProvider.coolantImages,
                  addImage: (image) {
                    checkInFormProvider.addCoolantImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateCoolantImage(image);
                  },
                  comments: checkInFormProvider.coolantComments,
                  report: checkInFormProvider.coolant,
                  updateReport: (report) {
                    checkInFormProvider.updateCoolant(report);
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
                  images: checkInFormProvider.powerSteeringImages,
                  addImage: (image) {
                    checkInFormProvider.addPowerSteeringImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updatePowerSteeringImage(image);
                  },
                  comments: checkInFormProvider.powerSteeringComments,
                  report: checkInFormProvider.powerSteering,
                  updateReport: (report) {
                    checkInFormProvider.updatePowerSteering(report);
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
                  images: checkInFormProvider.dieselExhaustFluidImages,
                  addImage: (image) {
                    checkInFormProvider.addDieselExhaustFluidImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateDieselExhaustFluidImage(image);
                  },
                  comments: checkInFormProvider.dieselExhaustFluidComments,
                  report: checkInFormProvider.dieselExhaustFluid,
                  updateReport: (report) {
                    checkInFormProvider.updateDieselExhaustFluid(report);
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
                  images: checkInFormProvider.windshieldWasherFluidImages,
                  addImage: (image) {
                    checkInFormProvider.addWindshieldWasherFluidImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateWindshieldWasherFluidImage(image);
                  },
                  comments: checkInFormProvider.windshieldWasherFluidComments,
                  report: checkInFormProvider.windshieldWasherFluid,
                  updateReport: (report) {
                    checkInFormProvider.updateWindshieldWasherFluid(report);
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
                  images: checkInFormProvider.insulatedImages,
                  addImage: (image) {
                    checkInFormProvider.addInsulatedImage(image);
                  },
                  updateImage: (image) {
                    checkInFormProvider.updateInsulatedImage(image);
                  },
                  comments: checkInFormProvider.insulatedComments,
                  report: checkInFormProvider.insulated,
                  updateReport: (report) {
                    checkInFormProvider.updateInsulated(report);
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
                  updateImage: (image) {
                    checkInFormProvider.updateHolesDrilledImage(image);
                  },
                  comments: checkInFormProvider.holesDrilledComments,
                  report: checkInFormProvider.holesDrilled,
                  updateReport: (report) {
                    checkInFormProvider.updateHolesDrilled(report);
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
                  updateImage: (image) {
                    checkInFormProvider.updateBucketLinerImage(image);
                  },
                  comments: checkInFormProvider.bucketLinerComments,
                  report: checkInFormProvider.bucketLiner,
                  updateReport: (report) {
                    checkInFormProvider.updateBucketLiner(report);
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
