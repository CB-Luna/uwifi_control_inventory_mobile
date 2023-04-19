import 'package:taller_alex_app_asesor/providers/sync_provider_emi_web.dart';
import 'package:taller_alex_app_asesor/screens/cotizacion/components/cotizacion_tab.dart';
import 'package:taller_alex_app_asesor/screens/cotizacion/components/pagos_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_alex_app_asesor/theme/theme.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_animations.dart';

class MainTabOpcionesScreen extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;

  const MainTabOpcionesScreen({
    Key? key,
    required this.ordenTrabajo, 
  }) : super(key: key);

  @override
  _MainTabOpcionesScreenState createState() => _MainTabOpcionesScreenState();
}

class _MainTabOpcionesScreenState extends State<MainTabOpcionesScreen>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final syncProviderEmiWeb =
        Provider.of<SyncProviderEmiWeb>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: AppTheme.of(context).primaryBackground,
              ),
            ),
            Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Color(0x004672FF),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                        ).animated(
                            [animationsMap['containerOnPageLoadAnimation1']!]),
                      ),
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              TabBar(
                                labelColor: AppTheme.of(context).primaryText,
                                unselectedLabelColor: const Color(0xFF7F7A7A),
                                labelStyle: AppTheme.of(context).bodyText1,
                                indicatorColor:
                                    AppTheme.of(context).secondaryText,
                                tabs: const [
                                  Tab(
                                    text: 'Cotización',
                                  ),
                                  Tab(
                                    text: 'Pagos',
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    CotizacionTab(
                                        ordenTrabajo: widget.ordenTrabajo,),
                                    PagosTab(
                                        ordenTrabajo: widget.ordenTrabajo,
                                        ),
                                  ],
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
