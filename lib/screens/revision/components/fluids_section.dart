import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/delivery_form_controller.dart';
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
                  text: "Fluids Check",
                ),
                // Engine Oil
                ItemForm(
                  textItem: "Engine Oil",
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.engineOilImages,
                  addImage: (image) {
                    deliveryFormProvider.addEngineOilImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateEngineOilImage(image);
                  },
                  comments: deliveryFormProvider.engineOilComments,
                  report: deliveryFormProvider.engineOil,
                  updateReport: (report) {
                    deliveryFormProvider.updateEngineOil(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.transmissionImages,
                  addImage: (image) {
                    deliveryFormProvider.addTransmissionImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateTransmissionImage(image);
                  },
                  comments: deliveryFormProvider.transmissionComments,
                  report: deliveryFormProvider.transmission,
                  updateReport: (report) {
                    deliveryFormProvider.updateTransmission(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.coolantImages,
                  addImage: (image) {
                    deliveryFormProvider.addCoolantImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateCoolantImage(image);
                  },
                  comments: deliveryFormProvider.coolantComments,
                  report: deliveryFormProvider.coolant,
                  updateReport: (report) {
                    deliveryFormProvider.updateCoolant(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.powerSteeringImages,
                  addImage: (image) {
                    deliveryFormProvider.addPowerSteeringImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updatePowerSteeringImage(image);
                  },
                  comments: deliveryFormProvider.powerSteeringComments,
                  report: deliveryFormProvider.powerSteering,
                  updateReport: (report) {
                    deliveryFormProvider.updatePowerSteering(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.dieselExhaustFluidImages,
                  addImage: (image) {
                    deliveryFormProvider.addDieselExhaustFluidImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateDieselExhaustFluidImage(image);
                  },
                  comments: deliveryFormProvider.dieselExhaustFluidComments,
                  report: deliveryFormProvider.dieselExhaustFluid,
                  updateReport: (report) {
                    deliveryFormProvider.updateDieselExhaustFluid(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.windshieldWasherFluidImages,
                  addImage: (image) {
                    deliveryFormProvider.addWindshieldWasherFluidImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateWindshieldWasherFluidImage(image);
                  },
                  comments: deliveryFormProvider.windshieldWasherFluidComments,
                  report: deliveryFormProvider.windshieldWasherFluid,
                  updateReport: (report) {
                    deliveryFormProvider.updateWindshieldWasherFluid(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.insulatedImages,
                  addImage: (image) {
                    deliveryFormProvider.addInsulatedImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateInsulatedImage(image);
                  },
                  comments: deliveryFormProvider.insulatedComments,
                  report: deliveryFormProvider.insulated,
                  updateReport: (report) {
                    deliveryFormProvider.updateInsulated(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.holesDrilledImages,
                  addImage: (image) {
                    deliveryFormProvider.addHolesDrilledImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateHolesDrilledImage(image);
                  },
                  comments: deliveryFormProvider.holesDrilledComments,
                  report: deliveryFormProvider.holesDrilled,
                  updateReport: (report) {
                    deliveryFormProvider.updateHolesDrilled(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.bucketLinerImages,
                  addImage: (image) {
                    deliveryFormProvider.addBucketLinerImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateBucketLinerImage(image);
                  },
                  comments: deliveryFormProvider.bucketLinerComments,
                  report: deliveryFormProvider.bucketLiner,
                  updateReport: (report) {
                    deliveryFormProvider.updateBucketLiner(report);
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
