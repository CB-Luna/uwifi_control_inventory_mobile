import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taller_alex_app_asesor/util/lat_lng.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  int _hourHeight = 150;
  int get hourHeight => _hourHeight;
  set hourHeight(int _value) {
    _hourHeight = _value;
  }

  bool _trueValue = true;
  bool get trueValue => _trueValue;
  set trueValue(bool _value) {
    _trueValue = _value;
  }

  DateTime? _selectedDay = DateTime.fromMillisecondsSinceEpoch(1667573100000);
  DateTime? get selectedDay => _selectedDay;
  set selectedDay(DateTime? _value) {
    _selectedDay = _value;
  }

  DateTime? _selectedDayIndicator =
      DateTime.fromMillisecondsSinceEpoch(1667573100000);
  DateTime? get selectedDayIndicator => _selectedDayIndicator;
  set selectedDayIndicator(DateTime? _value) {
    _selectedDayIndicator = _value;
  }

  List<String> _menuItems = [];
  List<String> get menuItems => _menuItems;
  set menuItems(List<String> _value) {
    _menuItems = _value;
  }

  void addToMenuItems(String _value) {
    _menuItems.add(_value);
  }

  void removeFromMenuItems(String _value) {
    _menuItems.remove(_value);
  }

  void removeAtIndexFromMenuItems(int _index) {
    _menuItems.removeAt(_index);
  }

  String _menuActiveItem = 'Home';
  String get menuActiveItem => _menuActiveItem;
  set menuActiveItem(String _value) {
    _menuActiveItem = _value;
  }

  List<Color> _menuItemColors = [];
  List<Color> get menuItemColors => _menuItemColors;
  set menuItemColors(List<Color> _value) {
    _menuItemColors = _value;
  }

  void addToMenuItemColors(Color _value) {
    _menuItemColors.add(_value);
  }

  void removeFromMenuItemColors(Color _value) {
    _menuItemColors.remove(_value);
  }

  void removeAtIndexFromMenuItemColors(int _index) {
    _menuItemColors.removeAt(_index);
  }

  bool _drawer = false;
  bool get drawer => _drawer;
  set drawer(bool _value) {
    _drawer = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}
