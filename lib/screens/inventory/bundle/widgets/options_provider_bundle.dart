import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/custom_button_option.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/indicator_filter_button.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

class OptionsProviderBundle extends StatelessWidget {
  
  OptionsProviderBundle({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bundleMenuProvider = Provider.of<BundleMenuProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              5, 25, 5, 25),
          child: Text(
            "Please select one provider which you're going to create bundles for.",
            style: AppTheme.of(context).title2,
            textAlign: TextAlign.center,
          )
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Builder(
            builder: (context) {
              return Center(
                child: ListView.builder(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 24),
                shrinkWrap: true,
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                itemCount: bundleMenuProvider.simCarriers.length,
                itemBuilder: (context, index) {
                  final carrier = bundleMenuProvider.simCarriers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: IndicatorFilterButton(
                      text: "${index + 1}. ${carrier.name}",
                      onPressed: () {
                        bundleMenuProvider.changeOptionSimCarrier(carrier.simCarrierId);
                      },
                      isTaped: bundleMenuProvider.valueSimCarrier == carrier.simCarrierId,
                    ),
                  );
                }),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              5, 10, 5, 10),
          child: FFButtonWidget(
            onPressed: () {
              bundleMenuProvider.changeOptionInventorySection(1);
            },
            text: 'Continue',
            icon: const Icon(
              Icons.check_outlined,
              size: 15,
            ),
            options: CustomButtonOption(
              width: MediaQuery.of(context).size.width * 0.3,
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
    );
  }
}
