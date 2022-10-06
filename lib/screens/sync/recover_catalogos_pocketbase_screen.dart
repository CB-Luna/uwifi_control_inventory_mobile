import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/providers/catalog_pocketbase_recover_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:lottie/lottie.dart';

import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class RecoverCatalogosPocketbaseScreen extends StatefulWidget {
  const RecoverCatalogosPocketbaseScreen({Key? key}) : super(key: key);

  @override
  State<RecoverCatalogosPocketbaseScreen> createState() => _RecoverCatalogosPocketbaseScreenState();
}

class _RecoverCatalogosPocketbaseScreenState extends State<RecoverCatalogosPocketbaseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      setState(() {
        context.read<CatalogPocketbaseRecoverProvider>().getCatalogosAgain();
    });
  }

  @override
  Widget build(BuildContext context) {
    final catalogoPocketbaseRecoverProvider = Provider.of<CatalogPocketbaseRecoverProvider>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 40, 0, 0),
                              child: Text(
                                '¡Sincronizando Cátalogos!',
                                textAlign: TextAlign.center,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 30,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Text(
                                'Los datos de los catálogos se\nestán sincronizando, por favor, no apague\nla conexión Wi-Fi o datos móviles hasta \nque se complete el proceso.',
                                textAlign: TextAlign.center,
                                maxLines: 4,
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      color: AppTheme.of(context).secondaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            catalogoPocketbaseRecoverProvider.procesocargando
                                ? Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 70, 0, 0),
                                    child: getProgressIndicatorAnimated(
                                        "Sincronizando..."),
                                  )
                                : Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 70, 0, 0),
                                    child: Lottie.asset(
                                      'assets/lottie_animations/elemento-creado.json',
                                      width: 250,
                                      height: 180,
                                      fit: BoxFit.cover,
                                      repeat: false,
                                      animate: true,
                                    ),
                                  ),
                            Visibility(
                              visible: catalogoPocketbaseRecoverProvider.procesoterminado,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 100, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EmprendimientosScreen(),
                                      ),
                                    );
                                    catalogoPocketbaseRecoverProvider.procesoTerminado(false);
                                  },
                                  text: 'Listo',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 45,
                                    color: AppTheme.of(context).secondaryText,
                                    textStyle:
                                        AppTheme.of(context).subtitle2.override(
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
      ),
    );
  }
}
