import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_animations.dart';

const String baseUrl = 'https://pocketbase.cbluna-dev.com';

final client = PocketBase(baseUrl);

final nombreCharacters = RegExp(r'^(([A-Z]{1}|[ÁÉÍÓÚÑ]{1})[a-zá-ÿ]+[ ]?)+$');
final curpCharacters = RegExp(r'^([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)$');
// final curpCharacters = RegExp(r'^([A-Z]{4}[0-9]{6}[HM]{1}[A-Z]{2}[BCDFGHJKLMNPQRSTVWXYZ]{3}[A-Z]{2}[0-9]{2})$');
final telefonoCharacters = RegExp(r'^[0-9\-() ]+$');
final cualquierCharacters = RegExp(r'^.+');
final capitalizadoCharacters = RegExp(r'^([A-Z]{1}|[ÁÉÍÓÚÑ]{1}).+$');
final fechaCharacters = RegExp(r'^(((0[1-9]|[12][0-9]|30)[-/]?(0[13-9]|1[012])|31[-/]?(0[13578]|1[02])|(0[1-9]|1[0-9]|2[0-8])[-/]?02)[-/]?[0-9]{4}|29[-/]?02[-/]?([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00))$');
final familiaCharacters = RegExp(r'^([1-9]?[0-9]{1})$');
final jornadaCharacters = RegExp(r'^[1-9]+$');
var telefonoFormat = MaskTextInputFormatter(
      mask: '###-###-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
var currencyFormat = CurrencyTextInputFormatter(
  symbol: '\$',
  name: 'MXN"'
);

//Animations

Column getProgressIndicatorAnimated(String message) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      SpinKitCircle(
        size: 200,
        itemBuilder: (context, index) {
          final colors = [
            const Color(0xFF221573),
            const Color(0xffB6D9F9)
          ];
          final color = colors[index % colors.length];
          return DecoratedBox(
            decoration:
                BoxDecoration(color: color, shape: BoxShape.rectangle),
          );
        },
      ),
      const SizedBox(height: 25,),
      SizedBox(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'Work Sans',
            color: Color(0xFF040404),
            fontSize: 20,
          ),
          child:
              AnimatedTextKit(repeatForever: true, animatedTexts: [
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