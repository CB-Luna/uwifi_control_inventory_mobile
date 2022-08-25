import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:bizpro_app/screens/emprendedores/emprendedores_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';


class EliminarEmprendedorScreen extends StatefulWidget {
  const EliminarEmprendedorScreen({Key? key}) : super(key: key);

  @override
  _EliminarEmprendedorScreenState createState() => _EliminarEmprendedorScreenState();
}

class _EliminarEmprendedorScreenState extends State<EliminarEmprendedorScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFDDEEF8),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.of(context).secondaryBackground,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/bglogin2.png',
                  ).image,
                ),
              ),
            ),
            Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                               const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                            child: Text(
                              'Eliminando',
                              textAlign: TextAlign.center,
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: AppTheme.of(context)
                                        .bodyText1Family,
                                    color: AppTheme.of(context)
                                        .primaryText,
                                    fontSize: 30,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                               const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Los datos del usuario se están\neliminando, por favor, no apague la \nconexión Wi-Fi o datos móviles \nhasta que se complete el proceso.',
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: AppTheme.of(context)
                                        .bodyText1Family,
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          Padding(
                            padding:
                               const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                            child: Lottie.asset(
                              'assets/lottie_animations/83011-delete-icon-red.json',
                              width: 250,
                              height: 180,
                              fit: BoxFit.cover,
                              repeat: false,
                              animate: true,
                            ),
                          ),
                          Padding(
                            padding:
                               const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EmprendedoresScreen(),
                                  ),
                                );
                              },
                              text: 'Listo',
                              options: FFButtonOptions(
                                width: 130,
                                height: 45,
                                color:
                                    AppTheme.of(context).secondaryText,
                                textStyle: AppTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: AppTheme.of(context)
                                          .subtitle2Family,
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
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
