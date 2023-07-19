import 'package:flutter/material.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';

class ExpandedText extends StatefulWidget {
  const ExpandedText({
    Key? key,
    required this.width,
    required this.text,
  }) : super(key: key);

  final double width;
  final String text;

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Text(
        textAlign: TextAlign.center,
        widget.text,
        style: FlutterFlowTheme.of(context)
        .bodyText1.override(
          fontFamily:
                FlutterFlowTheme.of(context).bodyText1Family,
          color: FlutterFlowTheme.of(context).tertiaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
