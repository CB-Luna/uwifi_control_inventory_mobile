import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';

class HeaderShimmer extends StatefulWidget {
  const HeaderShimmer({
    Key? key,
    required this.width,
    required this.text,
  }) : super(key: key);

  final double width;
  final String text;

  @override
  State<HeaderShimmer> createState() => _HeaderShimmerState();
}

class _HeaderShimmerState extends State<HeaderShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ClayContainer(
        depth: 30,
        width: widget.width,
        spread: 2,
        customBorderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), 
          bottomRight: Radius.circular(20),
        ),
        curveType: CurveType.concave,
        color: FlutterFlowTheme.of(context).secondaryColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                  fontFamily:
                      FlutterFlowTheme.of(context).bodyText1Family,
                  color: FlutterFlowTheme.of(context).white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
