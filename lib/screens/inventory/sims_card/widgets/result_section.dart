
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/services.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/sims_card_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/sims_card_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_button_option.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

class ResultSection extends StatelessWidget {
  
  ResultSection({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final simsCardMenuProvider = Provider.of<SIMSCardMenuProvider>(context);
    final simsCardFormProvider = Provider.of<SIMSCardFormProvider>(context);
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
                      if (simsCardFormProvider.validateForm(keyForm)) {
                        final message = await simsCardFormProvider.addNewSIMSCardBackend(usuarioProvider.usuarioCurrent!);
                        switch (message) {
                          case "True":
                            if (!context.mounted) return;
                            snackbarKey.currentState
                                ?.showSnackBar(SnackBar(
                              backgroundColor: AppTheme.of(context).primaryColor,
                              content: const Text(
                                  "SIMS Card registered successfully."),
                            ));
                            simsCardFormProvider.clearControllers();
                            simsCardMenuProvider.changeOptionInventorySection(1);
                            break;
                          case "False":
                            if (!context.mounted) return;
                            showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: const Text('Invalid action'),
                                  content: const Text(
                                      "Failed to load SIMS Card, please try again."),
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
                                  "SIMS Card already registered, please register a new one."),
                            ));
                            break;
                          default:
                            snackbarKey.currentState
                                ?.showSnackBar(SnackBar(
                              content: Text(
                                  "SIMS Card not registered, more info: '$message'"),
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
                    controller: simsCardFormProvider.imeiTextController,
                    textCapitalization: TextCapitalization.characters,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.dialpad_outlined,
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
                    keyboardType: const TextInputType.numberWithOptions(decimal: false),
                    textAlign: TextAlign.start,
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
                    controller: simsCardFormProvider.pinTextController,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.pin_outlined,
                        color: AppTheme.of(context).alternate,
                      ),
                      labelText: 'PIN*',
                      labelStyle: AppTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: AppTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the PIN...',
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
                    inputFormatters: [numbersFormat, LengthLimitingTextInputFormatter(12),],
                    keyboardType: const TextInputType.numberWithOptions(decimal: false),
                    validator: (value) {
                      if (value == "" || value == null || value.isEmpty) {
                        return 'Please input a valid PIN.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: simsCardFormProvider.productIDTextController,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.pin_outlined,
                        color: AppTheme.of(context).alternate,
                      ),
                      labelText: 'Product ID*',
                      labelStyle: AppTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: AppTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the product ID...',
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
                    controller: simsCardFormProvider.descriptionSTextController,
                    textCapitalization: TextCapitalization.words,
                    autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: Icon(
                        Icons.sim_card_outlined,
                        color: AppTheme.of(context).alternate,
                      ),
                      labelText: 'Description*',
                      labelStyle: AppTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: AppTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the description...',
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
                        return 'Please input a valid description.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 0, 5, 20),
                  child: TextFormField(
                    controller: simsCardFormProvider.productCodeTextController,
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
                      labelText: 'Product Code*',
                      labelStyle: AppTheme.of(context)
                          .title3
                          .override(
                            fontFamily: 'Montserrat',
                            color: AppTheme.of(context).grayDark,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                      hintText: 'Input the product code...',
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
                        return 'Please input a valid product code.';
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
                      simsCardFormProvider.clearControllers();
                      simsCardMenuProvider.changeOptionInventorySection(1);
                    },
                    text: 'Close',
                    icon: const Icon(
                      Icons.cancel_outlined,
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