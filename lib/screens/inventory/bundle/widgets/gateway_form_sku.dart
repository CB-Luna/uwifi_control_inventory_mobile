
import 'package:clay_containers/clay_containers.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/bundle_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/bundle_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_button_option.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/indicator_filter_button.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

class GatewayFormSKU extends StatelessWidget {
  
  GatewayFormSKU({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bundleMenuProvider = Provider.of<BundleMenuProvider>(context);
    final bundleFormProvider = Provider.of<BundleFormProvider>(context);
    // final usuarioProvider = Provider.of<UsuarioController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Form(
        key: keyForm,
        child: SizedBox( // Need to use container to add size constraint.
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Center(
                  child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: IndicatorFilterButton(
                    text: "${bundleMenuProvider.valueSimCarrier}. ${
                      bundleMenuProvider.simCarriers[
                      bundleMenuProvider.valueSimCarrier -1
                    ].name}",
                    onPressed: () {},
                    isTaped: true,
                  ),
                  ),
                ),
              ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
                  child: GestureDetector(
                    onTap: () async {
                      if (bundleFormProvider.validateForm(keyForm)) {
                        final validate = await bundleFormProvider.validateGatewayBackendSKU();
                        if (validate) {
                          bundleMenuProvider.changeOptionInventorySection(4);
                        } else {
                          if (!context.mounted) return;
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Gateway not found, please check the input serial number."),
                          ));
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
                            'Search Gateway',
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
                      5, 10, 5, 20),
                  child: TextFormField(
                    controller: bundleFormProvider.serialNumberTextController,
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
                      5, 5, 5, 15),
                  child: FFButtonWidget(
                    onPressed: () async {
                      bundleFormProvider.clearGatewayControllers();
                      bundleMenuProvider.changeOptionInventorySection(1);
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