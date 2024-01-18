import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';

class MenuFormButton extends StatefulWidget {
  const MenuFormButton({
    Key? key,
    this.fillColor = const Color(0xFFDBE2E7),
    required this.icon,
    this.iconColor = const Color(0xFF2E5899),
    required this.onPressed,
    this.isTaped = false,
  }) : super(key: key);

  final Color fillColor;
  final IconData icon;
  final Color iconColor;
  final void Function() onPressed;
  final bool isTaped;

  @override
  State<MenuFormButton> createState() => _MenuFormButtonState();
}

class _MenuFormButtonState extends State<MenuFormButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: ClayContainer(
        height: 50,
        width: 50,
        depth: widget.isTaped ? 20 : 20,
        spread: widget.isTaped ? 2 : 12,
        borderRadius: 5,
        curveType: CurveType.concave,
        color: widget.isTaped
          ? FlutterFlowTheme.of(context).alternate
          : widget.fillColor,
        child: Icon(
          widget.icon,
          color: widget.isTaped
            ? FlutterFlowTheme.of(context).white
            : widget.iconColor,
          size: 30,
        ),
      ),
    );
  }
}
