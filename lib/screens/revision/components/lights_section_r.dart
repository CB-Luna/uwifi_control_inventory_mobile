import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/receiving_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class LightsSectionR extends StatefulWidget {
  
  const LightsSectionR({super.key});

  @override
  State<LightsSectionR> createState() => _LightsSectionRState();
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

class _LightsSectionRState extends State<LightsSectionR> {
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
                  text: "Lights",
                ),
                // Headlights
                ItemForm(
                  textItem: "Headlights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: receivingFormProvider.headLightsImages,
                  addImage: (image) {
                    receivingFormProvider.addHeadLightsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateHeadLightsImage(image);
                  },
                  comments: receivingFormProvider.headLightsComments,
                  report: receivingFormProvider.headLights,
                  updateReport: (report) {
                    receivingFormProvider.updateHeadLights(report);
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
                  images: receivingFormProvider.brakeLightsImages,
                  addImage: (image) {
                    receivingFormProvider.addBrakeLightsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateBrakeLightsImage(image);
                  },
                  comments: receivingFormProvider.brakeLightsComments,
                  report: receivingFormProvider.brakeLights,
                  updateReport: (report) {
                    receivingFormProvider.updateBrakeLights(report);
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
                  images: receivingFormProvider.reverseLightsImages,
                  addImage: (image) {
                    receivingFormProvider.addReverseLightsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateReverseLightsImage(image);
                  },
                  comments: receivingFormProvider.reverseLightsComments,
                  report: receivingFormProvider.reverseLights,
                  updateReport: (report) {
                    receivingFormProvider.updateReverseLights(report);
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
                  images: receivingFormProvider.warningLightsImages,
                  addImage: (image) {
                    receivingFormProvider.addWarningLightsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateWarningLightsImage(image);
                  },
                  comments: receivingFormProvider.warningLightsComments,
                  report: receivingFormProvider.warningLights,
                  updateReport: (report) {
                    receivingFormProvider.updateWarningLights(report);
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
                  images: receivingFormProvider.turnSignalsImages,
                  addImage: (image) {
                    receivingFormProvider.addTurnSignalsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateTurnSignalsImage(image);
                  },
                  comments: receivingFormProvider.turnSignalsComments,
                  report: receivingFormProvider.turnSignals,
                  updateReport: (report) {
                    receivingFormProvider.updateTurnSignals(report);
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
                  images: receivingFormProvider.fourWayFlashersImages,
                  addImage: (image) {
                    receivingFormProvider.addFourWayFlashersImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateFourWayFlashersImage(image);
                  },
                  comments: receivingFormProvider.fourWayFlashersComments,
                  report: receivingFormProvider.fourWayFlashers,
                  updateReport: (report) {
                    receivingFormProvider.updateFourWayFlashers(report);
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
                  images: receivingFormProvider.dashLightsImages,
                  addImage: (image) {
                    receivingFormProvider.addDashLightsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateDashLightsImage(image);
                  },
                  comments: receivingFormProvider.dashLightsComments,
                  report: receivingFormProvider.dashLights,
                  updateReport: (report) {
                    receivingFormProvider.updateDashLights(report);
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
                  images: receivingFormProvider.strobeLightsImages,
                  addImage: (image) {
                    receivingFormProvider.addStrobeLightsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateStrobeLightsImage(image);
                  },
                  comments: receivingFormProvider.strobeLightsComments,
                  report: receivingFormProvider.strobeLights,
                  updateReport: (report) {
                    receivingFormProvider.updateStrobeLights(report);
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
                  images: receivingFormProvider.cabRoofLightsImages,
                  addImage: (image) {
                    receivingFormProvider.addCabRoofLightsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateCabRoofLightsImage(image);
                  },
                  comments: receivingFormProvider.cabRoofLightsComments,
                  report: receivingFormProvider.cabRoofLights,
                  updateReport: (report) {
                    receivingFormProvider.updateCabRoofLights(report);
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
                  images: receivingFormProvider.clearanceLightsImages,
                  addImage: (image) {
                    receivingFormProvider.addClearanceLightsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateClearanceLightsImage(image);
                  },
                  comments: receivingFormProvider.clearanceLightsComments,
                  report: receivingFormProvider.clearanceLights,
                  updateReport: (report) {
                    receivingFormProvider.updateClearanceLights(report);
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
                  images: receivingFormProvider.wiperBladesFrontImages,
                  addImage: (image) {
                    receivingFormProvider.addWiperBladesFrontImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateWiperBladesFrontImage(image);
                  },
                  comments: receivingFormProvider.wiperBladesFrontComments,
                  report: receivingFormProvider.wiperBladesFront,
                  updateReport: (report) {
                    receivingFormProvider.updateWiperBladesFront(report);
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
                  images: receivingFormProvider.wiperBladesBackImages,
                  addImage: (image) {
                    receivingFormProvider.addWiperBladesBackImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateWiperBladesBackImage(image);
                  },
                  comments: receivingFormProvider.wiperBladesBackComments,
                  report: receivingFormProvider.wiperBladesBack,
                  updateReport: (report) {
                    receivingFormProvider.updateWiperBladesBack(report);
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
                  images: receivingFormProvider.windshieldWiperFrontImages,
                  addImage: (image) {
                    receivingFormProvider.addWindshieldWiperFrontImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateWindshieldWiperFrontImage(image);
                  },
                  comments: receivingFormProvider.windshieldWiperFrontComments,
                  report: receivingFormProvider.windshieldWiperFront,
                  updateReport: (report) {
                    receivingFormProvider.updateWindshieldWiperFront(report);
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
                  images: receivingFormProvider.windshieldWiperBackImages,
                  addImage: (image) {
                    receivingFormProvider.addWindshieldWiperBackImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateWindshieldWiperBackImage(image);
                  },
                  comments: receivingFormProvider.windshieldWiperBackComments,
                  report: receivingFormProvider.windshieldWiperBack,
                  updateReport: (report) {
                    receivingFormProvider.updateWindshieldWiperBack(report);
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
                  images: receivingFormProvider.generalBodyImages,
                  addImage: (image) {
                    receivingFormProvider.addGeneralBodyImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateGeneralBodyImage(image);
                  },
                  comments: receivingFormProvider.generalBodyComments,
                  report: receivingFormProvider.generalBody,
                  updateReport: (report) {
                    receivingFormProvider.updateGeneralBody(report);
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
                  images: receivingFormProvider.decalingImages,
                  addImage: (image) {
                    receivingFormProvider.addDecalingImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateDecalingImage(image);
                  },
                  comments: receivingFormProvider.decalingComments,
                  report: receivingFormProvider.decaling,
                  updateReport: (report) {
                    receivingFormProvider.updateDecaling(report);
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
                  images: receivingFormProvider.tiresImages,
                  addImage: (image) {
                    receivingFormProvider.addTiresImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateTiresImage(image);
                  },
                  comments: receivingFormProvider.tiresComments,
                  report: receivingFormProvider.tires,
                  updateReport: (report) {
                    receivingFormProvider.updateTires(report);
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
                  images: receivingFormProvider.glassImages,
                  addImage: (image) {
                    receivingFormProvider.addGlassImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateGlassImage(image);
                  },
                  comments: receivingFormProvider.glassComments,
                  report: receivingFormProvider.glass,
                  updateReport: (report) {
                    receivingFormProvider.updateGlass(report);
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
                  images: receivingFormProvider.mirrorsImages,
                  addImage: (image) {
                    receivingFormProvider.addMirrorsImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateMirrorsImage(image);
                  },
                  comments: receivingFormProvider.mirrorsComments,
                  report: receivingFormProvider.mirrors,
                  updateReport: (report) {
                    receivingFormProvider.updateMirrors(report);
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
                  images: receivingFormProvider.parkingImages,
                  addImage: (image) {
                    receivingFormProvider.addParkingImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateParkingImage(image);
                  },
                  comments: receivingFormProvider.parkingComments,
                  report: receivingFormProvider.parking,
                  updateReport: (report) {
                    receivingFormProvider.updateParking(report);
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
                  images: receivingFormProvider.brakesImages,
                  addImage: (image) {
                    receivingFormProvider.addBrakesImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateBrakesImage(image);
                  },
                  comments: receivingFormProvider.brakesComments,
                  report: receivingFormProvider.brakes,
                  updateReport: (report) {
                    receivingFormProvider.updateBrakes(report);
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
                  images: receivingFormProvider.emgBrakesImages,
                  addImage: (image) {
                    receivingFormProvider.addEMGBrakesImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateEMGBrakesImage(image);
                  },
                  comments: receivingFormProvider.emgBrakesComments,
                  report: receivingFormProvider.emgBrakes,
                  updateReport: (report) {
                    receivingFormProvider.updateEMGBrakes(report);
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
                  images: receivingFormProvider.hornImages,
                  addImage: (image) {
                    receivingFormProvider.addHornImage(image);
                  },
                  updateImage: (image) {
                    receivingFormProvider.updateHornImage(image);
                  },
                  comments: receivingFormProvider.hornComments,
                  report: receivingFormProvider.horn,
                  updateReport: (report) {
                    receivingFormProvider.updateHorn(report);
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
