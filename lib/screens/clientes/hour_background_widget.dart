import 'package:taller_alex_app_asesor/modelsFormularios/data_draggable.dart';
import 'package:taller_alex_app_asesor/providers/control_form_provider.dart';
import 'package:taller_alex_app_asesor/screens/observaciones/observacion_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'flutter_flow_util_local.dart';
import 'hour_background_model.dart';
export 'hour_background_model.dart';

class HourBackgroundWidget extends StatefulWidget {
  const HourBackgroundWidget({
    Key? key,
    this.time,
    this.period,
  }) : super(key: key);

  final String? time;
  final String? period;

  @override
  _HourBackgroundWidgetState createState() => _HourBackgroundWidgetState();
}

class _HourBackgroundWidgetState extends State<HourBackgroundWidget> {
  late HourBackgroundModel _model;
  Color caughtColor = Colors.white;
  String vin = "";
  String image = "";

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HourBackgroundModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controlFormProvider = Provider.of<ControlFormProvider>(context);
    return DragTarget(
      onAccept: (DraggableData data) async{
        if (controlFormProvider.accept) {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('Invalid action'),
                content: const Text(
                    "You can't putting more than one vehicle into the schedule."),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(alertDialogContext),
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        } 
        else{
          setState(() {
            caughtColor = data.color;
            vin = data.vin;
            image = data.image;
          });
          controlFormProvider.updateDataSelected(data.accept);
        }
      },
      builder: (context, acceptedData, rejectedData) {
        return ClipRRect(
          child: Container(
            width: MediaQuery.of(context).size.width * 1.0,
            height: 200,
            decoration: BoxDecoration(
              color: caughtColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1.0,
                          height: 2.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).lineColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 80.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Stack(
                                  children: [
                                    SelectionArea(
                                        child: Text(
                                      widget.time!,
                                      style: FlutterFlowTheme.of(context)
                                          .title1
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 18.0,
                                          ),
                                    )),
                                    Align(
                                      alignment: AlignmentDirectional(-1.0, 0.45),
                                      child: SelectionArea(
                                          child: Text(
                                        valueOrDefault<String>(
                                          widget.period,
                                          'am',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Inter',
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1.0,
                            height: 2.0,
                            decoration: BoxDecoration(
                              color: Color(0x80E0E3E7),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Visibility(
                          visible: vin != "",
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: getAssetImageContainer(
                                  image,
                                  height: 120,
                                  width: 200,
                                  ),
                              ),
                              Text(
                                vin,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.0, 0.9),
                        child: 
                        vin != "" ? 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryColor,
                                borderRadius:
                                    BorderRadius.circular(30
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 1),
                                  )
                                ],
                              ),
                              child: InkWell(
                                onTap: () async {
                                 await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Are you sure you want to delete the schedule selected?'),
                                        content: const Text(
                                            'The chosen schedule will be removed.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              controlFormProvider.cleanData();
                                              setState(() {
                                                caughtColor = Colors.white;
                                                vin = "";
                                                image = "";
                                              });
                                              Navigator.pop(context);
                                            },
                                            child:
                                                const Text('Continue'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child:
                                                const Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return;
                                },
                                child: Icon(
                                Icons.delete_forever_outlined,
                                color: FlutterFlowTheme.of(context).white,
                                size: 30,
                              ),
                              ),
                            ),
                            const SizedBox(
                              width: 15.0, //Esto es solo para dar cierto margen entre los FAB
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryColor,
                                borderRadius:
                                    BorderRadius.circular(30
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 1),
                                  )
                                ],
                              ),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                       ObservacionScreen(hour: widget.time!, period: widget.period!,),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.add,
                                  color: FlutterFlowTheme.of(context).white,
                                  size: 30,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15.0, //Esto es solo para dar cierto margen entre los FAB
                            ),
                          ],
                        )
                        :
                        null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
