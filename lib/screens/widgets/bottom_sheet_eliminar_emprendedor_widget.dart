import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:lottie/lottie.dart';

import 'package:bizpro_app/screens/emprendedores/eliminar_emprendedor_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';


class BottomSheetEliminarEmprendedor extends StatefulWidget {
  const BottomSheetEliminarEmprendedor({
    Key? key
    }) : super(key: key);

  @override
  _BottomSheetEliminarEmprendedorState createState() =>
      _BottomSheetEliminarEmprendedorState();
}

class _BottomSheetEliminarEmprendedorState
    extends State<BottomSheetEliminarEmprendedor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      decoration: BoxDecoration(
        color: AppTheme.of(context).secondaryBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: 3,
                        indent: 150,
                        endIndent: 150,
                        color: AppTheme.of(context).primaryBackground,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    '¿Deseas eliminar al emprendedor?',
                                    style: AppTheme.of(context)
                                        .title2
                                        .override(
                                          fontFamily:
                                              AppTheme.of(context)
                                                  .title2Family,
                                          color: AppTheme.of(context)
                                              .primaryText,
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Text(
                                'Si tocas el boton BORRAR, se eliminará toda la información relacionada al emprendedor registrada en el sistema y no podrá ser recuperada.',
                                textAlign: TextAlign.center,
                                style: AppTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: AppTheme.of(context)
                                          .bodyText2Family,
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie_animations/15120-delete.json',
                              height: 100,
                              fit: BoxFit.cover,
                              animate: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              text: 'CANCELAR',
                              options: FFButtonOptions(
                                width: 150,
                                height: 50,
                                color: const Color(0xFF8C8C8C),
                                textStyle: AppTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: AppTheme.of(context)
                                          .subtitle2Family,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 2,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EliminarEmprendedorScreen(),
                                  ),
                                );
                              },
                              text: 'ELIMINAR',
                              options: FFButtonOptions(
                                width: 150,
                                height: 50,
                                color: const Color(0xFFD80122),
                                textStyle: AppTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                elevation: 2,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
