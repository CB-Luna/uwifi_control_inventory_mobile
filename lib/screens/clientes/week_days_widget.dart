import 'package:taller_alex_app_asesor/screens/clientes/day_picker_widget.dart';
import 'custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flutter_flow_util_local.dart';
import 'week_days_model.dart';
export 'week_days_model.dart';

class WeekDaysWidget extends StatefulWidget {
  const WeekDaysWidget({
    Key? key,
    this.callback,
  }) : super(key: key);

  final Future<dynamic> Function()? callback;

  @override
  _WeekDaysWidgetState createState() => _WeekDaysWidgetState();
}

class _WeekDaysWidgetState extends State<WeekDaysWidget>
    with TickerProviderStateMixin {
  late WeekDaysModel _model;

  // final animationsMap = {
  //   'rowOnActionTriggerAnimation': AnimationInfo(
  //     trigger: AnimationTrigger.onActionTrigger,
  //     applyInitialState: true,
  //     effects: [
  //       FadeEffect(
  //         curve: Curves.easeInOut,
  //         delay: 0.ms,
  //         duration: 300.ms,
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
    _model = createModel(context, () => WeekDaysModel());

    // setupAnimations(
    //   animationsMap.values.where((anim) =>
    //       anim.trigger == AnimationTrigger.onActionTrigger ||
    //       !anim.applyInitialState),
    //   this,
    // );
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) {
        final day = functions
            .generateSurroundingDays(FFAppState().selectedDay)
            .toList();
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(day.length, (dayIndex) {
            final dayItem = day[dayIndex];
            return InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                if (dayItem != FFAppState().selectedDay) {
                  FFAppState().update(() {
                    FFAppState().selectedDayIndicator = dayItem;
                  });
                  await Future.delayed(const Duration(milliseconds: 200));
                  FFAppState().update(() {
                    FFAppState().selectedDay = dayItem;
                  });
                  await widget.callback?.call();
                }
              },
              child: DayPickerWidget(
                key: Key('Key7qb_${dayIndex}_of_${day.length}'),
                day: getJsonField(
                  functions.dateInfo(dayItem),
                  r'''$.day''',
                ),
                weekday: getJsonField(
                  functions.dateInfo(dayItem),
                  r'''$.weekday''',
                ).toString(),
                selected: dayItem == FFAppState().selectedDay,
                tapped: dayItem == FFAppState().selectedDayIndicator,
              ),
            );
          }),
        );
      },
    );
  }
}
