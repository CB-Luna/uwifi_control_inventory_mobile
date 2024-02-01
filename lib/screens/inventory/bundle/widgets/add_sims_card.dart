import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/bundle_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class AddSIMSCard extends StatelessWidget {
  
  AddSIMSCard({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bundleFormProvider = Provider.of<BundleFormProvider>(context);
    final bundleMenuProvider = Provider.of<BundleMenuProvider>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
    return Column(
      children: [
       Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              5, 5, 5, 5),
          child: Text(
            (bundleFormProvider.simCard1 == null || bundleFormProvider.simCard2 == null) ?
            "Please add the SIMS card to Create the Bundle"
            : 
            "Click on next button to save the Bundle",
            style: AppTheme.of(context).subtitle2,
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: bundleFormProvider.simCard1 == null ? true : false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        bundleMenuProvider.changeOptionButtonsGC(1, 1);
                      },
                      text: 'Add Sim Card 1',
                      icon: const Icon(
                        Icons.sim_card_outlined,
                        size: 20,
                      ),
                      options: FFButtonOptions(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 40,
                        color: AppTheme.of(context)
                            .white,
                        textStyle: AppTheme.of(context)
                            .subtitle2
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .subtitle2Family,
                              color: AppTheme.of(context)
                            .alternate,
                              fontSize: 15,
                            ),
                        borderSide: BorderSide(
                          color: AppTheme.of(context)
                            .alternate,
                          width: 2,
                        ),
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: bundleFormProvider.simCard2 == null ? true : false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        bundleMenuProvider.changeOptionButtonsGC(1, 2);
                      },
                      text: 'Add Sim Card 2',
                      icon: const Icon(
                        Icons.sim_card_outlined,
                        size: 20,
                      ),
                      options: FFButtonOptions(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 40,
                        color: AppTheme.of(context)
                            .white,
                        textStyle: AppTheme.of(context)
                            .subtitle2
                            .override(
                              fontFamily: AppTheme.of(context)
                                  .subtitle2Family,
                              color: AppTheme.of(context)
                            .alternate,
                              fontSize: 15,
                            ),
                        borderSide: BorderSide(
                          color: AppTheme.of(context)
                            .alternate,
                          width: 2,
                        ),
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: (bundleFormProvider.simCard1 != null && bundleFormProvider.simCard2 != null) ? true : false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                    onPressed: () async {
                      final message = await bundleFormProvider.addNewBundleBackend(usuarioProvider.usuarioCurrent!);
                      switch (message) {
                        case "True":
                          if (!context.mounted) return;
                          bundleMenuProvider.changeOptionInventorySection(7);
                          break;
                        case "False":
                          if (!context.mounted) return;
                          showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: const Text('Invalid action'),
                                content: const Text(
                                    "Failed to load Bundle, please try again."),
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
                                "Bundle already registered, please register a new one."),
                          ));
                          break;
                        default:
                          snackbarKey.currentState
                              ?.showSnackBar(SnackBar(
                            content: Text(
                                "Bundle not registered, more info: '$message'"),
                          ));
                          break;
                      }
                    },
                    text: 'Save',
                    icon: const Icon(
                      Icons.save_outlined,
                      size: 20,
                    ),
                    options: FFButtonOptions(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 40,
                      color: AppTheme.of(context)
                          .white,
                      textStyle: AppTheme.of(context)
                          .subtitle2
                          .override(
                            fontFamily: AppTheme.of(context)
                                .subtitle2Family,
                            color: AppTheme.of(context)
                          .alternate,
                            fontSize: 15,
                          ),
                      borderSide: BorderSide(
                        color: AppTheme.of(context)
                          .alternate,
                        width: 2,
                      ),
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                  ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
