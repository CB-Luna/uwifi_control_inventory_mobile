
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/services.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/gateway_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/gateway_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_button_option.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

class ResultSection extends StatelessWidget {
  
  ResultSection({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final gatewayMenuProvider = Provider.of<GatewayMenuProvider>(context);
    final gatewayFormProvider = Provider.of<GatewayFormProvider>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
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
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
                  child: GestureDetector(
                    onTap: () async {
                      if (gatewayFormProvider.validateForm(keyForm)) {
                        final message = await gatewayFormProvider.addNewGatewayBackend(usuarioProvider.usuarioCurrent!);
                        switch (message) {
                          case "True":
                            if (!context.mounted) return;
                            snackbarKey.currentState
                                ?.showSnackBar(SnackBar(
                              backgroundColor: AppTheme.of(context).primaryColor,
                              content: const Text(
                                  "Gateway registered successfully."),
                            ));
                            gatewayFormProvider.clearControllers();
                            gatewayMenuProvider.changeOptionInventorySection(1);
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
                      AppTheme.of(context).primaryColor,
                      surfaceColor:
                      AppTheme.of(context).primaryColor,
                      parentColor:
                      AppTheme.of(context).primaryColor,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            'Save',
                            style: AppTheme.of(context).subtitle1.override(
                              fontFamily: 'Lexend Deca',
                              color: AppTheme.of(context).white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: gatewayFormProvider.serialNumberTextController,
                    textCapitalization: TextCapitalization.characters,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.numbers,
                        color: AppTheme.of(context).alternate,
                      ),
                      labelText: 'Serial Number*',
                      labelStyle: AppTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: AppTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the serial number...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              AppTheme.of(context).alternate.withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                    ),
                    style: AppTheme.of(context).bodyText1,
                    keyboardType: const TextInputType.numberWithOptions(decimal: false),
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
                    controller: gatewayFormProvider.imeiGTextController,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.pin_outlined,
                        color: AppTheme.of(context).alternate,
                      ),
                      labelText: 'IMEI*',
                      labelStyle: AppTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: AppTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the IMEI...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              AppTheme.of(context).alternate.withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                    ),
                    style: AppTheme.of(context).bodyText1,
                    textAlign: TextAlign.start,
                    inputFormatters: [numbersFormat, LengthLimitingTextInputFormatter(15),],
                    keyboardType: const TextInputType.numberWithOptions(decimal: false),
                    validator: (value) {
                      if (value == "" || value == null || value.isEmpty) {
                        return 'Please input a valid IMEI.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: gatewayFormProvider.wifiKeyTextController,
                    textCapitalization: TextCapitalization.words,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.label_outline,
                        color: AppTheme.of(context).alternate,
                      ),
                      labelText: 'Wi-Fi Key*',
                      labelStyle: AppTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: AppTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the wi-fi key...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              AppTheme.of(context).alternate.withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                    ),
                    style: AppTheme.of(context).bodyText1,
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == "" || value == null || value.isEmpty) {
                        return 'Please input a wi-fi key.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: gatewayFormProvider.macTextController,
                    textCapitalization: TextCapitalization.characters,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.numbers,
                        color: AppTheme.of(context).alternate,
                      ),
                      labelText: 'MAC*',
                      labelStyle: AppTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: AppTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the MAC...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              AppTheme.of(context).alternate.withOpacity(0.5),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                    ),
                    style: AppTheme.of(context).bodyText1,
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == "" || value == null || value.isEmpty) {
                        return 'Please input a valid MAC.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 5, 5, 15),
                  child: FFButtonWidget(
                    onPressed: () async {
                      gatewayFormProvider.clearControllers();
                      gatewayMenuProvider.changeOptionInventorySection(1);
                    },
                    text: 'Back',
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      size: 15,
                    ),
                    options: CustomButtonOption(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 40,
                      color: AppTheme.of(context)
                          .white,
                      textStyle: AppTheme.of(context)
                          .subtitle2
                          .override(
                            fontFamily: AppTheme.of(context)
                                .subtitle2Family,
                            color: AppTheme.of(context).alternate,
                            fontSize: 15,
                          ),
                      borderSide: BorderSide(
                        color: AppTheme.of(context).alternate,
                        width: 2,
                      ),
                      borderRadius:
                          BorderRadius.circular(8),
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