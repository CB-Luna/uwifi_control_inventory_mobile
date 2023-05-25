import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/receiving_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class FluidsSection extends StatefulWidget {
  
  const FluidsSection({super.key});

  @override
  State<FluidsSection> createState() => _FluidsSectionState();
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

class _FluidsSectionState extends State<FluidsSection> {
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
                  text: "Fluids Check",
                ),
                // Engine Oil
                ItemForm(
                  textItem: "Engine Oil",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: receivingFormProvider.engineOilImages,
                  addImage: (image) {
                    receivingFormProvider.addEngineOilImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateEngineOilImage(image);
                  },
                  comments: receivingFormProvider.engineOilComments,
                  report: receivingFormProvider.engineOil,
                  updateReport: (report) {
                    receivingFormProvider.updateEngineOil(report);
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
                  images: receivingFormProvider.transmissionImages,
                  addImage: (image) {
                    receivingFormProvider.addTransmissionImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateTransmissionImage(image);
                  },
                  comments: receivingFormProvider.transmissionComments,
                  report: receivingFormProvider.transmission,
                  updateReport: (report) {
                    receivingFormProvider.updateTransmission(report);
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
                  images: receivingFormProvider.coolantImages,
                  addImage: (image) {
                    receivingFormProvider.addCoolantImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateCoolantImage(image);
                  },
                  comments: receivingFormProvider.coolantComments,
                  report: receivingFormProvider.coolant,
                  updateReport: (report) {
                    receivingFormProvider.updateCoolant(report);
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
                  images: receivingFormProvider.powerSteeringImages,
                  addImage: (image) {
                    receivingFormProvider.addPowerSteeringImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updatePowerSteeringImage(image);
                  },
                  comments: receivingFormProvider.powerSteeringComments,
                  report: receivingFormProvider.powerSteering,
                  updateReport: (report) {
                    receivingFormProvider.updatePowerSteering(report);
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
                  images: receivingFormProvider.dieselExhaustFluidImages,
                  addImage: (image) {
                    receivingFormProvider.addDieselExhaustFluidImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateDieselExhaustFluidImage(image);
                  },
                  comments: receivingFormProvider.dieselExhaustFluidComments,
                  report: receivingFormProvider.dieselExhaustFluid,
                  updateReport: (report) {
                    receivingFormProvider.updateDieselExhaustFluid(report);
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
                  images: receivingFormProvider.windshieldWasherFluidImages,
                  addImage: (image) {
                    receivingFormProvider.addWindshieldWasherFluidImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateWindshieldWasherFluidImage(image);
                  },
                  comments: receivingFormProvider.windshieldWasherFluidComments,
                  report: receivingFormProvider.windshieldWasherFluid,
                  updateReport: (report) {
                    receivingFormProvider.updateWindshieldWasherFluid(report);
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
                  images: receivingFormProvider.insulatedImages,
                  addImage: (image) {
                    receivingFormProvider.addInsulatedImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateInsulatedImage(image);
                  },
                  comments: receivingFormProvider.insulatedComments,
                  report: receivingFormProvider.insulated,
                  updateReport: (report) {
                    receivingFormProvider.updateInsulated(report);
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
                  images: receivingFormProvider.holesDrilledImages,
                  addImage: (image) {
                    receivingFormProvider.addHolesDrilledImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateHolesDrilledImage(image);
                  },
                  comments: receivingFormProvider.holesDrilledComments,
                  report: receivingFormProvider.holesDrilled,
                  updateReport: (report) {
                    receivingFormProvider.updateHolesDrilled(report);
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
                  images: receivingFormProvider.bucketLinerImages,
                  addImage: (image) {
                    receivingFormProvider.addBucketLinerImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateBucketLinerImage(image);
                  },
                  comments: receivingFormProvider.bucketLinerComments,
                  report: receivingFormProvider.bucketLiner,
                  updateReport: (report) {
                    receivingFormProvider.updateBucketLiner(report);
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
