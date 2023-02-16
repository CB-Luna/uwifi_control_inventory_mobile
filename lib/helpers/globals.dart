import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

const storage = FlutterSecureStorage();

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

late final SharedPreferences prefs;

Future<void> initGlobals() async {
  prefs = await SharedPreferences.getInstance();
}



