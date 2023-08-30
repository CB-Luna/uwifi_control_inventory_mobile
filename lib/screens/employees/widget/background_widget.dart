import 'package:fleet_management_tool_rta/providers/control_form_provider.dart';
import 'package:fleet_management_tool_rta/screens/employees/widget/app_state.dart';

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
    required this.typeForm,
  }) : super(key: key);

  final int? height;
  final bool typeForm;

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
    final controlFormProvider = Provider.of<ControlFormProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      height: widget.height?.toDouble(),
      decoration: const BoxDecoration(),
      child: Align(
        alignment: const AlignmentDirectional(0.0, 0.0),
        child: Builder(
          builder: (context) {
            dynamic hours;
            if (controlFormProvider.hours != null) {
              hours = controlFormProvider.hours;
            } else {
              final registeredHour = DateTime.now();
              hours = getJsonFieldHours(
                functions.getHours(registeredHour.hour),
                r'''$.hours[*]''',
              ).toList();
              controlFormProvider.fillHoursData(hours);
              controlFormProvider.changeRegisteredHour(registeredHour);
            }
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(hours.length, (hoursIndex) {
                final hoursItem = hours[hoursIndex];
                List<String> timeParts = getJsonField(
                    hoursItem,
                    r'''$.hour''',
                  ).toString().split(':');
                int hour = int.parse(timeParts[0]);
                int minute = int.parse(timeParts[1]);

                DateTime hourSection = DateTime(
                  DateTime.now().year, 
                  DateTime.now().month, 
                  DateTime.now().day, 
                  hour, 
                  minute);
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
                  typeForm: widget.typeForm,
                  firstHour: hoursIndex == 0 ? true : false,
                  hourSection: hourSection,
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
