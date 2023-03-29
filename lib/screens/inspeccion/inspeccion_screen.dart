import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/screens/inspeccion/electrico/electrico_screen.dart';
import 'package:taller_alex_app_asesor/screens/inspeccion/fluidos/fluidos_screen.dart';
import 'package:taller_alex_app_asesor/screens/inspeccion/frenos/frenos_screen.dart';
import 'package:taller_alex_app_asesor/screens/inspeccion/motor/motor_screen.dart';
import 'package:taller_alex_app_asesor/screens/inspeccion/suspension_direccion/suspension_direccion_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';

class InspeccionScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const InspeccionScreen({
    super.key, 
    required this.ordenTrabajo,
    });

  @override
  State<InspeccionScreen> createState() => _InspeccionScreenState();
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

class _InspeccionScreenState extends State<InspeccionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Inspección',
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
              Divider(
                height: 4,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: ClayContainer(
                  height: 200,
                  width: double.infinity,
                  depth: 50,
                  spread: 10,
                  borderRadius: 25,
                  curveType: CurveType.concave,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: getImageEmprendimiento(
                        widget.ordenTrabajo.vehiculo.target?.imagen.target?.path),
                  ),
                ),
              ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
              Divider(
                height: 4,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Suspensión/Dirección',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                    InkWell(
                      onTap: () async {
                        if (widget.ordenTrabajo.inspeccion.target?.suspensionDireccion == null) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SuspensionDireccionScreen(ordenTrabajo: widget.ordenTrabajo,),
                            ),
                          );
                        } else {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Ya se ha realizado la inspección de la Suspensión / Dirección del vehículo."),
                          ));
                        }
                      },
                      child: ClayContainer(
                        height: 35,
                        width: 110,
                        depth: 30,
                        spread: 2,
                        borderRadius: 25,
                        curveType: CurveType.concave,
                        color: widget.ordenTrabajo.inspeccion.target?.suspensionDireccion == null ?
                          FlutterFlowTheme.of(context).tertiaryColor
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        surfaceColor: widget.ordenTrabajo.inspeccion.target?.suspensionDireccion == null ?
                          FlutterFlowTheme.of(context).tertiaryColor
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        parentColor: widget.ordenTrabajo.inspeccion.target?.suspensionDireccion == null ?
                          FlutterFlowTheme.of(context).grayDark
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              widget.ordenTrabajo.inspeccion.target?.suspensionDireccion == null ?
                              "Revisar"
                              :
                              "Revisado",
                              style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Outfit',
                                color: widget.ordenTrabajo.inspeccion.target?.suspensionDireccion == null ?
                                    FlutterFlowTheme.of(context).alternate
                                    :
                                    FlutterFlowTheme.of(context).white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/default-user-profile-picture.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.ordenTrabajo.inspeccion.target?.suspensionDireccion == null ?
                                      'Sin inspeccionar' 
                                      :
                                      'Inspeccionado',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            fontSize: 12,
                                            color: FlutterFlowTheme.of(context).primaryColor
                                          ),
                                    ),
                                    Text(
                                      '',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            color:
                                                FlutterFlowTheme.of(context)
                                                    .grayDark,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Text(
                                        "Sin Técnico Asignado",
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
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
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Motor',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                    InkWell(
                      onTap: () async {
                        if (widget.ordenTrabajo.inspeccion.target?.motor == null) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MotorScreen(ordenTrabajo: widget.ordenTrabajo,),
                            ),
                          );
                        } else {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Ya se ha realizado la inspección del Motor del vehículo."),
                          ));
                        }
                      },
                      child: ClayContainer(
                        height: 35,
                        width: 110,
                        depth: 30,
                        spread: 2,
                        borderRadius: 25,
                        curveType: CurveType.concave,
                        color: widget.ordenTrabajo.inspeccion.target?.motor == null ?
                          FlutterFlowTheme.of(context).tertiaryColor
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        surfaceColor: widget.ordenTrabajo.inspeccion.target?.motor == null ?
                          FlutterFlowTheme.of(context).tertiaryColor
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        parentColor: widget.ordenTrabajo.inspeccion.target?.motor == null ?
                          FlutterFlowTheme.of(context).grayDark
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              widget.ordenTrabajo.inspeccion.target?.motor == null ?
                              "Revisar"
                              :
                              "Revisado",
                              style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Outfit',
                                color: widget.ordenTrabajo.inspeccion.target?.motor == null ?
                                    FlutterFlowTheme.of(context).alternate
                                    :
                                    FlutterFlowTheme.of(context).white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/default-user-profile-picture.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.ordenTrabajo.inspeccion.target?.motor == null ?
                                      'Sin inspeccionar' 
                                      :
                                      'Inspeccionado',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            fontSize: 12,
                                            color: FlutterFlowTheme.of(context).primaryColor
                                          ),
                                    ),
                                    Text(
                                      '',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            color:
                                                FlutterFlowTheme.of(context)
                                                    .grayDark,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Text(
                                        "Sin Técnico Asignado",
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
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
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fluidos',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                    InkWell(
                      onTap: () async {
                         if (widget.ordenTrabajo.inspeccion.target?.fluidos == null) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FluidosScreen(ordenTrabajo: widget.ordenTrabajo,),
                            ),
                          );
                        } else {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Ya se ha realizado la inspección de los Fluidos del vehículo."),
                          ));
                        }
                      },
                      child: ClayContainer(
                        height: 35,
                        width: 110,
                        depth: 30,
                        spread: 2,
                        borderRadius: 25,
                        curveType: CurveType.concave,
                        color: widget.ordenTrabajo.inspeccion.target?.fluidos == null ?
                          FlutterFlowTheme.of(context).tertiaryColor
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        surfaceColor: widget.ordenTrabajo.inspeccion.target?.fluidos == null ?
                          FlutterFlowTheme.of(context).tertiaryColor
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        parentColor: widget.ordenTrabajo.inspeccion.target?.fluidos == null ?
                          FlutterFlowTheme.of(context).grayDark
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              widget.ordenTrabajo.inspeccion.target?.fluidos == null ?
                              "Revisar"
                              :
                              "Revisado",
                              style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Outfit',
                                color: widget.ordenTrabajo.inspeccion.target?.fluidos == null ?
                                    FlutterFlowTheme.of(context).alternate
                                    :
                                    FlutterFlowTheme.of(context).white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/default-user-profile-picture.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.ordenTrabajo.inspeccion.target?.fluidos == null ?
                                      'Sin inspeccionar' 
                                      :
                                      'Inspeccionado',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            fontSize: 12,
                                            color: FlutterFlowTheme.of(context).primaryColor
                                          ),
                                    ),
                                    Text(
                                      '',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            color:
                                                FlutterFlowTheme.of(context)
                                                    .grayDark,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Text(
                                        "Sin Técnico Asignado",
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
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
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Frenos',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                    InkWell(
                      onTap: () async {
                        if (widget.ordenTrabajo.inspeccion.target?.frenos == null) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FrenosScreen(ordenTrabajo: widget.ordenTrabajo,),
                            ),
                          );
                        } else {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Ya se ha realizado la inspección de los Frenos del vehículo."),
                          ));
                        }
                      },
                      child: ClayContainer(
                        height: 35,
                        width: 110,
                        depth: 30,
                        spread: 2,
                        borderRadius: 25,
                        curveType: CurveType.concave,
                        color: widget.ordenTrabajo.inspeccion.target?.frenos == null ?
                          FlutterFlowTheme.of(context).tertiaryColor
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        surfaceColor: widget.ordenTrabajo.inspeccion.target?.frenos == null ?
                          FlutterFlowTheme.of(context).tertiaryColor
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        parentColor: widget.ordenTrabajo.inspeccion.target?.frenos == null ?
                          FlutterFlowTheme.of(context).grayDark
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              widget.ordenTrabajo.inspeccion.target?.frenos == null ?
                              "Revisar"
                              :
                              "Revisado",
                              style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Outfit',
                                color: widget.ordenTrabajo.inspeccion.target?.frenos == null ?
                                    FlutterFlowTheme.of(context).alternate
                                    :
                                    FlutterFlowTheme.of(context).white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/default-user-profile-picture.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.ordenTrabajo.inspeccion.target?.frenos == null ?
                                      'Sin inspeccionar' 
                                      :
                                      'Inspeccionado',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            fontSize: 12,
                                            color: FlutterFlowTheme.of(context).primaryColor
                                          ),
                                    ),
                                    Text(
                                      '',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Outfit',
                                            color:
                                                FlutterFlowTheme.of(context)
                                                    .grayDark,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 12, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 4, 0, 0),
                                      child: Text(
                                        "Sin Técnico Asignado",
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
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
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sistema Eléctrico',
                      style: FlutterFlowTheme.of(context).bodyText2,
                    ),
                    InkWell(
                      onTap: () async {
                        if (widget.ordenTrabajo.inspeccion.target?.electrico == null) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ElectricoScreen(ordenTrabajo: widget.ordenTrabajo,),
                            ),
                          );
                        } else {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Ya se ha realizado la inspección del Sistema Eléctrico del vehículo."),
                          ));
                        }
                      },
                      child: ClayContainer(
                        height: 35,
                        width: 110,
                        depth: 30,
                        spread: 2,
                        borderRadius: 25,
                        curveType: CurveType.concave,
                        color: widget.ordenTrabajo.inspeccion.target?.electrico == null ?
                          FlutterFlowTheme.of(context).tertiaryColor
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        surfaceColor: widget.ordenTrabajo.inspeccion.target?.electrico == null ?
                          FlutterFlowTheme.of(context).tertiaryColor
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        parentColor: widget.ordenTrabajo.inspeccion.target?.electrico == null ?
                          FlutterFlowTheme.of(context).grayDark
                          :
                          FlutterFlowTheme.of(context).grayLight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              widget.ordenTrabajo.inspeccion.target?.electrico == null ?
                              "Revisar"
                              :
                              "Revisado",
                              style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Outfit',
                                color: widget.ordenTrabajo.inspeccion.target?.electrico == null ?
                                    FlutterFlowTheme.of(context).alternate
                                    :
                                    FlutterFlowTheme.of(context).white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: InkWell(
                  onTap: () async {
                  },
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/default-user-profile-picture.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 12, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.ordenTrabajo.inspeccion.target?.electrico == null ?
                                      'Sin inspeccionar' 
                                      :
                                      'Inspeccionado',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Outfit',
                                              fontSize: 12,
                                              color: FlutterFlowTheme.of(context).primaryColor
                                            ),
                                      ),
                                      Text(
                                        '',
                                        textAlign: TextAlign.end,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Outfit',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .grayDark,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 12, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          "Sin Técnico Asignado",
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1,
                                        ),
                                      ),
                                    ],
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