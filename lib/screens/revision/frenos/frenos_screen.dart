import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/frenos_controller.dart';
import 'package:taller_alex_app_asesor/screens/revision/frenos/components/seccion_dos_formularios.dart';
import 'package:taller_alex_app_asesor/screens/revision/frenos/components/seccion_uno_formulario.dart';
import 'package:taller_alex_app_asesor/screens/revision/frenos/frenos_agregado_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/detalle_orden_trabajo_screen.dart';

class FrenosScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const FrenosScreen({
    super.key, 
    required this.ordenTrabajo
  });

  @override
  _FrenosScreen createState() => _FrenosScreen();
}

class _FrenosScreen extends State<FrenosScreen> {
  // Las siguientes dos variables son necesarias para controlar el stepper
  int activeStep = 0; // step inicial está configurado a 0
  int upperBound = 2; // upperBound debe ser el total de iconos menos 1

  @override
  Widget build(BuildContext context) {
    final tabs = {
      0: const SeccionUnoFormulario(),
      1: const SeccionDosFormulario(),
    };
    final frenosProvider = Provider.of<FrenosController>(context);
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
                        'Paso ${activeStep + 1} de 2',
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
                        'Frenos',
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
                                  '¿Seguro que quieres abandonar esta pantalla?'),
                              content: const Text(
                                  'La información ingresada se perderá.'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    frenosProvider.limpiarInformacion();
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetalleOrdenTrabajoScreen(
                                              ordenTrabajo: widget.ordenTrabajo,
                                              pantalla: "pantallaRevision",
                                            ),
                                      ),
                                    );
                                  },
                                  child:
                                      const Text('Abandonar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child:
                                      const Text('Cancelar'),
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
                          'Regresar',
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
                          if (frenosProvider.validarSeccionUnoFormulario()) {
                              setState(() {
                                activeStep++;
                              });
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Campos vacíos'),
                                    content: const Text(
                                        'Para continuar, debe seleccionar el estado de los componentes solicitados.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: const Text('Bien'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }
                          break;
                        case 1:
                          if (frenosProvider.validarSeccionDosFormulario()) {
                            if (frenosProvider.agregarFrenos(widget.ordenTrabajo, widget.ordenTrabajo.revision.target!.frenos.target!)) {
                                frenosProvider.limpiarInformacion();
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FrenosAgregadoScreen(
                                          ordenTrabajo: widget.ordenTrabajo,
                                        ),
                                  ),
                                );
                              } else {
                                snackbarKey.currentState?.showSnackBar(const SnackBar(
                                  content: Text("No se pudo agregar información de los frenos, intente más tarde."),
                                ));
                              }
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Campos vacíos'),
                                    content: const Text(
                                        'Para continuar, debe seleccionar el estado de los componentes solicitados.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: const Text('Bien'),
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
                          activeStep == 1 ? 
                          'Finalizar' 
                          :
                          'Continuar',
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