import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/modelsFormularios/data_draggable.dart';
import 'package:taller_alex_app_asesor/screens/clientes/agregar_vehiculo_screen.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/observacion_screen.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';

class RevisionScreen extends StatefulWidget {
  final String hour;
  final String period;
  final DraggableData draggableData; 
  const RevisionScreen({
    super.key, 
    required this.draggableData, required this.hour, required this.period, 
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
              Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  5, 5, 0, 0),
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryColor,
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
                              AgregarVehiculoScreen(),
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
                          color: FlutterFlowTheme.of(context).white,
                          size: 16,
                        ),
                        Text(
                          'Atrás',
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
              ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
            ],
          ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Check Up Daily',
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
                thickness: 4,
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
                    child: getAssetImageContainer(
                        widget.draggableData.image),
                  ),
                ),
              ).animateOnPageLoad(animationsMap['moveLoadAnimationLR']!),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'General Information',
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    const Spacer(),
                    Shimmer(
                      child: InkWell(
                        onTap: () async {
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: true?
                            FlutterFlowTheme.of(context).secondaryColor
                            :
                            FlutterFlowTheme.of(context).secondaryColor,
                          surfaceColor: true?
                            FlutterFlowTheme.of(context).secondaryColor
                            :
                            FlutterFlowTheme.of(context).secondaryColor,
                          parentColor: true?
                            FlutterFlowTheme.of(context).secondaryColor
                            :
                            FlutterFlowTheme.of(context).secondaryColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                true?
                                "Completed"
                                :
                                "Pending",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: true?
                                      FlutterFlowTheme.of(context).white
                                      :
                                      FlutterFlowTheme.of(context).grayLighter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Measures',
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    const Spacer(),
                    Shimmer(
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ObservacionScreen(hour: widget.hour, period: widget.period, data: widget.draggableData,),
                            ),
                          );
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          surfaceColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          parentColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                "Pending",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: true?
                                      FlutterFlowTheme.of(context).white
                                      :
                                      FlutterFlowTheme.of(context).grayLighter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lights',
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    const Spacer(),
                    Shimmer(
                      child: InkWell(
                        onTap: () async {
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          surfaceColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          parentColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                true?
                                "Pending"
                                :
                                "Pending",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: true?
                                      FlutterFlowTheme.of(context).white
                                      :
                                      FlutterFlowTheme.of(context).grayLighter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Car BodyWork',
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    const Spacer(),
                    Shimmer(
                      child: InkWell(
                        onTap: () async {
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          surfaceColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          parentColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                true?
                                "Pending"
                                :
                                "Pending",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: true?
                                      FlutterFlowTheme.of(context).white
                                      :
                                      FlutterFlowTheme.of(context).grayLighter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fluids Check',
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    const Spacer(),
                    Shimmer(
                      child: InkWell(
                        onTap: () async {
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          surfaceColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          parentColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                true?
                                "Pending"
                                :
                                "Pending",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: true?
                                      FlutterFlowTheme.of(context).white
                                      :
                                      FlutterFlowTheme.of(context).grayLighter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bucket Inspection',
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    const Spacer(),
                    Shimmer(
                      child: InkWell(
                        onTap: () async {
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          surfaceColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          parentColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                true?
                                "Pending"
                                :
                                "Pending",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: true?
                                      FlutterFlowTheme.of(context).white
                                      :
                                      FlutterFlowTheme.of(context).grayLighter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Security',
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    const Spacer(),
                    Shimmer(
                      child: InkWell(
                        onTap: () async {
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          surfaceColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          parentColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                true?
                                "Pending"
                                :
                                "Pending",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: true?
                                      FlutterFlowTheme.of(context).white
                                      :
                                      FlutterFlowTheme.of(context).grayLighter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Extra',
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    const Spacer(),
                    Shimmer(
                      child: InkWell(
                        onTap: () async {
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          surfaceColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          parentColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                true?
                                "Pending"
                                :
                                "Pending",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: true?
                                      FlutterFlowTheme.of(context).white
                                      :
                                      FlutterFlowTheme.of(context).grayLighter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Equipment for Installers',
                      style: FlutterFlowTheme.of(context).subtitle1,
                    ),
                    const Spacer(),
                    Shimmer(
                      child: InkWell(
                        onTap: () async {
                        },
                        child: ClayContainer(
                          height: 35,
                          width: 90,
                          depth: 30,
                          spread: 2,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          color: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          surfaceColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          parentColor: true?
                            FlutterFlowTheme.of(context).primaryColor
                            :
                            FlutterFlowTheme.of(context).primaryColor,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                true?
                                "Pending"
                                :
                                "Pending",
                                style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Outfit',
                                  color: true?
                                      FlutterFlowTheme.of(context).white
                                      :
                                      FlutterFlowTheme.of(context).grayLighter,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['moveLoadAnimationRL']!),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Divider(
                height: 4,
                thickness: 4,
                indent: 20,
                endIndent: 20,
                color: FlutterFlowTheme.of(context).grayLighter,
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