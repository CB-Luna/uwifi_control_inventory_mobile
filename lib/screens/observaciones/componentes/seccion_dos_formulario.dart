import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/providers/control_form_provider.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import '../../widgets/custom_bottom_sheet.dart';

class SeccionDosFormulario extends StatefulWidget {
  const SeccionDosFormulario({super.key});

  @override
  State<SeccionDosFormulario> createState() => _SeccionDosFormularioState();
}

class _SeccionDosFormularioState extends State<SeccionDosFormulario> {
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
                          controlFormProvider.gasController.text == "" ? 
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
                        'Gas',
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
                    child: TextFormField(
                      controller: controlFormProvider.gasController,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onTap: () async {
                        await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            final controlFormProvider = Provider.of<ControlFormProvider>(context);
                            return AlertDialog(
                              title: const Text("Gas Percent"),
                              content: SizedBox( // Need to use container to add size constraint.
                                width: 300,
                                height: 300,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SemicircularIndicator(
                                        progress: controlFormProvider.gasPercent * 0.01,
                                        radius: 100,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        backgroundColor: FlutterFlowTheme.of(context).grayLighter,
                                        strokeWidth: 13,
                                        bottomPadding: 0,
                                        contain: true,
                                        child: Text(
                                          "${controlFormProvider.gasPercent} %",
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
                                            value: controlFormProvider.gasPercent, 
                                            stepSize: 1.0,
                                            activeColor: FlutterFlowTheme.of(context).secondaryColor,
                                            inactiveColor: FlutterFlowTheme.of(context).grayLighter,
                                            onChanged: ((value) {
                                              controlFormProvider.updateGasPercent(value.truncate());
                                            })
                                          ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            setState(() {
                                              controlFormProvider.gasController = TextEditingController(
                                                text: controlFormProvider.gasPercent.toString()
                                              );
                                            });
                                            Navigator.pop(context);
                                          },
                                          text: 'Accept',
                                          options: FFButtonOptions(
                                            width: 200,
                                            height: 50,
                                            color: FlutterFlowTheme.of(context).primaryColor,
                                            textStyle:
                                                FlutterFlowTheme.of(context).subtitle1.override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                            elevation: 3,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(50),
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
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.local_gas_station_outlined,
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                        labelText: 'Gas*',
                        labelStyle: FlutterFlowTheme.of(context)
                            .title3
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).grayDark,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                        hintText: 'Input the gas..',
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
                        suffixText: '%',
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.none,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                            return 'The gas percent is required.';
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
                          controlFormProvider.commentsGasController.text == "" ? 
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
                        'Comments about Gas',
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
                      controller: controlFormProvider.commentsGasController,
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
                              controlFormProvider.imageGas =
                                  base64;
                              controlFormProvider.pathGas = 
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