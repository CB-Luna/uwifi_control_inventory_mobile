import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../screens/widgets/flutter_flow_animations.dart';

//***********< RTA VEHICLE CONTROL BD >**************/


//***********< RTA VEHICLE CONTROL BD >**************/

const anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFhZG9obnhqYWdvb3F2cWF1ZnFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODM2NDg2MDIsImV4cCI6MTk5OTIyNDYwMn0.YYFVT0MzXW5J35XwhwqnZ0vqgmuZRfswODbfCHH0bfE";
const supabaseURL = "https://aadohnxjagooqvqaufqb.supabase.co"; 
const supabaseGraphqlURL = "https://aadohnxjagooqvqaufqb.supabase.co/graphql/v1";

//***********< REGEX >**************/

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
var currencyFormat = CurrencyTextInputFormatter(symbol: '\$', name: 'MXN"');
RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

//Animations

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

// final animationsMap2 = {
//     'containerOnActionTriggerAnimation1': AnimationInfo(
//       trigger: AnimationTrigger.onActionTrigger,
//       applyInitialState: true,
//       effects: [
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 500.ms,
//           begin: 0.0,
//           end: 1.0,
//         ),
//         MoveEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 500.ms,
//           begin: const Offset(-100.0, 0.0),
//           end: const Offset(0.0, 0.0),
//         ),
//       ],
//     ),
//     'containerOnActionTriggerAnimation2': AnimationInfo(
//       trigger: AnimationTrigger.onActionTrigger,
//       applyInitialState: true,
//       effects: [
//         MoveEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 500.ms,
//           begin: const Offset(0.0, 0.0),
//           end: const Offset(335.0, 0.0),
//         ),
//         TiltEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 500.ms,
//           begin: const Offset(0, 0),
//           end: const Offset(0, 0.524),
//         ),
//         ScaleEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 500.ms,
//           begin: 1.0,
//           end: 0.8,
//         ),
//       ],
//     ),
//     'rowOnPageLoadAnimation': AnimationInfo(
//       trigger: AnimationTrigger.onPageLoad,
//       effects: [
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 800.ms,
//           begin: 0.0,
//           end: 1.0,
//         ),
//       ],
//     ),
//     'containerOnPageLoadAnimation1': AnimationInfo(
//       trigger: AnimationTrigger.onPageLoad,
//       effects: [
//         MoveEffect(
//           curve: Curves.easeIn,
//           delay: 0.ms,
//           duration: 600.ms,
//           begin: const Offset(-400.0, 0.0),
//           end: const Offset(0.0, 0.0),
//         ),
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 1000.ms,
//           begin: 0.0,
//           end: 1.0,
//         ),
//       ],
//     ),
//     'containerOnPageLoadAnimation2': AnimationInfo(
//       trigger: AnimationTrigger.onPageLoad,
//       effects: [
//         MoveEffect(
//           curve: Curves.easeIn,
//           delay: 0.ms,
//           duration: 800.ms,
//           begin: const Offset(-400.0, 0.0),
//           end: const Offset(0.0, 0.0),
//         ),
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 1000.ms,
//           begin: 0.0,
//           end: 1.0,
//         ),
//       ],
//     ),
//     'containerOnPageLoadAnimation3': AnimationInfo(
//       trigger: AnimationTrigger.onPageLoad,
//       effects: [
//         MoveEffect(
//           curve: Curves.easeIn,
//           delay: 0.ms,
//           duration: 800.ms,
//           begin: const Offset(400.0, 0.0),
//           end: const Offset(0.0, 0.0),
//         ),
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 1000.ms,
//           begin: 0.0,
//           end: 1.0,
//         ),
//       ],
//     ),
//     'containerOnPageLoadAnimation4': AnimationInfo(
//       trigger: AnimationTrigger.onPageLoad,
//       effects: [
//         MoveEffect(
//           curve: Curves.easeIn,
//           delay: 0.ms,
//           duration: 600.ms,
//           begin: const Offset(400.0, 0.0),
//           end: const Offset(0.0, 0.0),
//         ),
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 1000.ms,
//           begin: 0.0,
//           end: 1.0,
//         ),
//       ],
//     ),
//     'iconOnActionTriggerAnimation1': AnimationInfo(
//       trigger: AnimationTrigger.onActionTrigger,
//       applyInitialState: true,
//       effects: [
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 500.ms,
//           begin: 0.0,
//           end: 1.0,
//         ),
//         MoveEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 500.ms,
//           begin: const Offset(14.0, 0.0),
//           end: const Offset(0.0, 0.0),
//         ),
//       ],
//     ),
//     'iconOnActionTriggerAnimation2': AnimationInfo(
//       trigger: AnimationTrigger.onActionTrigger,
//       applyInitialState: true,
//       effects: [
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 500.ms,
//           begin: 0.0,
//           end: 1.0,
//         ),
//         MoveEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 500.ms,
//           begin: const Offset(0.0, 0.0),
//           end: const Offset(-14.0, 0.0),
//         ),
//       ],
//     ),
//   };
  
