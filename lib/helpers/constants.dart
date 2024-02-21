import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';

import '../screens/widgets/flutter_flow_animations.dart';

//***********< U-wifi BD >**************/

//>>>>>>TEST
const anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5zcnBybHlncWFxZ2xqcGZnZ2poIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAxNzU2MjUsImV4cCI6MjAxNTc1MTYyNX0.JQUJ2i2mZlygBys5Gd5elAL_00TM_U2vJrXlIVuOtbk";
const supabaseUrl = "https://nsrprlygqaqgljpfggjh.supabase.co"; 
const supabaseGraphqlUrl = "https://nsrprlygqaqgljpfggjh.supabase.co/graphql/v1";
const urlNotificationsAPI = "https://nsrprlygqaqgljpfggjh.supabase.co/notifications/api";
const domain = "supabase";
const urlAirflow = "https://u-airflow.cbluna-dev.com";
const bearerAirflow = "Basic YWlyZmxvdzpjYiF1bmEyMDIz";

//>>>>>>>PRODUCTION
// const anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICAgInJvbGUiOiAiYW5vbiIsCiAgICAiaXNzIjogInN1cGFiYXNlIiwKICAgICJpYXQiOiAxNjg0ODI1MjAwLAogICAgImV4cCI6IDE4NDI2NzgwMDAKfQ.Atj9wTNbdEEVPOjstsO14DtxbY2SEpnr50elVXBgAmM";
// const supabaseUrl = "https://supa41.rtatel.com"; 
// const supabaseGraphqlUrl = "https://supa41.rtatel.com/graphql/v1";
// const urlNotificationsAPI = "https://supa41.rtatel.com/notifications/api";
// const domain = "supa41";
// const urlAirflow = "https://u-airflow.cbluna-dev.com";
// const bearerAirflow = "Basic YWlyZmxvdzpjYiF1bmEyMDIz";

//***********< REGEX >**************/

//Sims Card
final sapIdRegExp = RegExp(r'SAP ID: [0-9]{6}');
const nameFieldSapId = "SAP ID: ";
final imeiSCRegExp = RegExp(r' [0-9]{20}');
const nameFieldImeiSC = " ";

//Gateways
final serialNumberRegExp = RegExp(r'N:[0-9A-Z]{21}');
const nameFieldSerialNumber = "N:";
final wifiKeyRegExp = RegExp(r'Wi-Fi KEY: [0-9A-Z]{8}');
const nameFieldWifiKey = "Wi-Fi KEY: ";
final imeiGRegExp = RegExp(r'IMEI:[0-9]{15}');
const nameFieldImeiG = "IMEI:";
final macRegExp = RegExp(r'MAC:[0-9A-Z]{12}');
const nameFieldMac = "MAC:";

//Tracking
final trackingNumberRegExp = RegExp(r'TRACKING #: [0-9A-Z]{2} [0-9A-Z]{3} [0-9A-Z]{3} [0-9A-Z]{2} [0-9A-Z]{4} [0-9A-Z]{4}');
const nameFieldTrackingNumber = "TRACKING #: ";

final nombreCharacters = RegExp(r'^(([A-Z]{1}|[ÁÉÍÓÚÑ]{1})[a-zá-ÿ]+[ ]?)+$');
final curpCharacters = RegExp(
    r'^([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)$');

final palabras = RegExp(r'^([a-zA-Z\sñÑà-úÀ-Ú])+$');
final contrasena = RegExp(
    r"^(?=.*[A-Z])(?=.*\d)(?=.*\d)[A-Za-z\d!#\$%&/\(\)=?¡¿+\*\.\-_:,;]{6,50}$");
final rfcCharacters = RegExp(r'^([A-Z&Ñ]{3,4})\d{6}([A-Z0-9]{3})$');
final telefonoCharacters = RegExp(r'^[0-9\-() ]+$');
final cualquierCharacters = RegExp(r'^.+');
final capitalizadoCharacters = RegExp(r'^([A-Z]{1}|[ÁÉÍÓÚÑ]{1}).+$');
final fechaCharacters = RegExp(
    r'^(((0[1-9]|[12][0-9]|30)[-/]?(0[13-9]|1[012])|31[-/]?(0[13578]|1[02])|(0[1-9]|1[0-9]|2[0-8])[-/]?02)[-/]?[0-9]{4}|29[-/]?02[-/]?([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00))$');
