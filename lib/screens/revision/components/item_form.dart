import 'dart:io' as libraryIO;
import 'dart:io';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uwifi_control_inventory_mobile/database/image_evidence.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/flutter_flow_animaciones.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/bottom_sheet_image_required.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/bottom_sheet_validacion_eliminar_imagen.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_bottom_sheet.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/drop_down.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_expanded_image_view.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({
    Key? key,
    required this.textItem,
    required this.onPressed,
    this.readOnly = false,
    this.applyFuction = false,
    required this.isRight,
    required this.images,
    this.addImage,
    this.deleteImage,
    this.comments,
    this.report,
    this.updateReport,
    this.clearReport,
    this.reportYesNo = false,
    this.isRegistered = false,
    this.requiredImages = false,
  }) : super(key: key);

  final String textItem;
  final void Function() onPressed;
  final bool readOnly;
  final bool applyFuction;
  final bool isRight;
  final List<ImageEvidence> images;
  final void Function(ImageEvidence value)? addImage;
  final void Function(ImageEvidence value)? deleteImage;
  final TextEditingController? comments;
  final String? report;
  final void Function(String value)? updateReport;
  final void Function()? clearReport;
  final bool reportYesNo;
  final bool isRegistered;
  final bool requiredImages;

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  List<ImageEvidence> imagesTemp = [];
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

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.textItem,
            style: FlutterFlowTheme.of(context)
            .bodyText1.override(
              fontFamily:
                    FlutterFlowTheme.of(context).bodyText1Family,
              color: FlutterFlowTheme.of(context).tertiaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        GestureDetector(
          onTap: widget.applyFuction ?
          widget.onPressed
          :
          () async {
            await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(widget.textItem)
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.requiredImages) {
                          if (widget.report == "Bad" || widget.report == "No") {
                            if (widget.images.isEmpty) {
                              setState(() {
                                widget.clearReport!();
                              });
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                            }
                          } else {
                            Navigator.pop(context);
                          }
                        } else {
                          Navigator.pop(context);
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
                content: SizedBox( // Need to use container to add size constraint.
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        FormField(
                          builder: (state) {
                            return Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 20),
                              child: DropDown(
                                initialOption: widget.report!,
                                options: widget.reportYesNo ?
                                ['Yes', 'No']
                                :
                                ['Good', 'Bad'],
                                onChanged: (value) {
                                  state.setState(() {
                                    widget.updateReport!(value!);
                                  });
                                },
                                width: double.infinity,
                                height: 50,
                                textStyle: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context).alternate,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                hintText: 'Report*',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context).alternate,
                                  size: 30,
                                ),
                                fillColor: FlutterFlowTheme.of(context).white,
                                elevation: 2,
                                borderColor: FlutterFlowTheme.of(context).alternate,
                                borderWidth: 2,
                                borderRadius: 8,
                                margin: const EdgeInsetsDirectional
                                    .fromSTEB(12, 4, 12, 4),
                                hidesUnderline: true,
                              ),
                            );
                          },
                          validator: (val) {
                            if (val == "") {
                              return 'Report of item is required.';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5, 0, 5, 20),
                          child: TextFormField(
                            controller: widget.comments,
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
                                            0.40,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEEEEEE),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: SizedBox(
                                        width: 180,
                                        height: 100,
                                        child: CarouselSlider(
                                          options: CarouselOptions(height: 400.0),
                                          items: widget.images.map((i) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return InkWell(
                                                  onTap: () async {
                                                    await Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        type: PageTransitionType.fade,
                                                        child: FlutterFlowExpandedImageView(
                                                          image: Image.file(
                                                            File(i.path),
                                                            fit: BoxFit.contain,
                                                          ),
                                                          allowRotation: false,
                                                          tag: i.path,
                                                          useHeroAnimation: true,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  onLongPress: () async {
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
                                                              BottomSheetValidacionEliminarImagen(imagen: i.path,),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                  if (booleano != null &&
                                                      booleano == true){
                                                        setState(() {
                                                          widget.deleteImage!(i);
                                                        });
                                                      }
                                                  },
                                                  child: Hero(
                                                    tag: i.path,
                                                    transitionOnUserGestures: true,
                                                    child: Container(
                                                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                                      width: MediaQuery.of(context).size.width,
                                                      height: 200,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.rectangle,
                                                      ),
                                                      child: 
                                                          Image.file(
                                                        File(i.path),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }).toList(),
                                        )),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 0, 0),
                                        child: Text(
                                          "Total: ${widget.images.length}",
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
                                      if (widget.images.length <
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
                                            print("Tamaño nuevo: ${compressImage.lengthInBytes}");
                                            var newImageEvidence =
                                                ImageEvidence(
                                                    path:
                                                        file.path,
                                                    uint8List: compressImage,
                                                    name: pickedFile.name);
                                                state.setState(() {
                                                widget.addImage!(
                                                newImageEvidence);
                                              });
                                          } else {
                                            libraryIO.File file =
                                            libraryIO.File(
                                                pickedFile.path);
                                            var newImageEvidence =
                                              ImageEvidence(
                                                  path: file.path,
                                                  uint8List: file.readAsBytesSync(),
                                                  name: pickedFile.name);
                                              state.setState(() {
                                              widget.addImage!(
                                              newImageEvidence);
                                            });
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
                                      if (widget.images.length <
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
                                            print("Tamaño nuevo: ${compressImage.lengthInBytes}");
                                            var newImageEvidence =
                                                ImageEvidence(
                                                    path:
                                                        file.path,
                                                    uint8List: compressImage,
                                                    name: pickedFile.name);
                                                state.setState(() {
                                                widget.addImage!(
                                                newImageEvidence);
                                              });
                                          } else {
                                            libraryIO.File file =
                                            libraryIO.File(
                                                pickedFile.path);
                                            var newImageEvidence =
                                              ImageEvidence(
                                                  path: file.path,
                                                  uint8List: file.readAsBytesSync(),
                                                  name: pickedFile.name);
                                              state.setState(() {
                                              widget.addImage!(
                                              newImageEvidence);
                                            });
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
                                    for (var i = 0;
                                        i < imagesTemp.length;
                                        i++) {
                                          state.setState(() {
                                          widget.addImage!(
                                          imagesTemp[i]);
                                        });
                                    }
                                    setState(() {
                                      imagesTemp.clear();
                                    });
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
                          if (widget.requiredImages) {
                            if (val == []) {
                              return 'Images are required';
                            }
                          }
                          return null;
                        }),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.requiredImages) {
                                if (widget.report == "Bad" || widget.report == "No") {
                                  if (widget.images.isEmpty) {
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
                                                const BottomSheetImageRequired(),
                                          ),
                                        );
                                      },
                                    );
                                    if (booleano == null &&
                                        booleano == true){
                                      return;
                                    }
                                  } else {
                                    Navigator.pop(context);
                                  }
                                } else {
                                  Navigator.pop(context);
                                }
                              } else {
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
              );
            },
          );
          },
          child: ClayContainer(
            height: 30,
            width: 30,
            depth: 10,
            spread: 1,
            borderRadius: 25,
            curveType: CurveType.concave,
            color: widget.report == "Good" || widget.report == "Yes" || widget.readOnly || widget.isRegistered ?
            FlutterFlowTheme.of(context).buenoColor
            :
            FlutterFlowTheme.of(context).primaryColor,
            surfaceColor: widget.report == "Good" || widget.report == "Yes" || widget.readOnly || widget.isRegistered ?
            FlutterFlowTheme.of(context).buenoColor
            :
            FlutterFlowTheme.of(context).primaryColor,
            parentColor: widget.report == "Good" || widget.report == "Yes" || widget.readOnly || widget.isRegistered ?
            FlutterFlowTheme.of(context).buenoColor
            :
            FlutterFlowTheme.of(context).primaryColor,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                widget.readOnly ? Icons.info_outlined  :
                widget.report == "Good" || widget.report == "Yes" || widget.isRegistered ? Icons.check : Icons.close,
                color: FlutterFlowTheme.of(context).white,
                size: 20,
              ),
            ),
          ).animateOnPageLoad(
            widget.isRight ?
            animationsMap['moveLoadAnimationRL']!
            :
            animationsMap['moveLoadAnimationLR']!
            ),
        ),
      ],
    ),
  );
  }
}
