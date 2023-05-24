import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/delivery_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class LightsSection extends StatefulWidget {
  
  const LightsSection({super.key});

  @override
  State<LightsSection> createState() => _LightsSectionState();
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

class _LightsSectionState extends State<LightsSection> {
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
                  text: "Lights",
                ),
                // Headlights
                ItemForm(
                  textItem: "Headlights", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: deliveryFormProvider.headLightsImages,
                  addImage: (image) {
                    deliveryFormProvider.addHeadLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateHeadLightsImage(image);
                  },
                  comments: deliveryFormProvider.headLightsComments,
                  report: deliveryFormProvider.headLights,
                  updateReport: (report) {
                    deliveryFormProvider.updateHeadLights(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.brakeLightsImages,
                  addImage: (image) {
                    deliveryFormProvider.addBrakeLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateBrakeLightsImage(image);
                  },
                  comments: deliveryFormProvider.brakeLightsComments,
                  report: deliveryFormProvider.brakeLights,
                  updateReport: (report) {
                    deliveryFormProvider.updateBrakeLights(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.reverseLightsImages,
                  addImage: (image) {
                    deliveryFormProvider.addReverseLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateReverseLightsImage(image);
                  },
                  comments: deliveryFormProvider.reverseLightsComments,
                  report: deliveryFormProvider.reverseLights,
                  updateReport: (report) {
                    deliveryFormProvider.updateReverseLights(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.warningLightsImages,
                  addImage: (image) {
                    deliveryFormProvider.addWarningLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateWarningLightsImage(image);
                  },
                  comments: deliveryFormProvider.warningLightsComments,
                  report: deliveryFormProvider.warningLights,
                  updateReport: (report) {
                    deliveryFormProvider.updateWarningLights(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.turnSignalsImages,
                  addImage: (image) {
                    deliveryFormProvider.addTurnSignalsImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateTurnSignalsImage(image);
                  },
                  comments: deliveryFormProvider.turnSignalsComments,
                  report: deliveryFormProvider.turnSignals,
                  updateReport: (report) {
                    deliveryFormProvider.updateTurnSignals(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.fourWayFlashersImages,
                  addImage: (image) {
                    deliveryFormProvider.addFourWayFlashersImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateFourWayFlashersImage(image);
                  },
                  comments: deliveryFormProvider.fourWayFlashersComments,
                  report: deliveryFormProvider.fourWayFlashers,
                  updateReport: (report) {
                    deliveryFormProvider.updateFourWayFlashers(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.dashLightsImages,
                  addImage: (image) {
                    deliveryFormProvider.addDashLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateDashLightsImage(image);
                  },
                  comments: deliveryFormProvider.dashLightsComments,
                  report: deliveryFormProvider.dashLights,
                  updateReport: (report) {
                    deliveryFormProvider.updateDashLights(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.strobeLightsImages,
                  addImage: (image) {
                    deliveryFormProvider.addStrobeLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateStrobeLightsImage(image);
                  },
                  comments: deliveryFormProvider.strobeLightsComments,
                  report: deliveryFormProvider.strobeLights,
                  updateReport: (report) {
                    deliveryFormProvider.updateStrobeLights(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.cabRoofLightsImages,
                  addImage: (image) {
                    deliveryFormProvider.addCabRoofLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateCabRoofLightsImage(image);
                  },
                  comments: deliveryFormProvider.cabRoofLightsComments,
                  report: deliveryFormProvider.cabRoofLights,
                  updateReport: (report) {
                    deliveryFormProvider.updateCabRoofLights(report);
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
                  isRegistered: true,
                  images: deliveryFormProvider.clearenceLightsImages,
                  addImage: (image) {
                    deliveryFormProvider.addClearenceLightsImage(image);
                  },
                  updateImage: (image) {
                    deliveryFormProvider.updateClearenceLightsImage(image);
                  },
                  comments: deliveryFormProvider.clearenceLightsComments,
                  report: deliveryFormProvider.clearenceLights,
                  updateReport: (report) {
                    deliveryFormProvider.updateClearenceLights(report);
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
                  textItem: "Wiper Blades front", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: [],
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Wiper Blades back
                ItemForm(
                  textItem: "Wiper Blades back", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: [],
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
                  textItem: "Windshield wiper front", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: [],
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
                  textItem: "Windshield wiper back", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: [],
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
                  textItem: "General Body	", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: [],
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
                  isRegistered: true,
                  images: [],
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
                  isRegistered: true,
                  images: [],
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
                  isRegistered: true,
                  images: [],
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
                  isRegistered: true,
                  images: [],
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
                  isRegistered: true,
                  images: [],
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
                  isRegistered: true,
                  images: [],
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
                  isRegistered: true,
                  images: [],
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
                  isRegistered: true,
                  images: [],
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
