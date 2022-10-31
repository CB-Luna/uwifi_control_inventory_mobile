import 'dart:io';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/screens/inversiones/inversiones_screen.dart';
import 'package:bizpro_app/screens/inversiones/pagos/entrega_inversion_concluida.dart';
import 'package:bizpro_app/screens/inversiones/pagos/pagos_concluidos.dart';
import 'package:bizpro_app/screens/inversiones/pagos/recepcion_inversion_concluida.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_expanded_image_view.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/providers/database_providers/recepcion_y_entrega_inversion_controller.dart';
import 'package:bizpro_app/screens/inversiones/main_tab_opciones.dart';
import 'package:expandable/expandable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/widgets/toggle_icon.dart';


class PagosScreen extends StatefulWidget {
  final int idInversion;
  
  const PagosScreen({
    Key? key, 
    required this.idInversion,
    }) : super(key: key);

  @override
  _PagosScreenState createState() =>
      _PagosScreenState();
}

class _PagosScreenState extends State<PagosScreen> {
  Inversiones? actualInversion;
  InversionesXProdCotizados? inversionesXprodCotizados;
  TextEditingController montoPagar = TextEditingController();
  TextEditingController saldo = TextEditingController();
  TextEditingController montoAbonado = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  List<Pagos> listPagos = [];
  double totalProyecto = 0.00;
  late String imageFirma;
  late String imageProducto;

