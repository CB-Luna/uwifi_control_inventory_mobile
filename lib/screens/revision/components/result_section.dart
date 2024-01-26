
import 'dart:io' as libraryIO;
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/services.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_widgets.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/checkout_form_controller.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/vehiculo_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';

class ResultSection extends StatelessWidget {
  
  ResultSection({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehiculoController>(context);
    final checkOutProvider = Provider.of<CheckOutFormController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Form(
        key: keyForm,
        child: SizedBox( // Need to use container to add size constraint.
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 5, 5, 15),
                  child: FFButtonWidget(
                    onPressed: () async {
                      checkOutProvider.clearControllers();
                      vehicleProvider.changeOptionInventorySection(1);
                    },
                    text: 'Close',
                    icon: const Icon(
                      Icons.cancel_outlined,
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
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: checkOutProvider.serialNumberTextController,
                    textCapitalization: TextCapitalization.characters,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.numbers,
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
                    validator: (value) {
                      if (value == "" || value == null || value.isEmpty) {
                        return 'Please input a valid serial number.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: checkOutProvider.productIDTextController,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.pin_outlined,
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
                    inputFormatters: [numbersFormat, LengthLimitingTextInputFormatter(12),],
                    keyboardType: const TextInputType.numberWithOptions(decimal: false),
                    validator: (value) {
                      if (value == "" || value == null || value.isEmpty) {
                        return 'Please input a valid product ID.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: checkOutProvider.brandTextController,
                    textCapitalization: TextCapitalization.words,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.label_outline,
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
                      if (value == "" || value == null || value.isEmpty) {
                        return 'Please input a valid brand.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: checkOutProvider.modelTextController,
                    textCapitalization: TextCapitalization.words,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.router,
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
                      if (value == "" || value == null || value.isEmpty) {
                        return 'Please input a valid model.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: GestureDetector(
                    onTap: () async {
                      if (checkOutProvider.validateForm(keyForm)) {
                        final message = await checkOutProvider.addNewGatewayBackend();
                        switch (message) {
                          case "True":
                            if (!context.mounted) return;
                            snackbarKey.currentState
                                ?.showSnackBar(SnackBar(
                              backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                              content: const Text(
                                  "Gateway registered successfully."),
                            ));
                            checkOutProvider.clearControllers();
                            vehicleProvider.changeOptionInventorySection(1);
                            break;
                          case "False":
                            if (!context.mounted) return;
                            showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: const Text('Invalid action'),
                                  content: const Text(
                                      "Failed to load Gateway, please try again."),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            break;
                          case "Duplicate":
                            if (!context.mounted) return;
                            snackbarKey.currentState
                                ?.showSnackBar(const SnackBar(
                              content: Text(
                                  "Gateway already registered, please register a new one."),
                            ));
                            break;
                          default:
                            snackbarKey.currentState
                                ?.showSnackBar(SnackBar(
                              content: Text(
                                  "Gateway not registered, more info: '$message'"),
                            ));
                            break;
                        }
                      } else {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: const Text('Invalid action'),
                              content: const Text(
                                  "Please input the required fields."),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext),
                                  child: const Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
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
                            'Save',
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
  }
}