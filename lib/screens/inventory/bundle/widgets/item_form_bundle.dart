import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/models/bundle.dart';
import 'package:uwifi_control_inventory_mobile/models/image_evidence.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/bundles_provider.dart';
import 'package:uwifi_control_inventory_mobile/util/animations.dart';
class ItemFormBundle extends StatefulWidget {
  const ItemFormBundle({
    Key? key,
    required this.bundle,
  }) : super(key: key);

  final Bundle bundle;

  @override
  State<ItemFormBundle> createState() => _ItemFormBundleState();
}

class _ItemFormBundleState extends State<ItemFormBundle> {
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
    final provider = Provider.of<BundlesProvider>(context);
    final userProvider = Provider.of<UsuarioController>(context);
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
              backgroundColor: AppTheme.of(context).primaryColor,
              foregroundColor: AppTheme.of(context).white,
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
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              children: [
                                const Text("Created at: "),
                                Text(DateFormat("MMM-dd-yyyy").format(widget.bundle.sim.first!.connectedAt)),
                              ],
                            )
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
                              AppTheme.of(context).secondaryColor,
                              surfaceColor:
                              AppTheme.of(context).secondaryColor,
                              parentColor:
                              AppTheme.of(context).secondaryColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: AppTheme.of(context).white,
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
                                  initialValue: widget.bundle.serieNo,
                                  textCapitalization: TextCapitalization.characters,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    errorMaxLines: 3,
                                    prefixIcon: Icon(
                                      Icons.numbers,
                                      color: AppTheme.of(context).alternate,
                                    ),
                                    labelText: 'Serial Number',
                                    labelStyle: AppTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: AppTheme.of(context).grayDark,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintText: 'Input the serial number...',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            AppTheme.of(context).alternate.withOpacity(0.5),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            AppTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                  ),
                                  style: AppTheme.of(context).bodyText1,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 20),
                                child: TextFormField(
                                  readOnly: true,
                                  enabled: false,
                                  initialValue: "${widget.bundle.sim[0]?.imei}",
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    errorMaxLines: 3,
                                    prefixIcon: Icon(
                                      Icons.sim_card_outlined,
                                      color: AppTheme.of(context).alternate,
                                    ),
                                    labelText: 'IMEI SIM Card 1',
                                    labelStyle: AppTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: AppTheme.of(context).grayDark,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintText: 'Input the IMEI SIM Card 1...',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            AppTheme.of(context).alternate.withOpacity(0.5),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            AppTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                  ),
                                  style: AppTheme.of(context).bodyText1,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 20),
                                child: TextFormField(
                                  readOnly: true,
                                  enabled: false,
                                  initialValue: "${widget.bundle.sim[1]?.imei}",
                                  textCapitalization: TextCapitalization.words,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    errorMaxLines: 3,
                                    prefixIcon: Icon(
                                      Icons.sim_card_outlined,
                                      color: AppTheme.of(context).alternate,
                                    ),
                                    labelText: 'IMEI SIM Card 2',
                                    labelStyle: AppTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: AppTheme.of(context).grayDark,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintText: 'Input the IMEI SIM Card 2...',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            AppTheme.of(context).alternate.withOpacity(0.5),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            AppTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).alternate,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                  ),
                                  style: AppTheme.of(context).bodyText1,
                                  textAlign: TextAlign.start,
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
              backgroundColor: AppTheme.of(context).customColor3,
              foregroundColor: AppTheme.of(context).white,
              borderRadius: BorderRadius.circular(20.0),
              onPressed: (context) async {
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: Text(
                          'Are you sure you want to delete the bundle with serial no. "${widget.bundle.serieNo}"?'),
                      content: const Text(
                          'This action can not be undone.'),
                      actions: [
                        TextButton(
                          onPressed: () async {        
                            if (await provider.deleteBundle(widget.bundle.routerDetailId, userProvider.usuarioCurrent!.sequentialId)) {
                              if(!mounted) return;
                              Navigator.pop(alertDialogContext);
                              snackbarKey.currentState
                                  ?.showSnackBar(const SnackBar(
                                backgroundColor: Color(0xFF00B837),
                                content: Text(
                                    "bundle deleted successfully."),
                              ));
                            } else {
                              if(!mounted) return;
                              Navigator.pop(alertDialogContext);
                              snackbarKey.currentState
                                  ?.showSnackBar(SnackBar(
                                content: Text(
                                    "Falied to deleted with serial no. '${widget.bundle.serieNo}'"),
                              ));
                            }
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
                widget.bundle.serieNo,
                style: AppTheme.of(context)
                .bodyText1.override(
                  fontFamily:
                        AppTheme.of(context).bodyText1Family,
                  color: AppTheme.of(context).tertiaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                DateFormat("MMM-dd-yyyy").format(widget.bundle.createdAt),
                style: AppTheme.of(context)
                .bodyText1.override(
                  fontFamily:
                        AppTheme.of(context).bodyText1Family,
                  color: AppTheme.of(context).secondaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(
                    Icons.double_arrow_rounded,
                    size: 35,
                    color: AppTheme.of(context).alternate,
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
        color: AppTheme.of(context).grayLighter,
      ),
      ],
    );
  }
}
