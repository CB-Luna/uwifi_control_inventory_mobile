import 'package:bizpro_app/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

export 'lat_lng.dart';
export 'place.dart';
export 'dart:math' show min, max;
export 'package:intl/intl.dart';
export 'package:page_transition/page_transition.dart';
export 'package:bizpro_app/internationalization/internationalization.dart'
    show AppLocalizations;

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

String dateTimeFormat(String format, DateTime dateTime) {
  if (format == 'relative') {
    return timeago.format(dateTime);
  }
  return DateFormat(format).format(dateTime);
}

DateTime get getCurrentTimestamp => DateTime.now();

extension DateTimeComparisonOperators on DateTime {
  bool operator <(DateTime other) => isBefore(other);
  bool operator >(DateTime other) => isAfter(other);
  bool operator <=(DateTime other) => this < other || isAtSameMomentAs(other);
  bool operator >=(DateTime other) => this > other || isAtSameMomentAs(other);
}

void setAppLanguage(BuildContext context, String language) =>
    MyApp.of(context).setLocale(Locale(language, ''));

extension FFStringExt on String {
  String maybeHandleOverflow({
    required int maxChars,
    String replacement = '',
  }) =>
      length > maxChars ? replaceRange(maxChars, null, replacement) : this;
}
