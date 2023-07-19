import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'day_picker_model.dart';
import 'flutter_flow_util_local.dart';
export 'day_picker_model.dart';

class DayPickerWidget extends StatefulWidget {
  const DayPickerWidget({
    Key? key,
    this.day,
    this.weekday,
    this.selected,
    this.tapped,
  }) : super(key: key);

  final int? day;
  final String? weekday;
  final bool? selected;
  final bool? tapped;

  @override
  _DayPickerWidgetState createState() => _DayPickerWidgetState();
}

class _DayPickerWidgetState extends State<DayPickerWidget>
    with TickerProviderStateMixin {
  late DayPickerModel _model;

  // final animationsMap = {
  //   'containerOnPageLoadAnimation1': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     effects: [
  //       ScaleEffect(
  //         curve: Curves.easeInOut,
  //         delay: 0.ms,
  //         duration: 200.ms,
  //         begin: Offset(1.0, 1.0),
  //         end: Offset(1.1, 1.1),
  //       ),
  //     ],
  //   ),
  //   'containerOnPageLoadAnimation2': AnimationInfo(
  //     trigger: AnimationTrigger.onPageLoad,
  //     effects: [
  //       FadeEffect(
  //         curve: Curves.easeInOut,
  //         delay: 0.ms,
  //         duration: 200.ms,
  //         begin: 1.0,
  //         end: 0.0,
  //       ),
  //     ],
  //   ),
  // };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DayPickerModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            child: Stack(
              alignment: AlignmentDirectional(0.0, 0.0),
              children: [
                if (widget.selected ?? true)
                  ClipOval(
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      alignment:
                          AlignmentDirectional(0.0, 0.050000000000000044),
                    ),
                  ),
                Text(
                  valueOrDefault<String>(
                    widget.day?.toString(),
                    '1',
                  ),
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
                if (widget.tapped ?? true)
                  ClipOval(
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      alignment:
                          AlignmentDirectional(0.0, 0.050000000000000044),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
            child: SelectionArea(
                child: Text(
              widget.weekday!,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Inter',
                    color: Color(0x7857636C),
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                  ),
            )),
          ),
        ],
      ),
    );
  }
}
