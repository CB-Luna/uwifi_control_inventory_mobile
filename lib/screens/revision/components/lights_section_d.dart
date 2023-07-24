import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/checkin_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
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
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
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
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
        ),
      ],
    ),
  };

class _LightsSectionDState extends State<LightsSectionD> {
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
                  text: "Lights",
                ),
                // Headlights
                ItemForm(
                  textItem: "Headlights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkInFormProvider.headLightsImages,
                  addImage: (image) {
                    checkInFormProvider.addHeadLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteHeadLightsImage(image);
                  },
                  comments: checkInFormProvider.headLightsComments,
                  report: checkInFormProvider.headLights,
                  updateReport: (report) {
                    checkInFormProvider.updateHeadLights(report);
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
                  images: checkInFormProvider.brakeLightsImages,
                  addImage: (image) {
                    checkInFormProvider.addBrakeLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteBrakeLightsImage(image);
                  },
                  comments: checkInFormProvider.brakeLightsComments,
                  report: checkInFormProvider.brakeLights,
                  updateReport: (report) {
                    checkInFormProvider.updateBrakeLights(report);
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
                  images: checkInFormProvider.reverseLightsImages,
                  addImage: (image) {
                    checkInFormProvider.addReverseLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteReverseLightsImage(image);
                  },
                  comments: checkInFormProvider.reverseLightsComments,
                  report: checkInFormProvider.reverseLights,
                  updateReport: (report) {
                    checkInFormProvider.updateReverseLights(report);
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
                  images: checkInFormProvider.warningLightsImages,
                  addImage: (image) {
                    checkInFormProvider.addWarningLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteWarningLightsImage(image);
                  },
                  comments: checkInFormProvider.warningLightsComments,
                  report: checkInFormProvider.warningLights,
                  updateReport: (report) {
                    checkInFormProvider.updateWarningLights(report);
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
                  images: checkInFormProvider.turnSignalsImages,
                  addImage: (image) {
                    checkInFormProvider.addTurnSignalsImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteTurnSignalsImage(image);
                  },
                  comments: checkInFormProvider.turnSignalsComments,
                  report: checkInFormProvider.turnSignals,
                  updateReport: (report) {
                    checkInFormProvider.updateTurnSignals(report);
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
                  images: checkInFormProvider.fourWayFlashersImages,
                  addImage: (image) {
                    checkInFormProvider.addFourWayFlashersImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteFourWayFlashersImage(image);
                  },
                  comments: checkInFormProvider.fourWayFlashersComments,
                  report: checkInFormProvider.fourWayFlashers,
                  updateReport: (report) {
                    checkInFormProvider.updateFourWayFlashers(report);
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
                  images: checkInFormProvider.dashLightsImages,
                  addImage: (image) {
                    checkInFormProvider.addDashLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteDashLightsImage(image);
                  },
                  comments: checkInFormProvider.dashLightsComments,
                  report: checkInFormProvider.dashLights,
                  updateReport: (report) {
                    checkInFormProvider.updateDashLights(report);
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
                  images: checkInFormProvider.strobeLightsImages,
                  addImage: (image) {
                    checkInFormProvider.addStrobeLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteStrobeLightsImage(image);
                  },
                  comments: checkInFormProvider.strobeLightsComments,
                  report: checkInFormProvider.strobeLights,
                  updateReport: (report) {
                    checkInFormProvider.updateStrobeLights(report);
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
                  images: checkInFormProvider.cabRoofLightsImages,
                  addImage: (image) {
                    checkInFormProvider.addCabRoofLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteCabRoofLightsImage(image);
                  },
                  comments: checkInFormProvider.cabRoofLightsComments,
                  report: checkInFormProvider.cabRoofLights,
                  updateReport: (report) {
                    checkInFormProvider.updateCabRoofLights(report);
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
                  images: checkInFormProvider.clearanceLightsImages,
                  addImage: (image) {
                    checkInFormProvider.addClearanceLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteClearanceLightsImage(image);
                  },
                  comments: checkInFormProvider.clearanceLightsComments,
                  report: checkInFormProvider.clearanceLights,
                  updateReport: (report) {
                    checkInFormProvider.updateClearanceLights(report);
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
                  images: checkInFormProvider.wiperBladesFrontImages,
                  addImage: (image) {
                    checkInFormProvider.addWiperBladesFrontImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteWiperBladesFrontImage(image);
                  },
                  comments: checkInFormProvider.wiperBladesFrontComments,
                  report: checkInFormProvider.wiperBladesFront,
                  updateReport: (report) {
                    checkInFormProvider.updateWiperBladesFront(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearWiperBladesFront();
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
                  images: checkInFormProvider.wiperBladesBackImages,
                  addImage: (image) {
                    checkInFormProvider.addWiperBladesBackImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteWiperBladesBackImage(image);
                  },
                  comments: checkInFormProvider.wiperBladesBackComments,
                  report: checkInFormProvider.wiperBladesBack,
                  updateReport: (report) {
                    checkInFormProvider.updateWiperBladesBack(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearWiperBladesBack();
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
                  images: checkInFormProvider.windshieldWiperFrontImages,
                  addImage: (image) {
                    checkInFormProvider.addWindshieldWiperFrontImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteWindshieldWiperFrontImage(image);
                  },
                  comments: checkInFormProvider.windshieldWiperFrontComments,
                  report: checkInFormProvider.windshieldWiperFront,
                  updateReport: (report) {
                    checkInFormProvider.updateWindshieldWiperFront(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearWindshieldWiperFront();
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
                  images: checkInFormProvider.windshieldWiperBackImages,
                  addImage: (image) {
                    checkInFormProvider.addWindshieldWiperBackImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteWindshieldWiperBackImage(image);
                  },
                  comments: checkInFormProvider.windshieldWiperBackComments,
                  report: checkInFormProvider.windshieldWiperBack,
                  updateReport: (report) {
                    checkInFormProvider.updateWindshieldWiperBack(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearWindshieldWiperBack();
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
                  images: checkInFormProvider.generalBodyImages,
                  addImage: (image) {
                    checkInFormProvider.addGeneralBodyImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteGeneralBodyImage(image);
                  },
                  comments: checkInFormProvider.generalBodyComments,
                  report: checkInFormProvider.generalBody,
                  updateReport: (report) {
                    checkInFormProvider.updateGeneralBody(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearGeneralBody();
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
                  images: checkInFormProvider.decalingImages,
                  addImage: (image) {
                    checkInFormProvider.addDecalingImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteDecalingImage(image);
                  },
                  comments: checkInFormProvider.decalingComments,
                  report: checkInFormProvider.decaling,
                  updateReport: (report) {
                    checkInFormProvider.updateDecaling(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearDecaling();
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
                  images: checkInFormProvider.tiresImages,
                  addImage: (image) {
                    checkInFormProvider.addTiresImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteTiresImage(image);
                  },
                  comments: checkInFormProvider.tiresComments,
                  report: checkInFormProvider.tires,
                  updateReport: (report) {
                    checkInFormProvider.updateTires(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearTires();
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
                  images: checkInFormProvider.glassImages,
                  addImage: (image) {
                    checkInFormProvider.addGlassImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteGlassImage(image);
                  },
                  comments: checkInFormProvider.glassComments,
                  report: checkInFormProvider.glass,
                  updateReport: (report) {
                    checkInFormProvider.updateGlass(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearGlass();
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
                  images: checkInFormProvider.mirrorsImages,
                  addImage: (image) {
                    checkInFormProvider.addMirrorsImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteMirrorsImage(image);
                  },
                  comments: checkInFormProvider.mirrorsComments,
                  report: checkInFormProvider.mirrors,
                  updateReport: (report) {
                    checkInFormProvider.updateMirrors(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearMirrors();
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
                  images: checkInFormProvider.parkingImages,
                  addImage: (image) {
                    checkInFormProvider.addParkingImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteParkingImage(image);
                  },
                  comments: checkInFormProvider.parkingComments,
                  report: checkInFormProvider.parking,
                  updateReport: (report) {
                    checkInFormProvider.updateParking(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkInFormProvider.clearParking();
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
                  images: checkInFormProvider.brakesImages,
                  addImage: (image) {
                    checkInFormProvider.addBrakesImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteBrakesImage(image);
                  },
                  comments: checkInFormProvider.brakesComments,
                  report: checkInFormProvider.brakes,
                  updateReport: (report) {
                    checkInFormProvider.updateBrakes(report);
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
                  images: checkInFormProvider.emgBrakesImages,
                  addImage: (image) {
                    checkInFormProvider.addEMGBrakesImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteEMGBrakesImage(image);
                  },
                  comments: checkInFormProvider.emgBrakesComments,
                  report: checkInFormProvider.emgBrakes,
                  updateReport: (report) {
                    checkInFormProvider.updateEMGBrakes(report);
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
                  images: checkInFormProvider.hornImages,
                  addImage: (image) {
                    checkInFormProvider.addHornImage(image);
                  },
                  deleteImage: (image) {
                    checkInFormProvider.deleteHornImage(image);
                  },
                  comments: checkInFormProvider.hornComments,
                  report: checkInFormProvider.horn,
                  updateReport: (report) {
                    checkInFormProvider.updateHorn(report);
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
