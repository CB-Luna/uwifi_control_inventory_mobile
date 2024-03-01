import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/models/sims_card_batch_temp.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

class ItemSimCardBatchTemp extends StatefulWidget {
  const ItemSimCardBatchTemp({
    Key? key,
    required this.simCardBatchTemp,
    required this.index,
  }) : super(key: key);

  final SimCardBatchTemp simCardBatchTemp;
  final int index;

  @override
  State<ItemSimCardBatchTemp> createState() => _ItemSimCardBatchTempState();
}

class _ItemSimCardBatchTempState extends State<ItemSimCardBatchTemp> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                widget.simCardBatchTemp.imei,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.of(context)
                .bodyText1.override(
                  fontFamily:
                        AppTheme.of(context).bodyText1Family,
                  color: AppTheme.of(context).tertiaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: [
                    Icon(
                        widget.simCardBatchTemp.batchStatusFk == 1 ?
                        Icons.error
                        :
                        widget.simCardBatchTemp.batchStatusFk == 2 ?
                        Icons.cancel
                        :
                        Icons.check_circle,
                        size: 20,
                        color: 
                        widget.simCardBatchTemp.batchStatusFk == 1 ?
                        AppTheme.of(context).customColor4
                        :
                        widget.simCardBatchTemp.batchStatusFk == 2 ?
                        AppTheme.of(context).customColor3
                        :
                        AppTheme.of(context).primaryColor,
                    ),
                    Text(
                      widget.simCardBatchTemp.batchStatusFk == 1 ?
                        "Duplicate"
                        :
                        widget.simCardBatchTemp.batchStatusFk == 2 ?
                        "Fail"
                        :
                        "Success",
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.of(context)
                      .bodyText1.override(
                        fontFamily:
                              AppTheme.of(context).bodyText1Family,
                        color: widget.simCardBatchTemp.batchStatusFk == 1 ?
                        AppTheme.of(context).customColor4
                        :
                        widget.simCardBatchTemp.batchStatusFk == 2 ?
                        AppTheme.of(context).customColor3
                        :
                        AppTheme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Divider(
        height: 2,
        thickness: 2,
        indent: 20,
        endIndent: 20,
        color: AppTheme.of(context).grayLighter,
      ),
      ],
    );
  }
}
