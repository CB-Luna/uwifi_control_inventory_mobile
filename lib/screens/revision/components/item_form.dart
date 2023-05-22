import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:taller_alex_app_asesor/screens/ordenes_trabajo/flutter_flow_animaciones.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({
    Key? key,
    required this.textItem,
    required this.onPressed,
    this.isRegistered = true,
    required this.isRight,
  }) : super(key: key);

  final String textItem;
  final void Function() onPressed;
  final bool isRegistered;
  final bool isRight;

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.textItem,
            style: FlutterFlowTheme.of(context)
            .bodyText1.override(
              fontFamily:
                    FlutterFlowTheme.of(context).bodyText1Family,
              color: FlutterFlowTheme.of(context).tertiaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        GestureDetector(
          onTap: widget.onPressed,
          child: ClayContainer(
            height: 30,
            width: 30,
            depth: 10,
            spread: 1,
            borderRadius: 25,
            curveType: CurveType.concave,
            color: widget.isRegistered ?
            FlutterFlowTheme.of(context).buenoColor
            :
            FlutterFlowTheme.of(context).primaryColor,
            surfaceColor: widget.isRegistered ?
            FlutterFlowTheme.of(context).buenoColor
            :
            FlutterFlowTheme.of(context).primaryColor,
            parentColor: widget.isRegistered ?
            FlutterFlowTheme.of(context).buenoColor
            :
            FlutterFlowTheme.of(context).primaryColor,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                widget.isRegistered ? Icons.check : Icons.close,
                color: widget.isRegistered ?
                FlutterFlowTheme.of(context).grayDark
                :
                FlutterFlowTheme.of(context).white,
                size: 20,
              ),
            ),
          ) .animateOnPageLoad(
            widget.isRight ?
            animationsMap['moveLoadAnimationRL']!
            :
            animationsMap['moveLoadAnimationLR']!
            ),
        ),
      ],
    ),
  );
  }
}
