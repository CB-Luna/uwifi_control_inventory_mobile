import 'package:uwifi_control_inventory_mobile/screens/employees/widget/app_state.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flutter_flow_util_local.dart';
import 'now_line_model.dart';
export 'now_line_model.dart';

class NowLineWidget extends StatefulWidget {
  const NowLineWidget({
    Key? key,
    this.height,
  }) : super(key: key);

  final int? height;

  @override
  _NowLineWidgetState createState() => _NowLineWidgetState();
}

class _NowLineWidgetState extends State<NowLineWidget> {
  late NowLineModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NowLineModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 1.0,
          height: widget.height?.toDouble(),
          decoration: BoxDecoration(),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.03,
              height: MediaQuery.of(context).size.width * 0.03,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 2.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
