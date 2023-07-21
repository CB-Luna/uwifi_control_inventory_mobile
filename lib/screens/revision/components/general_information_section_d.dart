import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/expanded_text.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';
import 'package:taller_alex_app_asesor/util/util.dart';

class GeneralInformationSectionD extends StatefulWidget {
  
  const GeneralInformationSectionD({super.key});

  @override
  State<GeneralInformationSectionD> createState() => _GeneralInformationSectionDState();
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

class _GeneralInformationSectionDState extends State<GeneralInformationSectionD> {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UsuarioController>(context);
    
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
                  text: "General information",
                ),
                // ID VEHICLE
                ItemForm(
                  textItem: "ID Vehicle", 
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  readOnly: true,
                  images: const [],
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width * 0.4, 
                  text: userController.usuarioCurrent?.vehicle.target?.idDBR ?? "12",
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // MAKE
                ItemForm(
                  textItem: "Make", 
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  readOnly: true,
                  images: const [],
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width * 0.4, 
                  text: userController.usuarioCurrent?.vehicle.target?.make ?? "Mercedes",
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // MODEL
                ItemForm(
                  textItem: "Model", 
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  readOnly: true,
                  images: const [],
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width * 0.4, 
                  text: userController.usuarioCurrent?.vehicle.target?.model ?? "A1",
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // YEAR
                ItemForm(
                  textItem: "Year", 
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  readOnly: true,
                  images: const [],
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width * 0.4, 
                  text: userController.usuarioCurrent?.vehicle.target?.year ?? "2019",
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // VIN
                ItemForm(
                  textItem: "VIN", 
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  readOnly: true,
                  images: const [],
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width * 0.4, 
                  text: userController.usuarioCurrent?.vehicle.target?.vin ?? "PRUEBAVINCARRO01",
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Plate Number
                ItemForm(
                  textItem: "Plate Number", 
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  readOnly: true,
                  images: const [],
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width * 0.4, 
                  text: userController.usuarioCurrent?.vehicle.target?.licensePlates ?? "H52-86R",
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Last Transmission Fluid Change
                ItemForm(
                  textItem: "Last Transmission Fluid Change", 
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  readOnly: true,
                  images: const [],
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width * 0.4, 
                  text: DateFormat('d-MMMM-y').format(userController.usuarioCurrent?.vehicle.target?.lastTransmissionFluidChange ?? DateTime.now()),
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Last Radiator Fluid Change
                ItemForm(
                  textItem: "Last Radiator Fluid Change", 
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  readOnly: true,
                  images: const [],
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width * 0.4, 
                  text: DateFormat('d-MMMM-y').format(userController.usuarioCurrent?.vehicle.target?.lastRadiatorFluidChange?? DateTime.now()),
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Oil Change Due
                ItemForm(
                  textItem: "Oil Change Due", 
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  readOnly: true,
                  images: const [],
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width * 0.4, 
                  text: DateFormat('d-MMMM-y').format(userController.usuarioCurrent?.vehicle.target?.oilChangeDue ?? DateTime.now()),
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
