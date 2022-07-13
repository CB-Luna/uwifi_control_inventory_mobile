import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkState extends ChangeNotifier {
  final networkStream = Connectivity().onConnectivityChanged;

// converts the network events to the appropriate Color
  Color getConnectionColor(ConnectivityResult connection) {
    var color = Colors.red[900];
    switch (connection) {
      case ConnectivityResult.wifi:
        color = Colors.green[800];
        break;
      case ConnectivityResult.mobile:
        color = Colors.blue[900];
        break;
      case ConnectivityResult.none:
        color = Colors.red[900];
        break;
      default:
        color = Colors.red[900];
        break;
    }
    return color!;
  }

// converts the network events to the appropriate user-readable strings
  String getConnectionMessage(ConnectivityResult connection) {
    var msg = 'Conexión desconocida';
    switch (connection) {
      case ConnectivityResult.wifi:
        msg = 'Conectado a wifi';
        break;
      case ConnectivityResult.mobile:
        msg = 'Conectado a datos móbiles';
        break;
      case ConnectivityResult.none:
        msg = 'Desconectado';
        break;
      default:
        msg = 'Conexión desconocida';
        break;
    }
    return msg;
  }

  @override
  void dispose() {
    // subscription.cancel();
    super.dispose();
  }
}
