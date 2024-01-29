import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

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
        style: AppTheme.of(context)
        .bodyText1.override(
          fontFamily:
                AppTheme.of(context).bodyText1Family,
          color: AppTheme.of(context).tertiaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
