import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/providers/sync_provider_emi_web.dart';
import 'package:bizpro_app/screens/inversiones/inversiones_screen.dart';
import 'package:bizpro_app/screens/inversiones/pagos_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/screens/inversiones/tabs/cotizacion_tab.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/screens/inversiones/tabs/inversion_tab.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_animations.dart';

class MainTabOpcionesScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;
  final int idInversion;

  const MainTabOpcionesScreen({
    Key? key,
    required this.emprendimiento, 
    required this.idInversion,
  }) : super(key: key);

  @override
  _MainTabOpcionesScreenState createState() => _MainTabOpcionesScreenState();
}

class _MainTabOpcionesScreenState extends State<MainTabOpcionesScreen>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Inversiones? actualInversion;

  @override
  void initState() {
    super.initState();
    actualInversion = dataBase.inversionesBox.get(widget.idInversion);
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
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
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
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppTheme.of(context).secondaryText,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InversionesScreen(
                                        idEmprendimiento: widget.emprendimiento.id,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    Text(
                                      'Atrás',
                                      style: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: AppTheme.of(context)
                                                .bodyText1Family,
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: actualInversion!.estadoInversion.target!.estado == "Autorizada" ||
                              actualInversion!.estadoInversion.target!.estado == "Comprada" || 
                              actualInversion!.estadoInversion.target!.estado == "Entregada Al Promotor" ||
                              actualInversion!.estadoInversion.target!.estado == "Entregada Al Emprendedor" ||
                              actualInversion!.estadoInversion.target!.estado == "Pagado",
                              child: Container(
                                width: 45,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppTheme.of(context).secondaryText,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        
                                        switch (actualInversion!.estadoInversion.target!.estado) {
                                          case "Autorizada":
                                            final connectivityResult =
                                              await (Connectivity().checkConnectivity());
                                            if(connectivityResult == ConnectivityResult.none) {
                                              snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Necesitas conexión a internet para validar el estado de la Inversión."),
                                              ));
                                            }
                                            else {
                                              //print(actualInversion!.idDBR);
                                            if (await syncProviderEmiWeb.validateInversionComprada(actualInversion!)) {
                                              snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Se ha actualizado el estado de la inversión a 'Comprada'."),
                                              ));
                                              // ignore: use_build_context_synchronously
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => PagosScreen(
                                                    idInversion: actualInversion!.id, 
                                                    idEmprendimiento: widget.emprendimiento.id,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Aún no se actualiza el estado de esta inversión a 'Comprada'."),
                                              ));
                                            }
                                            }
                                            break;
                                          default:
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PagosScreen(
                                                  idInversion: actualInversion!.id, 
                                                  idEmprendimiento: widget.emprendimiento.id,
                                                ),
                                              ),
                                            );
                                            break;
                                        }
                                      },
                                      child: const Icon(
                                        Icons.edit_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                                    text: 'Inversión',
                                  ),
                                  Tab(
                                    text: 'Cotización',
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    InversionTab(
                                        emprendimiento: widget.emprendimiento,
                                        inversion: actualInversion!,),
                                    CotizacionTab(
                                        emprendimiento: widget.emprendimiento,
                                        inversion: actualInversion!,
                                        inversionesXprodCotizados: actualInversion!.inversionXprodCotizados.last,
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
