import 'dart:async';
import 'dart:developer';
import 'dart:io' as libraryIO;
import 'dart:typed_data';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/vehiculo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/database/image_evidence.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/checkout_form_controller.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/flutter_flow_animaciones.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/header_shimmer.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_bottom_sheet.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_carousel.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class MeasuresSectionR extends StatefulWidget {
  
  const MeasuresSectionR({super.key});

  @override
  State<MeasuresSectionR> createState() => _MeasuresSectionRState();
}
final scaffoldKey = GlobalKey<ScaffoldState>();
final keyForm = GlobalKey<FormState>();
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

class _MeasuresSectionRState extends State<MeasuresSectionR> {
  String text = "";
  final StreamController<String> controller = StreamController<String>();

  void setText(value) {
    controller.add(value);
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final checkOutProvider = Provider.of<CheckOutFormController>(context);
    final userController = Provider.of<UsuarioController>(context);
    final vehicleProvider = Provider.of<VehiculoController>(context);
    final mileage = checkOutProvider.mileage;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                // HEADER
                HeaderShimmer(
                  width: MediaQuery.of(context).size.width, 
                  text: "Inventory Form",
                ),
                // Form
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ScalableOCR(
                        boxLeftOff: 0,
                          paintboxCustom: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4.0
                            ..color = const Color.fromARGB(153, 102, 160, 241),
                          boxHeight: MediaQuery.of(context).size.height / 3,
                          getRawData: (value) {
                            inspect(value);
                          },
                          getScannedText: (value) {
                            setText(value);
                          }),
                      StreamBuilder<String>(
                        stream: controller.stream,
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          return Result(text: snapshot.data != null ? snapshot.data! : "");
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Form(
                    key: keyForm,
                    child: SizedBox( // Need to use container to add size constraint.
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: SingleChildScrollView(
                        controller: ScrollController(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 5, 20),
                              child: TextFormField(
                                initialValue: checkOutProvider.mileage,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                onChanged: (value) {
                                  checkOutProvider.updateMileage(value);
                                },
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
                                inputFormatters: [numbersFormat],
                                keyboardType: const TextInputType.numberWithOptions(),
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 5, 20),
                              child: TextFormField(
                                initialValue: checkOutProvider.mileage,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                onChanged: (value) {
                                  checkOutProvider.updateMileage(value);
                                },
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
                                initialValue: checkOutProvider.mileage,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                onChanged: (value) {
                                  checkOutProvider.updateMileage(value);
                                },
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
                                initialValue: checkOutProvider.mileage,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                onChanged: (value) {
                                  checkOutProvider.updateMileage(value);
                                },
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
                                inputFormatters: [numbersFormat],
                                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                                validator: (value) {
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 5, 20),
                              child: TextFormField(
                                controller: checkOutProvider.mileageComments,
                                maxLength: 500,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Capacity or Specifications',
                                  labelStyle:
                                      FlutterFlowTheme.of(context).title3.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                  hintText: 'Input your capacity or specifications...',
                                  hintStyle:
                                      FlutterFlowTheme.of(context).title3.override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).white,
                                ),
                                style: FlutterFlowTheme.of(context).title3.override(
                                      fontFamily: 'Poppins',
                                      color:
                                          FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                maxLines: 3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 5, 20),
                              child: TextFormField(
                                initialValue: checkOutProvider.mileage,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                onChanged: (value) {
                                  checkOutProvider.updateMileage(value);
                                },
                                decoration: InputDecoration(
                                  errorMaxLines: 3,
                                  prefixIcon: Icon(
                                    Icons.speed_outlined,
                                    color: FlutterFlowTheme.of(context).alternate,
                                  ),
                                  labelText: 'Acquisition Date*',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).grayDark,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Input the acquisition date...',
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
                                initialValue: checkOutProvider.mileage,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                onChanged: (value) {
                                  checkOutProvider.updateMileage(value);
                                },
                                decoration: InputDecoration(
                                  errorMaxLines: 3,
                                  prefixIcon: Icon(
                                    Icons.speed_outlined,
                                    color: FlutterFlowTheme.of(context).alternate,
                                  ),
                                  labelText: 'Current Location*',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).grayDark,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Input the current location...',
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
                                initialValue: checkOutProvider.mileage,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                onChanged: (value) {
                                  checkOutProvider.updateMileage(value);
                                },
                                decoration: InputDecoration(
                                  errorMaxLines: 3,
                                  prefixIcon: Icon(
                                    Icons.speed_outlined,
                                    color: FlutterFlowTheme.of(context).alternate,
                                  ),
                                  labelText: 'Connection Status*',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).grayDark,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Input the connection status...',
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
                                initialValue: checkOutProvider.mileage,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                onChanged: (value) {
                                  checkOutProvider.updateMileage(value);
                                },
                                decoration: InputDecoration(
                                  errorMaxLines: 3,
                                  prefixIcon: Icon(
                                    Icons.speed_outlined,
                                    color: FlutterFlowTheme.of(context).alternate,
                                  ),
                                  labelText: 'Network Settings*',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).grayDark,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Input the network settings...',
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
                                initialValue: checkOutProvider.mileage,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                onChanged: (value) {
                                  checkOutProvider.updateMileage(value);
                                },
                                decoration: InputDecoration(
                                  errorMaxLines: 3,
                                  prefixIcon: Icon(
                                    Icons.speed_outlined,
                                    color: FlutterFlowTheme.of(context).alternate,
                                  ),
                                  labelText: 'Location History*',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).grayDark,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Input the current location history...',
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
                                initialValue: checkOutProvider.mileage,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                onChanged: (value) {
                                  checkOutProvider.updateMileage(value);
                                },
                                decoration: InputDecoration(
                                  errorMaxLines: 3,
                                  prefixIcon: Icon(
                                    Icons.speed_outlined,
                                    color: FlutterFlowTheme.of(context).alternate,
                                  ),
                                  labelText: 'Maintenance and Repairs*',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).grayDark,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Input the current last maintenance and repairs...',
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
                                initialValue: checkOutProvider.mileage,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                onChanged: (value) {
                                  checkOutProvider.updateMileage(value);
                                },
                                decoration: InputDecoration(
                                  errorMaxLines: 3,
                                  prefixIcon: Icon(
                                    Icons.speed_outlined,
                                    color: FlutterFlowTheme.of(context).alternate,
                                  ),
                                  labelText: 'Connected Devices Count*',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).grayDark,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  hintText: 'Input the current connected devices count...',
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
                                controller: checkOutProvider.mileageComments,
                                maxLength: 500,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Additional Notes',
                                  labelStyle:
                                      FlutterFlowTheme.of(context).title3.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                  hintText: 'Input your aditional notes...',
                                  hintStyle:
                                      FlutterFlowTheme.of(context).title3.override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primaryText,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).white,
                                ),
                                style: FlutterFlowTheme.of(context).title3.override(
                                      fontFamily: 'Poppins',
                                      color:
                                          FlutterFlowTheme.of(context).primaryText,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                maxLines: 3,
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