import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_widgets.dart';

import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/vehiculo_controller.dart';
import 'package:taller_alex_app_asesor/screens/services_vehicle/services_vehicle_screen.dart';
import 'package:taller_alex_app_asesor/screens/services_vehicle/services_vehicle_updated_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/drop_down.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/util.dart';

class CompletedServicesVehicleScreen extends StatefulWidget {
  final Vehicle vehicle;
  final VehicleServices vehicleServices;
  const CompletedServicesVehicleScreen({
      Key? key, 
      required this.vehicle, 
      required this.vehicleServices,
    }) : super(key: key);

  @override
  _CompletedServicesVehicleScreenState createState() =>
      _CompletedServicesVehicleScreenState();
}

class _CompletedServicesVehicleScreenState extends State<CompletedServicesVehicleScreen> {
  XFile? image;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final vehiculoKey = GlobalKey<FormState>();
  final _unfocusNode = FocusNode();

    @override
  void initState() {
    super.initState();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final vehiculoController = Provider.of<VehiculoController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).background,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Form(
              key: vehiculoKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20, 45, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Are you sure you want to back previous screen?'),
                                    content: const Text(
                                        'The input information is going to be delete.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          vehiculoController.cleanServiceVehicleComponentes();
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                ServicesVehicleScreen(vehicle: widget.vehicle,),
                                            ),
                                          );
                                        },
                                        child:
                                            const Text('Back'),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Service Vehicle Form',
                          style:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyText1Family,
                                color: FlutterFlowTheme.of(context).tertiaryColor,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
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
                          style: FlutterFlowTheme.of(context).bodyText2,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 5, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "${widget.vehicle.company.target!.company}: ${widget.vehicle.licensePlates}",
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Outfit',
                                color: FlutterFlowTheme.of(context).dark400,
                              ),
                        ),
                      ],
                    ),
                  ),
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
                      child: getImageEmprendimiento(
                        widget.vehicle.path),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, 15, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.vehicleServices.service.target!.service,
                          style:
                          FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyText1Family,
                                color: FlutterFlowTheme.of(context).tertiaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                            35, 10, 35, 0),
                    child: SizedBox(
                      child: Text(
                        widget.vehicleServices.service.target!.description,
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                          fontFamily: 'Outfit',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                            40, 10, 35, 0),
                    child: SizedBox(
                      child: Row(
                        children: [
                          Text(
                            "Service Completed",
                            style: FlutterFlowTheme.of(context).bodyText2.override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).alternate,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FormField(
                    builder: (state) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            35, 5, 35, 0),
                        child: DropDown(
                          initialOption: 'No',
                          options: const ['Yes', 'No'],
                          onChanged: (val) => setState(() {
                            vehiculoController.updateServiceCompleted(val!);
                          }),
                          width: double.infinity,
                          height: 50,
                          textStyle:
                              FlutterFlowTheme.of(context).title3.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).tertiaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                          hintText: 'Service Completed',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).tertiaryColor,
                            size: 30,
                          ),
                          fillColor: FlutterFlowTheme.of(context).white,
                          elevation: 2,
                          borderColor: FlutterFlowTheme.of(context).tertiaryColor,
                          borderWidth: 2,
                          borderRadius: 8,
                          margin: const EdgeInsetsDirectional.fromSTEB(
                              12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                            35, 20, 35, 0),
                    child: TextFormField(
                      controller: vehiculoController.completedDateController,
                      autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                      onTap: () async {
                        await DatePicker.showDatePicker(
                          context,
                          locale: LocaleType.en,
                          showTitleActions: true,
                          onConfirm: (date) {
                            setState(() {
                              vehiculoController.updateCompletedDate(date);
                            });
                          },
                          currentTime: getCurrentTimestamp,
                          minTime: widget.vehicleServices.serviceDate ?? DateTime.now()
                        );
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: FlutterFlowTheme.of(context).white,
                        hintText: 'Completed Date...',
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                      suffixIcon: Icon(
                          Icons.date_range_outlined,
                          color: FlutterFlowTheme.of(context)
                              .primaryText,
                          size: 24,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyText1,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.none,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Completed date is required.';
                        }
                        return null;
                      }),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (vehiculoController
                            .validateForm(vehiculoKey) && vehiculoController.serviceCompleted.text == "Yes") {
                          if (vehiculoController.updateServiceVehicle(widget.vehicleServices)) {
                            vehiculoController.cleanServiceVehicleComponentes();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                  const ServicesVehicleUpdatedScreen(),
                              ),
                            );
                          } else {
                            vehiculoController.cleanServiceVehicleComponentes();
                            snackbarKey.currentState
                                ?.showSnackBar(
                                    const SnackBar(
                              content: Text(
                                  "Failed to Updated Vehicle Service, try later."),
                            ));
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                  ServicesVehicleScreen(vehicle: widget.vehicle,),
                              ),
                            );
                          }
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: const Text(
                                    'Field empty required or incomplete service.'),
                                content: const Text(
                                    "Full in all the fields and change the status of the Service to 'Yes' to continue."),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(
                                            alertDialogContext),
                                    child:
                                        const Text('Okay'),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }
                      },
                      text: 'Accept',
                      options: FFButtonOptions(
                        width: 200,
                        height: 50,
                        color: FlutterFlowTheme.of(context).alternate,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle1.override(
                                  fontFamily: 'Lexend Deca',
                                  color: FlutterFlowTheme.of(context).white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                        elevation: 3,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
