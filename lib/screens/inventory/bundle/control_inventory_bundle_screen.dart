import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:uwifi_control_inventory_mobile/screens/main/main_screen_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/indicator_filter_button.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/util/animations.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/menu_form_button.dart';
class ControlInventoryBundleScreen extends StatefulWidget {

  const ControlInventoryBundleScreen({
    super.key, 
    });

  @override
  State<ControlInventoryBundleScreen> createState() => _ControlInventoryBundleScreenState();
}
final animationsMap = {
    'moveLoadAnimationLR': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(-79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
        ),
      ],
    ),
    'moveLoadAnimationRL': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
        ),
      ],
    ),
  };
  

class _ControlInventoryBundleScreenState extends State<ControlInventoryBundleScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      BundleMenuProvider provider = Provider.of<BundleMenuProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bundleMenuProvider = Provider.of<BundleMenuProvider>(context);
    return Scaffold(
      backgroundColor: AppTheme.of(context).background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      5, 5, 0, 0),
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).primaryColor,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x39000000),
                            offset: Offset(-4, 8),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: const Text(
                                      'Are you sure you want to return to main screen?'),
                                  content: const Text(
                                      'Check if you save your changes.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        bundleMenuProvider.clean();
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreenSelector(),
                                          ),
                                        );
                                      },
                                      child:
                                          const Text('Continue'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child:
                                          const Text('Cancel'),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_rounded,
                              color: AppTheme.of(context).white,
                              size: 16,
                            ),
                            Text(
                              'Back',
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: AppTheme.of(context)
                                        .bodyText1Family,
                                    color: AppTheme.of(context).white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Control Inventory',
                      textAlign: TextAlign.center,
                      style:
                          AppTheme.of(context).bodyText1.override(
                                fontFamily: AppTheme.of(context)
                                    .bodyText1Family,
                                color: AppTheme.of(context).secondaryColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      'Bundle',
                      textAlign: TextAlign.center,
                      style:
                          AppTheme.of(context).bodyText1.override(
                                fontFamily: AppTheme.of(context)
                                    .bodyText1Family,
                                color: AppTheme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MenuFormButton(
                      icon: Icons.add_outlined, 
                      onPressed: () {
                        bundleMenuProvider.setButtonMenuTaped(0);
                      },
                      isTaped: bundleMenuProvider.buttonMenuTaped == 0,
                    ),
                    MenuFormButton(
                      icon: Icons.list_outlined, 
                      onPressed: () {
                        bundleMenuProvider.setButtonMenuTaped(1);
                      },
                      isTaped: bundleMenuProvider.buttonMenuTaped == 1,
                    ),
                  ],
                ),
              ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: AppTheme.of(context).grayLighter,
              ),
              SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
                child: Builder(
                  builder: (context) {
                    return Center(
                      child: ListView.builder(
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 24),
                      shrinkWrap: true,
                      controller: ScrollController(),
                      scrollDirection: Axis.horizontal,
                      itemCount: bundleMenuProvider.simCarriers.length,
                      itemBuilder: (context, index) {
                        final carrier = bundleMenuProvider.simCarriers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: IndicatorFilterButton(
                            text: carrier.name,
                            onPressed: () {
                              bundleMenuProvider.changeOptionSimCarrier(carrier.simCarrierId);
                            },
                            isTaped: bundleMenuProvider.valueSimCarrier == carrier.simCarrierId,
                          ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                        );
                      }),
                    );
                  },
                ),
              ),
              Builder(
                builder: (context) {
                  final section = bundleMenuProvider.menuTaped[
                      bundleMenuProvider.buttonMenuTaped]; 
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                      child: section,
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}