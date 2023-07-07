import 'dart:convert';
import 'dart:io' as libraryIO;
import 'dart:typed_data';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:taller_alex_app_asesor/database/image_evidence.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/checkout_form_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/header_shimmer.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/item_form.dart';
import 'package:taller_alex_app_asesor/screens/widgets/bottom_sheet_imagenes_completas.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_carousel.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

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

class _MeasuresSectionRState extends State<MeasuresSectionR> {
  @override
  Widget build(BuildContext context) {
    final checkOutController = Provider.of<CheckOutFormController>(context);
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
                        final checkOutProvider = Provider.of<CheckOutFormController>(context);
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: const Text("Mileage"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  final mileageInt = int.parse(checkOutProvider.mileage != "" ? checkOutProvider.mileage : "0");
                                  if (mileageInt != 0) {
                                    if (mileageInt < userController.usuarioCurrent!.vehicle.target!.mileage) {
                                      checkOutProvider.updateMileage("");
                                      checkOutProvider.flagOilChange = false;
                                      checkOutProvider.flagTransmissionFluidChange = false;
                                      checkOutProvider.flagRadiatorFluidChange = false;
                                    }
                                    if (mileageInt > userController.usuarioCurrent!.vehicle.target!.ruleOilChange.target!.lastMileageService) {
                                      checkOutProvider.updateMileage("");
                                      checkOutProvider.flagOilChange = false;
                                    } 
                                    if (mileageInt > userController.usuarioCurrent!.vehicle.target!.ruleTransmissionFluidChange.target!.lastMileageService) {
                                      checkOutProvider.updateMileage("");
                                      checkOutProvider.flagTransmissionFluidChange = false;
                                    } 
                                    if (mileageInt > userController.usuarioCurrent!.vehicle.target!.ruleRadiatorFluidChange.target!.lastMileageService) {
                                      checkOutProvider.updateMileage("");
                                      checkOutProvider.flagRadiatorFluidChange = false;
                                    } 
                                  }
                                  Navigator.pop(context);
                                },
                                child: ClayContainer(
                                  height: 30,
                                  width: 30,
                                  depth: 15,
                                  spread: 1,
                                  borderRadius: 15,
                                  curveType: CurveType.concave,
                                  color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                                  surfaceColor:
                                  FlutterFlowTheme.of(context).secondaryColor,
                                  parentColor:
                                  FlutterFlowTheme.of(context).secondaryColor,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: FlutterFlowTheme.of(context).white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          content: Form(
                            key: keyForm,
                            child: SizedBox( // Need to use container to add size constraint.
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.55,
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
                                          if (int.parse(value) < userController.usuarioCurrent!.vehicle.target!.mileage) {
                                            return "The value can't be lower than '${userController.usuarioCurrent!.vehicle.target!.mileage}' Mi.";
                                          }
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
                                                                checkOutProvider.mileageImages)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0, 10, 0, 0),
                                                    child: Text(
                                                      "Total: ${checkOutProvider.mileageImages.length}",
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
                                                  if (checkOutProvider.mileageImages.length <
                                                      5) {
                                                    pickedFile =
                                                        await picker.pickImage(
                                                      source: ImageSource.camera,
                                                      imageQuality: 80,
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
                                                        imageQuality: 80,
                              
                                                      );
                                                      if (pickedFile != null) {
                                                        libraryIO.File file =
                                                        libraryIO.File(
                                                            pickedFile.path);
                              
                                                        Uint8List? compressImage = await FlutterImageCompress.compressWithFile(
                                                          file.absolute.path,
                                                          minWidth: 1920,
                                                          minHeight: 1080,
                                                          quality: 80,
                                                        );
                            
                                                        if (compressImage != null) {
                                                          var updateImageEvidence =
                                                            ImageEvidence(
                                                                path:
                                                                    pickedFile.path,
                                                                uint8List: compressImage,
                                                                name: pickedFile.name);
                                                            checkOutProvider.updateMileageImage(
                                                            updateImageEvidence);
                                                        }
                                                      }
                                                      return;
                                                    }
                                                  }
                                                } else {
                                                  //Se selecciona galería
                                                  if (checkOutProvider.mileageImages.length <
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
                                                    switch (checkOutProvider.mileageImages.length) {
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
                                                        imageQuality: 80,
                              
                                                      );
                                                      if (pickedFile != null) {
                                                        libraryIO.File file =
                                                        libraryIO.File(
                                                            pickedFile.path);
                              
                                                        Uint8List? compressImage = await FlutterImageCompress.compressWithFile(
                                                          file.absolute.path,
                                                          minWidth: 1920,
                                                          minHeight: 1080,
                                                          quality: 80,
                                                        );
                            
                                                        if (compressImage != null) {
                                                          var updateImageEvidence =
                                                            ImageEvidence(
                                                                path:
                                                                    pickedFile.path,
                                                                uint8List: compressImage,
                                                                name: pickedFile.name);
                                                            checkOutProvider.updateMileageImage(
                                                            updateImageEvidence);
                                                        }
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
                              
                                                  Uint8List? compressImage = await FlutterImageCompress.compressWithFile(
                                                      file.absolute.path,
                                                      minWidth: 1920,
                                                      minHeight: 1080,
                                                      quality: 80,
                                                    );
                            
                                                    if (compressImage != null) {
                                                      var newImageEvidence =
                                                        ImageEvidence(
                                                            path:
                                                                imagesTemp[i].path,
                                                            uint8List: compressImage,
                                                            name: imagesTemp[i].name);
                                                        checkOutProvider.addMileageImage(
                                                        newImageEvidence);
                                                    }
                                                }
                                                imagesTemp.clear();
                                              },
                                              text: 'Add',
                                              icon: const Icon(
                                                Icons.add_a_photo,
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
                                      );
                                    }),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                      child: GestureDetector(
                                        onTap: () {
                                          final mileageInt = int.parse(checkOutProvider.mileage != "" ? checkOutProvider.mileage : "0");
                                          if (checkOutProvider.validateKeyForm(keyForm)) {
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
                                            Navigator.pop(context);
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
                          ),
                        );
                      },
                    );
                  },  
                  isRight: false,
                  readOnly: false,
                  images: const [],
                  isRegistered: checkOutController.isMileageRegistered,
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
                        final checkOutProvider = Provider.of<CheckOutFormController>(context);
                        List<String> imagesString = [];
                        for (var element in checkOutProvider.gasImages) {
                          imagesString.add(element.path);
                        }
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: const Text("% Gas/Diesel"),
                              ),
                              GestureDetector(
                                onTap: () {
                                    Navigator.pop(context);
                                },
                                child: ClayContainer(
                                  height: 30,
                                  width: 30,
                                  depth: 15,
                                  spread: 1,
                                  borderRadius: 15,
                                  curveType: CurveType.concave,
                                  color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                                  surfaceColor:
                                  FlutterFlowTheme.of(context).secondaryColor,
                                  parentColor:
                                  FlutterFlowTheme.of(context).secondaryColor,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: FlutterFlowTheme.of(context).white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          content: SizedBox( // Need to use container to add size constraint.
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: Column(
                                children: [
                                  SemicircularIndicator(
                                    progress: checkOutProvider.gasDieselPercent * 0.01,
                                    radius: 100,
                                    color: FlutterFlowTheme.of(context).primaryColor,
                                    backgroundColor: FlutterFlowTheme.of(context).grayLighter,
                                    strokeWidth: 13,
                                    bottomPadding: 0,
                                    contain: true,
                                    child: Text(
                                      checkOutProvider.gasDieselString,
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
                                        showDividers: true,
                                        min: 0.0,
                                        max: 100.0,
                                        interval: 25.0,
                                        value: checkOutProvider.gasDieselPercent, 
                                        stepSize: 25.0,
                                        activeColor: FlutterFlowTheme.of(context).secondaryColor,
                                        inactiveColor: FlutterFlowTheme.of(context).grayLighter,
                                        onChanged: ((value) {
                                          checkOutProvider.updateGasDieselPercent(value.truncate());
                                        })
                                      ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 5, 10),
                                    child: TextFormField(
                                      controller: checkOutProvider.gasComments,
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
                                                              checkOutProvider.gasImages)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 10, 0, 0),
                                                  child: Text(
                                                    "Total: ${checkOutProvider.gasImages.length}",
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
                                                if (checkOutProvider.gasImages.length <
                                                    5) {
                                                  pickedFile =
                                                      await picker.pickImage(
                                                    source: ImageSource.camera,
                                                    imageQuality: 80,
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
                                                      imageQuality: 80,
                            
                                                    );
                                                    if (pickedFile != null) {
                                                      libraryIO.File file =
                                                      libraryIO.File(
                                                          pickedFile.path);
                            
                                                      Uint8List? compressImage = await FlutterImageCompress.compressWithFile(
                                                        file.absolute.path,
                                                        minWidth: 1920,
                                                        minHeight: 1080,
                                                        quality: 80,
                                                      );

                                                      if (compressImage != null) {
                                                        var updateImageEvidence =
                                                          ImageEvidence(
                                                              path:
                                                                  pickedFile.path,
                                                              uint8List: compressImage,
                                                              name: pickedFile.name);
                                                          checkOutProvider.updateGasImage(
                                                          updateImageEvidence);
                                                      }
                                                    }
                                                    return;
                                                  }
                                                }
                                              } else {
                                                //Se selecciona galería
                                                if (checkOutProvider.gasImages.length <
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
                                                  switch (checkOutProvider.gasImages.length) {
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
                                                      imageQuality: 80,
                            
                                                    );
                                                    if (pickedFile != null) {
                                                      libraryIO.File file =
                                                      libraryIO.File(
                                                          pickedFile.path);
                            
                                                      Uint8List? compressImage = await FlutterImageCompress.compressWithFile(
                                                        file.absolute.path,
                                                        minWidth: 1920,
                                                        minHeight: 1080,
                                                        quality: 80,
                                                      );

                                                      if (compressImage != null) {
                                                        var updateImageEvidence =
                                                          ImageEvidence(
                                                              path:
                                                                  pickedFile.path,
                                                              uint8List: compressImage,
                                                              name: pickedFile.name);
                                                          checkOutProvider.updateGasImage(
                                                          updateImageEvidence);
                                                      }
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
                            
                                                Uint8List? compressImage = await FlutterImageCompress.compressWithFile(
                                                  file.absolute.path,
                                                  minWidth: 1920,
                                                  minHeight: 1080,
                                                  quality: 80,
                                                );

                                                if (compressImage != null) {
                                                  var updateImageEvidence =
                                                    ImageEvidence(
                                                        path:
                                                            imagesTemp[i].path,
                                                        uint8List: compressImage,
                                                        name: imagesTemp[i].name);
                                                    checkOutProvider.addGasImage(
                                                    updateImageEvidence);
                                                }
                                              }
                                              imagesTemp.clear();
                                            },
                                            text: 'Add',
                                            icon: const Icon(
                                              Icons.add_a_photo,
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
                  isRegistered: checkOutController.isGasRegistered,
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
                  text: "Fluids Check",
                ),
                // Engine Oil
                ItemForm(
                  textItem: "Engine Oil",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkOutController.engineOilImages,
                  addImage: (image) {
                    checkOutController.addEngineOilImage(image);
                  },
                  updateImage: (image) {
                    checkOutController.updateEngineOilImage(image);
                  },
                  comments: checkOutController.engineOilComments,
                  report: checkOutController.engineOil,
                  updateReport: (report) {
                    checkOutController.updateEngineOil(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Transmission
                ItemForm(
                  textItem: "Transmission",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkOutController.transmissionImages,
                  addImage: (image) {
                    checkOutController.addTransmissionImage(image);
                  },
                  updateImage: (image) {
                    checkOutController.updateTransmissionImage(image);
                  },
                  comments: checkOutController.transmissionComments,
                  report: checkOutController.transmission,
                  updateReport: (report) {
                    checkOutController.updateTransmission(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Coolant
                ItemForm(
                  textItem: "Coolant",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkOutController.coolantImages,
                  addImage: (image) {
                    checkOutController.addCoolantImage(image);
                  },
                  updateImage: (image) {
                    checkOutController.updateCoolantImage(image);
                  },
                  comments: checkOutController.coolantComments,
                  report: checkOutController.coolant,
                  updateReport: (report) {
                    checkOutController.updateCoolant(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Power Steering
                ItemForm(
                  textItem: "Power Steering",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkOutController.powerSteeringImages,
                  addImage: (image) {
                    checkOutController.addPowerSteeringImage(image);
                  },
                  updateImage: (image) {
                    checkOutController.updatePowerSteeringImage(image);
                  },
                  comments: checkOutController.powerSteeringComments,
                  report: checkOutController.powerSteering,
                  updateReport: (report) {
                    checkOutController.updatePowerSteering(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Diesel Exhaust Fluid
                ItemForm(
                  textItem: "Diesel Exhaust Fluid",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkOutController.dieselExhaustFluidImages,
                  addImage: (image) {
                    checkOutController.addDieselExhaustFluidImage(image);
                  },
                  updateImage: (image) {
                    checkOutController.updateDieselExhaustFluidImage(image);
                  },
                  comments: checkOutController.dieselExhaustFluidComments,
                  report: checkOutController.dieselExhaustFluid,
                  updateReport: (report) {
                    checkOutController.updateDieselExhaustFluid(report);
                  },
                ),
                Divider(
                  height: 4,
                  thickness: 4,
                  indent: 20,
                  endIndent: 20,
                  color: FlutterFlowTheme.of(context).grayLighter,
                ),

                // Windshield Washer Fluid
                ItemForm(
                  textItem: "Windshield Washer Fluid",
                  onPressed: () {

                  }, 
                  isRight: false,
                  readOnly: false,
                  images: checkOutController.windshieldWasherFluidImages,
                  addImage: (image) {
                    checkOutController.addWindshieldWasherFluidImage(image);
                  },
                  updateImage: (image) {
                    checkOutController.updateWindshieldWasherFluidImage(image);
                  },
                  comments: checkOutController.windshieldWasherFluidComments,
                  report: checkOutController.windshieldWasherFluid,
                  updateReport: (report) {
                    checkOutController.updateWindshieldWasherFluid(report);
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
