import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/screens/revision/electrico/asignacion_fluidos_screen.dart';
import 'package:taller_alex_app_asesor/screens/revision/fluidos/asignacion_fluidos_screen.dart';
import 'package:taller_alex_app_asesor/screens/revision/frenos/asignacion_frenos_screen.dart';
import 'package:taller_alex_app_asesor/screens/revision/motor/asignacion_motor_screen.dart';
import 'package:taller_alex_app_asesor/screens/revision/suspension_direccion/asignacion_suspension_direccion_screen.dart';
import 'package:taller_alex_app_asesor/screens/revision/electrico/electrico_screen.dart';
import 'package:taller_alex_app_asesor/screens/revision/fluidos/fluidos_screen.dart';
import 'package:taller_alex_app_asesor/screens/revision/frenos/frenos_screen.dart';
import 'package:taller_alex_app_asesor/screens/revision/motor/motor_screen.dart';
import 'package:taller_alex_app_asesor/screens/revision/suspension_direccion/suspension_direccion_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';

class RevisionScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;
  const RevisionScreen({
    super.key, 
    required this.ordenTrabajo,
    });

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
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

class _RevisionScreenState extends State<RevisionScreen> {
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
                      'Revisión',
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
                        widget.ordenTrabajo.vehiculo.target?.path),
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
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        if (widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.tecnicoMecanico.target == null) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AsignacionSuspensionDireccionScreen(ordenTrabajo: widget.ordenTrabajo,),
                            ),
                          );
                        } else {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Ya se ha asignado la revisión de la Suspensión / Dirección del vehículo."),
                          ));
                        }
                      },
                      child: ClayContainer(
                        height: 35,
                        width: 90,
                        depth: 30,
                        spread: 2,
                        borderRadius: 25,
                        curveType: CurveType.concave,
                        color: widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        surfaceColor: widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        parentColor: widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.tecnicoMecanico.target == null ?
                              "Asignar"
                              :
                              "Asignado",
                              style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Outfit',
                                color: widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.tecnicoMecanico.target == null ?
                                    FlutterFlowTheme.of(context).white
                                    :
                                    FlutterFlowTheme.of(context).grayLighter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    const SizedBox(
                      width: 30,
                    ),
                    Visibility(
                      visible: widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.tecnicoMecanico.target != null,
                      child: InkWell(
                        onTap: () async {
                          if (widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.completado == false) {
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
                                  "Ya se ha realizado la revisión de la Suspensión / Dirección del vehículo."),
                            ));
                          }
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.completado == false ?
                            FlutterFlowTheme.of(context).tertiaryColor
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          surfaceColor: widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.completado == false ?
                            FlutterFlowTheme.of(context).tertiaryColor
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          parentColor: widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.completado == false ?
                            FlutterFlowTheme.of(context).grayDark
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.completado == false ?
                                "Revisar"
                                :
                                "Revisado",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.completado == false ?
                                      FlutterFlowTheme.of(context).alternate
                                      :
                                      FlutterFlowTheme.of(context).white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
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
                        child: Center(
                          child: getWidgetImagePerfilUsuario(
                            widget.ordenTrabajo
                            .revision.target?.suspensionDireccion
                            .target?.tecnicoMecanico
                            .target?.path, 
                            40, 
                            40),
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
                                      widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.completado == null || 
                                      widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.completado == false ?
                                      'No revisado' 
                                      :
                                      'Revisado',
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
                                        widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.tecnicoMecanico.target == null ?
                                      'Sin Técnico Asignado' 
                                      :
                                      maybeHandleOverflow('${widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.tecnicoMecanico.target?.nombre} ${
                                        widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.tecnicoMecanico.target?.apellidoP} ${
                                        widget.ordenTrabajo.revision.target?.suspensionDireccion.target?.tecnicoMecanico.target?.apellidoM}', 50, '...'),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
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
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        if (widget.ordenTrabajo.revision.target?.motor.target?.tecnicoMecanico.target == null) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AsignacionMotorScreen(ordenTrabajo: widget.ordenTrabajo,),
                            ),
                          );
                        } else {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Ya se ha asignado la revisión del Motor del vehículo."),
                          ));
                        }
                      },
                      child: ClayContainer(
                        height: 35,
                        width: 90,
                        depth: 30,
                        spread: 2,
                        borderRadius: 25,
                        curveType: CurveType.concave,
                        color: widget.ordenTrabajo.revision.target?.motor.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        surfaceColor: widget.ordenTrabajo.revision.target?.motor.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        parentColor: widget.ordenTrabajo.revision.target?.motor.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              widget.ordenTrabajo.revision.target?.motor.target?.tecnicoMecanico.target == null ?
                              "Asignar"
                              :
                              "Asignado",
                              style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Outfit',
                                color: widget.ordenTrabajo.revision.target?.motor.target?.tecnicoMecanico.target == null ?
                                    FlutterFlowTheme.of(context).white
                                    :
                                    FlutterFlowTheme.of(context).grayLighter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    const SizedBox(
                      width: 30,
                    ),
                    Visibility(
                      visible: widget.ordenTrabajo.revision.target?.motor.target?.tecnicoMecanico.target != null,
                      child: InkWell(
                        onTap: () async {
                          if (widget.ordenTrabajo.revision.target?.motor.target?.completado == false) {
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
                                  "Ya se ha realizado la revisión del Motor del vehículo."),
                            ));
                          }
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: widget.ordenTrabajo.revision.target?.motor.target?.completado == false ?
                            FlutterFlowTheme.of(context).tertiaryColor
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          surfaceColor: widget.ordenTrabajo.revision.target?.motor.target?.completado == false ?
                            FlutterFlowTheme.of(context).tertiaryColor
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          parentColor: widget.ordenTrabajo.revision.target?.motor.target?.completado == false ?
                            FlutterFlowTheme.of(context).grayDark
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                widget.ordenTrabajo.revision.target?.motor.target?.completado == false ?
                                "Revisar"
                                :
                                "Revisado",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: widget.ordenTrabajo.revision.target?.motor.target?.completado == false ?
                                      FlutterFlowTheme.of(context).alternate
                                      :
                                      FlutterFlowTheme.of(context).white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
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
                        child: Center(
                          child: getWidgetImagePerfilUsuario(
                            widget.ordenTrabajo
                            .revision.target?.motor
                            .target?.tecnicoMecanico
                            .target?.path, 
                            40, 
                            40),
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
                                      widget.ordenTrabajo.revision.target?.motor.target?.completado == null || 
                                      widget.ordenTrabajo.revision.target?.motor.target?.completado == false ?
                                      'No revisado' 
                                      :
                                      'Revisado',
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
                                        widget.ordenTrabajo.revision.target?.motor.target?.tecnicoMecanico.target == null ?
                                      'Sin Técnico Asignado' 
                                      :
                                      maybeHandleOverflow('${widget.ordenTrabajo.revision.target?.motor.target?.tecnicoMecanico.target?.nombre} ${
                                        widget.ordenTrabajo.revision.target?.motor.target?.tecnicoMecanico.target?.apellidoP} ${
                                        widget.ordenTrabajo.revision.target?.motor.target?.tecnicoMecanico.target?.apellidoM}', 50, '...'),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
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
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        if (widget.ordenTrabajo.revision.target?.fluidos.target?.tecnicoMecanico.target == null) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AsignacionFluidosScreen(ordenTrabajo: widget.ordenTrabajo,),
                            ),
                          );
                        } else {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Ya se ha asignado la revisión de Fluidos del vehículo."),
                          ));
                        }
                      },
                      child: ClayContainer(
                        height: 35,
                        width: 90,
                        depth: 30,
                        spread: 2,
                        borderRadius: 25,
                        curveType: CurveType.concave,
                        color: widget.ordenTrabajo.revision.target?.fluidos.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        surfaceColor: widget.ordenTrabajo.revision.target?.fluidos.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        parentColor: widget.ordenTrabajo.revision.target?.fluidos.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              widget.ordenTrabajo.revision.target?.fluidos.target?.tecnicoMecanico.target == null ?
                              "Asignar"
                              :
                              "Asignado",
                              style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Outfit',
                                color: widget.ordenTrabajo.revision.target?.fluidos.target?.tecnicoMecanico.target == null ?
                                    FlutterFlowTheme.of(context).white
                                    :
                                    FlutterFlowTheme.of(context).grayLighter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    const SizedBox(
                      width: 30,
                    ),
                    Visibility(
                      visible: widget.ordenTrabajo.revision.target?.fluidos.target?.tecnicoMecanico.target != null,
                      child: InkWell(
                        onTap: () async {
                          if (widget.ordenTrabajo.revision.target?.fluidos.target?.completado == false) {
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
                                  "Ya se ha realizado la revisión del Fluido del vehículo."),
                            ));
                          }
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: widget.ordenTrabajo.revision.target?.fluidos.target?.completado == false ?
                            FlutterFlowTheme.of(context).tertiaryColor
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          surfaceColor: widget.ordenTrabajo.revision.target?.fluidos.target?.completado == false ?
                            FlutterFlowTheme.of(context).tertiaryColor
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          parentColor: widget.ordenTrabajo.revision.target?.fluidos.target?.completado == false ?
                            FlutterFlowTheme.of(context).grayDark
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                widget.ordenTrabajo.revision.target?.fluidos.target?.completado == false ?
                                "Revisar"
                                :
                                "Revisado",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: widget.ordenTrabajo.revision.target?.fluidos.target?.completado == false ?
                                      FlutterFlowTheme.of(context).alternate
                                      :
                                      FlutterFlowTheme.of(context).white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
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
                        child: Center(
                          child: getWidgetImagePerfilUsuario(
                            widget.ordenTrabajo
                            .revision.target?.fluidos
                            .target?.tecnicoMecanico
                            .target?.path, 
                            40, 
                            40),
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
                                      widget.ordenTrabajo.revision.target?.fluidos.target?.completado == null || 
                                      widget.ordenTrabajo.revision.target?.fluidos.target?.completado == false ?
                                      'No revisado' 
                                      :
                                      'Revisado',
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
                                        widget.ordenTrabajo.revision.target?.fluidos.target?.tecnicoMecanico.target == null ?
                                      'Sin Técnico Asignado' 
                                      :
                                      maybeHandleOverflow('${widget.ordenTrabajo.revision.target?.fluidos.target?.tecnicoMecanico.target?.nombre} ${
                                        widget.ordenTrabajo.revision.target?.fluidos.target?.tecnicoMecanico.target?.apellidoP} ${
                                        widget.ordenTrabajo.revision.target?.fluidos.target?.tecnicoMecanico.target?.apellidoM}', 50, '...'),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
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
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        if (widget.ordenTrabajo.revision.target?.frenos.target?.tecnicoMecanico.target == null) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AsignacionFrenosScreen(ordenTrabajo: widget.ordenTrabajo,),
                            ),
                          );
                        } else {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Ya se ha asignado la revisión de Frenos del vehículo."),
                          ));
                        }
                      },
                      child: ClayContainer(
                        height: 35,
                        width: 90,
                        depth: 30,
                        spread: 2,
                        borderRadius: 25,
                        curveType: CurveType.concave,
                        color: widget.ordenTrabajo.revision.target?.frenos.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        surfaceColor: widget.ordenTrabajo.revision.target?.frenos.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        parentColor: widget.ordenTrabajo.revision.target?.frenos.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              widget.ordenTrabajo.revision.target?.frenos.target?.tecnicoMecanico.target == null ?
                              "Asignar"
                              :
                              "Asignado",
                              style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Outfit',
                                color: widget.ordenTrabajo.revision.target?.frenos.target?.tecnicoMecanico.target == null ?
                                    FlutterFlowTheme.of(context).white
                                    :
                                    FlutterFlowTheme.of(context).grayLighter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    const SizedBox(
                      width: 30,
                    ),
                    Visibility(
                      visible: widget.ordenTrabajo.revision.target?.frenos.target?.tecnicoMecanico.target != null,
                      child: InkWell(
                        onTap: () async {
                          if (widget.ordenTrabajo.revision.target?.frenos.target?.completado == false) {
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
                                  "Ya se ha realizado la revisión de Frenos del vehículo."),
                            ));
                          }
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: widget.ordenTrabajo.revision.target?.frenos.target?.completado == false ?
                            FlutterFlowTheme.of(context).tertiaryColor
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          surfaceColor: widget.ordenTrabajo.revision.target?.frenos.target?.completado == false ?
                            FlutterFlowTheme.of(context).tertiaryColor
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          parentColor: widget.ordenTrabajo.revision.target?.frenos.target?.completado == false ?
                            FlutterFlowTheme.of(context).grayDark
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                widget.ordenTrabajo.revision.target?.frenos.target?.completado == false ?
                                "Revisar"
                                :
                                "Revisado",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: widget.ordenTrabajo.revision.target?.frenos.target?.completado == false ?
                                      FlutterFlowTheme.of(context).alternate
                                      :
                                      FlutterFlowTheme.of(context).white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
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
                        child: Center(
                          child: getWidgetImagePerfilUsuario(
                            widget.ordenTrabajo
                            .revision.target?.frenos
                            .target?.tecnicoMecanico
                            .target?.path, 
                            40, 
                            40),
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
                                      widget.ordenTrabajo.revision.target?.frenos.target?.completado == null || 
                                      widget.ordenTrabajo.revision.target?.frenos.target?.completado == false ?
                                      'No revisado' 
                                      :
                                      'Revisado',
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
                                        widget.ordenTrabajo.revision.target?.frenos.target?.tecnicoMecanico.target == null ?
                                      'Sin Técnico Asignado' 
                                      :
                                      maybeHandleOverflow('${widget.ordenTrabajo.revision.target?.frenos.target?.tecnicoMecanico.target?.nombre} ${
                                        widget.ordenTrabajo.revision.target?.frenos.target?.tecnicoMecanico.target?.apellidoP} ${
                                        widget.ordenTrabajo.revision.target?.frenos.target?.tecnicoMecanico.target?.apellidoM}', 50, '...'),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
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
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        if (widget.ordenTrabajo.revision.target?.electrico.target?.tecnicoMecanico.target == null) {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AsignacionElectricoScreen(ordenTrabajo: widget.ordenTrabajo,),
                            ),
                          );
                        } else {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "Ya se ha asignado la revisión del Sistema Eléctrico del vehículo."),
                          ));
                        }
                      },
                      child: ClayContainer(
                        height: 35,
                        width: 90,
                        depth: 30,
                        spread: 2,
                        borderRadius: 25,
                        curveType: CurveType.concave,
                        color: widget.ordenTrabajo.revision.target?.electrico.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        surfaceColor: widget.ordenTrabajo.revision.target?.electrico.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        parentColor: widget.ordenTrabajo.revision.target?.electrico.target?.tecnicoMecanico.target == null ?
                          FlutterFlowTheme.of(context).primaryColor
                          :
                          FlutterFlowTheme.of(context).secondaryColor,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              widget.ordenTrabajo.revision.target?.electrico.target?.tecnicoMecanico.target == null ?
                              "Asignar"
                              :
                              "Asignado",
                              style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Outfit',
                                color: widget.ordenTrabajo.revision.target?.electrico.target?.tecnicoMecanico.target == null ?
                                    FlutterFlowTheme.of(context).white
                                    :
                                    FlutterFlowTheme.of(context).grayLighter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    const SizedBox(
                      width: 30,
                    ),
                    Visibility(
                      visible: widget.ordenTrabajo.revision.target?.electrico.target?.tecnicoMecanico.target != null,
                      child: InkWell(
                        onTap: () async {
                          if (widget.ordenTrabajo.revision.target?.electrico.target?.completado == false) {
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
                                  "Ya se ha realizado la revisión del Sistema Eléctrico del vehículo."),
                            ));
                          }
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: widget.ordenTrabajo.revision.target?.electrico.target?.completado == false ?
                            FlutterFlowTheme.of(context).tertiaryColor
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          surfaceColor: widget.ordenTrabajo.revision.target?.electrico.target?.completado == false ?
                            FlutterFlowTheme.of(context).tertiaryColor
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          parentColor: widget.ordenTrabajo.revision.target?.electrico.target?.completado == false ?
                            FlutterFlowTheme.of(context).grayDark
                            :
                            FlutterFlowTheme.of(context).grayLight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                widget.ordenTrabajo.revision.target?.electrico.target?.completado == false ?
                                "Revisar"
                                :
                                "Revisado",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: widget.ordenTrabajo.revision.target?.electrico.target?.completado == false ?
                                      FlutterFlowTheme.of(context).alternate
                                      :
                                      FlutterFlowTheme.of(context).white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
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
                        child: Center(
                          child: getWidgetImagePerfilUsuario(
                            widget.ordenTrabajo
                            .revision.target?.electrico
                            .target?.tecnicoMecanico
                            .target?.path, 
                            40, 
                            40),
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
                                      widget.ordenTrabajo.revision.target?.electrico.target?.completado == null || 
                                      widget.ordenTrabajo.revision.target?.electrico.target?.completado == false ?
                                      'No revisado' 
                                      :
                                      'Revisado',
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
                                        widget.ordenTrabajo.revision.target?.electrico.target?.tecnicoMecanico.target == null ?
                                      'Sin Técnico Asignado' 
                                      :
                                      maybeHandleOverflow('${widget.ordenTrabajo.revision.target?.electrico.target?.tecnicoMecanico.target?.nombre} ${
                                        widget.ordenTrabajo.revision.target?.electrico.target?.tecnicoMecanico.target?.apellidoP} ${
                                        widget.ordenTrabajo.revision.target?.electrico.target?.tecnicoMecanico.target?.apellidoM}', 50, '...'),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
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