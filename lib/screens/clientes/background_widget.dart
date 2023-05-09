import 'hour_background_widget.dart';
import 'custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'background_model.dart';
import 'flutter_flow_util_local.dart';
export 'background_model.dart';

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({
    Key? key,
    this.height,
  }) : super(key: key);

  final int? height;

  @override
  _BackgroundWidgetState createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  late BackgroundModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BackgroundModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      height: widget.height?.toDouble(),
      decoration: BoxDecoration(),
      child: Align(
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Builder(
          builder: (context) {
            final hours = getJsonField(
              functions.getHours(),
              r'''$.hours[*]''',
            ).toList();
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(hours.length, (hoursIndex) {
                final hoursItem = hours[hoursIndex];
                return HourBackgroundWidget(
                  key: Key('Keyy5q_${hoursIndex}_of_${hours.length}'),
                  time: getJsonField(
                    hoursItem,
                    r'''$.hour''',
                  ).toString(),
                  period: getJsonField(
                    hoursItem,
                    r'''$.period''',
                  ).toString(),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
