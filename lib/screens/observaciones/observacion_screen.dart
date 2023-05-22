import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/modelsFormularios/data_draggable.dart';
import 'package:taller_alex_app_asesor/providers/control_form_provider.dart';
import 'package:taller_alex_app_asesor/screens/clientes/agregar_vehiculo_screen.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/componentes/seccion_dos_formulario.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/componentes/seccion_tres_formulario.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/componentes/seccion_uno_formulario.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/observacion_creada_screen.dart';
import 'package:taller_alex_app_asesor/screens/revision/revision_screen.dart';
import 'package:taller_alex_app_asesor/screens/revision/revision_screen_dos.dart';

class ObservacionScreen extends StatefulWidget {
  final DraggableData data;
  final String hour;
  final String period;
  const ObservacionScreen({
    super.key, 
    required this.hour, 
    required this.period, 
    required this.data, 
  });

  @override
  _ObservacionScreen createState() => _ObservacionScreen();
}

class _ObservacionScreen extends State<ObservacionScreen> {
  // Las siguientes dos variables son necesarias para controlar el stepper
  int activeStep = 0; // step inicial está configurado a 0
  int upperBound = 2; // upperBound debe ser el total de iconos menos 1

  @override
  Widget build(BuildContext context) {
    final tabs = {
      0: SeccionUnoFormulario(
        hour: widget.hour, 
        period: widget.period,
      ),
      1: const SeccionDosFormulario(),
      2: const SeccionTresFormulario(),
    };
    final controlFormProvider = Provider.of<ControlFormProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                IconStepper(
                  enableStepTapping: false,
                  activeStepColor: FlutterFlowTheme.of(context).primaryColor,
                  activeStepBorderColor: FlutterFlowTheme.of(context).primaryColor,
                  lineColor: FlutterFlowTheme.of(context).primaryColor,
                  lineDotRadius: 2.0,
                  enableNextPreviousButtons: false,
                  activeStep: activeStep,
                  icons: [
                    Icon(
                      Icons.looks_one_outlined,
                      color: FlutterFlowTheme.of(context).white,
                    ),
                    Icon(
                      Icons.looks_two_outlined,
                      color: FlutterFlowTheme.of(context).white,
                    ),
                    Icon(
                      Icons.looks_3_outlined,
                      color: FlutterFlowTheme.of(context).white,
                    ),
                  ],
                  onStepReached: (index) {
                    setState(() {
                      activeStep = index;
                    });
                  },
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Text(
                        'Step ${activeStep + 1} of 3',
                        style: FlutterFlowTheme.of(context)
                            .title1
                            .override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).primaryColor,
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                      child: Text(
                        'Control Daily Check Up',
                        style: FlutterFlowTheme.of(context)
                            .title1
                            .override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).primaryColor,
                              fontSize: 25,
                            ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: tabs[activeStep]!
                ),
              ],
            ),
            bottomNavigationBar: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: BottomNavigationBar(
                selectedFontSize: 0,
                items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () async {
                      if (activeStep > 0) {
                        setState(() {
                          activeStep--;
                        });
                      } else {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: const Text(
                                  'Are you sure you want to come back previous screen?'),
                              content: const Text(
                                  'The actual form data will be removed.'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    controlFormProvider.cleanData();
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                          RevisionScreenDos(draggableData: widget.data, hour: widget.hour, period: widget.period,),
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
                      }
                    },
                    child: ClayContainer(
                      height: 40,
                      width: 120,
                      depth: 40,
                      spread: 2,
                      borderRadius: 25,
                      curveType: CurveType.concave,
                      child: Center(
                        child: Text(
                          'Return',
                          style: FlutterFlowTheme.of(context)
                              .title1
                              .override(
                                fontFamily: 'Outfit',
                                color: FlutterFlowTheme.of(context).grayDark,
                                fontSize: 18,
                              ),
                        ),
                      ),
                    ),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () async {
                      switch (activeStep) {
                        case 0:
                          if (controlFormProvider.validateStepOneForm()) {
                              setState(() {
                                activeStep++;
                              });
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Empty required fields'),
                                    content: const Text(
                                        'You should input the required fields to continue.'),
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
                              return;
                            }
                          break;
                        case 1:
                          if (controlFormProvider.validateStepTwoForm()) {
                              setState(() {
                                activeStep++;
                              });
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Empty required fields'),
                                    content: const Text(
                                        'You should input the required fields to continue.'),
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
                              return;
                            }
                          break;
                        case 2:
                          if (controlFormProvider.validateStepThreeForm()) {
                              if (controlFormProvider.add()) {
                                controlFormProvider.cleanData();
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ObservacionCreadaScreen(),
                                    ),
                                  );
                              } else {
                                snackbarKey.currentState?.showSnackBar(const SnackBar(
                                content: Text("It is not possible to save the data of this form, try later."),
                              ));
                              }
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Empty required fields'),
                                    content: const Text(
                                        'You should input the required fields to continue.'),
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
                              return;
                            }
                          break;
                        default:
                          break;
                      }
                    },
                    child: ClayContainer(
                      height: 40,
                      width: 120,
                      depth: 40,
                      spread: 2,
                      borderRadius: 25,
                      curveType: CurveType.concave,
                      child: Center(
                        child: Text(
                          activeStep == 2 ? 
                          'Finish' 
                          :
                          'Continue',
                          style: FlutterFlowTheme.of(context)
                              .title1
                              .override(
                                fontFamily: 'Outfit',
                                color: FlutterFlowTheme.of(context).grayDark,
                                fontSize: 18,
                              ),
                        ),
                      ),
                    ),
                  ),
                  label: "",
                ),
              ]),
            ),
          ),
      ),
    );
  }

}