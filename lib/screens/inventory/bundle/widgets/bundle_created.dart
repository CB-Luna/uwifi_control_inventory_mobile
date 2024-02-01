import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_widgets.dart';

class BundleCreated extends StatelessWidget {
  
  BundleCreated({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bundleMenuProvider = Provider.of<BundleMenuProvider>(context);
    return Column(
      children: [
       Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              5, 15, 5, 15),
          child: Text(
            "Bundle Created",
            style: AppTheme.of(context).title2,
          )
        ),
        Padding(
          padding:
              const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 10),
          child: Lottie.asset(
            'assets/lottie_animations/elemento-creado.json',
            width: 180,
            height: 180,
            fit: BoxFit.cover,
            repeat: true,
            animate: true,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      bundleMenuProvider.changeOptionButtonsGC(0, null);
                      bundleMenuProvider.changeOptionInventorySection(0);
                    },
                    text: 'Create New One',
                    icon: const Icon(
                      Icons.restart_alt_outlined,
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
          ],
        ),
      ],
    );
  }
}
