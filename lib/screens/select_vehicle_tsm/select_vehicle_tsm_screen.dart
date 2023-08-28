import 'package:fleet_management_tool_rta/screens/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fleet_management_tool_rta/database/entitys.dart';
import 'package:fleet_management_tool_rta/flutter_flow/flutter_flow_theme.dart';
import 'package:fleet_management_tool_rta/providers/database_providers/usuario_controller.dart';
import 'package:fleet_management_tool_rta/providers/database_providers/vehiculo_controller.dart';
import 'package:fleet_management_tool_rta/screens/widgets/get_image_widget.dart';

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
      context.read<VehiculoController>().vehicleSelected =
          vehicleAvailables.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    //final vehiculoController = Provider.of<VehiculoController>(context);
    //final UserState userState = Provider.of<UserState>(context);
    vehicleAvailables = usuarioProvider.getAllVehicles();
    usuarioProvider.recoverPreviousControlForms(DateTime.now());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const SideMenu(),
        backgroundColor: FlutterFlowTheme.of(context).background,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
              child: Text(
                'Please select an Available Vehicle to continue M/TCS',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: FlutterFlowTheme.of(context).title1Family,
                      color: FlutterFlowTheme.of(context).tertiaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  height: MediaQuery.of(context).size.height - 140,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: vehicleAvailables.length,
                    itemBuilder: (context, index) {
                      final vehicle = vehicleAvailables[index];
                      return Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height * 0.14,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                color:
                                    FlutterFlowTheme.of(context).secondaryColor,
                                offset: const Offset(3.0, 3.0),
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
                                //companyColor(vehicle.company.target.company, context)
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
                                  width: 130,
                                  height: 130,
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
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(15),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Column(
                                    children: [
                                      Text(
                                          "ID: ${vehicleAvailables[index].id}"),
                                      Row(
                                        children: [
                                          const Text(
                                            "License Plates: ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(vehicle.licensePlates,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      // Comentar si quieren lo del color de la compania sea igual al color del cuadro.
                                      Row(
                                        children: [
                                          const Text(
                                            "Company: ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            "${vehicle.company.target?.company}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Status: ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            vehicle.weeklyCheckUp.toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: CarouselSlider(
            //     options: CarouselOptions(height: 200),
            //     items: vehicleAvailables.map((data) {
            //       return Builder(
            //         builder: (BuildContext context) {
            //           return InkWell(
            //             onTap: () {
            //               vehiculoController.updateVehicleSelected(data);
            //             },
            //             child: Container(
            //               height: 200,
            //               width: 290,
            //               decoration: BoxDecoration(
            //                 gradient: blueRadial,
            //                 boxShadow: [
            //                   BoxShadow(
            //                     blurRadius: 4,
            //                     color:
            //                         FlutterFlowTheme.of(context).secondaryColor,
            //                     offset: const Offset(2, 2),
            //                   )
            //                 ],
            //                 color: FlutterFlowTheme.of(context).secondaryColor,
            //                 borderRadius: const BorderRadius.only(
            //                   bottomLeft: Radius.circular(50),
            //                   bottomRight: Radius.circular(50),
            //                   topLeft: Radius.circular(20),
            //                   topRight: Radius.circular(20),
            //                 ),
            //               ),
            //               child: Center(
            //                 child: Column(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: Container(
            //                         width: 130,
            //                         height: 130,
            //                         clipBehavior: Clip.antiAlias,
            //                         decoration: const BoxDecoration(
            //                           borderRadius: BorderRadius.all(
            //                             Radius.circular(80.0),
            //                           ),
            //                         ),
            //                         child: getImageContainer(data.path),
            //                       ),
            //                     ),
            //                     Text(
            //                       "License Plates: ${data.licensePlates}",
            //                       style: TextStyle(
            //                           color: FlutterFlowTheme.of(context).white,
            //                           fontSize: 15.0,
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     }).toList(),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

// Color companyColor(String status, BuildContext context) {
//   late Color color;

//   switch (status) {
//     case "ODE": //Sales Form
//       color = AppTheme.of(context).odePrimary;
//       break;
//     case "SMI": //Sen. Exec. Validate
//       color = AppTheme.of(context).smiPrimary;
//       break;
//     case "CRY": //Finance Validate
//       color = AppTheme.of(context).cryPrimary;
//       break;

//     default:
//       return Colors.black;
//   }
//   return color;
// }
