import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

class IndicatorFilterButton extends StatefulWidget {
  const IndicatorFilterButton({
    Key? key,
    this.fillColor = const Color(0xFFDBE2E7),
    required this.text,
    this.textColor = const Color(0xFF2E5899),
    required this.onPressed,
    this.isTaped = false,
  }) : super(key: key);

  final Color fillColor;
  final String text;
  final Color textColor;
  final void Function() onPressed;
  final bool isTaped;

  @override
  State<IndicatorFilterButton> createState() => _IndicatorFilterButtonState();
}

class _IndicatorFilterButtonState extends State<IndicatorFilterButton> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: ClayContainer(
        height: 50,
        width: 100,
        depth: widget.isTaped ? 20 : 20,
        spread: widget.isTaped ? 2 : 12,
        borderRadius: 5,
        curveType: CurveType.concave,
        color: widget.isTaped
          ? AppTheme.of(context).alternate
          : widget.fillColor,
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: AppTheme.of(context)
              .subtitle2
              .override(
                fontFamily: AppTheme.of(context)
                    .subtitle2Family,
                color: widget.isTaped
              ? AppTheme.of(context).white
              : widget.textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
          ),
        ),
      ),
    );
  }
}
