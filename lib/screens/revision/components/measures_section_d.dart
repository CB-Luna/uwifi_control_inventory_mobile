import 'dart:convert';
import 'dart:io' as libraryIO;
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:taller_alex_app_asesor/database/image_evidence.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/delivered_form_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/expanded_text.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';
import 'package:taller_alex_app_asesor/screens/widgets/bottom_sheet_imagenes_completas.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_carousel.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

class MeasuresSectionD extends StatefulWidget {
  
  const MeasuresSectionD({super.key});

  @override
  State<MeasuresSectionD> createState() => _MeasuresSectionDState();
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

class _MeasuresSectionDState extends State<MeasuresSectionD> {
  @override
  Widget build(BuildContext context) {
    final deliveredFormController = Provider.of<DeliveredFormController>(context);
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

                // Registration Due
                ItemForm(
                  textItem: "Registration Due", 
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
                  text: DateFormat('d-MMMM-y').format(userController.usuarioCurrent?.vehicle.target?.registrationDue ?? DateTime.now()),
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
                  text: DateFormat('d-MMMM-y').format(userController.usuarioCurrent?.vehicle.target?.insuranceRenewalDue?? DateTime.now()),
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
                  applyFuction: true,
                  onPressed: () async {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        List<XFile> imagesTemp = [];
                        final deliveredFormProvider = Provider.of<DeliveredFormController>(context);
                        return AlertDialog(
                          scrollable: true,
                          title: const Text("Mileage"),
                          content: SizedBox( // Need to use container to add size constraint.
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 5, 20),
                                    child: TextFormField(
                                      initialValue: deliveredFormProvider.mileage,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: false,
                                      onChanged: (value) {
                                        deliveredFormProvider.updateMileage(value);
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.speed_outlined,
                                          color: FlutterFlowTheme.of(context).alternate,
                                        ),
                                        labelText: 'Mileage*',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).grayDark,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        hintText: 'Input the mileage...',
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
                                        suffixText: 'Mi',
                                      ),
                                      style: FlutterFlowTheme.of(context).bodyText1,
                                      textAlign: TextAlign.start,
                                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                            return 'The Mileage is required.';
                                          } 
                                          return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 5, 20),
                                    child: TextFormField(
                                      controller: deliveredFormProvider.mileageComments,
                                      maxLength: 500,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Comments',
                                        labelStyle:
                                            FlutterFlowTheme.of(context).title3.override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                        hintText: 'Input your comments...',
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
                                  FormField(builder: (state) {
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 5, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 10, 0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFEEEEEE),
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                  ),
                                                  child: SizedBox(
                                                      width: 180,
                                                      height: 100,
                                                      child: FlutterFlowCarousel(
                                                          width: 180,
                                                          height: 100,
                                                          listaImagenes:
                                                              deliveredFormProvider.mileageImages)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 10, 0, 0),
                                                  child: Text(
                                                    "Total: ${deliveredFormProvider.mileageImages.length}",
                                                    style: FlutterFlowTheme.of(context)
                                                        .title3
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              FlutterFlowTheme.of(context)
                                                                  .secondaryText,
                                                          fontSize: 12.5,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          FFButtonWidget(
                                            onPressed: () async {
                                              String? option =
                                                  await showModalBottomSheet(
                                                context: context,
                                                builder: (_) =>
                                                    const CustomBottomSheet(),
                                              );

                                              if (option == null) return;

                                              final picker = ImagePicker();
                                              // imagesTemp = [];
                                              XFile? pickedFile;
                                              List<XFile>? pickedFiles;
                                              if (option == 'camera') {
                                                if (deliveredFormProvider.mileageImages.length <
                                                    5) {
                                                  pickedFile =
                                                      await picker.pickImage(
                                                    source: ImageSource.camera,
                                                  );
                                                  if (pickedFile != null) {
                                                    imagesTemp.add(pickedFile);
                                                  }
                                                } else {
                                                  bool? booleano =
                                                      // ignore: use_build_context_synchronously
                                                      await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding:
                                                            MediaQuery.of(context)
                                                                .viewInsets,
                                                        child: SizedBox(
                                                          height:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                  0.45,
                                                          child:
                                                              const BottomSheetImagenesCompletas(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                  if (booleano != null &&
                                                      booleano == true) {
                                                    pickedFile =
                                                        await picker.pickImage(
                                                      source: ImageSource.camera,

                                                    );
                                                    if (pickedFile != null) {
                                                      libraryIO.File file =
                                                      libraryIO.File(
                                                          pickedFile.path);

                                                      List<int> fileInByte =
                                                          file.readAsBytesSync();

                                                      String base64 =
                                                          base64Encode(fileInByte);

                                                      var updateImageEvidence =
                                                          ImageEvidence(
                                                              path:
                                                                  pickedFile.path,
                                                              base64: base64);
                                                        deliveredFormProvider.updateMileageImage(
                                                          updateImageEvidence);
                                                    }
                                                    return;
                                                  }
                                                }
                                              } else {
                                                //Se selecciona galería
                                                if (deliveredFormProvider.mileageImages.length <
                                                    5) {
                                                  pickedFiles =
                                                      await picker.pickMultiImage(
                                                  );
                                                  if (pickedFiles == null) {
                                                    return;
                                                  }
                                                  if (pickedFiles.length > 5) {
                                                    snackbarKey.currentState
                                                        ?.showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          "Not allowed to upload more than 5 images."),
                                                    ));
                                                    return;
                                                  }
                                                  switch (deliveredFormProvider.mileageImages.length) {
                                                    case 0:
                                                      for (int i = 0;
                                                          i < pickedFiles.length;
                                                          i++) {
                                                        imagesTemp
                                                            .add(pickedFiles[i]);
                                                      }
                                                      break;
                                                    case 1:
                                                      if (pickedFiles.length <= 4) {
                                                        for (int i = 0;
                                                            i < pickedFiles.length;
                                                            i++) {
                                                          imagesTemp
                                                              .add(pickedFiles[i]);
                                                        }
                                                      } else {
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Not allowed to upload more than 5 images."),
                                                        ));
                                                        return;
                                                      }
                                                      break;
                                                    case 2:
                                                      if (pickedFiles.length <= 3) {
                                                        for (int i = 0;
                                                            i < pickedFiles.length;
                                                            i++) {
                                                          imagesTemp
                                                              .add(pickedFiles[i]);
                                                        }
                                                      } else {
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Not allowed to upload more than 5 images."),
                                                        ));
                                                        return;
                                                      }
                                                      break;
                                                    case 3:
                                                      if (pickedFiles.length <= 4) {
                                                        for (int i = 0;
                                                            i < pickedFiles.length;
                                                            i++) {
                                                          imagesTemp
                                                              .add(pickedFiles[i]);
                                                        }
                                                      } else {
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Not allowed to upload more than 5 images."),
                                                        ));
                                                        return;
                                                      }
                                                      break;
                                                    case 4:
                                                      if (pickedFiles.length <= 1) {
                                                        for (int i = 0;
                                                            i < pickedFiles.length;
                                                            i++) {
                                                          imagesTemp
                                                              .add(pickedFiles[i]);
                                                        }
                                                      } else {
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Not allowed to upload more than 5 images."),
                                                        ));
                                                        return;
                                                      }
                                                      break;
                                                    default:
                                                      break;
                                                  }
                                                } else {
                                                  bool? booleano =
                                                      // ignore: use_build_context_synchronously
                                                      await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding:
                                                            MediaQuery.of(context)
                                                                .viewInsets,
                                                        child: SizedBox(
                                                          height:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                  0.45,
                                                          child:
                                                              const BottomSheetImagenesCompletas(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                  if (booleano != null &&
                                                      booleano == true) {
                                                    pickedFile =
                                                        await picker.pickImage(
                                                      source: ImageSource.gallery,

                                                    );
                                                    if (pickedFile != null) {
                                                      libraryIO.File file =
                                                      libraryIO.File(
                                                          pickedFile.path);

                                                      List<int> fileInByte =
                                                          file.readAsBytesSync();

                                                      String base64 =
                                                          base64Encode(fileInByte);

                                                      var updateImageEvidence =
                                                          ImageEvidence(
                                                              path:
                                                                  pickedFile.path,
                                                              base64: base64);
                                                        deliveredFormProvider.updateMileageImage(
                                                          updateImageEvidence);
                                                    }
                                                    return;
                                                  }
                                                }
                                              }
                                              for (var i = 0;
                                                  i < imagesTemp.length;
                                                  i++) {
                                                libraryIO.File file =
                                                    libraryIO.File(
                                                        imagesTemp[i].path);

                                                List<int> fileInByte =
                                                    file.readAsBytesSync();

                                                String base64 =
                                                    base64Encode(fileInByte);

                                                var newImageEvidence =
                                                    ImageEvidence(
                                                        path:
                                                            imagesTemp[i].path,
                                                        base64: base64);
                                                deliveredFormProvider.addMileageImage(
                                                  newImageEvidence);
                                                imagesTemp.clear();
                                              }
                                            },
                                            text: 'Add',
                                            icon: const Icon(
                                              Icons.add_a_photo,
                                              size: 15,
                                            ),
                                            options: FFButtonOptions(
                                              width: 100,
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
                                    );
                                  }, validator: (val) {
                                    if (val == []) {
                                      return 'Images are required';
                                    }
                                    return null;
                                  }),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: ClayContainer(
                                        height: 50,
                                        width: 200,
                                        depth: 15,
                                        spread: 3,
                                        borderRadius: 25,
                                        curveType: CurveType.concave,
                                        color:
                                        FlutterFlowTheme.of(context).alternate,
                                        surfaceColor:
                                        FlutterFlowTheme.of(context).alternate,
                                        parentColor:
                                        FlutterFlowTheme.of(context).alternate,
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
                        );
                      },
                    );
                  },  
                  isRight: false,
                  readOnly: false,
                  images: const [],
                  isRegistered: deliveredFormController.isMileageRegistered,
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
                  applyFuction: true,
                  onPressed: () async {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        List<XFile> imagesTemp = [];
                        final deliveredFormProvider = Provider.of<DeliveredFormController>(context);
                        List<String> imagesString = [];
                        for (var element in deliveredFormProvider.gasImages) {
                          imagesString.add(element.path);
                        }
                        return AlertDialog(
                          scrollable: true,
                          title: const Text("% Gas/Diesel"),
                          content: SizedBox( // Need to use container to add size constraint.
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Center(
                              child: Column(
                                children: [
                                  SemicircularIndicator(
                                    progress: deliveredFormProvider.gasDieselPercent * 0.01,
                                    radius: 100,
                                    color: FlutterFlowTheme.of(context).primaryColor,
                                    backgroundColor: FlutterFlowTheme.of(context).grayLighter,
                                    strokeWidth: 13,
                                    bottomPadding: 0,
                                    contain: true,
                                    child: Text(
                                      "${deliveredFormProvider.gasDieselPercent} %",
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
                                        value: deliveredFormProvider.gasDieselPercent, 
                                        stepSize: 1.0,
                                        activeColor: FlutterFlowTheme.of(context).secondaryColor,
                                        inactiveColor: FlutterFlowTheme.of(context).grayLighter,
                                        onChanged: ((value) {
                                          deliveredFormProvider.updateGasDieselPercent(value.truncate());
                                        })
                                      ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 5, 10),
                                    child: TextFormField(
                                      controller: deliveredFormProvider.gasComments,
                                      maxLength: 500,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Comments',
                                        labelStyle:
                                            FlutterFlowTheme.of(context).title3.override(
                                                  fontFamily: 'Montserrat',
                                                  color: FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                        hintText: 'Input your comments...',
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
                                  FormField(builder: (state) {
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 5, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 10, 0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFEEEEEE),
                                                    borderRadius:
                                                        BorderRadius.circular(5),
                                                  ),
                                                  child: SizedBox(
                                                      width: 180,
                                                      height: 100,
                                                      child: FlutterFlowCarousel(
                                                          width: 180,
                                                          height: 100,
                                                          listaImagenes:
                                                              deliveredFormProvider.gasImages)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 10, 0, 0),
                                                  child: Text(
                                                    "Total: ${deliveredFormProvider.gasImages.length}",
                                                    style: FlutterFlowTheme.of(context)
                                                        .title3
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              FlutterFlowTheme.of(context)
                                                                  .secondaryText,
                                                          fontSize: 12.5,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          FFButtonWidget(
                                            onPressed: () async {
                                              String? option =
                                                  await showModalBottomSheet(
                                                context: context,
                                                builder: (_) =>
                                                    const CustomBottomSheet(),
                                              );

                                              if (option == null) return;

                                              final picker = ImagePicker();
                                              // imagesTemp = [];
                                              XFile? pickedFile;
                                              List<XFile>? pickedFiles;
                                              if (option == 'camera') {
                                                if (deliveredFormProvider.gasImages.length <
                                                    5) {
                                                  pickedFile =
                                                      await picker.pickImage(
                                                    source: ImageSource.camera,
                                                  );
                                                  if (pickedFile != null) {
                                                    imagesTemp.add(pickedFile);
                                                  }
                                                } else {
                                                  bool? booleano =
                                                      // ignore: use_build_context_synchronously
                                                      await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding:
                                                            MediaQuery.of(context)
                                                                .viewInsets,
                                                        child: SizedBox(
                                                          height:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                  0.45,
                                                          child:
                                                              const BottomSheetImagenesCompletas(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                  if (booleano != null &&
                                                      booleano == true) {
                                                    pickedFile =
                                                        await picker.pickImage(
                                                      source: ImageSource.camera,

                                                    );
                                                    if (pickedFile != null) {
                                                      libraryIO.File file =
                                                      libraryIO.File(
                                                          pickedFile.path);

                                                      List<int> fileInByte =
                                                          file.readAsBytesSync();

                                                      String base64 =
                                                          base64Encode(fileInByte);

                                                      var updateImageEvidence =
                                                          ImageEvidence(
                                                              path:
                                                                  pickedFile.path,
                                                              base64: base64);
                                                        deliveredFormProvider.updateGasImage(
                                                          updateImageEvidence);
                                                    }
                                                    return;
                                                  }
                                                }
                                              } else {
                                                //Se selecciona galería
                                                if (deliveredFormProvider.gasImages.length <
                                                    5) {
                                                  pickedFiles =
                                                      await picker.pickMultiImage(
                                                  );
                                                  if (pickedFiles == null) {
                                                    return;
                                                  }
                                                  if (pickedFiles.length > 5) {
                                                    snackbarKey.currentState
                                                        ?.showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          "Not allowed to upload more than 5 images."),
                                                    ));
                                                    return;
                                                  }
                                                  switch (deliveredFormProvider.gasImages.length) {
                                                    case 0:
                                                      for (int i = 0;
                                                          i < pickedFiles.length;
                                                          i++) {
                                                        imagesTemp
                                                            .add(pickedFiles[i]);
                                                      }
                                                      break;
                                                    case 1:
                                                      if (pickedFiles.length <= 4) {
                                                        for (int i = 0;
                                                            i < pickedFiles.length;
                                                            i++) {
                                                          imagesTemp
                                                              .add(pickedFiles[i]);
                                                        }
                                                      } else {
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Not allowed to upload more than 5 images."),
                                                        ));
                                                        return;
                                                      }
                                                      break;
                                                    case 2:
                                                      if (pickedFiles.length <= 3) {
                                                        for (int i = 0;
                                                            i < pickedFiles.length;
                                                            i++) {
                                                          imagesTemp
                                                              .add(pickedFiles[i]);
                                                        }
                                                      } else {
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Not allowed to upload more than 5 images."),
                                                        ));
                                                        return;
                                                      }
                                                      break;
                                                    case 3:
                                                      if (pickedFiles.length <= 4) {
                                                        for (int i = 0;
                                                            i < pickedFiles.length;
                                                            i++) {
                                                          imagesTemp
                                                              .add(pickedFiles[i]);
                                                        }
                                                      } else {
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Not allowed to upload more than 5 images."),
                                                        ));
                                                        return;
                                                      }
                                                      break;
                                                    case 4:
                                                      if (pickedFiles.length <= 1) {
                                                        for (int i = 0;
                                                            i < pickedFiles.length;
                                                            i++) {
                                                          imagesTemp
                                                              .add(pickedFiles[i]);
                                                        }
                                                      } else {
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                              "Not allowed to upload more than 5 images."),
                                                        ));
                                                        return;
                                                      }
                                                      break;
                                                    default:
                                                      break;
                                                  }
                                                } else {
                                                  bool? booleano =
                                                      // ignore: use_build_context_synchronously
                                                      await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding:
                                                            MediaQuery.of(context)
                                                                .viewInsets,
                                                        child: SizedBox(
                                                          height:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                  0.45,
                                                          child:
                                                              const BottomSheetImagenesCompletas(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                  if (booleano != null &&
                                                      booleano == true) {
                                                    pickedFile =
                                                        await picker.pickImage(
                                                      source: ImageSource.gallery,

                                                    );
                                                    if (pickedFile != null) {
                                                      libraryIO.File file =
                                                      libraryIO.File(
                                                          pickedFile.path);

                                                      List<int> fileInByte =
                                                          file.readAsBytesSync();

                                                      String base64 =
                                                          base64Encode(fileInByte);

                                                      var updateImageEvidence =
                                                          ImageEvidence(
                                                              path:
                                                                  pickedFile.path,
                                                              base64: base64);
                                                        deliveredFormProvider.updateGasImage(
                                                          updateImageEvidence);
                                                    }
                                                    return;
                                                  }
                                                }
                                              }
                                              for (var i = 0;
                                                  i < imagesTemp.length;
                                                  i++) {
                                                libraryIO.File file =
                                                    libraryIO.File(
                                                        imagesTemp[i].path);

                                                List<int> fileInByte =
                                                    file.readAsBytesSync();

                                                String base64 =
                                                    base64Encode(fileInByte);

                                                var newImageEvidence =
                                                    ImageEvidence(
                                                        path:
                                                            imagesTemp[i].path,
                                                        base64: base64);
                                                deliveredFormProvider.addGasImage
                                                  (newImageEvidence);
                                                imagesTemp.clear();
                                              }
                                            },
                                            text: 'Add',
                                            icon: const Icon(
                                              Icons.add_a_photo,
                                              size: 15,
                                            ),
                                            options: FFButtonOptions(
                                              width: 100,
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
                                    );
                                  }, validator: (val) {
                                    if (val == []) {
                                      return 'Images are required';
                                    }
                                    return null;
                                  }),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: ClayContainer(
                                        height: 50,
                                        width: 200,
                                        depth: 15,
                                        spread: 3,
                                        borderRadius: 25,
                                        curveType: CurveType.concave,
                                        color:
                                        FlutterFlowTheme.of(context).alternate,
                                        surfaceColor:
                                        FlutterFlowTheme.of(context).alternate,
                                        parentColor:
                                        FlutterFlowTheme.of(context).alternate,
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
                        );
                      },
                    );
                  }, 
                  isRight: false,
                  readOnly: false,
                  images: const [],
                  isRegistered: deliveredFormController.isGasRegistered,
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
