import 'package:bizpro_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:lottie/lottie.dart';

import 'package:bizpro_app/providers/sync_provider.dart';


import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';



class SincronizacionScreen extends StatefulWidget {

  const SincronizacionScreen({Key? key}) : super(key: key);
  

  @override
  State<SincronizacionScreen> createState() => _SincronizacionScreenState();
  
}

class _SincronizacionScreenState extends State<SincronizacionScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<SyncProvider>().executeInstrucciones(dataBase.bitacoraBox.getAll().toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final syncProvider = Provider.of<SyncProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFDDEEF8),
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                            child: Text(
                              'Sincronizando!',
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
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Los datos de los emprendimientos se\nestán sincronizando, por favor, no apague\nla conexión Wi-Fi o datos móviles hasta \nque se complete el proceso.',
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
                          syncProvider.procesocargando ?
                          CircularProgressIndicator()
                          :
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                            child: Lottie.asset(
                              'assets/lottie_animations/23719-reach-circle-progress.json',
                              width: 250,
                              height: 180,
                              fit: BoxFit.cover,
                              repeat: false,
                              animate: true,
                            ),
                          ),
                          Visibility(
                            visible: syncProvider.procesoterminado,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EmprendimientosScreen(),
                                    ),
                                  );
                                  syncProvider.procesoTerminado(false);
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
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
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
