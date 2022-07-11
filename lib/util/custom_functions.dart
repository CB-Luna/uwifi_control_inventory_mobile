import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/util/util.dart';
import 'package:flutter/material.dart';

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final hour = timeOfDay.hour.toString().padLeft(2, '0');
  final min = timeOfDay.minute.toString().padLeft(2, '0');
  const sec = '00';
  return '$hour:$min:$sec';
}

InputDecoration getInputDecoration(
  BuildContext context,
  String labelText,
  String hintText,
) {
  return InputDecoration(
    labelText: AppLocalizations.of(context).getText(
      labelText /* Nombre de Evento */,
    ),
    labelStyle: AppTheme.of(context).title3.override(
          fontFamily: 'Montserrat',
          color: AppTheme.of(context).secondaryText,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
    hintText: AppLocalizations.of(context).getText(
      hintText /* Nombre del Evento... */,
    ),
    // enabledBorder: OutlineInputBorder(
    //   borderSide: BorderSide(
    //     color: AppTheme.of(context).contornos,
    //     width: 1,
    //   ),
    //   borderRadius: BorderRadius.circular(8),
    // ),
    // focusedBorder: OutlineInputBorder(
    //   borderSide: BorderSide(
    //     color: AppTheme.of(context).contornos,
    //     width: 1,
    //   ),
    //   borderRadius: BorderRadius.circular(8),
    // ),
    filled: true,
    // fillColor: AppTheme.of(context).campos,
  );
}

Future<void> showAlertDialog({
  required BuildContext context,
  required void Function() onPressedContinue,
  String? alertMessage,
}) async {
  //Buttons
  Widget cancelButton = TextButton(
    child: Text(AppLocalizations.of(context).getText(
      'j5lv9tmd' /* Cancelar */,
    )),
    onPressed: () => Navigator.pop(context),
  );
  Widget continueButton = TextButton(
    child: Text(AppLocalizations.of(context).getText(
      'fdk49smv' /* Continuar */,
    )),
    onPressed: () async {
      onPressedContinue();
      // Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(AppLocalizations.of(context).getText(
      'g96mufnr' /* Alerta */,
    )),
    content: Text(AppLocalizations.of(context).getText(
      'mfl04k3k' /* Seguro que desea continuar? */,
    )),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
