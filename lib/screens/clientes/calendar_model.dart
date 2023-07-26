import 'package:fleet_management_tool_rta/screens/clientes/background_widget.dart';
import 'package:fleet_management_tool_rta/screens/clientes/events_widget.dart';
import 'package:fleet_management_tool_rta/screens/clientes/flutter_flow_model.dart';
import 'package:fleet_management_tool_rta/screens/clientes/now_line_widget.dart';
import 'package:fleet_management_tool_rta/screens/clientes/week_days_widget.dart';
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
