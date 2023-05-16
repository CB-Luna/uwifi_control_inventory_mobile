import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/control_form_provider.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';
import 'package:taller_alex_app_asesor/screens/widgets/drop_down.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';

class SeccionTresFormulario extends StatefulWidget {
  const SeccionTresFormulario({super.key});

  @override
  State<SeccionTresFormulario> createState() => _SeccionTresFormularioState();
}

class _SeccionTresFormularioState extends State<SeccionTresFormulario> {
  XFile? image;
  @override
  Widget build(BuildContext context) {
    final controlFormProvider = Provider.of<ControlFormProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                16, 16, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ExpandableNotifier(
                initialExpanded: true,
                child: ExpandablePanel(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(0, 0, 16, 0),
                      child: Icon(
                          controlFormProvider.dentsController.text == "" ? 
                          Icons.check_box_outline_blank_rounded
                          :
                          Icons.check_box_rounded,
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          size: 25,
                        ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'Dents',
                        style: FlutterFlowTheme.of(context)
                            .title1
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .title1Family,
                              color: FlutterFlowTheme.of(context)
                                  .primaryText,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    ],
                  ),
                  collapsed: Divider(
                    thickness: 1.5,
                    color: FlutterFlowTheme.of(context).lineColor,
                  ),
                  expanded: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: FormField(   
                      initialValue: controlFormProvider.dentsController.text,  
                      builder: (state) {
                        return DropDown(
                          options: const ['Yes', 'No'],
                          onChanged: (val) {
                            controlFormProvider.dentsController.text = val!;
                            setState(() {});
                          },
                          width: double.infinity,
                          height: 50,
                          textStyle: FlutterFlowTheme.of(context)
                              .title3
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                          hintText: 'Dents*',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            size: 30,
                          ),
                          elevation: 2,
                          borderColor: FlutterFlowTheme.of(context).primaryColor,
                          borderWidth: 2,
                          borderRadius: 8,
                          margin: const EdgeInsetsDirectional
                              .fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        );
                      },
                      validator: (val) {
                        if (controlFormProvider.dentsController.text == "" ||
                            controlFormProvider.dentsController.text.isEmpty) {
                          return 'Dents are required to continue.';
                        }
                        return null;
                      },
                    ),
                  ),
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    headerAlignment:
                        ExpandablePanelHeaderAlignment.center,
                    hasIcon: true,
                    iconColor:
                        FlutterFlowTheme.of(context).secondaryColor,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                16, 16, 16, 0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ExpandableNotifier(
                initialExpanded: true,
                child: ExpandablePanel(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Padding(
                      padding: const EdgeInsetsDirectional
                          .fromSTEB(0, 0, 16, 0),
                      child: Icon(
                          controlFormProvider.commentsDentsController.text == "" ? 
                          Icons.check_box_outline_blank_rounded
                          :
                          Icons.check_box_rounded,
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          size: 25,
                        ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'Comments about Dents',
                        style: FlutterFlowTheme.of(context)
                            .title1
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .title1Family,
                              color: FlutterFlowTheme.of(context)
                                  .primaryText,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    ],
                  ),
                  collapsed: Divider(
                    thickness: 1.5,
                    color: FlutterFlowTheme.of(context).lineColor,
                  ),
                  expanded: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: TextFormField(
                      controller: controlFormProvider.commentsDentsController,
                      textCapitalization: TextCapitalization.sentences,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Input your personal comments...',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).grayDark,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                FlutterFlowTheme.of(context).dark400,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).dark400,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).dark400,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      maxLines: 4,
                      validator: (val) {
                        return null;
                      }
                    ),
                  ),
                  theme: ExpandableThemeData(
                    tapHeaderToExpand: true,
                    tapBodyToExpand: false,
                    tapBodyToCollapse: false,
                    headerAlignment:
                        ExpandablePanelHeaderAlignment.center,
                    hasIcon: true,
                    iconColor:
                        FlutterFlowTheme.of(context).secondaryColor,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormField(
                builder: (state) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional
                            .fromSTEB(0, 10, 0, 16),
                        child: InkWell(
                          onTap: () async {
                            String? option =
                                await showModalBottomSheet(
                              context: context,
                              builder: (_) =>
                                  const CustomBottomSheet(),
                            );

                            if (option == null) return;

                            final picker = ImagePicker();

                            late final XFile? pickedFile;

                            if (option == 'camera') {
                              pickedFile =
                                  await picker.pickImage(
                                source: ImageSource.camera,
                                imageQuality: 50,
                              );
                            } else {
                              pickedFile =
                                  await picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 50,
                              );
                            }

                            if (pickedFile == null) {
                              return;
                            }

                            setState(() {
                              image = pickedFile;
                              File file = File(image!.path);
                              List<int> fileInByte =
                                  file.readAsBytesSync();
                              String base64 =
                                  base64Encode(fileInByte);
                              controlFormProvider.imageDents =
                                  base64;
                              controlFormProvider.pathDents = 
                                file.path;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context)
                                    .size
                                    .width *
                                0.9,
                            height: 180,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/animation_500_l3ur8tqa.gif',
                                ).image,
                              ),
                              borderRadius:
                                  BorderRadius.circular(8),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).grayDark,
                                width: 1.5,
                              ),
                            ),
                            child: getImage(image?.path),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}