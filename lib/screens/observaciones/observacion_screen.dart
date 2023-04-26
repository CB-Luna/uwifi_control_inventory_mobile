import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/observacion_controller.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/usuario_controller.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/componentes/seccion_dos_formulario.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/componentes/seccion_tres_formulario.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/componentes/seccion_uno_formulario.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/observacion_creada_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/detalle_orden_trabajo_screen.dart';

class ObservacionScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const ObservacionScreen({
    super.key, 
    required this.ordenTrabajo
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
      0: const SeccionUnoFormulario(),
      1: const SeccionDosFormulario(),
      2: const SeccionTresFormulario(),
    };
    final observacionProvider = Provider.of<ObservacionController>(context);
    final usuarioProvider = Provider.of<UsuarioController>(context);
    final Usuarios currentUser = usuarioProvider.usuarioCurrent!;
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
                        'Paso ${activeStep + 1} de 3',
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
                        'Observaciones',
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
                                    observacionProvider.limpiarInformacion();
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetalleOrdenTrabajoScreen(
                                              ordenTrabajo: widget.ordenTrabajo,
                                              pantalla: "pantallaRecepcion",
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
                          if (observacionProvider.validarSeccionUnoFormulario()) {
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
                                        'Para continuar, debe llenar todos los campos solicitados.'),
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
                          if (observacionProvider.validarSeccionDosFormulario()) {
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
                                        'Para continuar, debe llenar todos los campos solicitados.'),
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
                        case 2:
                          if (observacionProvider.validarSeccionTresFormulario()) {
                            if (observacionProvider.agregarObservacion(widget.ordenTrabajo, currentUser)) {
                              observacionProvider.limpiarInformacion();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ObservacionCreadaScreen(),
                                ),
                              );
                            } else {
                              snackbarKey.currentState?.showSnackBar(const SnackBar(
                                content: Text("No se pudo agregar información de la observación, intente más tarde."),
                              ));
                            }
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Campos vacíos'),
                                    content: const Text(
                                        'Para continuar, debe llenar todos los campos solicitados.'),
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
                          activeStep == 2 ? 
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