import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/batch_sim_card_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_button_option.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

class InventoryFormBatch extends StatelessWidget {
  
  const InventoryFormBatch({super.key});


  @override
  Widget build(BuildContext context) {
    final simsCardMenuProvider = Provider.of<SIMSCardMenuProvider>(context);
    final simsCardFormProvider = Provider.of<SIMSCardFormProvider>(context);
    final batchSimCardProvider = Provider.of<BatchSimCardProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: SizedBox( // Need to use container to add size constraint.
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  5, 5, 5, 5),
              child: Text(
                "Please Upload a Valid CSV File",
                style: AppTheme.of(context).subtitle2,
              )
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  5, 15, 5, 15),
              child: FFButtonWidget(
                onPressed: () async {
                  switch (await batchSimCardProvider.uploadSimsCardBatch()) {
                    case 'Not Valid Extension':
                      snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "The File Selected hasn't a valid extension."),
                          ));
                    case 'Not Valid Format':
                      snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "The File Selected hasn't a valid format."),
                          ));
                    case 'Not Content':
                      snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "The File Selected hasn't content."),
                          ));
                    case 'Not Rows Data':
                      snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "The File Selected hasn't rows."),
                          ));
                    case 'Succesfull Upload':
                      snackbarKey.currentState
                          ?.showSnackBar(const SnackBar(
                        backgroundColor: Color(0xFF00B837),
                        content: Text(
                            "File uploaded successfully."),
                      ));
                      simsCardMenuProvider.changeOptionInventorySection(5);
                    default:
                      snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Failed while uploading File, try again."),
                          ));
                  }
                },
                text: 'Upload Batch',
                icon: const Icon(
                  Icons.upload_file_outlined,
                  size: 15,
                ),
                options: CustomButtonOption(
                  width: MediaQuery.of(context).size.width * 0.4,
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
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  5, 15, 5, 15),
              child: FFButtonWidget(
                onPressed: () async {
                  simsCardFormProvider.clearControllers();
                  simsCardMenuProvider.changeOptionInventorySection(1);
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
    );
  }
}
