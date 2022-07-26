import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const String baseUrl = 'https://pocketbase.cbluna-dev.com';

final nombreCharacters = RegExp(r'^[A-zÀ-ÿ\- ]+$');
final curpCharacters = RegExp(r'^([A-Z]{4}[0-9]{6}[HM]{1}[A-Z]{2}[BCDFGHJKLMNPQRSTVWXYZ]{3}([A-Z]{2})?([0-9]{2})?)$');
// final curpCharacters = RegExp(r'^([A-Z]{4}[0-9]{6}[HM]{1}[A-Z]{2}[BCDFGHJKLMNPQRSTVWXYZ]{3}[A-Z]{2}[0-9]{2})$');
final telefonoCharacters = RegExp(r'^[0-9\-() ]+$');
final cualquierCharacters = RegExp(r'^.+');

var telefonoFormat = MaskTextInputFormatter(
      mask: '(##) ####-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );