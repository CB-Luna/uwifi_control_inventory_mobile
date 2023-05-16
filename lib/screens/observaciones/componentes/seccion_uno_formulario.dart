import 'dart:convert';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/control_form_provider.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';

class SeccionUnoFormulario extends StatefulWidget {
  final String hour;
  final String period;
  const SeccionUnoFormulario({
    super.key, 
    required this.hour, 
    required this.period});

  @override
  State<SeccionUnoFormulario> createState() => _SeccionUnoFormularioState();
}

class _SeccionUnoFormularioState extends State<SeccionUnoFormulario> {
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
                          Icons.check_box_rounded,
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          size: 25,
                        ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        'Registration Date',
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
                      readOnly: true,
                      initialValue: DateFormat("MM/dd/yyyy hh:mm a").format(
                        DateTime(
                          DateTime.now().year, 
                          DateTime.now().month, 
                          DateTime.now().day, 
                          int.parse(widget.hour.split(":").first), 
                          int.parse(widget.hour.split(":").last), 
                          0, 
                          0)
                        ),
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Date...',
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).primaryColor.withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                      suffixIcon: Icon(
                          Icons.date_range_outlined,
                          color: FlutterFlowTheme.of(context)
                              .secondaryText,
                          size: 24,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.none,
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
                          controlFormProvider.mileageController.text == "" ? 
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
                        'Mileage',
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: TextFormField(
                        controller: controlFormProvider.mileageController,
                        autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.speed_outlined,
                            color: FlutterFlowTheme.of(context).primaryColor,
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
                                  FlutterFlowTheme.of(context).primaryColor.withOpacity(0.5),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  FlutterFlowTheme.of(context).primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryColor,
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
                          controlFormProvider.commentsMileageController.text == "" ? 
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
                        'Comments about Mileage',
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
                      controller: controlFormProvider.commentsMileageController,
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
                              controlFormProvider.imageMileage =
                                  base64;
                              controlFormProvider.pathMileage = 
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