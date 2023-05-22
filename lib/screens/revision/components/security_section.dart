import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';

class SecuritySection extends StatefulWidget {
  
  const SecuritySection({super.key});

  @override
  State<SecuritySection> createState() => _SecuritySectionState();
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

class _SecuritySectionState extends State<SecuritySection> {
  @override
  Widget build(BuildContext context) {
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
                  text: "Security",
                ),
                // RTA Magnet
                ItemForm(
                  textItem: "RTA Magnet", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Triangle Reflectors
                ItemForm(
                  textItem: "Triangle Reflectors", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Wheel Chocks
                ItemForm(
                  textItem: "Wheel Chocks", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Fire Extinguisher
                ItemForm(
                  textItem: "Fire Extinguisher", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // First ait kit safesty vest
                ItemForm(
                  textItem: "First ait kit safesty vest", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Back up Alarm
                ItemForm(
                  textItem: "Back up Alarm", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
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
                  text: "Extra",
                ),
                // Ladder
                ItemForm(
                  textItem: "Ladder", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Step Ladder
                ItemForm(
                  textItem: "Step Ladder", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Ladder straps (J-hook)
                ItemForm(
                  textItem: "Ladder straps (J-hook)", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Hydraulic Fluid for Bucket
                ItemForm(
                  textItem: "Hydraulic Fluid for Bucket", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Fiber Reel Rack	
                ItemForm(
                  textItem: "Fiber Reel Rack	", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                //Bins Locked and secure
                ItemForm(
                  textItem: "Bins Locked and secure", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Safety Harness
                ItemForm(
                  textItem: "Safety Harness", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Lanyard safety harness
                ItemForm(
                  textItem: "Lanyard safety harness", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
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
