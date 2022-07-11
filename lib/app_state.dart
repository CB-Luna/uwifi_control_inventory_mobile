import 'package:shared_preferences/shared_preferences.dart';

//TODO: convertir en provider?
class AppState {
  static final AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _correoElectronico =
        prefs.getString('ff_correoElectronico') ?? _correoElectronico;
  }

  late SharedPreferences prefs;

  bool recuerdameOn = true;

  String _correoElectronico = '';
  String get correoElectronico => _correoElectronico;
  set correoElectronico(String value) {
    _correoElectronico = value;
    prefs.setString('ff_correoElectronico', value);
  }
}
