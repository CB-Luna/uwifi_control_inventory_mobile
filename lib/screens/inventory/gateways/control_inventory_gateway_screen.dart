import 'package:clay_containers/clay_containers.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/gateway_menu_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/main/main_screen_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/util/animations.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/menu_form_button.dart';
import 'package:uwifi_control_inventory_mobile/util/flutter_flow_util.dart';
class ControlInventoryGatewayScreen extends StatefulWidget {

  const ControlInventoryGatewayScreen({
    super.key, 
    });

  @override
  State<ControlInventoryGatewayScreen> createState() => _ControlInventoryGatewayScreenState();
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

class _ControlInventoryGatewayScreenState extends State<ControlInventoryGatewayScreen> {
  @override
  Widget build(BuildContext context) {
    final gatewayMenuProvider = Provider.of<GatewayMenuProvider>(context);
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
                                      'Check if you save your changes.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        gatewayMenuProvider.clean();
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
                      'Gateway',
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
                      icon: Icons.add_outlined, 
                      onPressed: () {
                        gatewayMenuProvider.setButtonMenuTaped(0);
                      },
                      isTaped: gatewayMenuProvider.buttonMenuTaped == 0,
                    ),
                    MenuFormButton(
                      icon: Icons.list_outlined, 
                      onPressed: () {
                        gatewayMenuProvider.setButtonMenuTaped(1);
                      },
                      isTaped: gatewayMenuProvider.buttonMenuTaped == 1,
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
                  final section = gatewayMenuProvider.menuTaped[
                      gatewayMenuProvider.buttonMenuTaped]; 
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