import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/theme/theme.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DeviceInformationWidget extends StatefulWidget {
  const DeviceInformationWidget({Key? key}) : super(key: key);

  @override
  State<DeviceInformationWidget> createState() =>
      _DeviceInformationWidgetState();
}

class _DeviceInformationWidgetState extends State<DeviceInformationWidget> {
  late Future<AndroidDeviceInfo> androidInfo;

  @override
  void initState() {
    androidInfo = deviceInfo.androidInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionTile(
            title: Text(
              'Información del dispositivo',
              style: AppTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            children: [
              FutureBuilder<AndroidDeviceInfo>(
                future: androidInfo,
                builder: (_, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Modelo: ${snapshot.data!.model ?? ''}",
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: const Color(0xFF221573),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Text(
                          "Fabricante: ${snapshot.data!.manufacturer ?? ''}",
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: const Color(0xFF221573),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Text(
                          "Marca: ${snapshot.data!.brand ?? ''}",
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: const Color(0xFF221573),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Text(
                          "Dispositivo: ${snapshot.data!.device ?? ''}",
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: const Color(0xFF221573),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Text(
                          "Version: ${snapshot.data!.version.release}",
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: const Color(0xFF221573),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: SpinKitRipple(
                          color: AppTheme.of(context).primaryColor,
                          size: 50,
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
