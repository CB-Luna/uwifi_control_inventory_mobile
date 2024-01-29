import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/checkin_scheduler_screen.dart';
import 'package:uwifi_control_inventory_mobile/screens/revision/checkout_scheduler_screen.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/side_menu/side_menu.dart';

class ControlDailyVehicleScreen extends StatefulWidget {
  const ControlDailyVehicleScreen({Key? key}) : super(key: key);

  @override
  State<ControlDailyVehicleScreen> createState() => _ControlDailyVehicleScreenState();
}

class _ControlDailyVehicleScreenState extends State<ControlDailyVehicleScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ControlForm? controlFormCheckOut;
  ControlForm? controlFormCheckIn;
  List<VehicleServices>? vehicleServicesList = [];
  // List<String> vehicleServicesList = ["Hola", "Adios"];

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const SideMenu(),
        backgroundColor: AppTheme.of(context).white,
        body: GestureDetector(
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
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20, 50, 20, 0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              scaffoldKey.currentState?.openDrawer();
                            },
                            child: Container(
                              width: 50,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.menu_rounded,
                                    color: AppTheme.of(context).white,
                                    size: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Control Daily Inventory',
                              textAlign: TextAlign.center,
                              style:
                                AppTheme.of(context).bodyText1.override(
                                      fontFamily: AppTheme.of(context)
                                          .bodyText1Family,
                                      color: AppTheme.of(context).tertiaryColor,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional
                      .fromSTEB(0, 5, 0, 5),
                    child: GradientText(
                      "${usuarioProvider.usuarioCurrent?.firstName} ${usuarioProvider.usuarioCurrent?.lastName}",
                      style: AppTheme.of(
                              context)
                          .bodyText1
                          .override(
                            fontFamily: 'Inter',
                            color:
                                AppTheme.of(
                                        context)
                                    .primaryText,
                            fontSize: 30.0,
                            fontWeight:
                                FontWeight.w600,
                          ),
                      colors: [
                        AppTheme.of(context)
                          .alternate,
                        AppTheme.of(context)
                          .secondaryColor
                      ],
                      gradientDirection:
                          GradientDirection.ltr,
                      gradientType:
                          GradientType.linear,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: AppTheme.of(context).secondaryColor,
                            offset: const Offset(1.0, 1.0),
                          )
                        ],
                        color: AppTheme.of(context).grayLighter,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        border: Border.all(
                          width: 1,
                          color: AppTheme.of(context).secondaryColor,
                        )
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CheckOutSchedulerScreen(registeredHour: DateTime.now(),),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 15),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: AppTheme.of(context).alternate,
                                      offset: const Offset(2.0, 2.0),
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      AppTheme.of(context).alternate,
                                      AppTheme.of(context).alternate.withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(30.0),
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10.0, 10.0, 0.0, 10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize:
                                                MainAxisSize.max,
                                            children: [
                                              Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.rotationY(3.14159), // Rotación en radiane
                                                child: Icon(
                                                  Icons.sort_outlined,
                                                  color: AppTheme
                                                          .of(context)
                                                      .white,
                                                  size: 35.0,
                                                ),
                                              ),
                                              Icon(
                                                Icons.router_outlined,
                                                color: AppTheme
                                                        .of(context)
                                                    .white,
                                                size: 35.0,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Add Gateway Data',
                                            style: AppTheme.of(
                                                    context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: AppTheme
                                                          .of(context)
                                                      .primaryBackground,
                                                  fontSize: 18.0,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                              10.0, 10.0, 10.0, 10.0),
                                      child: ClayContainer(
                                        height: 30,
                                        width: 30,
                                        depth: 10,
                                        spread: 1,
                                        borderRadius: 25,
                                        curveType: CurveType.concave,
                                        color: 
                                        controlFormCheckOut != null ?
                                        AppTheme.of(context).buenoColor
                                        :
                                        AppTheme.of(context).primaryColor,
                                        surfaceColor: 
                                        controlFormCheckOut != null ?
                                        AppTheme.of(context).buenoColor
                                        :
                                        AppTheme.of(context).primaryColor,
                                        parentColor: 
                                        controlFormCheckOut != null ?
                                        AppTheme.of(context).buenoColor
                                        :
                                        AppTheme.of(context).primaryColor,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: Icon(
                                              Icons.info_outline,
                                            color:
                                            AppTheme.of(context).white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                                await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CheckInSchedulerScreen(registeredHour: DateTime.now(),),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 15),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4.0,
                                      color: AppTheme.of(context).alternate,
                                      offset: const Offset(2.0, 2.0),
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      AppTheme.of(context).alternate,
                                      AppTheme.of(context).alternate.withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(30.0),
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10.0, 10.0, 0.0, 10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize:
                                                MainAxisSize.max,
                                            children: [
                                              Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.rotationY(3.14159), // Rotación en radiane
                                                child: Icon(
                                                  Icons.sort_outlined,
                                                  color: AppTheme
                                                          .of(context)
                                                      .white,
                                                  size: 35.0,
                                                ),
                                              ),
                                              Icon(
                                                Icons.sim_card_outlined,
                                                color: AppTheme
                                                        .of(context)
                                                    .white,
                                                size: 30.0,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Add SIM Card Data',
                                            style: AppTheme.of(
                                                    context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Inter',
                                                  color: AppTheme
                                                          .of(context)
                                                      .primaryBackground,
                                                  fontSize: 18.0,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                              10.0, 10.0, 10.0, 10.0),
                                      child: ClayContainer(
                                        height: 30,
                                        width: 30,
                                        depth: 10,
                                        spread: 1,
                                        borderRadius: 25,
                                        curveType: CurveType.concave,
                                        color: 
                                        controlFormCheckIn != null ?
                                        AppTheme.of(context).buenoColor
                                        :
                                        AppTheme.of(context).primaryColor,
                                        surfaceColor: 
                                        controlFormCheckIn != null ?
                                        AppTheme.of(context).buenoColor
                                        :
                                        AppTheme.of(context).primaryColor,
                                        parentColor: 
                                        controlFormCheckIn != null ?
                                        AppTheme.of(context).buenoColor
                                        :
                                        AppTheme.of(context).primaryColor,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: Icon(
                                              Icons.info_outline,
                                            color:
                                            AppTheme.of(context).white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
        ),
      ),
    );
  }
}
