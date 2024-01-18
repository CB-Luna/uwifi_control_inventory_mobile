import 'dart:io' as libraryIO;
import 'dart:typed_data';
import 'package:clay_containers/clay_containers.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/vehiculo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:uwifi_control_inventory_mobile/database/image_evidence.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/checkout_form_controller.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/flutter_flow_animaciones.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/header_shimmer.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/components/item_form.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/bottom_sheet_close_item_form.dart';
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
  @override
  Widget build(BuildContext context) {
    final checkOutController = Provider.of<CheckOutFormController>(context);
    final userController = Provider.of<UsuarioController>(context);
    final vehicleProvider = Provider.of<VehiculoController>(context);
    final mileage = checkOutController.mileage;
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
                                onTap: () async {
                                  //Este botón no guarda la información ingresada para Mileage
                                  bool? booleano =
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
                                              const BottomSheetCloseItemForm(),
                                        ),
                                      );
                                    },
                                  );
                                  if (booleano != null &&
                                      booleano == true){
                                    if (mileage == checkOutProvider.mileage) {
                                      if (mounted) Navigator.pop(context);
                                    } else {
                                      final mileageInt = int.parse(checkOutProvider.mileage != "" ? checkOutProvider.mileage.replaceAll(",", "") : "0");
                                      if (mileageInt != 0) {
                                        checkOutProvider.updateMileage(mileage);
                                        if (userController.isEmployee || (userController.isTechSupervisor && vehicleProvider.vehicleSelected == null)) {
                                          if (mileageInt < userController.usuarioCurrent!.vehicle.target!.mileage) {
                                            checkOutProvider.flagOilChange = false;
                                            checkOutProvider.flagTransmissionFluidChange = false;
                                            checkOutProvider.flagRadiatorFluidChange = false;
                                            checkOutProvider.flagTireChange = false;
                                            checkOutProvider.flagBrakeChange = false;
                                          }
                                          if (mileageInt > userController.usuarioCurrent!.vehicle.target!.ruleOilChange.target!.lastMileageService) {
                                            checkOutProvider.flagOilChange = false;
                                          } 
                                          if (mileageInt > userController.usuarioCurrent!.vehicle.target!.ruleTransmissionFluidChange.target!.lastMileageService) {
                                            checkOutProvider.flagTransmissionFluidChange = false;
                                          } 
                                          if (mileageInt > userController.usuarioCurrent!.vehicle.target!.ruleRadiatorFluidChange.target!.lastMileageService) {
                                            checkOutProvider.flagRadiatorFluidChange = false;
                                          } 
                                          if (mileageInt > userController.usuarioCurrent!.vehicle.target!.ruleTireChange.target!.lastMileageService) {
                                            checkOutProvider.flagTireChange = false;
                                          }
                                          if (mileageInt > userController.usuarioCurrent!.vehicle.target!.ruleBrakeChange.target!.lastMileageService) {
                                            checkOutProvider.flagBrakeChange = false;
                                          }
                                        } else {
                                          if (vehicleProvider.vehicleSelected != null) {
                                            if (mileageInt < vehicleProvider.vehicleSelected!.mileage) {
                                              checkOutProvider.flagOilChange = false;
                                              checkOutProvider.flagTransmissionFluidChange = false;
                                              checkOutProvider.flagRadiatorFluidChange = false;
                                              checkOutProvider.flagTireChange = false;
                                              checkOutProvider.flagBrakeChange = false;
                                            }
                                            if (mileageInt > vehicleProvider.vehicleSelected!.ruleOilChange.target!.lastMileageService) {
                                              checkOutProvider.flagOilChange = false;
                                            } 
                                            if (mileageInt > vehicleProvider.vehicleSelected!.ruleTransmissionFluidChange.target!.lastMileageService) {
                                              checkOutProvider.flagTransmissionFluidChange = false;
                                            } 
                                            if (mileageInt > vehicleProvider.vehicleSelected!.ruleRadiatorFluidChange.target!.lastMileageService) {
                                              checkOutProvider.flagRadiatorFluidChange = false;
                                            } 
                                            if (mileageInt > vehicleProvider.vehicleSelected!.ruleTireChange.target!.lastMileageService) {
                                              checkOutProvider.flagTireChange = false;
                                            }
                                            if (mileageInt > vehicleProvider.vehicleSelected!.ruleBrakeChange.target!.lastMileageService) {
                                              checkOutProvider.flagBrakeChange = false;
                                            }
                                          }
                                        }
                                      }
                                      if (mounted) Navigator.pop(context);
                                    }
                                  }
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
                                          errorMaxLines: 3,
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
                                        inputFormatters: [numbersFormat],
                                        keyboardType: const TextInputType.numberWithOptions(decimal: false),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                              return 'The Mileage is required.';
                                            } 
                                          if (userController.isEmployee || (userController.isTechSupervisor && vehicleProvider.vehicleSelected == null)) {
                                            if (int.parse(value.replaceAll(",", "")) < userController.usuarioCurrent!.vehicle.target!.mileage) {
                                              return "The value can't be lower than '${
                                                NumberFormat.decimalPattern().
                                                format(userController.usuarioCurrent!
                                                .vehicle.target!.mileage)}' Mi.";
                                            }
                                          } else {
                                            if (vehicleProvider.vehicleSelected != null) {
                                              if (int.parse(value.replaceAll(",", "")) < vehicleProvider.vehicleSelected!.mileage) {
                                              return "The value can't be lower than '${
                                                NumberFormat.decimalPattern().
                                                format(vehicleProvider
                                                .vehicleSelected?.mileage)}' Mi.";
                                            }
                                            }
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
                                                                checkOutProvider.mileageImages,
                                                            deleteImage: (image) {
                                                              checkOutProvider.deleteMileageImage(image);
                                                            },)),
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
                                                XFile? pickedFile;
                                                Uint8List? compressImage;
                                                if (option == 'camera') {
                                                  if (checkOutProvider.mileageImages.length <
                                                      5) {
                                                    pickedFile =
                                                        await picker.pickImage(
                                                      source: ImageSource.camera,
                                                      maxHeight: 1080,
                                                      maxWidth: 1080,
                                                      imageQuality: 80,
                                                    );
                                                    if (pickedFile != null) {
                                                      if (await pickedFile.length() >= 1000000) {
                                                        int quality = 70;
                                                        libraryIO.File file =
                                                        libraryIO.File(
                                                            pickedFile.path);
                                                        do {
                                                          compressImage = await FlutterImageCompress.compressWithFile(
                                                            file.absolute.path,
                                                            minWidth: 1920,
                                                            minHeight: 1080,
                                                            quality: quality,
                                                          );
                                                          if (compressImage != null) {
                                                            if (compressImage.lengthInBytes >= 1000000) {
                                                              quality -= 10;
                                                            } else {
                                                              quality = 0;
                                                            }
                                                          } else {
                                                            snackbarKey.currentState
                                                                ?.showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  "Failed to compress this picture."),
                                                            ));
                                                            return;
                                                          }
                                                        } while (quality > 0);
                                                        var newImageEvidence =
                                                            ImageEvidence(
                                                                path:
                                                                    file.path,
                                                                uint8List: compressImage,
                                                                name: pickedFile.name);
                                                            checkOutProvider.addMileageImage(
                                                            newImageEvidence);
                                                      } else {
                                                        libraryIO.File file =
                                                        libraryIO.File(
                                                            pickedFile.path);
                                                        var newImageEvidence =
                                                          ImageEvidence(
                                                              path: file.path,
                                                              uint8List: file.readAsBytesSync(),
                                                              name: pickedFile.name);
                                                          checkOutProvider.addMileageImage(
                                                            newImageEvidence);
                                                      }
                                                    } else {
                                                      snackbarKey.currentState
                                                          ?.showSnackBar(
                                                              const SnackBar(
                                                        content: Text(
                                                            "Failed to upload this Picture."),
                                                      ));
                                                      return;
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
                                                } else {
                                                  //Se selecciona galería
                                                  if (checkOutProvider.mileageImages.length <
                                                      5) {
                                                    pickedFile =
                                                        await picker.pickImage(
                                                          source: ImageSource.gallery
                                                    );
                                                    if (pickedFile != null) {
                                                      if (await pickedFile.length() >= 1000000) {
                                                        int quality = 70;
                                                        libraryIO.File file =
                                                        libraryIO.File(
                                                            pickedFile.path);
                                                        do {
                                                          compressImage = await FlutterImageCompress.compressWithFile(
                                                            file.absolute.path,
                                                            minWidth: 1920,
                                                            minHeight: 1080,
                                                            quality: quality,
                                                          );
                                                          if (compressImage != null) {
                                                            if (compressImage.lengthInBytes >= 1000000) {
                                                              quality -= 10;
                                                            } else {
                                                              quality = 0;
                                                            }
                                                          } else {
                                                            snackbarKey.currentState
                                                                ?.showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  "Failed to compress this picture."),
                                                            ));
                                                            return;
                                                          }
                                                        } while (quality > 0);
                                                        var newImageEvidence =
                                                            ImageEvidence(
                                                                path:
                                                                    file.path,
                                                                uint8List: compressImage,
                                                                name: pickedFile.name);
                                                            checkOutProvider.addMileageImage(
                                                            newImageEvidence);
                                                      } else {
                                                        libraryIO.File file =
                                                        libraryIO.File(
                                                            pickedFile.path);
                                                        var newImageEvidence =
                                                          ImageEvidence(
                                                              path: file.path,
                                                              uint8List: file.readAsBytesSync(),
                                                              name: pickedFile.name);
                                                          checkOutProvider.addMileageImage(
                                                          newImageEvidence);
                                                      }
                                                    } else {
                                                      snackbarKey.currentState
                                                          ?.showSnackBar(
                                                              const SnackBar(
                                                        content: Text(
                                                            "Failed to upload this Image."),
                                                      ));
                                                      return;
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
                                                }
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
                                                              checkOutProvider.gasImages,
                                                          deleteImage: (image) {
                                                              checkOutProvider.deleteGasImage(image);
                                                            },)),
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
                                              Uint8List? compressImage;
                                              if (option == 'camera') {
                                                if (checkOutProvider.gasImages.length <
                                                    5) {
                                                  pickedFile =
                                                      await picker.pickImage(
                                                    source: ImageSource.camera,
                                                    maxHeight: 1080,
                                                    maxWidth: 1080,
                                                    imageQuality: 80,
                                                  );
                                                  if (pickedFile != null) {
                                                    if (await pickedFile.length() >= 1000000) {
                                                      int quality = 70;
                                                      libraryIO.File file =
                                                      libraryIO.File(
                                                          pickedFile.path);
                                                      do {
                                                        compressImage = await FlutterImageCompress.compressWithFile(
                                                          file.absolute.path,
                                                          minWidth: 1920,
                                                          minHeight: 1080,
                                                          quality: quality,
                                                        );
                                                        if (compressImage != null) {
                                                          if (compressImage.lengthInBytes >= 1000000) {
                                                            quality -= 10;
                                                          } else {
                                                            quality = 0;
                                                          }
                                                        } else {
                                                          snackbarKey.currentState
                                                              ?.showSnackBar(
                                                                  const SnackBar(
                                                            content: Text(
                                                                "Failed to compress this picture."),
                                                          ));
                                                          return;
                                                        }
                                                      } while (quality > 0);
                                                      var newImageEvidence =
                                                          ImageEvidence(
                                                              path:
                                                                  file.path,
                                                              uint8List: compressImage,
                                                              name: pickedFile.name);
                                                          checkOutProvider.addGasImage(
                                                          newImageEvidence);
                                                    } else {
                                                      libraryIO.File file =
                                                      libraryIO.File(
                                                          pickedFile.path);
                                                      var newImageEvidence =
                                                        ImageEvidence(
                                                            path: file.path,
                                                            uint8List: file.readAsBytesSync(),
                                                            name: pickedFile.name);
                                                        checkOutProvider.addGasImage(
                                                          newImageEvidence);
                                                    }
                                                  } else {
                                                    snackbarKey.currentState
                                                        ?.showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          "Failed to upload this Picture."),
                                                    ));
                                                    return;
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
                                              } else {
                                                //Se selecciona galería
                                                if (checkOutProvider.gasImages.length <
                                                    5) {
                                                  pickedFile =
                                                      await picker.pickImage(
                                                        source: ImageSource.gallery
                                                  );
                                                  if (pickedFile != null) {
                                                    if (await pickedFile.length() >= 1000000) {
                                                      int quality = 70;
                                                      libraryIO.File file =
                                                      libraryIO.File(
                                                          pickedFile.path);
                                                      do {
                                                        compressImage = await FlutterImageCompress.compressWithFile(
                                                          file.absolute.path,
                                                          minWidth: 1920,
                                                          minHeight: 1080,
                                                          quality: quality,
                                                        );
                                                        if (compressImage != null) {
                                                          if (compressImage.lengthInBytes >= 1000000) {
                                                            quality -= 10;
                                                          } else {
                                                            quality = 0;
                                                          }
                                                        } else {
                                                          snackbarKey.currentState
                                                              ?.showSnackBar(
                                                                  const SnackBar(
                                                            content: Text(
                                                                "Failed to compress this picture."),
                                                          ));
                                                          return;
                                                        }
                                                      } while (quality > 0);
                                                      var newImageEvidence =
                                                          ImageEvidence(
                                                              path:
                                                                  file.path,
                                                              uint8List: compressImage,
                                                              name: pickedFile.name);
                                                          checkOutProvider.addGasImage(
                                                          newImageEvidence);
                                                    } else {
                                                      libraryIO.File file =
                                                      libraryIO.File(
                                                          pickedFile.path);
                                                      var newImageEvidence =
                                                        ImageEvidence(
                                                            path: file.path,
                                                            uint8List: file.readAsBytesSync(),
                                                            name: pickedFile.name);
                                                        checkOutProvider.addGasImage(
                                                        newImageEvidence);
                                                    }
                                                  } else {
                                                    snackbarKey.currentState
                                                        ?.showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          "Failed to upload this Image."),
                                                    ));
                                                    return;
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
                                              }
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
                  deleteImage: (image) {
                    checkOutController.deleteEngineOilImage(image);
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
                  deleteImage: (image) {
                    checkOutController.deleteTransmissionImage(image);
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
                  deleteImage: (image) {
                    checkOutController.deleteCoolantImage(image);
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
                  deleteImage: (image) {
                    checkOutController.deletePowerSteeringImage(image);
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
                  deleteImage: (image) {
                    checkOutController.deleteDieselExhaustFluidImage(image);
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
                  deleteImage: (image) {
                    checkOutController.deleteWindshieldWasherFluidImage(image);
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
