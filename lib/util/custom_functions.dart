import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/util/util.dart';
import 'package:flutter/material.dart';

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final hour = timeOfDay.hour.toString().padLeft(2, '0');
  final min = timeOfDay.minute.toString().padLeft(2, '0');
  const sec = '00';
  return '$hour:$min:$sec';
}

InputDecoration getInputDecoration({
  required BuildContext context,
  required String labelText,
  String requiredCharacter = '*',
  String? hintText,
  InkWell? inkWell,
}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: AppTheme.of(context).bodyText1.override(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
    hintText: hintText,
    hintStyle: AppTheme.of(context).bodyText1.override(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
    enabledBorder: UnderlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0x00000000),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(30),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0x00000000),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(30),
    ),
    filled: true,
    fillColor: const Color(0x52FFFFFF),
    suffixIcon: inkWell,
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
