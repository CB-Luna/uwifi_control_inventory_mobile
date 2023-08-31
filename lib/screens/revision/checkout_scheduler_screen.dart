import 'package:clay_containers/clay_containers.dart';
import 'package:fleet_management_tool_rta/screens/control_form/main_screen_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badge;
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:fleet_management_tool_rta/flutter_flow/flutter_flow_theme.dart';
import 'package:fleet_management_tool_rta/providers/control_form_provider.dart';
import 'package:fleet_management_tool_rta/providers/database_providers/checkout_form_controller.dart';
import 'package:fleet_management_tool_rta/providers/database_providers/usuario_controller.dart';
import 'package:fleet_management_tool_rta/providers/database_providers/vehiculo_controller.dart';
import 'package:fleet_management_tool_rta/screens/control_form/flutter_flow_animaciones.dart';
import 'package:fleet_management_tool_rta/screens/revision/components/menu_form_button.dart';
import 'package:fleet_management_tool_rta/screens/revision/control_form_r_created.dart';
import 'package:fleet_management_tool_rta/screens/revision/control_form_r_not_created.dart';
import 'package:fleet_management_tool_rta/util/flutter_flow_util.dart';
class CheckOutSchedulerScreen extends StatefulWidget {
  final String hour;
  final String period;
  final DateTime registeredHour;
  const CheckOutSchedulerScreen({
    super.key, 
    required this.hour, 
    required this.period, 
    required this.registeredHour,
    });

  @override
  State<CheckOutSchedulerScreen> createState() => _CheckOutSchedulerScreenState();
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

class _CheckOutSchedulerScreenState extends State<CheckOutSchedulerScreen> {
  @override
  Widget build(BuildContext context) {
    final vehiculoController = Provider.of<VehiculoController>(context);
    final checkOutFormProvider = Provider.of<CheckOutFormController>(context);
    final userProvider = Provider.of<UsuarioController>(context);
    final controlFormProvider = Provider.of<ControlFormProvider>(context);
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).background,
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
                        color: FlutterFlowTheme.of(context).alternate,
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
                                        controlFormProvider.cleanData();
                                        checkOutFormProvider.cleanInformation();
                                        vehiculoController.cleanComponents();
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
                              color: FlutterFlowTheme.of(context).white,
                              size: 16,
                            ),
                            Text(
                              'Back',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText1Family,
                                    color: FlutterFlowTheme.of(context).white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0, 5, 5, 0),
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
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
                          if (checkOutFormProvider.validateForm()) {
                            if (checkOutFormProvider.addControlForm(
                              userProvider.usuarioCurrent, 
                              vehiculoController.vehicleSelected, 
                              widget.registeredHour)) {
                              // checkOutFormProvider.cleanInformation();
                              controlFormProvider.cleanData();
                              vehiculoController.cleanComponents();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ControlFormRCreatedScreen(),
                                ),
                              );
                            } else {
                              checkOutFormProvider.cleanInformation();
                              controlFormProvider.cleanData();
                              vehiculoController.cleanComponents();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ControlFormRNotCreatedScreen(),
                                ),
                              );
                            }
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: const Text('Invalid action'),
                                  content: const Text(
                                      "The value of 'Mileage' and '% Gas/Diesel' are required."),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Continue',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText1Family,
                                    color: FlutterFlowTheme.of(context).white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: FlutterFlowTheme.of(context).white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Check Out Form',
                      textAlign: TextAlign.center,
                      style:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyText1Family,
                                color: FlutterFlowTheme.of(context).tertiaryColor,
                                fontSize: 28,
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
                    color: FlutterFlowTheme.of(context).secondaryColor,
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
                                userProvider.usuarioCurrent?.name} ${
                                userProvider.usuarioCurrent?.lastName}", 24, "..."),
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyText1Family,
                                color: FlutterFlowTheme.of(context).white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "${userProvider.usuarioCurrent?.company.target?.company}",
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyText1Family,
                                color: FlutterFlowTheme.of(context).white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              DateFormat(
                               'hh:mm a').
                                format(
                                  widget.registeredHour),
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyText1Family,
                                color: FlutterFlowTheme.of(context).white,
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
                    badge.Badge(
                      badgeContent: Text(
                        "${checkOutFormProvider.pendingMeasures}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: checkOutFormProvider.pendingMeasures != 0,
                      position: badge.BadgePosition.topEnd(),
                      badgeStyle: badge.BadgeStyle(
                        badgeColor: FlutterFlowTheme.of(context).primaryColor,
                        elevation: 4,
                      ),
                      child: MenuFormButton(
                        icon: Icons.speed_outlined, 
                        onPressed: () {
                          vehiculoController.setTapedOptionCheckOut(0);
                        },
                        isTaped: vehiculoController.isTapedCheckOut == 0,
                      ),
                    ),
                    badge.Badge(
                      badgeContent: Text(
                        "${checkOutFormProvider.badStateLights}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: checkOutFormProvider.badStateLights != 0,
                      position: badge.BadgePosition.topEnd(),
                      badgeStyle: badge.BadgeStyle(
                        badgeColor: FlutterFlowTheme.of(context).primaryColor,
                        elevation: 4,
                      ),
                      child: MenuFormButton(
                        icon: Icons.flare, 
                        onPressed: () {
                          vehiculoController.setTapedOptionCheckOut(1);
                        },
                        isTaped: vehiculoController.isTapedCheckOut == 1,
                      ),
                    ),
                    badge.Badge(
                      badgeContent: Text(
                        "${checkOutFormProvider.badStateSecurity}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: checkOutFormProvider.badStateSecurity != 0,
                      position: badge.BadgePosition.topEnd(),
                      badgeStyle: badge.BadgeStyle(
                        badgeColor: FlutterFlowTheme.of(context).primaryColor,
                        elevation: 4,
                      ),
                      child: MenuFormButton(
                        icon: Icons.health_and_safety, 
                        onPressed: () {
                          vehiculoController.setTapedOptionCheckOut(2);
                        },
                        isTaped: vehiculoController.isTapedCheckOut == 2,
                      ),
                    ),
                    badge.Badge(
                      badgeContent: Text(
                        "${checkOutFormProvider.badStateEquipment}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: checkOutFormProvider.badStateEquipment != 0,
                      position: badge.BadgePosition.topEnd(),
                      badgeStyle: badge.BadgeStyle(
                        badgeColor: FlutterFlowTheme.of(context).primaryColor,
                        elevation: 4,
                      ),
                      child: MenuFormButton(
                        icon: Icons.build, 
                        onPressed: () {
                          vehiculoController.setTapedOptionCheckOut(3);
                        },
                        isTaped: vehiculoController.isTapedCheckOut == 3,
                      ),
                    ),
                    MenuFormButton(
                    icon: Icons.local_shipping, 
                      onPressed: () {
                        vehiculoController.setTapedOptionCheckOut(4);
                      },
                      isTaped: vehiculoController.isTapedCheckOut == 4,
                    ),
                  ],
                ),
              ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),

              Builder(
                builder: (context) {
                  return ListView.builder(
                      controller: ScrollController(),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                      reverse: true,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        final section = vehiculoController.menuTapedCheckOut[
                            vehiculoController.isTapedCheckOut];
                        return section;
                      });
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