import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/screens/emprendedores/emprendedores_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';


class EmprendedorActualizado extends StatefulWidget {
  const EmprendedorActualizado({Key? key}) : super(key: key);

  @override
  State<EmprendedorActualizado> createState() => _EmprendedorActualizadoState();
}

class _EmprendedorActualizadoState extends State<EmprendedorActualizado> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFDDEEF8),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: Text(
                      '¡Emprendedor\nActualizado!',
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 30,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Text(
                      'Listo, el emprendor se agregará \na la lista de emprendedores.',
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 15,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                    child: Lottie.asset(
                      'assets/lottie_animations/elemento-creado.json',
                      width: 250,
                      height: 180,
                      fit: BoxFit.cover,
                      repeat: false,
                      animate: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EmprendedoresScreen(),
                          ),
                        );
                      },
                      text: 'Listo',
                      options: FFButtonOptions(
                        width: 200,
                        height: 45,
                        color: const Color(0xFF28BFFA),
                        textStyle: AppTheme.of(context).subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
