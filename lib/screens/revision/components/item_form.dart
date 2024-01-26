import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/database/image_evidence.dart';
import 'package:uwifi_control_inventory_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uwifi_control_inventory_mobile/models/gateway.dart';
import 'package:uwifi_control_inventory_mobile/providers/gateways_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/control_form/flutter_flow_animaciones.dart';
class ItemForm extends StatefulWidget {
  const ItemForm({
    Key? key,
    required this.gateway,
  }) : super(key: key);

  final Gateway gateway;

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  List<ImageEvidence> imagesTemp = [];
  final animationsMap = {
    'moveLoadAnimationLR': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(-79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
        ),
      ],
    ),
    'moveLoadAnimationRL': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
        ),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GatewaysProvider>(context);
    return Column(
      children: [
        Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
        child: Slidable(
          endActionPane: ActionPane(
          motion: const DrawerMotion(), 
          children: [
            SlidableAction(
              icon: Icons.visibility_outlined,
              backgroundColor: FlutterFlowTheme.of(context).primaryColor,
              foregroundColor: FlutterFlowTheme.of(context).white,
              borderRadius: BorderRadius.circular(20.0),
              onPressed: (context) async {
                if (!mounted) return;
                await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: const Text("Gateway")
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ClayContainer(
                              height: 30,
                              width: 30,
                              depth: 15,
                              spread: 1,
                              borderRadius: 15,
                              curveType: CurveType.concave,
                              color:
                              FlutterFlowTheme.of(context).secondaryColor,
                              surfaceColor:
                              FlutterFlowTheme.of(context).secondaryColor,
                              parentColor:
                              FlutterFlowTheme.of(context).secondaryColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: FlutterFlowTheme.of(context).white,
                                  size: 30,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      content: SizedBox( // Need to use container to add size constraint.
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 20),
                                child: TextFormField(
                                  readOnly: true,
                                  enabled: false,
                                  initialValue: widget.gateway.serialNo,
                                  textCapitalization: TextCapitalization.characters,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    errorMaxLines: 3,
                                    prefixIcon: Icon(
                                      Icons.numbers,
                                      color: FlutterFlowTheme.of(context).alternate,
                                    ),
                                    labelText: 'Serial Number*',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).grayDark,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintText: 'Input the serial number...',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 20),
                                child: TextFormField(
                                  readOnly: true,
                                  enabled: false,
                                  initialValue: widget.gateway.productId.toString(),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    errorMaxLines: 3,
                                    prefixIcon: Icon(
                                      Icons.pin_outlined,
                                      color: FlutterFlowTheme.of(context).alternate,
                                    ),
                                    labelText: 'Product ID*',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).grayDark,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintText: 'Input the product ID...',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 20),
                                child: TextFormField(
                                  readOnly: true,
                                  enabled: false,
                                  initialValue: widget.gateway.brand,
                                  textCapitalization: TextCapitalization.words,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    errorMaxLines: 3,
                                    prefixIcon: Icon(
                                      Icons.label_outline,
                                      color: FlutterFlowTheme.of(context).alternate,
                                    ),
                                    labelText: 'Brand*',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).grayDark,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintText: 'Input the brand...',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.start,
                                  validator: (value) {
                                    if (value == "" || value == null || value.isEmpty) {
                                      return 'Please input a valid brand.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 20),
                                child: TextFormField(
                                  readOnly: true,
                                  enabled: false,
                                  initialValue: widget.gateway.model,
                                  textCapitalization: TextCapitalization.words,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    errorMaxLines: 3,
                                    prefixIcon: Icon(
                                      Icons.router,
                                      color: FlutterFlowTheme.of(context).alternate,
                                    ),
                                    labelText: 'Model*',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).grayDark,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintText: 'Input the model...',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  textAlign: TextAlign.start,
                                  validator: (value) {
                                    if (value == "" || value == null || value.isEmpty) {
                                      return 'Please input a valid model.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            ),
            SlidableAction(
              icon: Icons.delete_outline,
              backgroundColor: FlutterFlowTheme.of(context).customColor3,
              foregroundColor: FlutterFlowTheme.of(context).white,
              borderRadius: BorderRadius.circular(20.0),
              onPressed: (context) async {
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: Text(
                          'Are you sure you want to delete the gateway with serial no. "${widget.gateway.serialNo}"?'),
                      content: const Text(
                          'This action can not be undone.'),
                      actions: [
                        TextButton(
                          onPressed: () async {        
                            await provider.deleteGateway(widget.gateway.serialNo);
                            if(!mounted) return;
                            Navigator.pop(alertDialogContext);
                          },
                          child:
                              const Text('Continue'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(alertDialogContext); 
                          },
                          child:
                              const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              }
            ),
          ]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.gateway.serialNo,
                style: FlutterFlowTheme.of(context)
                .bodyText1.override(
                  fontFamily:
                        FlutterFlowTheme.of(context).bodyText1Family,
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                DateFormat("MMM-dd-yyyy").format(widget.gateway.createdAt),
                style: FlutterFlowTheme.of(context)
                .bodyText1.override(
                  fontFamily:
                        FlutterFlowTheme.of(context).bodyText1Family,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(
                    Icons.double_arrow_rounded,
                    size: 35,
                    color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
            ],
          ),
        ),
      ),
      Divider(
        height: 4,
        thickness: 4,
        indent: 20,
        endIndent: 20,
        color: FlutterFlowTheme.of(context).grayLighter,
      ),
      ],
    );
  }
}
