import 'dart:convert';
import 'dart:io' as libraryIO;
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taller_alex_app_asesor/database/image.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/widgets/bottom_sheet_imagenes_completas.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';
import 'package:taller_alex_app_asesor/screens/widgets/drop_down.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_carousel.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

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
    this.updateImage,
    this.comments,
    this.report,
    this.updateReport,
    this.reportYesNo = false,
    this.isRegistered = false,
  }) : super(key: key);

  final String textItem;
  final void Function() onPressed;
  final bool readOnly;
  final bool applyFuction;
  final bool isRight;
  final List<ImageEvidence> images;
  final void Function(ImageEvidence value)? addImage;
  final void Function(ImageEvidence value)? updateImage;
  final TextEditingController? comments;
  final String? report;
  final void Function(String value)? updateReport;
  final bool reportYesNo;
  final bool isRegistered;

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  List<XFile> imagesTemp = [];
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
                scrollable: true,
                title: Text(widget.textItem),
                content: SizedBox( // Need to use container to add size constraint.
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
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
                                                    widget.images)),
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
                                    List<XFile>? pickedFiles;
                                    if (option == 'camera') {
                                      if (widget.images.length <
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

                                            var updateImagenEvidence =
                                                ImageEvidence(
                                                    path:
                                                        pickedFile.path,
                                                    base64: base64);
                                            state.setState(() {
                                              widget.updateImage!(updateImagenEvidence);
                                            });
                                          }
                                          return;
                                        }
                                      }
                                    } else {
                                      //Se selecciona galería
                                      if (widget.images.length <
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
                                        switch (widget.images.length) {
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

                                            var updateImagenEvidence =
                                                ImageEvidence(
                                                    path:
                                                        pickedFile.path,
                                                    base64: base64);
                                            state.setState(() {
                                              widget.updateImage!(updateImagenEvidence);
                                            });
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

                                      var newImagenEvidence =
                                          ImageEvidence(
                                              path:
                                                  imagesTemp[i].path,
                                              base64: base64);
                                      state.setState(() {
                                        widget.addImage!(
                                        newImagenEvidence);
                                        imagesTemp.clear();
                                      });
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
                              if (widget.report == "Bad" || widget.report == "No") {
                                if (widget.images.isEmpty) {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "You need to add images like a evidence."),
                                  ));
                                  return;
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
                widget.report == "Good" || widget.report == "Yes" || widget.readOnly || widget.isRegistered ? Icons.check : Icons.close,
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
