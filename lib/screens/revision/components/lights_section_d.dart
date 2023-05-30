import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/delivered_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class LightsSectionD extends StatefulWidget {
  
  const LightsSectionD({super.key});

  @override
  State<LightsSectionD> createState() => _LightsSectionDState();
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

class _LightsSectionDState extends State<LightsSectionD> {
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
                  text: "Lights",
                ),
                // Headlights
                ItemForm(
                  textItem: "Headlights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.headLightsImages,
                  addImage: (image) {
                    deliveredFormProvider.addHeadLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateHeadLightsImage(image);
                  },
                  comments: deliveredFormProvider.headLightsComments,
                  report: deliveredFormProvider.headLights,
                  updateReport: (report) {
                    deliveredFormProvider.updateHeadLights(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Brake Lights
                ItemForm(
                  textItem: "Brake Lights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.brakeLightsImages,
                  addImage: (image) {
                    deliveredFormProvider.addBrakeLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateBrakeLightsImage(image);
                  },
                  comments: deliveredFormProvider.brakeLightsComments,
                  report: deliveredFormProvider.brakeLights,
                  updateReport: (report) {
                    deliveredFormProvider.updateBrakeLights(report);
                  }
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Reverse Lights
                ItemForm(
                  textItem: "Reverse Lights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.reverseLightsImages,
                  addImage: (image) {
                    deliveredFormProvider.addReverseLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateReverseLightsImage(image);
                  },
                  comments: deliveredFormProvider.reverseLightsComments,
                  report: deliveredFormProvider.reverseLights,
                  updateReport: (report) {
                    deliveredFormProvider.updateReverseLights(report);
                  }
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Warning Lights
                ItemForm(
                  textItem: "Warning Lights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.warningLightsImages,
                  addImage: (image) {
                    deliveredFormProvider.addWarningLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateWarningLightsImage(image);
                  },
                  comments: deliveredFormProvider.warningLightsComments,
                  report: deliveredFormProvider.warningLights,
                  updateReport: (report) {
                    deliveredFormProvider.updateWarningLights(report);
                  }
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Turn signals
                ItemForm(
                  textItem: "Turn signals", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.turnSignalsImages,
                  addImage: (image) {
                    deliveredFormProvider.addTurnSignalsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateTurnSignalsImage(image);
                  },
                  comments: deliveredFormProvider.turnSignalsComments,
                  report: deliveredFormProvider.turnSignals,
                  updateReport: (report) {
                    deliveredFormProvider.updateTurnSignals(report);
                  }
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // 4-Way flashers
                ItemForm(
                  textItem: "4-Way flashers", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.fourWayFlashersImages,
                  addImage: (image) {
                    deliveredFormProvider.addFourWayFlashersImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateFourWayFlashersImage(image);
                  },
                  comments: deliveredFormProvider.fourWayFlashersComments,
                  report: deliveredFormProvider.fourWayFlashers,
                  updateReport: (report) {
                    deliveredFormProvider.updateFourWayFlashers(report);
                  }
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Dash lights
                ItemForm(
                  textItem: "Dash lights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.dashLightsImages,
                  addImage: (image) {
                    deliveredFormProvider.addDashLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateDashLightsImage(image);
                  },
                  comments: deliveredFormProvider.dashLightsComments,
                  report: deliveredFormProvider.dashLights,
                  updateReport: (report) {
                    deliveredFormProvider.updateDashLights(report);
                  }
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Strobe lights
                ItemForm(
                  textItem: "Strobe lights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.strobeLightsImages,
                  addImage: (image) {
                    deliveredFormProvider.addStrobeLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateStrobeLightsImage(image);
                  },
                  comments: deliveredFormProvider.strobeLightsComments,
                  report: deliveredFormProvider.strobeLights,
                  updateReport: (report) {
                    deliveredFormProvider.updateStrobeLights(report);
                  }
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Cab roof lights
                ItemForm(
                  textItem: "Cab roof lights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.cabRoofLightsImages,
                  addImage: (image) {
                    deliveredFormProvider.addCabRoofLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateCabRoofLightsImage(image);
                  },
                  comments: deliveredFormProvider.cabRoofLightsComments,
                  report: deliveredFormProvider.cabRoofLights,
                  updateReport: (report) {
                    deliveredFormProvider.updateCabRoofLights(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Clearance lights
                ItemForm(
                  textItem: "Clearance lights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.clearenceLightsImages,
                  addImage: (image) {
                    deliveredFormProvider.addClearenceLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateClearenceLightsImage(image);
                  },
                  comments: deliveredFormProvider.clearenceLightsComments,
                  report: deliveredFormProvider.clearenceLights,
                  updateReport: (report) {
                    deliveredFormProvider.updateClearenceLights(report);
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
                  text: "Car Bodywork",
                ),
                // Wiper Blades front
                ItemForm(
                  textItem: "Wiper Blades Front",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.wiperBladesFrontImages,
                  addImage: (image) {
                    deliveredFormProvider.addWiperBladesFrontImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateWiperBladesFrontImage(image);
                  },
                  comments: deliveredFormProvider.wiperBladesFrontComments,
                  report: deliveredFormProvider.wiperBladesFront,
                  updateReport: (report) {
                    deliveredFormProvider.updateWiperBladesFront(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Wiper Blades Back
                ItemForm(
                  textItem: "Wiper Blades Back",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.wiperBladesBackImages,
                  addImage: (image) {
                    deliveredFormProvider.addWiperBladesBackImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateWiperBladesBackImage(image);
                  },
                  comments: deliveredFormProvider.wiperBladesBackComments,
                  report: deliveredFormProvider.wiperBladesBack,
                  updateReport: (report) {
                    deliveredFormProvider.updateWiperBladesBack(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Windshield wiper front
                ItemForm(
                  textItem: "Windshield Wiper Front",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.windshieldWiperFrontImages,
                  addImage: (image) {
                    deliveredFormProvider.addWindshieldWiperFrontImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateWindshieldWiperFrontImage(image);
                  },
                  comments: deliveredFormProvider.windshieldWiperFrontComments,
                  report: deliveredFormProvider.windshieldWiperFront,
                  updateReport: (report) {
                    deliveredFormProvider.updateWindshieldWiperFront(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Windshield wiper back
                ItemForm(
                  textItem: "Windshield Wiper Back",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.windshieldWiperBackImages,
                  addImage: (image) {
                    deliveredFormProvider.addWindshieldWiperBackImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateWindshieldWiperBackImage(image);
                  },
                  comments: deliveredFormProvider.windshieldWiperBackComments,
                  report: deliveredFormProvider.windshieldWiperBack,
                  updateReport: (report) {
                    deliveredFormProvider.updateWindshieldWiperBack(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // General Body	
                ItemForm(
                  textItem: "General Body",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.generalBodyImages,
                  addImage: (image) {
                    deliveredFormProvider.addGeneralBodyImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateGeneralBodyImage(image);
                  },
                  comments: deliveredFormProvider.generalBodyComments,
                  report: deliveredFormProvider.generalBody,
                  updateReport: (report) {
                    deliveredFormProvider.updateGeneralBody(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Decaling
                ItemForm(
                  textItem: "Decaling",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.decalingImages,
                  addImage: (image) {
                    deliveredFormProvider.addDecalingImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateDecalingImage(image);
                  },
                  comments: deliveredFormProvider.decalingComments,
                  report: deliveredFormProvider.decaling,
                  updateReport: (report) {
                    deliveredFormProvider.updateDecaling(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Tires
                ItemForm(
                  textItem: "Tires",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.tiresImages,
                  addImage: (image) {
                    deliveredFormProvider.addTiresImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateTiresImage(image);
                  },
                  comments: deliveredFormProvider.tiresComments,
                  report: deliveredFormProvider.tires,
                  updateReport: (report) {
                    deliveredFormProvider.updateTires(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Glass
                ItemForm(
                  textItem: "Glass",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.glassImages,
                  addImage: (image) {
                    deliveredFormProvider.addGlassImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateGlassImage(image);
                  },
                  comments: deliveredFormProvider.glassComments,
                  report: deliveredFormProvider.glass,
                  updateReport: (report) {
                    deliveredFormProvider.updateGlass(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Mirrors
                ItemForm(
                  textItem: "Mirrors",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.mirrorsImages,
                  addImage: (image) {
                    deliveredFormProvider.addMirrorsImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateMirrorsImage(image);
                  },
                  comments: deliveredFormProvider.mirrorsComments,
                  report: deliveredFormProvider.mirrors,
                  updateReport: (report) {
                    deliveredFormProvider.updateMirrors(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Parking
                ItemForm(
                  textItem: "Parking",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.parkingImages,
                  addImage: (image) {
                    deliveredFormProvider.addParkingImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateParkingImage(image);
                  },
                  comments: deliveredFormProvider.parkingComments,
                  report: deliveredFormProvider.parking,
                  updateReport: (report) {
                    deliveredFormProvider.updateParking(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Brakes
                ItemForm(
                  textItem: "Brakes",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.brakesImages,
                  addImage: (image) {
                    deliveredFormProvider.addBrakesImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateBrakesImage(image);
                  },
                  comments: deliveredFormProvider.brakesComments,
                  report: deliveredFormProvider.brakes,
                  updateReport: (report) {
                    deliveredFormProvider.updateBrakes(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // EMG Brakes
                ItemForm(
                  textItem: "EMG Brakes",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.emgBrakesImages,
                  addImage: (image) {
                    deliveredFormProvider.addEMGBrakesImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateEMGBrakesImage(image);
                  },
                  comments: deliveredFormProvider.emgBrakesComments,
                  report: deliveredFormProvider.emgBrakes,
                  updateReport: (report) {
                    deliveredFormProvider.updateEMGBrakes(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Horn
                ItemForm(
                  textItem: "Horn",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: deliveredFormProvider.hornImages,
                  addImage: (image) {
                    deliveredFormProvider.addHornImage(image);
                  },
                  updateImage: (image) {
                    deliveredFormProvider.updateHornImage(image);
                  },
                  comments: deliveredFormProvider.hornComments,
                  report: deliveredFormProvider.horn,
                  updateReport: (report) {
                    deliveredFormProvider.updateHorn(report);
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
