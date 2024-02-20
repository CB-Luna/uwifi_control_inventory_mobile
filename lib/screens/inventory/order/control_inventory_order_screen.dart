import 'package:clay_containers/clay_containers.dart';
import 'package:uwifi_control_inventory_mobile/providers/providers.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/order_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/main/main_screen_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/util/animations.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/menu_form_button.dart';
import 'package:uwifi_control_inventory_mobile/util/flutter_flow_util.dart';
class ControlInventoryOrderScreen extends StatefulWidget {

  const ControlInventoryOrderScreen({
    super.key, 
    });

  @override
  State<ControlInventoryOrderScreen> createState() => _ControlInventoryOrderScreenState();
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

class _ControlInventoryOrderScreenState extends State<ControlInventoryOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderMenuProvider = Provider.of<OrderMenuProvider>(context);
    final userProvider = Provider.of<UsuarioController>(context);
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
                                      'The recent input data will be deleted.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        orderMenuProvider.clean();
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
                      'Order',
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
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: Shimmer(
                  child: ClayContainer(
                    height: 60,
                    depth: 30,
                    spread: 2,
                    customBorderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30), 
                      bottomRight: Radius.circular(30),
                    ),
                    curveType: CurveType.concave,
                    color: AppTheme.of(context).secondaryColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              maybeHandleOverflow("${
                                userProvider.usuarioCurrent?.firstName} ${
                                userProvider.usuarioCurrent?.lastName}", 24, "..."),
                              style: AppTheme.of(context).bodyText1.override(
                                fontFamily:
                                    AppTheme.of(context).bodyText1Family,
                                color: AppTheme.of(context).white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              DateFormat(
                               'MMM-dd-yyyy').
                                format(DateTime.now()),
                              style: AppTheme.of(context).bodyText1.override(
                                fontFamily:
                                    AppTheme.of(context).bodyText1Family,
                                color: AppTheme.of(context).white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MenuFormButton(
                      icon: Icons.search_outlined, 
                      onPressed: () {
                        orderMenuProvider.setButtonMenuTaped(0);
                      },
                      isTaped: orderMenuProvider.buttonMenuTaped == 0,
                    ),
                    MenuFormButton(
                      icon: Icons.inventory_2_outlined, 
                      onPressed: () {
                        orderMenuProvider.setButtonMenuTaped(1);
                      },
                      isTaped: orderMenuProvider.buttonMenuTaped == 1,
                    ),
                    MenuFormButton(
                      icon: Icons.local_shipping,
                      onPressed: () {
                        orderMenuProvider.setButtonMenuTaped(2);
                      },
                      isTaped: orderMenuProvider.buttonMenuTaped == 2,
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

              Builder(
                builder: (context) {
                  final section = orderMenuProvider.menuTaped[
                      orderMenuProvider.buttonMenuTaped]; 
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