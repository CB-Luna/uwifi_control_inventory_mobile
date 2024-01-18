import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class CustomMenuItem extends StatelessWidget {
  const CustomMenuItem({
    Key? key,
    required this.label,
    required this.iconData,
    required this.onTap,
    this.padding = const EdgeInsets.only(top: 10),
    this.lineHeight,
  }) : super(key: key);

  final String label;
  final IconData iconData;
  final Function() onTap;
  final EdgeInsets padding;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: padding,
        child: Ink(
          width: 200,
          height: 40,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tertiaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            highlightColor: const Color(0x22C6ECFF),
            hoverColor: const Color(0x19C6ECFF).withOpacity(0.5),
            focusColor: const Color(0x4CCAEDFF).withOpacity(0.5),
            splashColor: const Color(0x33BDE9FF),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    iconData,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: FlutterFlowTheme.of(context).bodyText1Family,
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        lineHeight: lineHeight),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
