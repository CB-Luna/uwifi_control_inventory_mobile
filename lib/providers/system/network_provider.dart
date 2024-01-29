import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkState extends ChangeNotifier {
  final networkStream = Connectivity().onConnectivityChanged;
  final connection = Connectivity().checkConnectivity();

// converts the network events to the appropriate Color
  Future<Color> getConnectionColor() async {
    var color = Colors.red[900];
    switch (await connection) {
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
  Future<String> getConnectionMessage() async {
    var msg = 'Unknown connection';
    switch (await connection) {
      case ConnectivityResult.wifi:
        msg = 'Wifi connection';
        break;
      case ConnectivityResult.mobile:
        msg = 'Mobile data connection';
        break;
      case ConnectivityResult.none:
        msg = 'Not connection';
        break;
      default:
        msg = 'Unknown connection';
        break;
    }
    return msg;
  }

// converts the network events to the appropriate user-readable widgets status
  Future<bool> getConnectionStatus() async {
    var msg = false;
    switch (await connection) {
      case ConnectivityResult.wifi:
        msg = true;
        break;
      case ConnectivityResult.mobile:
        msg = true;
        break;
      case ConnectivityResult.none:
        msg = false;
        break;
      default:
        msg = false;
        break;
    }
    return msg;
  }
}
