import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/checkout_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
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

class _LightsSectionRState extends State<LightsSectionR> {
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
                  text: "Lights",
                ),
                // Headlights
                ItemForm(
                  textItem: "Headlights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkOutFormProvider.headLightsImages,
                  addImage: (image) {
                    checkOutFormProvider.addHeadLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteHeadLightsImage(image);
                  },
                  comments: checkOutFormProvider.headLightsComments,
                  report: checkOutFormProvider.headLights,
                  updateReport: (report) {
                    checkOutFormProvider.updateHeadLights(report);
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
                  images: checkOutFormProvider.brakeLightsImages,
                  addImage: (image) {
                    checkOutFormProvider.addBrakeLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteBrakeLightsImage(image);
                  },
                  comments: checkOutFormProvider.brakeLightsComments,
                  report: checkOutFormProvider.brakeLights,
                  updateReport: (report) {
                    checkOutFormProvider.updateBrakeLights(report);
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
                  images: checkOutFormProvider.reverseLightsImages,
                  addImage: (image) {
                    checkOutFormProvider.addReverseLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteReverseLightsImage(image);
                  },
                  comments: checkOutFormProvider.reverseLightsComments,
                  report: checkOutFormProvider.reverseLights,
                  updateReport: (report) {
                    checkOutFormProvider.updateReverseLights(report);
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
                  images: checkOutFormProvider.warningLightsImages,
                  addImage: (image) {
                    checkOutFormProvider.addWarningLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteWarningLightsImage(image);
                  },
                  comments: checkOutFormProvider.warningLightsComments,
                  report: checkOutFormProvider.warningLights,
                  updateReport: (report) {
                    checkOutFormProvider.updateWarningLights(report);
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
                  images: checkOutFormProvider.turnSignalsImages,
                  addImage: (image) {
                    checkOutFormProvider.addTurnSignalsImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteTurnSignalsImage(image);
                  },
                  comments: checkOutFormProvider.turnSignalsComments,
                  report: checkOutFormProvider.turnSignals,
                  updateReport: (report) {
                    checkOutFormProvider.updateTurnSignals(report);
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
                  images: checkOutFormProvider.fourWayFlashersImages,
                  addImage: (image) {
                    checkOutFormProvider.addFourWayFlashersImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteFourWayFlashersImage(image);
                  },
                  comments: checkOutFormProvider.fourWayFlashersComments,
                  report: checkOutFormProvider.fourWayFlashers,
                  updateReport: (report) {
                    checkOutFormProvider.updateFourWayFlashers(report);
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
                  images: checkOutFormProvider.dashLightsImages,
                  addImage: (image) {
                    checkOutFormProvider.addDashLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteDashLightsImage(image);
                  },
                  comments: checkOutFormProvider.dashLightsComments,
                  report: checkOutFormProvider.dashLights,
                  updateReport: (report) {
                    checkOutFormProvider.updateDashLights(report);
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
                  images: checkOutFormProvider.strobeLightsImages,
                  addImage: (image) {
                    checkOutFormProvider.addStrobeLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteStrobeLightsImage(image);
                  },
                  comments: checkOutFormProvider.strobeLightsComments,
                  report: checkOutFormProvider.strobeLights,
                  updateReport: (report) {
                    checkOutFormProvider.updateStrobeLights(report);
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
                  images: checkOutFormProvider.cabRoofLightsImages,
                  addImage: (image) {
                    checkOutFormProvider.addCabRoofLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteCabRoofLightsImage(image);
                  },
                  comments: checkOutFormProvider.cabRoofLightsComments,
                  report: checkOutFormProvider.cabRoofLights,
                  updateReport: (report) {
                    checkOutFormProvider.updateCabRoofLights(report);
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
                  images: checkOutFormProvider.clearanceLightsImages,
                  addImage: (image) {
                    checkOutFormProvider.addClearanceLightsImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteClearanceLightsImage(image);
                  },
                  comments: checkOutFormProvider.clearanceLightsComments,
                  report: checkOutFormProvider.clearanceLights,
                  updateReport: (report) {
                    checkOutFormProvider.updateClearanceLights(report);
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
                  images: checkOutFormProvider.wiperBladesFrontImages,
                  addImage: (image) {
                    checkOutFormProvider.addWiperBladesFrontImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteWiperBladesFrontImage(image);
                  },
                  comments: checkOutFormProvider.wiperBladesFrontComments,
                  report: checkOutFormProvider.wiperBladesFront,
                  updateReport: (report) {
                    checkOutFormProvider.updateWiperBladesFront(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkOutFormProvider.clearWiperBladesFront();
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
                  images: checkOutFormProvider.wiperBladesBackImages,
                  addImage: (image) {
                    checkOutFormProvider.addWiperBladesBackImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteWiperBladesBackImage(image);
                  },
                  comments: checkOutFormProvider.wiperBladesBackComments,
                  report: checkOutFormProvider.wiperBladesBack,
                  updateReport: (report) {
                    checkOutFormProvider.updateWiperBladesBack(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkOutFormProvider.clearWiperBladesBack();
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
                  images: checkOutFormProvider.windshieldWiperFrontImages,
                  addImage: (image) {
                    checkOutFormProvider.addWindshieldWiperFrontImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteWindshieldWiperFrontImage(image);
                  },
                  comments: checkOutFormProvider.windshieldWiperFrontComments,
                  report: checkOutFormProvider.windshieldWiperFront,
                  updateReport: (report) {
                    checkOutFormProvider.updateWindshieldWiperFront(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkOutFormProvider.clearWindshieldWiperFront();
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
                  images: checkOutFormProvider.windshieldWiperBackImages,
                  addImage: (image) {
                    checkOutFormProvider.addWindshieldWiperBackImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteWindshieldWiperBackImage(image);
                  },
                  comments: checkOutFormProvider.windshieldWiperBackComments,
                  report: checkOutFormProvider.windshieldWiperBack,
                  updateReport: (report) {
                    checkOutFormProvider.updateWindshieldWiperBack(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkOutFormProvider.clearWindshieldWiperBack();
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
                  images: checkOutFormProvider.generalBodyImages,
                  addImage: (image) {
                    checkOutFormProvider.addGeneralBodyImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteGeneralBodyImage(image);
                  },
                  comments: checkOutFormProvider.generalBodyComments,
                  report: checkOutFormProvider.generalBody,
                  updateReport: (report) {
                    checkOutFormProvider.updateGeneralBody(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkOutFormProvider.clearGeneralBody();
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
                  images: checkOutFormProvider.decalingImages,
                  addImage: (image) {
                    checkOutFormProvider.addDecalingImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteDecalingImage(image);
                  },
                  comments: checkOutFormProvider.decalingComments,
                  report: checkOutFormProvider.decaling,
                  updateReport: (report) {
                    checkOutFormProvider.updateDecaling(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkOutFormProvider.clearDecaling();
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
                  images: checkOutFormProvider.tiresImages,
                  addImage: (image) {
                    checkOutFormProvider.addTiresImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteTiresImage(image);
                  },
                  comments: checkOutFormProvider.tiresComments,
                  report: checkOutFormProvider.tires,
                  updateReport: (report) {
                    checkOutFormProvider.updateTires(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkOutFormProvider.clearTires();
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
                  images: checkOutFormProvider.glassImages,
                  addImage: (image) {
                    checkOutFormProvider.addGlassImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteGlassImage(image);
                  },
                  comments: checkOutFormProvider.glassComments,
                  report: checkOutFormProvider.glass,
                  updateReport: (report) {
                    checkOutFormProvider.updateGlass(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkOutFormProvider.clearGlass();
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
                  images: checkOutFormProvider.mirrorsImages,
                  addImage: (image) {
                    checkOutFormProvider.addMirrorsImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteMirrorsImage(image);
                  },
                  comments: checkOutFormProvider.mirrorsComments,
                  report: checkOutFormProvider.mirrors,
                  updateReport: (report) {
                    checkOutFormProvider.updateMirrors(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkOutFormProvider.clearMirrors();
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
                  images: checkOutFormProvider.parkingImages,
                  addImage: (image) {
                    checkOutFormProvider.addParkingImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteParkingImage(image);
                  },
                  comments: checkOutFormProvider.parkingComments,
                  report: checkOutFormProvider.parking,
                  updateReport: (report) {
                    checkOutFormProvider.updateParking(report);
                  },
                  requiredImages: true,
                  clearReport: () {
                    checkOutFormProvider.clearParking();
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
                  images: checkOutFormProvider.brakesImages,
                  addImage: (image) {
                    checkOutFormProvider.addBrakesImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteBrakesImage(image);
                  },
                  comments: checkOutFormProvider.brakesComments,
                  report: checkOutFormProvider.brakes,
                  updateReport: (report) {
                    checkOutFormProvider.updateBrakes(report);
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
                  images: checkOutFormProvider.emgBrakesImages,
                  addImage: (image) {
                    checkOutFormProvider.addEMGBrakesImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteEMGBrakesImage(image);
                  },
                  comments: checkOutFormProvider.emgBrakesComments,
                  report: checkOutFormProvider.emgBrakes,
                  updateReport: (report) {
                    checkOutFormProvider.updateEMGBrakes(report);
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
                  images: checkOutFormProvider.hornImages,
                  addImage: (image) {
                    checkOutFormProvider.addHornImage(image);
                  },
                  deleteImage: (image) {
                    checkOutFormProvider.deleteHornImage(image);
                  },
                  comments: checkOutFormProvider.hornComments,
                  report: checkOutFormProvider.horn,
                  updateReport: (report) {
                    checkOutFormProvider.updateHorn(report);
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
