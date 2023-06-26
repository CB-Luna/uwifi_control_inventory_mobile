import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/checkout_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class FluidsSectionR extends StatefulWidget {
  
  const FluidsSectionR({super.key});

  @override
  State<FluidsSectionR> createState() => _FluidsSectionRState();
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

class _FluidsSectionRState extends State<FluidsSectionR> {
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
                  text: "Fluids Check",
                ),
                // Engine Oil
                ItemForm(
                  textItem: "Engine Oil",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkOutFormProvider.engineOilImages,
                  addImage: (image) {
                    checkOutFormProvider.addEngineOilImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateEngineOilImage(image);
                  },
                  comments: checkOutFormProvider.engineOilComments,
                  report: checkOutFormProvider.engineOil,
                  updateReport: (report) {
                    checkOutFormProvider.updateEngineOil(report);
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
                  images: checkOutFormProvider.transmissionImages,
                  addImage: (image) {
                    checkOutFormProvider.addTransmissionImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateTransmissionImage(image);
                  },
                  comments: checkOutFormProvider.transmissionComments,
                  report: checkOutFormProvider.transmission,
                  updateReport: (report) {
                    checkOutFormProvider.updateTransmission(report);
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
                  images: checkOutFormProvider.coolantImages,
                  addImage: (image) {
                    checkOutFormProvider.addCoolantImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateCoolantImage(image);
                  },
                  comments: checkOutFormProvider.coolantComments,
                  report: checkOutFormProvider.coolant,
                  updateReport: (report) {
                    checkOutFormProvider.updateCoolant(report);
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
                  images: checkOutFormProvider.powerSteeringImages,
                  addImage: (image) {
                    checkOutFormProvider.addPowerSteeringImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updatePowerSteeringImage(image);
                  },
                  comments: checkOutFormProvider.powerSteeringComments,
                  report: checkOutFormProvider.powerSteering,
                  updateReport: (report) {
                    checkOutFormProvider.updatePowerSteering(report);
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
                  images: checkOutFormProvider.dieselExhaustFluidImages,
                  addImage: (image) {
                    checkOutFormProvider.addDieselExhaustFluidImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateDieselExhaustFluidImage(image);
                  },
                  comments: checkOutFormProvider.dieselExhaustFluidComments,
                  report: checkOutFormProvider.dieselExhaustFluid,
                  updateReport: (report) {
                    checkOutFormProvider.updateDieselExhaustFluid(report);
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
                  images: checkOutFormProvider.windshieldWasherFluidImages,
                  addImage: (image) {
                    checkOutFormProvider.addWindshieldWasherFluidImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateWindshieldWasherFluidImage(image);
                  },
                  comments: checkOutFormProvider.windshieldWasherFluidComments,
                  report: checkOutFormProvider.windshieldWasherFluid,
                  updateReport: (report) {
                    checkOutFormProvider.updateWindshieldWasherFluid(report);
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
                  images: checkOutFormProvider.insulatedImages,
                  addImage: (image) {
                    checkOutFormProvider.addInsulatedImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateInsulatedImage(image);
                  },
                  comments: checkOutFormProvider.insulatedComments,
                  report: checkOutFormProvider.insulated,
                  updateReport: (report) {
                    checkOutFormProvider.updateInsulated(report);
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
                  images: checkOutFormProvider.holesDrilledImages,
                  addImage: (image) {
                    checkOutFormProvider.addHolesDrilledImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateHolesDrilledImage(image);
                  },
                  comments: checkOutFormProvider.holesDrilledComments,
                  report: checkOutFormProvider.holesDrilled,
                  updateReport: (report) {
                    checkOutFormProvider.updateHolesDrilled(report);
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
                  images: checkOutFormProvider.bucketLinerImages,
                  addImage: (image) {
                    checkOutFormProvider.addBucketLinerImage(image);
                  },
                  updateImage: (image) {
                    checkOutFormProvider.updateBucketLinerImage(image);
                  },
                  comments: checkOutFormProvider.bucketLinerComments,
                  report: checkOutFormProvider.bucketLiner,
                  updateReport: (report) {
                    checkOutFormProvider.updateBucketLiner(report);
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
