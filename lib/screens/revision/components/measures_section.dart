import 'dart:convert';
import 'dart:io' as libraryIO;
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/save_imagenes_local.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/delivery_form_controller.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/expanded_text.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';
import 'package:taller_alex_app_asesor/screens/widgets/bottom_sheet_imagenes_completas.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_carousel.dart';
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
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: const [],
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
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: const [],
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
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: const [],
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
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: const [],
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
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: const [],
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
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: const [],
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
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: const [],
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
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: const [],
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
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: const [],
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
                  applyFuction: true,
                  onPressed: () {
                    snackbarKey.currentState
                        ?.showSnackBar(const SnackBar(
                      content: Text(
                          "This item can't be edited."),
                    ));
                  }, 
                  isRight: false,
                  isRegistered: true,
                  images: const [],
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
                  applyFuction: true,
                  onPressed: () async {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        final deliveryFormProvider = Provider.of<DeliveryFormController>(context);
                        List<XFile> imagenesTemp = [];
                        return AlertDialog(
                          scrollable: true,
                          title: const Text("Mileage"),
                          content: SizedBox( // Need to use container to add size constraint.
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 5, 20),
                                    child: TextFormField(
                                      controller: deliveryFormProvider.mileageController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      obscureText: false,
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
                                      controller: deliveryFormProvider.mileageComments,
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
                                                              deliveryFormProvider.mileageImages)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 10, 0, 0),
                                                  child: Text(
                                                    "Total: ${deliveryFormProvider.mileageImages.length}",
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
                                              // imagenesTemp = [];
                                              XFile? pickedFile;
                                              List<XFile>? pickedFiles;
                                              if (option == 'camera') {
                                                if (deliveryFormProvider.mileageImages.length <
                                                    5) {
                                                  pickedFile =
                                                      await picker.pickImage(
                                                    source: ImageSource.camera,
                                                  );
                                                  if (pickedFile != null) {
                                                    imagenesTemp.add(pickedFile);
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
                                                      deliveryFormProvider.updateMileageImage(
                                                        pickedFile.path);
                                                    }
                                                    return;
                                                  }
                                                }
                                              } else {
                                                //Se selecciona galería
                                                if (deliveryFormProvider.mileageImages.length <
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
                                                  switch (deliveryFormProvider.mileageImages.length) {
                                                    case 0:
                                                      for (int i = 0;
                                                          i < pickedFiles.length;
                                                          i++) {
                                                        imagenesTemp
                                                            .add(pickedFiles[i]);
                                                      }
                                                      break;
                                                    case 1:
                                                      if (pickedFiles.length <= 4) {
                                                        for (int i = 0;
                                                            i < pickedFiles.length;
                                                            i++) {
                                                          imagenesTemp
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
                                                          imagenesTemp
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
                                                          imagenesTemp
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
                                                          imagenesTemp
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
                                                      deliveryFormProvider.updateMileageImage(
                                                        pickedFile.path);
                                                    }
                                                    return;
                                                  }
                                                }
                                              }
                                              for (var i = 0;
                                                  i < imagenesTemp.length;
                                                  i++) {
                                                libraryIO.File file =
                                                    libraryIO.File(
                                                        imagenesTemp[i].path);

                                                List<int> fileInByte =
                                                    file.readAsBytesSync();

                                                String base64 =
                                                    base64Encode(fileInByte);

                                                var newImagenLocal =
                                                    SaveImagenesLocal(
                                                        nombre:
                                                            imagenesTemp[i].name,
                                                        path:
                                                            imagenesTemp[i].path,
                                                        base64: base64);
                                                // widget.images
                                                //     .add(base64);
                                                deliveryFormProvider.addMileageImage(
                                                  imagenesTemp[i].path);
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
                  isRegistered: false,
                  images: const [],
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
                        final deliveryFormProvider = Provider.of<DeliveryFormController>(context);
                        List<XFile> imagenesTemp = [];
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
                                    progress: deliveryFormProvider.gasDieselPercent * 0.01,
                                    radius: 100,
                                    color: FlutterFlowTheme.of(context).primaryColor,
                                    backgroundColor: FlutterFlowTheme.of(context).grayLighter,
                                    strokeWidth: 13,
                                    bottomPadding: 0,
                                    contain: true,
                                    child: Text(
                                      "${deliveryFormProvider.gasDieselPercent} %",
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
                                        value: deliveryFormProvider.gasDieselPercent, 
                                        stepSize: 1.0,
                                        activeColor: FlutterFlowTheme.of(context).secondaryColor,
                                        inactiveColor: FlutterFlowTheme.of(context).grayLighter,
                                        onChanged: ((value) {
                                          deliveryFormProvider.updateGasDieselPercent(value.truncate());
                                        })
                                      ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 5, 10),
                                    child: TextFormField(
                                      controller: deliveryFormProvider.gasComments,
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
                                                              deliveryFormProvider.gasImages)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 10, 0, 0),
                                                  child: Text(
                                                    "Total: ${deliveryFormProvider.gasImages.length}",
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
                                              // imagenesTemp = [];
                                              XFile? pickedFile;
                                              List<XFile>? pickedFiles;
                                              if (option == 'camera') {
                                                if (deliveryFormProvider.gasImages.length <
                                                    5) {
                                                  pickedFile =
                                                      await picker.pickImage(
                                                    source: ImageSource.camera,
                                                  );
                                                  if (pickedFile != null) {
                                                    imagenesTemp.add(pickedFile);
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
                                                      deliveryFormProvider.updateGasImage
                                                        (pickedFile.path);
                                                    }
                                                    return;
                                                  }
                                                }
                                              } else {
                                                //Se selecciona galería
                                                if (deliveryFormProvider.gasImages.length <
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
                                                  switch (deliveryFormProvider.gasImages.length) {
                                                    case 0:
                                                      for (int i = 0;
                                                          i < pickedFiles.length;
                                                          i++) {
                                                        imagenesTemp
                                                            .add(pickedFiles[i]);
                                                      }
                                                      break;
                                                    case 1:
                                                      if (pickedFiles.length <= 4) {
                                                        for (int i = 0;
                                                            i < pickedFiles.length;
                                                            i++) {
                                                          imagenesTemp
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
                                                          imagenesTemp
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
                                                          imagenesTemp
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
                                                          imagenesTemp
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
                                                      deliveryFormProvider.updateGasImage
                                                        (pickedFile.path);
                                                    }
                                                    return;
                                                  }
                                                }
                                              }
                                              for (var i = 0;
                                                  i < imagenesTemp.length;
                                                  i++) {
                                                libraryIO.File file =
                                                    libraryIO.File(
                                                        imagenesTemp[i].path);

                                                List<int> fileInByte =
                                                    file.readAsBytesSync();

                                                String base64 =
                                                    base64Encode(fileInByte);

                                                var newImagenLocal =
                                                    SaveImagenesLocal(
                                                        nombre:
                                                            imagenesTemp[i].name,
                                                        path:
                                                            imagenesTemp[i].path,
                                                        base64: base64);
                                                // widget.images
                                                //     .add(base64);
                                                deliveryFormProvider.addGasImage
                                                  (imagenesTemp[i].path);
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
                  isRegistered: false,
                  images: const [],
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