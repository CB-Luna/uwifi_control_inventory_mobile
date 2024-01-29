import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/control_daily_vehicle_screen.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/flutter_flow_animaciones.dart';
import 'package:uwifi_control_inventory_mobile/screens/services_vehicle/completed_services_vehicle.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/get_image_widget.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/side_menu/side_menu.dart';
import 'package:uwifi_control_inventory_mobile/util/flutter_flow_util.dart';

class ServicesVehicleScreen extends StatefulWidget {
  final Vehicle vehicle;
  const ServicesVehicleScreen({
      super.key, 
      required this.vehicle, 
    });

  @override
  State<ServicesVehicleScreen> createState() => _ServicesVehicleScreenState();
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
  
class _ServicesVehicleScreenState extends State<ServicesVehicleScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const SideMenu(),
        backgroundColor: AppTheme.of(context).white,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: AppTheme.of(context).background,
              ),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.57,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 5, 0, 0),
                                child: Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.of(context).alternate,
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
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ControlDailyVehicleScreen(),
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
                                10, 5, 10, 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Service',
                                  textAlign: TextAlign.center,
                                  style:
                                      AppTheme.of(context).bodyText1.override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            color: AppTheme.of(context).tertiaryColor,
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold,
                                          ),
                                ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(24, 15, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "${widget.vehicle.make} - ${widget.vehicle.model} ${widget.vehicle.year}",
                                  style: AppTheme.of(context).bodyText2,
                                ),
                              ],
                            ),
                          ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(24, 5, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "${widget.vehicle.company.target!.company}: ${widget.vehicle.licensePlates}",
                                  style: AppTheme.of(context).title1.override(
                                        fontFamily: 'Outfit',
                                        color: AppTheme.of(context).dark400,
                                      ),
                                ),
                              ],
                            ),
                          ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x43000000),
                                    offset: Offset(-4, 8),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: getImageContainer(
                                widget.vehicle.path).
                                  animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                      child: Text(
                                        'Total Services',
                                        style: AppTheme.of(context).bodyText2,
                                      ),
                                    ),
                                    Text(
                                      "${widget.vehicle.vehicleServices.toList().length}",
                                      style: AppTheme.of(context).title1.override(
                                            fontFamily: 'Outfit',
                                            color:
                                                AppTheme.of(context).alternate,
                                          ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                      child: Text(
                                        'Motor',
                                        style: AppTheme.of(context).bodyText2,
                                      ),
                                    ),
                                    Text(
                                      widget.vehicle.motor,
                                      style: AppTheme.of(context).title1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.43,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Pending Services:',
                                  style: AppTheme.of(context).bodyText2.override(
                                    fontFamily: 'Outfit',
                                    color: AppTheme.of(context).primaryText,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "${widget.vehicle.vehicleServices.where((element) => !element.completed).toList().length}",
                                  style: AppTheme.of(context).bodyText2.override(
                                    fontFamily: 'Outfit',
                                    color: AppTheme.of(context).alternate,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: Builder(
                                builder: (context) {
                                  return ListView.builder(
                                    controller: ScrollController(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: widget.vehicle.vehicleServices.where((element) => !element.completed).toList().length,
                                    itemBuilder: (context, index) {
                                      final vehicleServices = widget.vehicle.vehicleServices.where((element) => !element.completed).toList()[index];
                                      return InkWell(
                                        onTap: () async {
                                          final today = DateTime.now();
                                          if (vehicleServices.service.target?.service == "Car Wash") {
                                            if (today >= vehicleServices.serviceDate!) {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CompletedServicesVehicleScreen(
                                                        vehicle: widget.vehicle, 
                                                        vehicleServices: vehicleServices,),
                                                ),
                                              );
                                            } else {
                                              snackbarKey.currentState
                                                  ?.showSnackBar(const SnackBar(
                                                content: Text(
                                                    "You have to await to do this service."),
                                              ));
                                            }
                                          } else {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CompletedServicesVehicleScreen(
                                                      vehicle: widget.vehicle, 
                                                      vehicleServices: vehicleServices,),
                                              ),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                        0, 0, 0, 8),
                                                child: Container(
                                                  width:
                                                      MediaQuery.of(context).size.width *
                                                          0.92,
                                                  decoration: BoxDecoration(
                                                    gradient: purpleRadial,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        blurRadius: 4,
                                                        color: Color(0x43000000),
                                                        offset: Offset(6, 6),
                                                      )
                                                    ],
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(15, 0, 0, 0),
                                                        child: Container(
                                                          width: 35,
                                                          height: 35,
                                                          decoration: BoxDecoration(
                                                            color: AppTheme.of(context)
                                                                .secondaryBackground,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                (index + 1).toString(),
                                                                style:
                                                                    AppTheme.of(context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily: AppTheme.of(
                                                                                  context)
                                                                              .bodyText1Family,
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.bold
                                                                        ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .all(8),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize.max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    maybeHandleOverflow(
                                                                        vehicleServices.service.target!.service,
                                                                        25,
                                                                        "..."),
                                                                    style:
                                                                        AppTheme.of(
                                                                                context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily:
                                                                                  AppTheme.of(context)
                                                                                      .bodyText1Family,
                                                                              color: AppTheme.of(
                                                                                      context)
                                                                                  .grayLighter,
                                                                            ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize.max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    vehicleServices.serviceDate != null ?
                                                                    "Due Date: ${DateFormat('MMMM d, y').format(vehicleServices.serviceDate!)}"
                                                                    :
                                                                    vehicleServices.mileageRemaining! > 0 ? 
                                                                    "Due: ${vehicleServices.mileageRemaining} Mi"
                                                                    :
                                                                    "Over: ${vehicleServices.mileageRemaining?.abs()} Mi",
                                                                    textAlign:
                                                                        TextAlign.end,
                                                                    style: AppTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily: AppTheme.of(
                                                                                  context)
                                                                              .bodyText1Family,
                                                                          color: AppTheme.of(
                                                                                  context)
                                                                              .white,
                                                                          fontSize: 12,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 5),
                                                                child: Text(
                                                                  maybeHandleOverflow(vehicleServices.service.target!.description, 50, "..."),
                                                                  maxLines: 2,
                                                                  style: AppTheme.of(
                                                                          context)
                                                                      .subtitle1
                                                                      .override(
                                                                        fontFamily: AppTheme.of(
                                                                                context)
                                                                            .subtitle1Family,
                                                                        color: AppTheme.of(
                                                                                context)
                                                                            .white,
                                                                        fontSize: 12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}