import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:uwifi_control_inventory_mobile/helpers/constants.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/gateway_form_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/batch_gateway_provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/gateway_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_button_option.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

class InventoryFormBatch extends StatelessWidget {
  
  const InventoryFormBatch({super.key});


  @override
  Widget build(BuildContext context) {
    final keyForm = GlobalKey<FormState>();
    final gatewayMenuProvider = Provider.of<GatewayMenuProvider>(context);
    final gatewayFormProvider = Provider.of<GatewayFormProvider>(context);
    final batchGatewayProvider = Provider.of<BatchGatewayProvider>(context);
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
                "Please Select One Option",
                style: AppTheme.of(context).subtitle1,
              )
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  5, 5, 5, 5),
              child: Text(
                "*Note: If you want to upload a Batch, select a valid .xlsx File",
                textAlign: TextAlign.center,
                style: AppTheme.of(context).subtitle2,
              )
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  5, 15, 5, 15),
              child: FFButtonWidget(
                onPressed: () async {
                  if (!context.mounted) return;
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                batchGatewayProvider.clearNoRecordController();
                                Navigator.pop(context);
                              },
                              child: ClayContainer(
                                height: 30,
                                width: 30,
                                depth: 15,
                                spread: 1,
                                borderRadius: 15,
                                curveType: CurveType.concave,
                                color:
                                AppTheme.of(context).secondaryColor,
                                surfaceColor:
                                AppTheme.of(context).secondaryColor,
                                parentColor:
                                AppTheme.of(context).secondaryColor,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: AppTheme.of(context).white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        content: SizedBox( // Need to use container to add size constraint.
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Form(
                              key: keyForm,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 5, 20),
                                    child: Text(
                                      "Please Input No. Records of your File.",
                                      style: AppTheme.of(context).subtitle2,
                                      textAlign: TextAlign.left,
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 5, 20),
                                    child: TextFormField(
                                      controller: batchGatewayProvider.noRecordsController,
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
                                        labelText: 'No. Records',
                                        labelStyle: AppTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: AppTheme.of(context).grayDark,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                        hintText: 'Input the no. records...',
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
                                      inputFormatters: [numbersFormat],
                                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                                      style: AppTheme.of(context).bodyText1,
                                      textAlign: TextAlign.start,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'The No. Records is required.';
                                        } 
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (batchGatewayProvider.validateKeyForm(keyForm)) {
                                          switch (await batchGatewayProvider.uploadGatewaysBatch()) {
                                              case 'Not Valid Extension':
                                                batchGatewayProvider.clearNoRecordController();
                                                if (!context.mounted) return;
                                                Navigator.pop(context);
                                                snackbarKey.currentState
                                                        ?.showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "The File Selected hasn't a valid extension."),
                                                    ));
                                              case 'Not Valid Format':
                                                batchGatewayProvider.clearNoRecordController();
                                                if (!context.mounted) return;
                                                Navigator.pop(context);
                                                snackbarKey.currentState
                                                        ?.showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "The File Selected hasn't a valid format."),
                                                    ));
                                              case 'Not Content':
                                                batchGatewayProvider.clearNoRecordController();
                                                if (!context.mounted) return;
                                                Navigator.pop(context);
                                                snackbarKey.currentState
                                                        ?.showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "The File Selected hasn't content."),
                                                    ));
                                              case 'Not Same No. Records':
                                                batchGatewayProvider.clearNoRecordController();
                                                if (!context.mounted) return;
                                                Navigator.pop(context);
                                                snackbarKey.currentState
                                                        ?.showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "The File Selected hasn't the same no. records input."),
                                                    ));
                                              case 'Succesfull Upload':
                                                batchGatewayProvider.clearNoRecordController();
                                                if (!context.mounted) return;
                                                Navigator.pop(context);
                                                snackbarKey.currentState
                                                    ?.showSnackBar(const SnackBar(
                                                  backgroundColor: Color(0xFF00B837),
                                                  content: Text(
                                                      "File uploaded successfully."),
                                                ));
                                                gatewayMenuProvider.changeOptionInventorySection(5);
                                              default:
                                                batchGatewayProvider.clearNoRecordController();
                                                if (!context.mounted) return;
                                                Navigator.pop(context);
                                                snackbarKey.currentState
                                                    ?.showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Failed while uploading File, try again."),
                                                ));
                                          }
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
                                        AppTheme.of(context).alternate,
                                        surfaceColor:
                                        AppTheme.of(context).alternate,
                                        parentColor:
                                        AppTheme.of(context).alternate,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Accept',
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
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
                  gatewayMenuProvider.changeOptionInventorySection(8);
                },
                text: 'Create Batch',
                icon: const Icon(
                  Icons.note_add_outlined,
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
    );
  }
}
