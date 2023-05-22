import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/orden_trabajo_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/expanded_text.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

class MeasuresSection extends StatefulWidget {
  
  const MeasuresSection({super.key});

  @override
  State<MeasuresSection> createState() => _MeasuresSectionState();
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

class _MeasuresSectionState extends State<MeasuresSection> {
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
                  text: "General information",
                ),
                // ID VEHICLE
                ItemForm(
                  textItem: "ID Vehicle", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width, 
                  text: "12",
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
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width, 
                  text: "Mercedes",
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
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width, 
                  text: "A1",
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
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width, 
                  text: "2019",
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
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width, 
                  text: "PRUEBAVINCARRO01",
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
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width, 
                  text: "H52-86R",
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Week
                ItemForm(
                  textItem: "Week", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width, 
                  text: "21",
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Registration Due
                ItemForm(
                  textItem: "Registration Due", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width, 
                  text: "12-MAY-2024",
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Insurance Renewal Due
                ItemForm(
                  textItem: "Insurance Renewal Due", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width, 
                  text: "12-MAY-2024",
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
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: true,
                ),
                ExpandedText(
                  width: MediaQuery.of(context).size.width, 
                  text: "08-SEP-2024",
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
                  text: "Measures",
                ),
                // MILEAGE
                ItemForm(
                  textItem: "Mileage", 
                  onPressed: () {

                  }, 
                  isRight: false,
                  isRegistered: false,
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // %GAS/DIESEL
                ItemForm(
                  textItem: "% Gas/Diesel", 
                  onPressed: () async {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        final ordenTrabajoProvider = Provider.of<OrdenTrabajoController>(context);
                        return AlertDialog(
                          title: const Text("Porcentaje de Gasolina"),
                          content: SizedBox( // Need to use container to add size constraint.
                            width: 300,
                            height: 300,
                            child: Center(
                              child: Column(
                                children: [
                                  SemicircularIndicator(
                                    progress: ordenTrabajoProvider.porcentajeGasolina * 0.01,
                                    radius: 100,
                                    color: FlutterFlowTheme.of(context).primaryColor,
                                    backgroundColor: FlutterFlowTheme.of(context).grayLighter,
                                    strokeWidth: 13,
                                    bottomPadding: 0,
                                    contain: true,
                                    child: Text(
                                      "${ordenTrabajoProvider.porcentajeGasolina} %",
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w600,
                                          color: FlutterFlowTheme.of(context).primaryColor),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Icon(
                                        Icons.local_gas_station_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 40,
                                      ),
                                      Icon(
                                        Icons.local_gas_station_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 40,
                                      )
                                    ],),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SfSlider(
                                        min: 0.0,
                                        max: 100.0,
                                        interval: 1.0,
                                        value: ordenTrabajoProvider.porcentajeGasolina, 
                                        stepSize: 1.0,
                                        activeColor: FlutterFlowTheme.of(context).secondaryColor,
                                        inactiveColor: FlutterFlowTheme.of(context).grayLighter,
                                        onChanged: ((value) {
                                          ordenTrabajoProvider.actualizarPorcentajeGasolina(value.truncate());
                                        })
                                      ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        setState(() {
                                          ordenTrabajoProvider.gasolinaController = TextEditingController(
                                            text: ordenTrabajoProvider.porcentajeGasolina.toString()
                                          );
                                        });
                                        Navigator.pop(context);
                                      },
                                      text: 'Aceptar',
                                      options: FFButtonOptions(
                                        width: 200,
                                        height: 50,
                                        color: FlutterFlowTheme.of(context).secondaryColor,
                                        textStyle:
                                            FlutterFlowTheme.of(context).subtitle1.override(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                        elevation: 3,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }, 
                  isRight: false,
                  isRegistered: false,
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