  @override
  void initState() {
    super.initState();
    actualInversion = dataBase.inversionesBox.get(widget.idInversion);
    if (actualInversion != null) {
      if (actualInversion!.imagenes.isNotEmpty) {
      imageFirma = actualInversion!.imagenes.first.imagenes;
      imageProducto = actualInversion!.imagenes.last.imagenes;
      } else {
        imageFirma = "";
        imageProducto = "";
      }
      listPagos = actualInversion!.pagos.toList();
      montoPagar = TextEditingController(text: currencyFormat.format(actualInversion!.montoPagar.toStringAsFixed(2)));
      saldo = TextEditingController(text: currencyFormat.format(actualInversion!.saldo.toStringAsFixed(2)));
      montoAbonado = TextEditingController();
      totalProyecto = 0.00;
      inversionesXprodCotizados = actualInversion!.inversionXprodCotizados.last;
      setState(() {
        totalProyecto = context.read<RecepcionYEntregaController>().getProdCotizadosEinversionXprodCotizados(
          inversionesXprodCotizados!.prodCotizados,
          inversionesXprodCotizados!
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final recepcionYentregaProvider =
        Provider.of<RecepcionYEntregaController>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
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
                                  builder: (context) => MainTabOpcionesScreen(
                                    emprendimiento: actualInversion!.emprendimiento.target!,
                                    idInversion: actualInversion!.id,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                AppTheme.of(context)
                                                    .bodyText1Family),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Recepción y Entrega de Inversión',
                          textAlign: TextAlign.center,
                          style: AppTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: AppTheme.of(context)
                                    .bodyText1Family,
                                fontSize: 20,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    AppTheme.of(context)
                                        .bodyText1Family),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00F2F4F8),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    color: const Color(0x00F2F4F8),
                                    child: ExpandableNotifier(
                                      initialExpanded: actualInversion!.estadoInversion.target!.estado == "Comprada",
                                      child: ExpandablePanel(
                                        header: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 8, 0),
                                              child: FaIcon(
                                                FontAwesomeIcons.handHolding,
                                                color:
                                                    AppTheme.of(context)
                                                        .secondaryText,
                                                size: 24,
                                              ),
                                            ),
                                            Text(
                                              'Recepción de Inversión',
                                              style:
                                                  AppTheme.of(context)
                                                      .title1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(
                                                                    context)
                                                                .title1Family,
                                                        color:
                                                            AppTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 20,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                AppTheme.of(
                                                                        context)
                                                                    .title1Family),
                                                      ),
                                            ),
                                          ],
                                        ),
                                        collapsed: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: const [
                                            Divider(
                                              thickness: 1.5,
                                              color: Color(0xFF8B8B8B),
                                            ),
                                          ],
                                        ),
                                        expanded: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: 1,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppTheme.of(context)
                                                        .secondaryText,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Producto',
                                                    style: AppTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    'Cantidad',
                                                    style: AppTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    'Costo final',
                                                    style: AppTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: 1,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppTheme.of(context)
                                                        .secondaryText,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            IgnorePointer(
                                              ignoring: actualInversion!.estadoInversion.target!.estado != "Comprada" ||
                                              actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol == "Amigo del Cambio"
                                              || actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol == "Emprendedor",
                                              child: Builder(
                                                builder: (context) {
                                                  return ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.vertical,
                                                    controller: ScrollController(),
                                                    itemCount: recepcionYentregaProvider.prodCotizadosTemp.length,
                                                    itemBuilder: (context, index) {
                                                      final productoCot = recepcionYentregaProvider.prodCotizadosTemp[index];
                                                      return Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                        children: [
                                                          ToggleIcon(
                                                            onPressed: () {
                                                              setState(() {
                                                                recepcionYentregaProvider
                                                                .prodCotizadosTemp[index]
                                                                .aceptado = 
                                                                !recepcionYentregaProvider
                                                                .prodCotizadosTemp[index]
                                                                .aceptado;
                                                              });
                                                            },
                                                            value: recepcionYentregaProvider
                                                                    .prodCotizadosTemp[index]
                                                                    .aceptado,
                                                            onIcon: Icon(
                                                              Icons.check_box,
                                                              color:
                                                                  AppTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              size: 25,
                                                            ),
                                                            offIcon: Icon(
                                                              Icons
                                                                  .check_box_outline_blank,
                                                              color:
                                                                  AppTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              size: 25,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize.max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  productoCot.productosProv.target!.nombre,
                                                                  style: AppTheme
                                                                          .of(context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily: AppTheme.of(
                                                                                context)
                                                                            .bodyText1Family,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        useGoogleFonts: GoogleFonts
                                                                                .asMap()
                                                                            .containsKey(
                                                                                AppTheme.of(context)
                                                                                    .bodyText1Family),
                                                                      ),
                                                                ),
                                                                Text(
                                                                  productoCot.cantidad.toString(),
                                                                  style: AppTheme
                                                                          .of(context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily: AppTheme.of(
                                                                                context)
                                                                            .bodyText1Family,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        useGoogleFonts: GoogleFonts
                                                                                .asMap()
                                                                            .containsKey(
                                                                                AppTheme.of(context)
                                                                                    .bodyText1Family),
                                                                      ),
                                                                ),
                                                                Text(
                                                                  currencyFormat.format((productoCot.costoTotal).toStringAsFixed(2)),
                                                                  style: AppTheme
                                                                          .of(context)
                                                                      .bodyText1
                                                                      .override(
                                                                        fontFamily: AppTheme.of(
                                                                                context)
                                                                            .bodyText1Family,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        useGoogleFonts: GoogleFonts
                                                                                .asMap()
                                                                            .containsKey(
                                                                                AppTheme.of(context)
                                                                                    .bodyText1Family),
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              ),
                                            ),
                                            IgnorePointer(
                                              ignoring: actualInversion!.estadoInversion.target!.estado != "Comprada" || 
                                              actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol == "Amigo del Cambio"
                                              || actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol == "Emprendedor",
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: const Color(0x2D4672FF),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        ToggleIcon(
                                                          onPressed: () {
                                                            setState(() {
                                                                recepcionYentregaProvider
                                                                .inversionXProdCotizadosTemp!
                                                                .aceptado = 
                                                                !recepcionYentregaProvider
                                                                .inversionXProdCotizadosTemp!
                                                                .aceptado;
                                                              });
                                                          },
                                                          value: recepcionYentregaProvider
                                                                .inversionXProdCotizadosTemp!
                                                                .aceptado,
                                                          onIcon: Icon(
                                                            Icons.check_box,
                                                            color: AppTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 25,
                                                          ),
                                                          offIcon: Icon(
                                                            Icons
                                                                .check_box_outline_blank,
                                                            color: AppTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 25,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(0,
                                                                        0, 10, 0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Finalizar recepción',
                                                                  style: AppTheme.of(
                                                                          context)
                                                                      .bodyText1,
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              10,
                                                                              0),
                                                                      child: Text(
                                                                        'Total',
                                                                        style: AppTheme.of(
                                                                                context)
                                                                            .bodyText1,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      currencyFormat.format(totalProyecto.toStringAsFixed(2)),
                                                                      style: AppTheme.of(
                                                                              context)
                                                                          .bodyText1
                                                                          .override(
                                                                            fontFamily:
                                                                                AppTheme.of(context).bodyText1Family,
                                                                            fontSize:
                                                                                18,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey(AppTheme.of(context).bodyText1Family),
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 10),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      if (actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol != "Amigo del Cambio"
                                                          && actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol != "Emprendedor") {
                                                      if (actualInversion!.estadoInversion.target!.estado == "Comprada") {
                                                        if ((!recepcionYentregaProvider
                                                          .prodCotizadosTemp
                                                          .every((element) => element.aceptado == true)) &&
                                                          (recepcionYentregaProvider
                                                          .inversionXProdCotizadosTemp!
                                                          .aceptado == true)
                                                      ) {
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Para finalizar la recepción debes de seleccionar todos los productos."),
                                                        ));                                                     
                                                      } else {
                                                        if (recepcionYentregaProvider
                                                          .inversionXProdCotizadosTemp!
                                                          .aceptado) {
                                                          recepcionYentregaProvider.finishRecepcionInversion(actualInversion!.inversionXprodCotizados.last);
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => RecepcionInversionConcluida(
                                                                idEmprendimiento: 
                                                                  actualInversion!.emprendimiento.target!.id,
                                                              ),
                                                            ),
                                                          );
                                                          
                                                        } else {
                                                          recepcionYentregaProvider.updateRecepcionInversion();
                                                          snackbarKey.currentState
                                                            ?.showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Estado de productos actualizado."),
                                                          )); 
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => InversionesScreen(
                                                                idEmprendimiento: 
                                                                  actualInversion!.emprendimiento.target!.id,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                      } else{
                                                        snackbarKey.currentState
                                                            ?.showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "No puedes actualizar esta sección."),
                                                          )); 
                                                      }
                                                    } else {
                                                            snackbarKey.currentState
                                                                ?.showSnackBar(const SnackBar(
                                                              content: Text(
                                                                  "Este usuario no tiene permisos para esta acción."),
                                                            ));
                                                    }
                                                    },
                                                    text: 'Aceptar',
                                                    icon: const Icon(
                                                      Icons.check_circle_outline,
                                                      size: 15,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: 200,
                                                      height: 50,
                                                      color: const Color(0xFF4672FF),
                                                      textStyle: AppTheme.of(context)
                                                          .title3
                                                          .override(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w300,
                                                          ),
                                                      elevation: 3,
                                                      borderSide: const BorderSide(
                                                        color: Color(0x002CC3F4),
                                                        width: 0,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment:
                                              ExpandablePanelHeaderAlignment
                                                  .center,
                                          hasIcon: true,
                                          iconColor:
                                              AppTheme.of(context)
                                                  .secondaryText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00F2F4F8),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    color: const Color(0x00F2F4F8),
                                    child: ExpandableNotifier(
                                      initialExpanded: actualInversion!.estadoInversion.target!.estado == "Entregada Al Promotor",
                                      child: ExpandablePanel(
                                        header: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 8, 0),
                                              child: FaIcon(
                                                FontAwesomeIcons.solidHandshake,
                                                color:
                                                    AppTheme.of(context)
                                                        .secondaryText,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Entrega de Inversión',
                                              style:
                                                  AppTheme.of(context)
                                                      .title1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(
                                                                    context)
                                                                .title1Family,
                                                        color:
                                                            AppTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 20,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                AppTheme.of(
                                                                        context)
                                                                    .title1Family),
                                                      ),
                                            ),
                                          ],
                                        ),
                                        collapsed: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: const [
                                            Divider(
                                              thickness: 1.5,
                                              color: Color(0xFF8B8B8B),
                                            ),
                                          ],
                                        ),
                                        expanded: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 5),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Firma de recibido*',
                                                    style: AppTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodyText1Family,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  AppTheme.of(
                                                                          context)
                                                                      .bodyText1Family),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FormField(builder: (state){
                                              return Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: AppTheme.of(context)
                                                            .primaryText,
                                                        borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type: PageTransitionType.fade,
                                                              child:
                                                                  FlutterFlowExpandedImageView(
                                                                image: imageFirma == "" ? Image.asset(
                                                                  'assets/images/default_image.png',
                                                                  fit: BoxFit.contain,
                                                                ) 
                                                                :
                                                                Image.file(
                                                                  File(imageFirma),
                                                                  fit: BoxFit.contain,
                                                                ),
                                                                allowRotation: false,
                                                                tag: 'imagenFirma',
                                                                useHeroAnimation: true,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Hero(
                                                          tag: 'imagenFirma',
                                                          transitionOnUserGestures: true,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(5),
                                                            child: imageFirma == "" ? Image.asset(
                                                              'assets/images/default_image.png',
                                                              width: 200,
                                                              height: 120,
                                                              fit: BoxFit.cover,
                                                            )
                                                            :
                                                            Image.file(
                                                              File(imageFirma),
                                                              width: 200,
                                                              height: 120,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    IgnorePointer(
                                                      ignoring: actualInversion!.estadoInversion.target!.estado != "Entregada Al Promotor" ||
                                                      actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol == "Amigo del Cambio"
                                                      || actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol == "Emprendedor",
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          String? option = await showModalBottomSheet(
                                                              context: context,
                                                              builder: (_) => const CustomBottomSheet(),
                                                            );
                                                                                                  
                                                            if (option == null) return;
                                                                                                  
                                                            final picker = ImagePicker();
                                                                                                  
                                                            late final XFile? pickedFile;
                                                                                                  
                                                            if (option == 'camera') {
                                                              pickedFile = await picker.pickImage(
                                                                source: ImageSource.camera,
                                                                imageQuality: 100,
                                                              );
                                                            } else {
                                                              pickedFile = await picker.pickImage(
                                                                source: ImageSource.gallery,
                                                                imageQuality: 100,
                                                              );
                                                            }
                                                                                                  
                                                            if (pickedFile == null) {
                                                              return;
                                                            }
                                                                                                  
                                                            setState(() {
                                                              imageFirma = pickedFile!.path;
                                                            });
                                                        },
                                                        text: 'Agregar',
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 15,
                                                        ),
                                                        options: FFButtonOptions(
                                                          height: 50,
                                                          color: AppTheme.of(context)
                                                              .secondaryText,
                                                          textStyle: AppTheme.of(context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    AppTheme.of(context)
                                                                        .subtitle2Family,
                                                                color: Colors.white,
                                                                fontSize: 15,
                                                              ),
                                                          borderSide: const BorderSide(
                                                            color: Colors.transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 5),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Producto entregado*',
                                                    style: AppTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              AppTheme.of(
                                                                      context)
                                                                  .bodyText1Family,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  AppTheme.of(
                                                                          context)
                                                                      .bodyText1Family),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FormField(builder: (state){
                                              return Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: AppTheme.of(context)
                                                            .primaryText,
                                                        borderRadius: BorderRadius.circular(8),
                                                        border: Border.all(
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              type: PageTransitionType.fade,
                                                              child:
                                                                  FlutterFlowExpandedImageView(
                                                                image: imageProducto == "" ? Image.asset(
                                                                  'assets/images/default_image.png',
                                                                  fit: BoxFit.contain,
                                                                ) 
                                                                :
                                                                Image.file(
                                                                  File(imageProducto),
                                                                  fit: BoxFit.contain,
                                                                ),
                                                                allowRotation: false,
                                                                tag: 'imagenProducto',
                                                                useHeroAnimation: true,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Hero(
                                                          tag: 'imagenProducto',
                                                          transitionOnUserGestures: true,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(5),
                                                            child: imageProducto == "" ? Image.asset(
                                                              'assets/images/default_image.png',
                                                              width: 200,
                                                              height: 120,
                                                              fit: BoxFit.cover,
                                                            )
                                                            :
                                                            Image.file(
                                                              File(imageProducto),
                                                              width: 200,
                                                              height: 120,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    IgnorePointer(
                                                      ignoring: actualInversion!.estadoInversion.target!.estado != "Entregada Al Promotor" ||
                                                      actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol == "Amigo del Cambio"
                                                      || actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol == "Emprendedor",
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          String? option = await showModalBottomSheet(
                                                              context: context,
                                                              builder: (_) => const CustomBottomSheet(),
                                                            );
                                                                                                  
                                                            if (option == null) return;
                                                                                                  
                                                            final picker = ImagePicker();
                                                                                                  
                                                            late final XFile? pickedFile;
                                                                                                  
                                                            if (option == 'camera') {
                                                              pickedFile = await picker.pickImage(
                                                                source: ImageSource.camera,
                                                                imageQuality: 100,
                                                              );
                                                            } else {
                                                              pickedFile = await picker.pickImage(
                                                                source: ImageSource.gallery,
                                                                imageQuality: 100,
                                                              );
                                                            }
                                                                                                  
                                                            if (pickedFile == null) {
                                                              return;
                                                            }
                                                                                                  
                                                            setState(() {
                                                              imageProducto = pickedFile!.path;
                                                            });
                                                        },
                                                        text: 'Agregar',
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 15,
                                                        ),
                                                        options: FFButtonOptions(
                                                          height: 50,
                                                          color: AppTheme.of(context)
                                                              .secondaryText,
                                                          textStyle: AppTheme.of(context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    AppTheme.of(context)
                                                                        .subtitle2Family,
                                                                color: Colors.white,
                                                                fontSize: 15,
                                                              ),
                                                          borderSide: const BorderSide(
                                                            color: Colors.transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            ),
                                            Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                0, 30, 0, 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    if (actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol != "Amigo del Cambio"
                                                    && actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol != "Emprendedor") {
                                                    if (actualInversion!.estadoInversion.target!.estado == "Entregada Al Promotor") {
                                                      if (imageFirma != ""  && imageProducto != "") {
                                                        recepcionYentregaProvider.entregaInversion(
                                                            imageFirma,
                                                            imageProducto,
                                                            actualInversion!.id
                                                          );
                                                        await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => EntregaInversionConcluida(
                                                                idEmprendimiento: 
                                                                  actualInversion!.emprendimiento.target!.id,
                                                              ),
                                                            ),
                                                          );
                                                      } else {
                                                        snackbarKey.currentState
                                                          ?.showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Por favor carga los archivos solicitados 'Firma de recibido' y 'Producto entregado'."),
                                                        ));                                  
                                                      }
                                                    } else{
                                                      snackbarKey.currentState
                                                          ?.showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "No puedes actualizar esta sección."),
                                                        )); 
                                                    }
                                                    } else {
                                                      snackbarKey.currentState
                                                          ?.showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Este usuario no tiene permisos para esta acción."),
                                                      ));
                                                    }
                                                  },
                                                  text: 'Aceptar',
                                                  icon: const Icon(
                                                    Icons.check_circle_outline,
                                                    size: 15,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: 200,
                                                    height: 50,
                                                    color: const Color(0xFF4672FF),
                                                    textStyle: AppTheme.of(context)
                                                        .title3
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w300,
                                                        ),
                                                    elevation: 3,
                                                    borderSide: const BorderSide(
                                                      color: Color(0x002CC3F4),
                                                      width: 0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ],
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment:
                                              ExpandablePanelHeaderAlignment
                                                  .center,
                                          hasIcon: true,
                                          iconColor:
                                              AppTheme.of(context)
                                                  .secondaryText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00F2F4F8),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    color: const Color(0x00F2F4F8),
                                    child: ExpandableNotifier(
                                      initialExpanded: actualInversion!.estadoInversion.target!.estado == "Entregada Al Emprendedor",
                                      child: ExpandablePanel(
                                        header: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 8, 0),
                                              child: Icon(
                                                Icons.attach_money_rounded,
                                                color:
                                                    AppTheme.of(context)
                                                        .secondaryText,
                                                size: 24,
                                              ),
                                            ),
                                            Text(
                                              'Pagos',
                                              style:
                                                  AppTheme.of(context)
                                                      .title1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(
                                                                    context)
                                                                .title1Family,
                                                        color:
                                                            AppTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontSize: 20,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                AppTheme.of(
                                                                        context)
                                                                    .title1Family),
                                                      ),
                                            ),
                                          ],
                                        ),
                                        collapsed: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: const [
                                            Divider(
                                              thickness: 1.5,
                                              color: Color(0xFF8B8B8B),
                                            ),
                                          ],
                                        ),
                                        expanded: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 20),
                                          child: Form(
                                            key: formKey,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 5, 0, 10),
                                                          child: Text(
                                                            'Monto a pagar',
                                                            style:
                                                                AppTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 5, 0, 10),
                                                          child: Text(
                                                            montoPagar.text,
                                                            style:
                                                                AppTheme.of(
                                                                    context)
                                                                .title3
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: AppTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          AppTheme.of(context)
                                                                              .title3Family),
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 5, 0, 10),
                                                          child: Text(
                                                            'Monto Abonado*',
                                                            style:
                                                                AppTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                          ),
                                                        ),
                                                        IgnorePointer(
                                                          ignoring: actualInversion!.estadoInversion.target!.estado != "Entregada Al Emprendedor" ||
                                                          actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol == "Amigo del Cambio"
                                                          || actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol == "Emprendedor",
                                                          child: SizedBox(
                                                            width: 200,
                                                            child: Padding(
                                                              padding: const EdgeInsetsDirectional
                                                                  .fromSTEB(0, 0, 10, 0),
                                                              child: TextFormField(
                                                                controller: montoAbonado,
                                                                autovalidateMode: AutovalidateMode
                                                                    .onUserInteraction,
                                                                obscureText: false,
                                                                decoration: InputDecoration(
                                                                  labelText: 'Monto abonado*',
                                                                  labelStyle: AppTheme.of(context)
                                                                      .title3
                                                                      .override(
                                                                        fontFamily: 'Montserrat',
                                                                        color: AppTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize: 15,
                                                                        fontWeight: FontWeight.normal,
                                                                      ),
                                                                  hintText:
                                                                      'Monto abonado*...',
                                                                  hintStyle: AppTheme.of(context)
                                                                      .title3
                                                                      .override(
                                                                        fontFamily: 'Poppins',
                                                                        color: AppTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize: 15,
                                                                        fontWeight: FontWeight.normal,
                                                                      ),
                                                                  enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: AppTheme.of(context)
                                                                          .primaryText,
                                                                      width: 1.5,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(12),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                      color: AppTheme.of(context)
                                                                          .primaryText,
                                                                      width: 1.5,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(12),
                                                                  ),
                                                                  filled: true,
                                                                  fillColor: const Color(0x49FFFFFF),
                                                                ),
                                                                keyboardType: TextInputType.number,
                                                                inputFormatters: [currencyFormat],
                                                                style: AppTheme.of(context)
                                                                    .title3
                                                                    .override(
                                                                      fontFamily: 'Poppins',
                                                                      color: AppTheme.of(context)
                                                                          .primaryText,
                                                                      fontSize: 15,
                                                                      fontWeight: FontWeight.normal,
                                                                    ),
                                                                maxLines: 1,
                                                                validator: (val) {
                                                                  if (val == null || val.isEmpty) {
                                                                    return 'Ingrese un monto abonado.';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 5, 0, 10),
                                                          child: Text(
                                                            'Saldo Restante',
                                                            style:
                                                                AppTheme.of(
                                                                        context)
                                                                    .bodyText1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0, 5, 0, 10),
                                                          child: Text(
                                                            currencyFormat.format(saldo.text),
                                                            style:
                                                                AppTheme.of(
                                                                    context)
                                                                .title3
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: AppTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          AppTheme.of(context)
                                                                              .title3Family),
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0, 5, 0, 10),
                                                            child: Text(
                                                              'Pagos',
                                                              style:
                                                                  AppTheme.of(
                                                                          context)
                                                                      .bodyText1,
                                                            ),
                                                          ),
                                                          Builder(
                                                            builder: (context) {
                                                              return ListView.builder(
                                                                padding: EdgeInsets.zero,
                                                                shrinkWrap: true,
                                                                scrollDirection: Axis.vertical,
                                                                controller: ScrollController(),
                                                                itemCount: listPagos.length,
                                                                itemBuilder: (context, index) {
                                                                  final pago = listPagos[index];
                                                                  return Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize.max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        dateTimeFormat(
                                                                        'dd/MMM/yyyy',
                                                                        pago.fechaMovimiento),
                                                                        style: AppTheme
                                                                                .of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: AppTheme.of(
                                                                                      context)
                                                                                  .bodyText1Family,
                                                                              fontWeight:
                                                                                  FontWeight
                                                                                      .normal,
                                                                              useGoogleFonts: GoogleFonts
                                                                                      .asMap()
                                                                                  .containsKey(
                                                                                      AppTheme.of(context)
                                                                                          .bodyText1Family),
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        currencyFormat.format(pago.montoAbonado.toStringAsFixed(2)),
                                                                        style: AppTheme
                                                                                .of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: AppTheme.of(
                                                                                      context)
                                                                                  .bodyText1Family,
                                                                              fontWeight:
                                                                                  FontWeight
                                                                                      .w600,
                                                                              useGoogleFonts: GoogleFonts
                                                                                      .asMap()
                                                                                  .containsKey(
                                                                                      AppTheme.of(context)
                                                                                          .bodyText1Family),
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            }
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                                      0, 30, 0, 10),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          if (actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol != "Amigo del Cambio"
                                                          && actualInversion!.emprendimiento.target!.usuario.target!.rol.target!.rol != "Emprendedor") {
                                                          if (actualInversion!.estadoInversion.target!.estado == "Entregada Al Emprendedor") {
                                                              if (recepcionYentregaProvider.validateForm(formKey)) {
                                                                if (double.parse(
                                                                  montoAbonado.text.replaceAll("\$", "")
                                                                  .replaceAll(",", "")) == double.parse(
                                                                  saldo.text.replaceAll("\$", "")
                                                                  .replaceAll(",", ""))) {
                                                                    recepcionYentregaProvider.finishPago(
                                                                      double.parse(
                                                                      montoAbonado.text.replaceAll("\$", "")
                                                                      .replaceAll(",", "")), 
                                                                      actualInversion!.id
                                                                    );
                                                                    await Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            PagosConcluidos(
                                                                              idEmprendimiento: 
                                                                                actualInversion!.emprendimiento.target!.id
                                                                              ,),
                                                                      ),
                                                                    );
                                                                  
                                                                }
                                                                if (double.parse(
                                                                  montoAbonado.text.replaceAll("\$", "")
                                                                  .replaceAll(",", "")) < double.parse(
                                                                  saldo.text.replaceAll("\$", "")
                                                                  .replaceAll(",", ""))) {
                                                                    recepcionYentregaProvider.updatePago(
                                                                      double.parse(
                                                                      montoAbonado.text.replaceAll("\$", "")
                                                                      .replaceAll(",", "")), 
                                                                      actualInversion!.id
                                                                    );
                                                                  snackbarKey.currentState
                                                                    ?.showSnackBar(const SnackBar(
                                                                  content: Text(
                                                                      "Pago agregado éxitosamente."),
                                                                  )); 
                                                                  // ignore: use_build_context_synchronously
                                                                  await Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InversionesScreen(
                                                                              idEmprendimiento: 
                                                                                actualInversion!.emprendimiento.target!.id
                                                                              ,),
                                                                      ),
                                                                    );
                                                                }
                                                                if (double.parse(
                                                                  montoAbonado.text.replaceAll("\$", "")
                                                                  .replaceAll(",", "")) > double.parse(
                                                                  saldo.text.replaceAll("\$", "")
                                                                  .replaceAll(",", ""))) {
                                                                  snackbarKey.currentState
                                                                    ?.showSnackBar(const SnackBar(
                                                                  content: Text(
                                                                      "El monto abonado no puede ser mayor al saldo restante."),
                                                                  )); 
                                                                }
                                                              }
                                                            } else{
                                                              snackbarKey.currentState
                                                                  ?.showSnackBar(const SnackBar(
                                                                content: Text(
                                                                    "No puedes actualizar esta sección."),
                                                                )); 
                                                            }
                                                          } else {
                                                            snackbarKey.currentState
                                                                ?.showSnackBar(const SnackBar(
                                                              content: Text(
                                                                  "Este usuario no tiene permisos para esta acción."),
                                                            ));
                                                          }
                                                        },
                                                        text: 'Aceptar',
                                                        icon: const Icon(
                                                          Icons.check_circle_outline,
                                                          size: 15,
                                                        ),
                                                        options: FFButtonOptions(
                                                          width: 200,
                                                          height: 50,
                                                          color: const Color(0xFF4672FF),
                                                          textStyle: AppTheme.of(context)
                                                              .title3
                                                              .override(
                                                                fontFamily: 'Poppins',
                                                                color: Colors.white,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w300,
                                                              ),
                                                          elevation: 3,
                                                          borderSide: const BorderSide(
                                                            color: Color(0x002CC3F4),
                                                            width: 0,
                                                          ),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        theme: ExpandableThemeData(
                                          tapHeaderToExpand: true,
                                          tapBodyToExpand: false,
                                          tapBodyToCollapse: false,
                                          headerAlignment:
                                              ExpandablePanelHeaderAlignment
                                                  .center,
                                          hasIcon: true,
                                          iconColor:
                                              AppTheme.of(context)
                                                  .secondaryText,
                                        ),
                                      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}