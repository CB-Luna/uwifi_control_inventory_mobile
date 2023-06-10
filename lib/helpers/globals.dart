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
late SupabaseClient supabaseCRM;
late SupabaseClient supabaseCtrlV;
late SupabaseClient supabasePublic;

String key =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICAgInJvbGUiOiAic2VydmljZV9yb2xlIiwKICAgICJpc3MiOiAic3VwYWJhc2UiLAogICAgImlhdCI6IDE2ODQ4MjUyMDAsCiAgICAiZXhwIjogMTg0MjY3ODAwMAp9.gAA9u40KP0uFMjACjoUF1zMPpnxbrkUYCGP_ovgl9Io';

final supabase = Supabase.instance.client;
late SupabaseClient supabaseCRMJuan;

Future<void> initGlobals() async {
  prefs = await SharedPreferences.getInstance();
}



