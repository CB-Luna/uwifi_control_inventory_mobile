import 'dart:io' as libraryIO;
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uwifi_control_inventory_mobile/database/image_evidence.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/flutter_flow_animaciones.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/bottom_sheet_image_required.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/bottom_sheet_validacion_eliminar_imagen.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/drop_down.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/flutter_flow_expanded_image_view.dart';
class ItemFormBundleGatewaySIMSCard extends StatefulWidget {
  const ItemFormBundleGatewaySIMSCard({
    Key? key,
    required this.textItem,
    required this.onPressed,
    this.readOnly = false,
    this.applyFuction = false,
    required this.isRight,
    required this.images,
    this.addImage,
    this.deleteImage,
    this.comments,
    this.report,
    this.updateReport,
    this.clearReport,
    this.reportYesNo = false,
    this.isRegistered = false,
    this.requiredImages = false,
  }) : super(key: key);

  final String textItem;
  final void Function() onPressed;
  final bool readOnly;
  final bool applyFuction;
  final bool isRight;
  final List<ImageEvidence> images;
  final void Function(ImageEvidence value)? addImage;
  final void Function(ImageEvidence value)? deleteImage;
  final TextEditingController? comments;
  final String? report;
  final void Function(String value)? updateReport;
  final void Function()? clearReport;
  final bool reportYesNo;
  final bool isRegistered;
  final bool requiredImages;

  @override
  State<ItemFormBundleGatewaySIMSCard> createState() => _ItemFormBundleGatewaySIMSCardState();
}

class _ItemFormBundleGatewaySIMSCardState extends State<ItemFormBundleGatewaySIMSCard> {
  List<ImageEvidence> imagesTemp = [];
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
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
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
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
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
        Text(
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
        Text(
          DateFormat("MMM-dd-yyyy").format(DateTime.now()),
          style: FlutterFlowTheme.of(context)
          .bodyText1.override(
            fontFamily:
                  FlutterFlowTheme.of(context).bodyText1Family,
            color: FlutterFlowTheme.of(context).secondaryText,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
              child: GestureDetector(
                onTap: widget.applyFuction ?
                widget.onPressed
                :
                () async {
                },
                child: ClayContainer(
                  height: 30,
                  width: 30,
                  depth: 10,
                  spread: 1,
                  borderRadius: 25,
                  curveType: CurveType.concave,
                  color: widget.report == "Good" || widget.report == "Yes" || widget.readOnly || widget.isRegistered ?
                  FlutterFlowTheme.of(context).buenoColor
                  :
                  FlutterFlowTheme.of(context).customColor3,
                  surfaceColor: widget.report == "Good" || widget.report == "Yes" || widget.readOnly || widget.isRegistered ?
                  FlutterFlowTheme.of(context).buenoColor
                  :
                  FlutterFlowTheme.of(context).customColor3,
                  parentColor: widget.report == "Good" || widget.report == "Yes" || widget.readOnly || widget.isRegistered ?
                  FlutterFlowTheme.of(context).buenoColor
                  :
                  FlutterFlowTheme.of(context).customColor3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      Icons.looks_one_outlined,
                      color: FlutterFlowTheme.of(context).white,
                      size: 20,
                    ),
                  ),
                ).animateOnPageLoad(
                  widget.isRight ?
                  animationsMap['moveLoadAnimationRL']!
                  :
                  animationsMap['moveLoadAnimationLR']!
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
              child: GestureDetector(
                onTap: widget.applyFuction ?
                widget.onPressed
                :
                () async {
                },
                child: ClayContainer(
                  height: 30,
                  width: 30,
                  depth: 10,
                  spread: 1,
                  borderRadius: 25,
                  curveType: CurveType.concave,
                  color: FlutterFlowTheme.of(context).customColor3,
                  surfaceColor: FlutterFlowTheme.of(context).customColor3,
                  parentColor: FlutterFlowTheme.of(context).customColor3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      Icons.looks_two_outlined,
                      color: FlutterFlowTheme.of(context).white,
                      size: 20,
                    ),
                  ),
                ).animateOnPageLoad(
                  widget.isRight ?
                  animationsMap['moveLoadAnimationRL']!
                  :
                  animationsMap['moveLoadAnimationLR']!
                  ),
              ),
            ),
          ],
        )
      ],
    ),
  );
  }
}
