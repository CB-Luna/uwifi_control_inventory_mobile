import 'package:fleet_management_tool_rta/screens/employees/widget/background_model.dart';
import 'package:fleet_management_tool_rta/screens/employees/widget/events_model.dart';
import 'package:fleet_management_tool_rta/screens/employees/widget/flutter_flow_model.dart';
import 'package:fleet_management_tool_rta/screens/employees/widget/now_line_model.dart';
import 'package:fleet_management_tool_rta/screens/employees/widget/week_days_model.dart';
import 'package:flutter/material.dart';

class CalendarModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for ScrollableColumn widget.
  ScrollController? scrollableColumn;
  // Model for Background component.
  late BackgroundModel backgroundModel;
  // Model for NowLine component.
  late NowLineModel nowLineModel;
  // Model for Events component.
  late EventsModel eventsModel;
  // Model for WeekDays component.
  late WeekDaysModel weekDaysModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    scrollableColumn = ScrollController();
    backgroundModel = createModel(context, () => BackgroundModel());
    nowLineModel = createModel(context, () => NowLineModel());
    eventsModel = createModel(context, () => EventsModel());
    weekDaysModel = createModel(context, () => WeekDaysModel());
  }

  @override
  void dispose() {
    scrollableColumn?.dispose();
    backgroundModel.dispose();
    nowLineModel.dispose();
    eventsModel.dispose();
    weekDaysModel.dispose();
  }

  /// Additional helper methods are added here.

}
