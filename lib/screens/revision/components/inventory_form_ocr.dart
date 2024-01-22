
import 'dart:io' as libraryIO;
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/vehiculo_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/checkout_form_controller.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class InvetoryFormOCR extends StatelessWidget {
  
  InvetoryFormOCR({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final checkOutProvider = Provider.of<CheckOutFormController>(context);
    final userController = Provider.of<UsuarioController>(context);
    final vehicleProvider = Provider.of<VehiculoController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Form(
        key: keyForm,
        child: SizedBox( // Need to use container to add size constraint.
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        ScalableOCR(
                            paintboxCustom: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4.0
                              ..color = FlutterFlowTheme.of(context).primaryColor,
                            boxHeight: MediaQuery.of(context).size.height / 3,
                            getScannedText: (value) {
                              checkOutProvider.autofillFields(value);
                            }),
                        FFButtonWidget(
                          onPressed: () async {
                            checkOutProvider.changeActiveOCR(false);
                          },
                          text: 'Close',
                          icon: const Icon(
                            Icons.cancel_outlined,
                            size: 15,
                          ),
                          options: FFButtonOptions(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: 40,
                            color: FlutterFlowTheme.of(context)
                                .white,
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .subtitle2Family,
                                  color: FlutterFlowTheme.of(context).alternate,
                                  fontSize: 15,
                                ),
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 2,
                            ),
                            borderRadius:
                                BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: checkOutProvider.productIDTextController,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.speed_outlined,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                      labelText: 'Product ID*',
                      labelStyle: FlutterFlowTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the product ID...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1,
                    textAlign: TextAlign.start,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: checkOutProvider.brandTextController,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.speed_outlined,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                      labelText: 'Brand*',
                      labelStyle: FlutterFlowTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the brand...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1,
                    textAlign: TextAlign.start,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: checkOutProvider.modelTextController,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.speed_outlined,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                      labelText: 'Model*',
                      labelStyle: FlutterFlowTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the model...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1,
                    textAlign: TextAlign.start,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: checkOutProvider.serialNumberTextController,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.speed_outlined,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                      labelText: 'Serial Number*',
                      labelStyle: FlutterFlowTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the serial number...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                    ),
                    style: FlutterFlowTheme.of(context).bodyText1,
                    textAlign: TextAlign.start,
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: GestureDetector(
                    onTap: () {
                      //Este botón sí guarda la información ingresada para Mileage
                      final mileageInt = int.parse(checkOutProvider.mileage != "" ? checkOutProvider.mileage.replaceAll(",", "") : "0");
                      if (checkOutProvider.validateKeyForm(keyForm)) {
                        if (userController.isEmployee || (userController.isTechSupervisor && vehicleProvider.vehicleSelected == null)) {
                          //Se valida para ruleOilChange
                          if (userController.usuarioCurrent!.vehicle.target?.ruleOilChange.target?.registered == "False") {
                            final limitMileageService = userController.usuarioCurrent!.vehicle.target!.ruleOilChange.target!.lastMileageService + int.parse(userController.usuarioCurrent!.vehicle.target!.ruleOilChange.target!.value);
                            if (limitMileageService - mileageInt <= 100) {
                              //Se activa la bandera oil a true
                              checkOutProvider.flagOilChange = true;
                            }
                          }
                          //Se valida para ruleTransmissionFluidChange
                          if (userController.usuarioCurrent!.vehicle.target?.ruleTransmissionFluidChange.target?.registered == "False") {
                            final limitMileageService = userController.usuarioCurrent!.vehicle.target!.ruleTransmissionFluidChange.target!.lastMileageService + int.parse(userController.usuarioCurrent!.vehicle.target!.ruleTransmissionFluidChange.target!.value);
                            if (limitMileageService - mileageInt <= 100) {
                              // Se actualiza la bandera transmission a true
                              checkOutProvider.flagTransmissionFluidChange = true;
                            }
                          }
                          //Se valida para ruleRadiatorFluidChange
                          if (userController.usuarioCurrent!.vehicle.target?.ruleRadiatorFluidChange.target?.registered == "False") {
                            final limitMileageService = userController.usuarioCurrent!.vehicle.target!.ruleRadiatorFluidChange.target!.lastMileageService + int.parse(userController.usuarioCurrent!.vehicle.target!.ruleRadiatorFluidChange.target!.value);
                            if (limitMileageService - mileageInt <= 100) {
                              // Se actualiza la bandera radiator a true
                              checkOutProvider.flagRadiatorFluidChange = true;
                            }
                          }
                          //Se valida para ruleTireChange
                          if (userController.usuarioCurrent!.vehicle.target?.ruleTireChange.target?.registered == "False") {
                            final limitMileageService = userController.usuarioCurrent!.vehicle.target!.ruleTireChange.target!.lastMileageService + int.parse(userController.usuarioCurrent!.vehicle.target!.ruleTireChange.target!.value);
                            if (limitMileageService - mileageInt <= 100) {
                              // Se actualiza la bandera radiator a true
                              checkOutProvider.flagTireChange = true;
                            }
                          }
                          //Se valida para ruleBrakeChange
                          if (userController.usuarioCurrent!.vehicle.target?.ruleBrakeChange.target?.registered == "False") {
                            final limitMileageService = userController.usuarioCurrent!.vehicle.target!.ruleBrakeChange.target!.lastMileageService + int.parse(userController.usuarioCurrent!.vehicle.target!.ruleBrakeChange.target!.value);
                            if (limitMileageService - mileageInt <= 100) {
                              // Se actualiza la bandera radiator a true
                              checkOutProvider.flagBrakeChange = true;
                            }
                          }
                          Navigator.pop(context);
                        } else {
                          if (vehicleProvider.vehicleSelected != null) {
                            //Se valida para ruleOilChange
                            if (vehicleProvider.vehicleSelected!.ruleOilChange.target?.registered == "False") {
                              final limitMileageService = vehicleProvider.vehicleSelected!.ruleOilChange.target!.lastMileageService + int.parse(vehicleProvider.vehicleSelected!.ruleOilChange.target!.value);
                              if (limitMileageService - mileageInt <= 100) {
                                //Se activa la bandera oil a true
                                checkOutProvider.flagOilChange = true;
                              }
                            }
                            //Se valida para ruleTransmissionFluidChange
                            if (vehicleProvider.vehicleSelected!.ruleTransmissionFluidChange.target?.registered == "False") {
                              final limitMileageService = vehicleProvider.vehicleSelected!.ruleTransmissionFluidChange.target!.lastMileageService + int.parse(vehicleProvider.vehicleSelected!.ruleTransmissionFluidChange.target!.value);
                              if (limitMileageService - mileageInt <= 100) {
                                // Se actualiza la bandera transmission a true
                                checkOutProvider.flagTransmissionFluidChange = true;
                              }
                            }
                            //Se valida para ruleRadiatorFluidChange
                            if (vehicleProvider.vehicleSelected!.ruleRadiatorFluidChange.target?.registered == "False") {
                              final limitMileageService = vehicleProvider.vehicleSelected!.ruleRadiatorFluidChange.target!.lastMileageService + int.parse(vehicleProvider.vehicleSelected!.ruleRadiatorFluidChange.target!.value);
                              if (limitMileageService - mileageInt <= 100) {
                                // Se actualiza la bandera radiator a true
                                checkOutProvider.flagRadiatorFluidChange = true;
                              }
                            }
                            //Se valida para ruleTireChange
                            if (vehicleProvider.vehicleSelected!.ruleTireChange.target?.registered == "False") {
                              final limitMileageService = vehicleProvider.vehicleSelected!.ruleTireChange.target!.lastMileageService + int.parse(vehicleProvider.vehicleSelected!.ruleTireChange.target!.value);
                              if (limitMileageService - mileageInt <= 100) {
                                // Se actualiza la bandera radiator a true
                                checkOutProvider.flagTireChange = true;
                              }
                            }
                            //Se valida para ruleBrakeChange
                            if (vehicleProvider.vehicleSelected!.ruleBrakeChange.target?.registered == "False") {
                              final limitMileageService = vehicleProvider.vehicleSelected!.ruleBrakeChange.target!.lastMileageService + int.parse(vehicleProvider.vehicleSelected!.ruleBrakeChange.target!.value);
                              if (limitMileageService - mileageInt <= 100) {
                                // Se actualiza la bandera radiator a true
                                checkOutProvider.flagBrakeChange = true;
                              }
                            }
                          }
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: ClayContainer(
                      height: 50,
                      width: 200,
                      depth: 15,
                      spread: 3,
                      borderRadius: 25,
                      curveType: CurveType.concave,
                      color:
                      FlutterFlowTheme.of(context).primaryColor,
                      surfaceColor:
                      FlutterFlowTheme.of(context).primaryColor,
                      parentColor:
                      FlutterFlowTheme.of(context).primaryColor,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            'Accept',
                            style: FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Lexend Deca',
                              color: FlutterFlowTheme.of(context).white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text("Readed text: $text");
  }
}