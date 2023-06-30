import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badge;
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/control_form_provider.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/checkin_form_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/vehiculo_controller.dart';
import 'package:taller_alex_app_asesor/screens/control_form/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/control_form/main_screen_selector.dart';
import 'package:taller_alex_app_asesor/screens/revision/components/menu_form_button.dart';
import 'package:taller_alex_app_asesor/screens/revision/control_form_d_creted.dart';
import 'package:taller_alex_app_asesor/screens/revision/control_form_d_not_created.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
class CheckInSchedulerScreen extends StatefulWidget {
  final String hour;
  final String period;
  final DateTime registeredHour;
  const CheckInSchedulerScreen({
    super.key, 
    required this.hour, 
    required this.period, 
    required this.registeredHour,
    });

  @override
  State<CheckInSchedulerScreen> createState() => _CheckInSchedulerScreenState();
}
final scaffoldKey = GlobalKey<ScaffoldState>();
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
          begin: 1,
          end: 1,
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
          begin: 1,
          end: 1,
        ),
      ],
    ),
  };

class _CheckInSchedulerScreenState extends State<CheckInSchedulerScreen> {
  @override
  Widget build(BuildContext context) {
    final vehiculoController = Provider.of<VehiculoController>(context);
    final cehckInFormProvider = Provider.of<CheckInFormController>(context);
    final userProvider = Provider.of<UsuarioController>(context);
    final controlFormProvider = Provider.of<ControlFormProvider>(context);
    return Scaffold(
      key: scaffoldKey,
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
                          cehckInFormProvider.cleanInformation();
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MainScreenSelector(),
                            ),
                          );
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
                          if (cehckInFormProvider.validateForm()) {
                            if (cehckInFormProvider.addControlForm(userProvider.usuarioCurrent, widget.registeredHour)) {
                              // cehckInFormProvider.cleanInformation();
                              controlFormProvider.cleanData();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ControlFormDCreatedScreen(),
                                ),
                              );
                            } else {
                              cehckInFormProvider.cleanInformation();
                              controlFormProvider.cleanData();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ControlFormDNotCreatedScreen(),
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
                      'Check In Form',
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
                                userProvider.usuarioCurrent?.lastName}", 20, "..."),
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyText1Family,
                                color: FlutterFlowTheme.of(context).white,
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                              ),
                            ),
                            Text(
                              "${userProvider.usuarioCurrent?.company.target?.company}",
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyText1Family,
                                color: FlutterFlowTheme.of(context).white,
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                              ),
                            ),
                            Text(
                              DateFormat(
                               'hh:mm:ss').
                                format(
                                  widget.registeredHour),
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyText1Family,
                                color: FlutterFlowTheme.of(context).white,
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
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
                        "${cehckInFormProvider.pendingMeasures}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: cehckInFormProvider.pendingMeasures != 0,
                      badgeColor: FlutterFlowTheme.of(context).primaryColor,
                      position: badge.BadgePosition.topEnd(),
                      elevation: 4,
                      child: MenuFormButton(
                        icon: Icons.speed_outlined, 
                        onPressed: () {
                          vehiculoController.setTapedOptionCheckIn(0);
                        },
                        isTaped: vehiculoController.isTapedCheckIn == 0,
                      ),
                    ),
                    badge.Badge(
                      badgeContent: Text(
                        "${cehckInFormProvider.badStateLights}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: cehckInFormProvider.badStateLights != 0,
                      badgeColor: FlutterFlowTheme.of(context).primaryColor,
                      position: badge.BadgePosition.topEnd(),
                      elevation: 4,
                      child: MenuFormButton(
                        icon: Icons.flare, 
                        onPressed: () {
                          vehiculoController.setTapedOptionCheckIn(1);
                        },
                        isTaped: vehiculoController.isTapedCheckIn == 1,
                      ),
                    ),
                    badge.Badge(
                      badgeContent: Text(
                        "${cehckInFormProvider.badStateFluids}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: cehckInFormProvider.badStateFluids != 0,
                      badgeColor: FlutterFlowTheme.of(context).primaryColor,
                      position: badge.BadgePosition.topEnd(),
                      elevation: 4,
                      child: MenuFormButton(
                        icon: Icons.health_and_safety, 
                        onPressed: () {
                          vehiculoController.setTapedOptionCheckIn(2);
                        },
                        isTaped: vehiculoController.isTapedCheckIn == 2,
                      ),
                    ),
                    badge.Badge(
                      badgeContent: Text(
                        "${cehckInFormProvider.badStateSecurity}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: cehckInFormProvider.badStateSecurity != 0,
                      badgeColor: FlutterFlowTheme.of(context).primaryColor,
                      position: badge.BadgePosition.topEnd(),
                      elevation: 4,
                      child: MenuFormButton(
                        icon: Icons.build, 
                        onPressed: () {
                          vehiculoController.setTapedOptionCheckIn(3);
                        },
                        isTaped: vehiculoController.isTapedCheckIn == 3,
                      ),
                    ),
                    badge.Badge(
                      badgeContent: Text(
                        "${cehckInFormProvider.badStateEquipment}",
                          style: TextStyle(
                              color: FlutterFlowTheme.of(context).white)),
                      showBadge: cehckInFormProvider.badStateEquipment != 0,
                      badgeColor: FlutterFlowTheme.of(context).primaryColor,
                      position: badge.BadgePosition.topEnd(),
                      elevation: 4,
                      child: MenuFormButton(
                      icon: Icons.local_shipping, 
                        onPressed: () {
                          vehiculoController.setTapedOptionCheckIn(4);
                        },
                        isTaped: vehiculoController.isTapedCheckIn == 4,
                      ),
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
                        final section = vehiculoController.menuTapedCheckIn [
                            vehiculoController.isTapedCheckIn];
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