import 'package:clay_containers/clay_containers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diacritic/diacritic.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/main.dart';
import 'package:uwifi_control_inventory_mobile/screens/tech_supervisor_manager/select_hour_check_up_screen.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/side_menu/side_menu.dart';
import 'package:uwifi_control_inventory_mobile/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/providers/database_providers/vehiculo_controller.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/get_image_widget.dart';

class SelectVehicleTSMScreen extends StatefulWidget {
  const SelectVehicleTSMScreen({Key? key}) : super(key: key);

  @override
  State<SelectVehicleTSMScreen> createState() => _SelectVehicleTSMScreenState();
}

class _SelectVehicleTSMScreenState extends State<SelectVehicleTSMScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Vehicle> vehicleAvailables = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      vehicleAvailables = context.read<UsuarioController>().getAllVehicles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final vehiculoController = Provider.of<VehiculoController>(context);
    //final UserState userState = Provider.of<UserState>(context);
    vehicleAvailables = usuarioProvider.getAllVehicles();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const SideMenu(),
        backgroundColor: FlutterFlowTheme.of(context).background,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).background,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              scaffoldKey.currentState?.openDrawer();
                            },
                            child: Container(
                              width: 50,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.menu_rounded,
                                    color: FlutterFlowTheme.of(context).white,
                                    size: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            '${usuarioProvider.usuarioCurrent?.company.target?.company}',
                            textAlign: TextAlign.center,
                            style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText1Family,
                                    color: FlutterFlowTheme.of(context).tertiaryColor,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        15, 15, 0, 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.9,
                          height: 50,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).grayLighter,
                            boxShadow: [
                              BoxShadow(
                                color: FlutterFlowTheme.of(context).grayLighter,
                              )
                            ],
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    4, 4, 0, 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional
                                            .fromSTEB(4, 0, 4, 0),
                                    child: TextFormField(
                                      controller: searchController,
                                      onChanged: (value) =>
                                          setState(() {}),
                                      decoration: InputDecoration(
                                        labelText: 'Search...',
                                        labelStyle: FlutterFlowTheme.of(
                                                context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight:
                                                  FontWeight.normal,
                                            ),
                                        enabledBorder:
                                            OutlineInputBorder(
                                          borderSide:
                                              BorderSide(
                                            color: FlutterFlowTheme.of(context).grayLighter,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(
                                                  8),
                                        ),
                                        focusedBorder:
                                            OutlineInputBorder(
                                          borderSide:
                                              BorderSide(
                                            color: FlutterFlowTheme.of(context).grayLighter,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(
                                                  8),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.search_sharp,
                                          color: FlutterFlowTheme.of(context).white,
                                          size: 15,
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context).primaryText,
                                            fontSize: 13,
                                            fontWeight:
                                                FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional
                                      .fromSTEB(0, 0, 5, 0),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      borderRadius:
                                          const BorderRadius.only(
                                        bottomLeft:
                                            Radius.circular(8),
                                        bottomRight:
                                            Radius.circular(30),
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.search_rounded,
                                        color: FlutterFlowTheme.of(context).white,
                                        size: 24,
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
                  Container(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Builder(
                      builder: (context) {
                        if (searchController.text != '') {
                        vehicleAvailables.removeWhere((element) {
                          final licensePlates =
                              removeDiacritics(element.licensePlates)
                                  .toLowerCase();
                          final make = removeDiacritics(
                                  element.make)
                              .toLowerCase();
                          final model = removeDiacritics(
                                  element.model)
                              .toLowerCase();
                          final status = removeDiacritics(
                                  element.status.target!.status)
                              .toLowerCase();
                          final tempSearch =
                              removeDiacritics(searchController.text)
                                  .toLowerCase();
                          if (licensePlates.contains(tempSearch) ||
                              make.contains(tempSearch) ||
                              model.contains(tempSearch) ||
                              status.contains(tempSearch)) {
                            return false;
                          }
                          return true;
                        });
                      }
                      return ListView.builder(
                        padding: const EdgeInsetsDirectional
                                      .fromSTEB(0, 0, 0, 180),
                        itemCount: vehicleAvailables.length,
                        itemBuilder: (context, index) {
                          final vehicle = vehicleAvailables[index];
                          return Padding(
                            padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 15),
                            child: InkWell(
                              onTap: () async {
                                vehiculoController.updateVehicleSelected(vehicle);
                                if (!vehicle.weeklyCheckUp) {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: const Text('Validation'),
                                        content: Text(
                                            "Are you sure you want to Select the Vehicle with License Plates: '${vehicle.licensePlates}'."),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(alertDialogContext),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              //Se revisa el estatus de la Red
                                              final connectivityResult =
                                                  await (Connectivity().checkConnectivity());
                                              if (connectivityResult == ConnectivityResult.none) {
                                                if (vehicle.filterCheckTSM) {
                                                  if (vehiculoController.vehicleSelected != null ) {
                                                    if (!mounted) return;
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const SelectHourCheckUpScreen(typeForm: true,),
                                                      ),
                                                    );
                                                  } else {
                                                    if (!mounted) return;
                                                    Navigator.pop(alertDialogContext);
                                                  }
                                                } else {
                                                  snackbarKey.currentState
                                                      ?.showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "This vehicle is being checked by an employee, please try again later with Internet Connection."),
                                                  ));
                                                  if (!mounted) return;
                                                  Navigator.pop(alertDialogContext);
                                                }
                                              } else {
                                                DateTime currentDate = DateTime.now();
                                                DateTime startOfDayCurrent = DateTime(currentDate.year, currentDate.month, currentDate.day);
                                                DateTime endOfDayCurrent = DateTime(currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);

                                                DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

                                                String formattedStartOfDayCurrent = format.format(startOfDayCurrent);
                                                String formattedEndOfDayCurrent = format.format(endOfDayCurrent);
                                                List<dynamic> filterCheckTSM = await supabaseCtrlV
                                                .from('control_form')
                                                .select()
                                                .gt('date_added_r', formattedStartOfDayCurrent).lt('date_added_r', formattedEndOfDayCurrent)
                                                .eq('id_vehicle_fk', int.parse(vehicle.idDBR!))
                                                .is_('date_added_d', null);
                                                if (filterCheckTSM.isNotEmpty) {
                                                  snackbarKey.currentState
                                                      ?.showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "This vehicle is being checked by an employee, please try later."),
                                                  ));
                                                  if (!mounted) return;
                                                  Navigator.pop(alertDialogContext);
                                                } else {
                                                  //Se actualiza la bandera de filterCheckTSM del vehículo
                                                  vehicle.filterCheckTSM = true;
                                                  dataBase.vehicleBox.put(vehicle);
                                                  if (!mounted) return;
                                                  await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const SelectHourCheckUpScreen(typeForm: true,),
                                                      ),
                                                    );
                                                }
                                              }
                                            },
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "This vehicle has been already checked this week."),
                                  ));
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 1.0,
                                      color:
                                          FlutterFlowTheme.of(context).secondaryColor,
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      FlutterFlowTheme.of(context).alternate,
                                      FlutterFlowTheme.of(context)
                                          .secondaryColor
                                          .withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 110,
                                        height: 110,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(80.0),
                                          ),
                                        ),
                                        child: getImageContainer(vehicle.path),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      width:
                                          MediaQuery.of(context).size.width * 0.6,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "License Plates: ",
                                                style:
                                                    TextStyle(color: FlutterFlowTheme.of(context).white),
                                              ),
                                              Text(maybeHandleOverflow(vehicle.licensePlates, 8, "..."),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13,
                                                      color: FlutterFlowTheme.of(context).white)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Make: ",
                                                style:
                                                    TextStyle(color: FlutterFlowTheme.of(context).white),
                                              ),
                                              Text(vehicle.make,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13,
                                                      color: FlutterFlowTheme.of(context).white)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Model: ",
                                                style:
                                                    TextStyle(color: FlutterFlowTheme.of(context).white),
                                              ),
                                              Text(
                                                vehicle.model,
                                                style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Status: ",
                                                style:
                                                    TextStyle(color: FlutterFlowTheme.of(context).white),
                                              ),
                                              Text(
                                                "${vehicle.status.target?.status}",
                                                style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                vehicle.weeklyCheckUp ? "Checked " : "Not Checked ",
                                                style: TextStyle(
                                                    color: FlutterFlowTheme.of(context).white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              ClayContainer(
                                                height: 30,
                                                width: 30,
                                                depth: 30,
                                                spread: 0,
                                                borderRadius: 25,
                                                curveType: CurveType.concave,
                                                color: vehicle.weeklyCheckUp ?
                                                FlutterFlowTheme.of(context).buenoColor
                                                :
                                                FlutterFlowTheme.of(context).primaryColor,
                                                surfaceColor: vehicle.weeklyCheckUp ?
                                                FlutterFlowTheme.of(context).buenoColor
                                                :
                                                FlutterFlowTheme.of(context).primaryColor,
                                                parentColor: vehicle.weeklyCheckUp ?
                                                FlutterFlowTheme.of(context).buenoColor
                                                :
                                                FlutterFlowTheme.of(context).primaryColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