final familiaCharacters = RegExp(r'^(([1-9][0-9]{1})|([1-9]))$');
final jornadaCharacters = RegExp(r'^[1-9]+$');
var telefonoFormat = MaskTextInputFormatter(
  mask: '###-###-####',
  filter: {'#': RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);
var numbersFormat = CurrencyTextInputFormatter(symbol: '', name: '', decimalDigits: 0, enableNegative: false, turnOffGrouping: true);
RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

//Animations

Row getProgressIndicatorOCR(BuildContext context, String message) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        child: DefaultTextStyle(
          style: AppTheme.of(context).bodyText2,
          child: Text(message),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      SpinKitCircle(
        size: 30,
        itemBuilder: (context, index) {
          final colors = [AppTheme.of(context).primaryColor, AppTheme.of(context).secondaryColor];
          final color = colors[index % colors.length];
          return DecoratedBox(
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          );
        },
      ),
      
    ],
  );
}

Column getProgressIndicatorAnimated(String message) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      SpinKitCircle(
        size: 200,
        itemBuilder: (context, index) {
          final colors = [const Color(0xFFD20030), const Color(0xFF2E5899)];
          final color = colors[index % colors.length];
          return DecoratedBox(
            decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
          );
        },
      ),
      const SizedBox(
        height: 25,
      ),
      SizedBox(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'Work Sans',
            color: Color(0xFF040404),
            fontSize: 20,
          ),
          child: AnimatedTextKit(repeatForever: true, animatedTexts: [
            FadeAnimatedText(message),
          ]),
        ),
      ),
    ],
  );
}

Column getDownloadIndicatorAnimated(String message) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      SpinKitThreeInOut(
        size: 120,
        itemBuilder: (context, index) {
          final colors = [const Color(0xFFD20030), const Color(0xFF2E5899)];
          final color = colors[index % colors.length];
          return DecoratedBox(
            decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
          );
        },
      ),
      const SizedBox(
        height: 25,
      ),
      SizedBox(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'Work Sans',
            color: Color(0xFF040404),
            fontSize: 20,
          ),
          child: AnimatedTextKit(repeatForever: true, animatedTexts: [
            FadeAnimatedText(message),
          ]),
        ),
      ),
    ],
  );
}

Column getSyncIndicatorAnimated(String message) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      SpinKitWave(
        size: 100,
        itemBuilder: (context, index) {
          final colors = [const Color(0xFFD20030), const Color(0xFF2E5899)];
          final color = colors[index % colors.length];
          return DecoratedBox(
            decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
          );
        },
      ),
      const SizedBox(
        height: 25,
      ),
      SizedBox(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'Work Sans',
            color: Color(0xFF040404),
            fontSize: 20,
          ),
          child: AnimatedTextKit(repeatForever: true, animatedTexts: [
            FadeAnimatedText(message),
          ]),
        ),
      ),
    ],
  );
}

final animationsMap = {
  'containerOnPageLoadAnimation1': AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    duration: 600,
    delay: 80,
    hideBeforeAnimating: false,
    fadeIn: true,
    initialState: AnimationState(
      offset: const Offset(0, 69),
      opacity: 0,
    ),
    finalState: AnimationState(
      offset: const Offset(0, 0),
      opacity: 1,
    ),
  ),
  'rowOnPageLoadAnimation1': AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    duration: 600,
    hideBeforeAnimating: false,
    fadeIn: true,
    initialState: AnimationState(
      offset: const Offset(0, 30),
      scale: 0.4,
      opacity: 0,
    ),
    finalState: AnimationState(
      offset: const Offset(0, 0),
      scale: 1,
      opacity: 1,
    ),
  ),
  'containerOnPageLoadAnimation2': AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    duration: 600,
    delay: 80,
    hideBeforeAnimating: false,
    fadeIn: true,
    initialState: AnimationState(
      offset: const Offset(0, 69),
      opacity: 0,
    ),
    finalState: AnimationState(
      offset: const Offset(0, 0),
      opacity: 1,
    ),
  ),
  'rowOnPageLoadAnimation2': AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    duration: 600,
    hideBeforeAnimating: false,
    fadeIn: true,
    initialState: AnimationState(
      offset: const Offset(0, 30),
      scale: 0.4,
      opacity: 0,
    ),
    finalState: AnimationState(
      offset: const Offset(0, 0),
      scale: 1,
      opacity: 1,
    ),
  ),
  'containerOnPageLoadAnimation3': AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    duration: 600,
    delay: 80,
    hideBeforeAnimating: false,
    fadeIn: true,
    initialState: AnimationState(
      offset: const Offset(0, 69),
      opacity: 0,
    ),
    finalState: AnimationState(
      offset: const Offset(0, 0),
      opacity: 1,
    ),
  ),
};
