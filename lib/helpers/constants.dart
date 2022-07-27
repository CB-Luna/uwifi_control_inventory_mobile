import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const String baseUrl = 'https://pocketbase.cbluna-dev.com';

final nombreCharacters = RegExp(r'^[A-zÀ-ÿ\- ]+$');
final curpCharacters = RegExp(r'^([A-Z]{4}[0-9]{6}[HM]{1}[A-Z]{2}[BCDFGHJKLMNPQRSTVWXYZ]{3}([A-Z]{2})?([0-9]{2})?)$');
// final curpCharacters = RegExp(r'^([A-Z]{4}[0-9]{6}[HM]{1}[A-Z]{2}[BCDFGHJKLMNPQRSTVWXYZ]{3}[A-Z]{2}[0-9]{2})$');
final telefonoCharacters = RegExp(r'^[0-9\-() ]+$');
final cualquierCharacters = RegExp(r'^.+');
final fechaCharacters = RegExp(r'^(((0[1-9]|[12][0-9]|30)[-/]?(0[13-9]|1[012])|31[-/]?(0[13578]|1[02])|(0[1-9]|1[0-9]|2[0-8])[-/]?02)[-/]?[0-9]{4}|29[-/]?02[-/]?([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00))$');

var telefonoFormat = MaskTextInputFormatter(
      mask: '(##) ####-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );