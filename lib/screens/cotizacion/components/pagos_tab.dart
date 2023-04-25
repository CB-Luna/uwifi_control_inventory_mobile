import 'dart:convert';
import 'dart:io';
import 'package:expandable/expandable.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/providers/sync_provider_supabase.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_expanded_image_view.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';
import 'package:provider/provider.dart';

class PagosTab extends StatefulWidget {
  final OrdenTrabajo ordenTrabajo;

  const PagosTab(
      {Key? key, required this.ordenTrabajo})
      : super(key: key);

  @override
  State<PagosTab> createState() => _PagosTabState();
}

class _PagosTabState extends State<PagosTab>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final syncProviderSupabase = Provider.of<SyncProviderSupabase>(context);
    final List<ProdSolicitado> prodSolicitado = [];
    double totalProyecto = 3555;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Contrato y Pago de la Orden',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyText1Family,
                                fontSize: 20,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context).bodyText1Family),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 5, 0, 0),
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
                                      initialExpanded: false,
                                      child: ExpandablePanel(
                                        header: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 8, 0),
                                              child: FaIcon(
                                                FontAwesomeIcons.solidHandshake,
                                                color: FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              'Contrato',
                                              style: FlutterFlowTheme.of(context)
                                                  .title1
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(context)
                                                            .title1Family,
                                                    color: FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                    fontSize: 20,
                                                    useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                        .containsKey(
                                                            FlutterFlowTheme.of(context)
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
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 5),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Firma de aceptación*',
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1Family,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1Family),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FormField(
                                              builder: (state) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(5, 0, 5, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            width: 1.5,
                                                          ),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              PageTransition(
                                                                type:
                                                                    PageTransitionType
                                                                        .fade,
                                                                child:
                                                                    FlutterFlowExpandedImageView(
                                                                  image: Image
                                                                          .asset(
                                                                          'assets/images/animation_500_l3ur8tqa.gif',
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                  allowRotation:
                                                                      false,
                                                                  tag:
                                                                      'imagenFirma',
                                                                  useHeroAnimation:
                                                                      true,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Hero(
                                                            tag: 'imagenFirma',
                                                            transitionOnUserGestures:
                                                                true,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              child:  Image
                                                                .asset(
                                                                'assets/images/animation_500_l3ur8tqa.gif',
                                                                width:
                                                                    200,
                                                                height:
                                                                    120,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          String? option =
                                                              await showModalBottomSheet(
                                                            context: context,
                                                            builder: (_) =>
                                                                const CustomBottomSheet(),
                                                          );

                                                          if (option == null)
                                                            return;

                                                          final picker =
                                                              ImagePicker();

                                                          late final XFile?
                                                              pickedFile;

                                                          if (option ==
                                                              'camera') {
                                                            pickedFile =
                                                                await picker
                                                                    .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera,
                                                              imageQuality:
                                                                  50,
                                                            );
                                                          } else {
                                                            pickedFile =
                                                                await picker
                                                                    .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery,
                                                              imageQuality:
                                                                  50,
                                                            );
                                                          }

                                                          if (pickedFile ==
                                                              null) {
                                                            return;
                                                          }

                                                          setState(() {
                                                            File file = File(
                                                                pickedFile!
                                                                    .path);
                                                            List<int>
                                                                fileInByte =
                                                                file.readAsBytesSync();
                                                            String base64 =
                                                                base64Encode(
                                                                    fileInByte);
                                                          });
                                                        },
                                                        text: 'Agregar',
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 15,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 50,
                                                          color: FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .subtitle2
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .subtitle2Family,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 5),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Detalle contrato*',
                                                    style: FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1Family,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1Family),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FormField(
                                              builder: (state) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(5, 0, 5, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            width: 1.5,
                                                          ),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              PageTransition(
                                                                type:
                                                                    PageTransitionType
                                                                        .fade,
                                                                child:
                                                                    FlutterFlowExpandedImageView(
                                                                  image: Image
                                                                          .asset(
                                                                          'assets/images/animation_500_l3ur8tqa.gif',
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                  allowRotation:
                                                                      false,
                                                                  tag:
                                                                      'imagenProducto',
                                                                  useHeroAnimation:
                                                                      true,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Hero(
                                                            tag:
                                                                'imagenProducto',
                                                            transitionOnUserGestures:
                                                                true,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              child:Image
                                                                .asset(
                                                                'assets/images/animation_500_l3ur8tqa.gif',
                                                                width:
                                                                    200,
                                                                height:
                                                                    120,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          String? option =
                                                              await showModalBottomSheet(
                                                            context: context,
                                                            builder: (_) =>
                                                                const CustomBottomSheet(),
                                                          );

                                                          if (option == null)
                                                            return;

                                                          final picker =
                                                              ImagePicker();

                                                          late final XFile?
                                                              pickedFile;

                                                          if (option ==
                                                              'camera') {
                                                            pickedFile =
                                                                await picker
                                                                    .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera,
                                                              imageQuality:
                                                                  50,
                                                            );
                                                          } else {
                                                            pickedFile =
                                                                await picker
                                                                    .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery,
                                                              imageQuality:
                                                                  50,
                                                            );
                                                          }

                                                          if (pickedFile ==
                                                              null) {
                                                            return;
                                                          }

                                                          setState(() {
                                                            File file = File(
                                                                pickedFile!
                                                                    .path);
                                                            List<int>
                                                                fileInByte =
                                                                file.readAsBytesSync();
                                                            String base64 =
                                                                base64Encode(
                                                                    fileInByte);
                                                          });
                                                        },
                                                        text: 'Agregar',
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 15,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 50,
                                                          color: FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .subtitle2
                                                                  .override(
                                                                    fontFamily:
                                                                        FlutterFlowTheme.of(context)
                                                                            .subtitle2Family,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 30, 0, 10),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                    },
                                                    text: 'Aceptar',
                                                    icon: const Icon(
                                                      Icons
                                                          .check_circle_outline,
                                                      size: 15,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: 200,
                                                      height: 50,
                                                      color: FlutterFlowTheme.of(context).primaryColor,
                                                      textStyle: FlutterFlowTheme.of(
                                                              context)
                                                          .title3
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                      elevation: 3,
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0x002CC3F4),
                                                        width: 0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
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
                                          iconColor: FlutterFlowTheme.of(context)
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 5, 0, 0),
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
                                    child: ExpandablePanel(
                                      header: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 8, 0),
                                            child: Icon(
                                              Icons.attach_money_rounded,
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                              size: 24,
                                            ),
                                          ),
                                          Text(
                                            'Pagos',
                                            style: FlutterFlowTheme.of(context)
                                                .title1
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(context)
                                                          .title1Family,
                                                  color: FlutterFlowTheme.of(context)
                                                      .primaryText,
                                                  fontSize: 20,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(context)
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 20),
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisSize:
                                                    MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                0, 5, 0, 10),
                                                        child: Text(
                                                          'Monto a pagar',
                                                          style: FlutterFlowTheme.of(
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
                                                          "\$ 1,000.00",
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .title3
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).title3Family),
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
                                                          style: FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 200,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0,
                                                                  0,
                                                                  10,
                                                                  0),
                                                          child:
                                                              TextFormField(
                                                            autovalidateMode:
                                                                AutovalidateMode
                                                                    .onUserInteraction,
                                                            obscureText:
                                                                false,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Monto abonado*',
                                                              labelStyle: FlutterFlowTheme.of(
                                                                      context)
                                                                  .title3
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: FlutterFlowTheme.of(context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight.normal,
                                                                  ),
                                                              hintText:
                                                                  'Monto abonado*...',
                                                              hintStyle: FlutterFlowTheme.of(
                                                                      context)
                                                                  .title3
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: FlutterFlowTheme.of(context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight.normal,
                                                                  ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width:
                                                                      1.5,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        12),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  width:
                                                                      1.5,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        12),
                                                              ),
                                                              filled: true,
                                                              fillColor:
                                                                  const Color(
                                                                      0x49FFFFFF),
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              currencyFormat
                                                            ],
                                                            style: FlutterFlowTheme.of(
                                                                    context)
                                                                .title3
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                            maxLines: 1,
                                                            validator:
                                                                (val) {
                                                              if (val!.length >
                                                                  1) {
                                                                double abono = double.parse(val
                                                                    .replaceAll(
                                                                        '\$',
                                                                        '')
                                                                    .replaceAll(
                                                                        ',',
                                                                        ''));
                                                                if (abono <=
                                                                    0) {
                                                                  return 'Para continuar, ingrese un monto mayor a 0.';
                                                                }

                                                                return null;
                                                              }
                                                            },
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
                                                          style: FlutterFlowTheme.of(
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
                                                          currencyFormat
                                                              .format(
                                                                  "5000.0"),
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .title3
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).title3Family),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                  0,
                                                                  5,
                                                                  0,
                                                                  10),
                                                          child: Text(
                                                            'Pagos',
                                                            style: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1,
                                                          ),
                                                        ),
                                                        Builder(builder:
                                                            (context) {
                                                          return ListView
                                                              .builder(
                                                            padding:
                                                                EdgeInsets
                                                                    .zero,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            controller:
                                                                ScrollController(),
                                                            itemCount:
                                                                1,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                        0,
                                                                        5,
                                                                        0,
                                                                        10),
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(8.0),
                                                                      child:
                                                                          Text(
                                                                        "${dateTimeFormat('d/MMMM/y', DateTime.now())} \n ${currencyFormat.format("40.99")}",
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodyText1Family,
                                                                              fontWeight: FontWeight.normal,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyText1Family),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        0, 30, 0, 10),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                      },
                                                      text: 'Aceptar',
                                                      icon: const Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        size: 15,
                                                      ),
                                                      options:
                                                          FFButtonOptions(
                                                        width: 200,
                                                        height: 50,
                                                        color: FlutterFlowTheme.of(context).primaryColor,
                                                        textStyle: FlutterFlowTheme
                                                                .of(context)
                                                            .title3
                                                            .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                        elevation: 3,
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color(
                                                              0x002CC3F4),
                                                          width: 0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
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
                                        iconColor: FlutterFlowTheme.of(context)
                                            .secondaryText,
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

  DataRow _getDataRow(int index) {
    return DataRow(
      color: MaterialStateProperty.all(Colors.transparent),
      selected: true,
      onSelectChanged: (value) {
      },
      cells: <DataCell>[
        DataCell(Center(
          child: Text(
              maybeHandleOverflow(
                  "Producto Test no.$index", 15, "..."),
              style: GoogleFonts.roboto(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
        )),
        DataCell(Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              readOnly: true,
              //maxLength: 2,
              maxLines: 1,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              initialValue: "1",
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
              },
              obscureText: false,

              style: FlutterFlowTheme.of(context).title3.override(
                    fontFamily: 'Poppins',
                    color: const Color(0xFF221573),
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))
              ],
            ),
          ),
        )),
        DataCell(Center(
          child: Text(
              maybeHandleOverflow(currencyFormat.format("300.99"),8,'...'),
              style: GoogleFonts.roboto(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
        )),
      ],
    );
  }
  
}


