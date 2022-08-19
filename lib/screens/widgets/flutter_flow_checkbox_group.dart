import 'package:flutter/material.dart';

class FlutterFlowCheckboxGroup extends StatefulWidget {
  const FlutterFlowCheckboxGroup({
    required this.initiallySelected,
    required this.options,
    required this.onChanged,
    this.textStyle,
    this.labelPadding,
    this.itemPadding,
    this.activeColor,
    this.checkColor,
    this.checkboxBorderRadius,
    this.checkboxBorderColor,
  });

  final bool initiallySelected;
  final String options;
  final void Function(bool) onChanged;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? labelPadding;
  final EdgeInsetsGeometry? itemPadding;
  final Color? activeColor;
  final Color? checkColor;
  final BorderRadius? checkboxBorderRadius;
  final Color? checkboxBorderColor;

  @override
  State<FlutterFlowCheckboxGroup> createState() =>
      _FlutterFlowCheckboxGroupState();
}

class _FlutterFlowCheckboxGroupState extends State<FlutterFlowCheckboxGroup> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool selected = widget.initiallySelected;
    return Theme(
      data: ThemeData(unselectedWidgetColor: widget.checkboxBorderColor),
      child: Padding(
        padding: widget.itemPadding ?? EdgeInsets.zero,
        child: Row(
          children: [
            Checkbox(
              value: selected,
              onChanged: (isSelected) {
                if (isSelected == null) {
                  return;
                }
                selected = !isSelected;
                widget.onChanged(selected);
                setState(() {
                });
              },
              activeColor: widget.activeColor,
              checkColor: widget.checkColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    widget.checkboxBorderRadius ?? BorderRadius.zero,
              ),
            ),
            Padding(
              padding: widget.labelPadding ?? EdgeInsets.zero,
              child: Text(
                widget.options,
                style: widget.textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
