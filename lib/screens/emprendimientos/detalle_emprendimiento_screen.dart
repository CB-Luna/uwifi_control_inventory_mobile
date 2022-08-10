import 'package:bizpro_app/screens/widgets/pdf/api/pdf_invoice_api.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/customer.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/invoice.dart';
import 'package:bizpro_app/screens/widgets/pdf/models/supplier.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:expandable/expandable.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/consultorias/agregar_consultoria_screen.dart';
import 'package:bizpro_app/screens/emprendedores/agregar_emprendedor_screen.dart';
import 'package:bizpro_app/screens/jornadas/agregar_jornada_screen.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:bizpro_app/screens/emprendimientos/editar_emprendimiento.dart';

class DetalleEmprendimientoScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;

  const DetalleEmprendimientoScreen({
    Key? key,
    required this.emprendimiento,
  }) : super(key: key);

  @override
  State<DetalleEmprendimientoScreen> createState() =>
      _DetalleEmprendimientoScreenState();
}

class _DetalleEmprendimientoScreenState
    extends State<DetalleEmprendimientoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    String emprendedor = "";
    if (widget.emprendimiento.emprendedor.target != null) {
      emprendedor =
          "${widget.emprendimiento.emprendedor.target!.nombre} ${widget.emprendimiento.emprendedor.target!.apellidos}";
    }
    final List<Jornadas> jornadas = [];
    widget.emprendimiento.jornadas.forEach((element) {
      jornadas.add(element);
    });
    final List<Consultorias> consultorias = [];
    widget.emprendimiento.consultorias.forEach((element) {
      consultorias.add(element);
    });
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            //Imagen de fondo
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

            //Imagen de emprendimiento
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(widget.emprendimiento.imagen)),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0x0014181B),
                      AppTheme.of(context).secondaryBackground
                    ],
                    stops: const [0, 1],
                    begin: const AlignmentDirectional(0, -1),
                    end: const AlignmentDirectional(0, 1),
                  ),
                ),
              ),
            ),

            //Opciones superiores
            Positioned(
              left: 16,
              top: 45,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4672FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          Text(
                            'Atrás',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      width: 45,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4672FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () async {
                        final date = DateTime.now();
                        final dueDate = date.add(Duration(days: 7));

                        final invoice = Invoice(
                          supplier: Supplier(
                            name: 'Sarah Field',
                            address: 'Sarah Street 9, Beijing, China',
                            paymentInfo: 'https://paypal.me/sarahfieldzz',
                          ),
                          customer: Customer(
                            name: 'Apple Inc.',
                            address: 'Apple Street, Cupertino, CA 95014',
                          ),
                          info: InvoiceInfo(
                            date: date,
                            dueDate: dueDate,
                            description: 'My description...',
                            number: '${DateTime.now().year}-9999',
                          ),
                          items: [
                            InvoiceItem(
                              description: 'Coffee',
                              date: DateTime.now(),
                              quantity: 3,
                              vat: 0.19,
                              unitPrice: 5.99,
                            ),
                            InvoiceItem(
                              description: 'Water',
                              date: DateTime.now(),
                              quantity: 8,
                              vat: 0.19,
                              unitPrice: 0.99,
                            ),
                            InvoiceItem(
                              description: 'Orange',
                              date: DateTime.now(),
                              quantity: 3,
                              vat: 0.19,
                              unitPrice: 2.99,
                            ),
                            InvoiceItem(
                              description: 'Apple',
                              date: DateTime.now(),
                              quantity: 8,
                              vat: 0.19,
                              unitPrice: 3.99,
                            ),
                            InvoiceItem(
                              description: 'Mango',
                              date: DateTime.now(),
                              quantity: 1,
                              vat: 0.19,
                              unitPrice: 1.59,
                            ),
                            InvoiceItem(
                              description: 'Blue Berries',
                              date: DateTime.now(),
                              quantity: 5,
                              vat: 0.19,
                              unitPrice: 0.99,
                            ),
                            InvoiceItem(
                              description: 'Lemon',
                              date: DateTime.now(),
                              quantity: 4,
                              vat: 0.19,
                              unitPrice: 1.29,
                            ),
                          ],
                        );
                        final pdfFile = await PdfInvoiceApi.generate(invoice);

                        // PdfApi.openFile(pdfFile);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.fileArrowDown,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 45,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4672FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditarEmprendimientoScreen(
                                  emprendimiento: widget.emprendimiento)),
                        );
                      },
                      child: const Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Titulo de emprendimiento
            Positioned.fill(
              top: 100,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  widget.emprendimiento.nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                ),
              ),
            ),

            //Detalles de emprendimiento
            Positioned(
              top: 200,
              left: 20,
              right: 20,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 8, 0),
                                    child: Icon(
                                      Icons.info_rounded,
                                      color: AppTheme.of(context).secondaryText,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    'Detalles Emprendimiento',
                                    style: AppTheme.of(context).title1.override(
                                          fontFamily:
                                              AppTheme.of(context).title1Family,
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 20,
                                        ),
                                  ),
                                ],
                              ),
                              collapsed: const Divider(
                                thickness: 1.5,
                                color: Color(0xFF8B8B8B),
                              ),
                              expanded: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: const Color(0x1C4672FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Text(
                                          'Descripción del emprendimiento',
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: AutoSizeText(
                                          maybeHandleOverflow(
                                              widget.emprendimiento.descripcion,
                                              100,
                                              "..."),
                                          textAlign: TextAlign.start,
                                          maxLines: 4,
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Text(
                                          'Emprendedor',
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Text(
                                          emprendedor == ""
                                              ? 'SIN EMPRENDEDOR'
                                              : emprendedor,
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      // getImage(widget.emprendimiento.emprendedor.target?.imagen ?? null)!,
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Text(
                                          'Fecha de creación',
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 5),
                                        child: AutoSizeText(
                                          dateTimeFormat(
                                              'dd/MM/yyyy',
                                              widget.emprendimiento
                                                  .fechaRegistro),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                        child: Text(
                                          'Creado por promotor',
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 5),
                                        child: AutoSizeText(
                                          "${usuarioProvider.usuarioCurrent!.nombre} ${usuarioProvider.usuarioCurrent!.apellidoP}",
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
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
                                    ExpandablePanelHeaderAlignment.center,
                                hasIcon: true,
                                iconColor: AppTheme.of(context).secondaryText,
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
                            initialExpanded: false,
                            child: ExpandablePanel(
                              header: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 8, 0),
                                    child: FaIcon(
                                      FontAwesomeIcons.calendarCheck,
                                      color: AppTheme.of(context).secondaryText,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    'Jornadas',
                                    style: AppTheme.of(context).title1.override(
                                          fontFamily:
                                              AppTheme.of(context).title1Family,
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 20,
                                        ),
                                  ),
                                ],
                              ),
                              collapsed: const Divider(
                                thickness: 1.5,
                                color: Color(0xFF8B8B8B),
                              ),
                              expanded: Builder(
                                builder: (context) {
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: jornadas.length,
                                    itemBuilder: (context, index) {
                                      final jornada = jornadas[index];
                                      return Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(15, 10, 15, 0),
                                        child: InkWell(
                                          onTap: () {
                                            // await Navigator
                                            //     .push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder:
                                            //         (context) =>
                                            //             DetalleJornadaWidget(
                                            //       proyectoDocRef:
                                            //           listViewJornadasRecord
                                            //               .refemprendimiento,
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF1F68CB),
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  color: Color(0x32000000),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          16, 5, 16, 5),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            0, 5, 0, 0),
                                                    child: Text(
                                                      'Jornada No. ${jornada.numJornada.toString()}',
                                                      maxLines: 1,
                                                      style: AppTheme.of(
                                                              context)
                                                          .title3
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          16, 0, 16, 5),
                                                  child: Text(
                                                    'Fecha de registro: ${dateTimeFormat('dd/MM/yyyy', jornada.fechaRegistro)}',
                                                    maxLines: 1,
                                                    style: AppTheme.of(context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          16, 0, 16, 5),
                                                  child: Text(
                                                    'Próxima visita: ${dateTimeFormat('dd/MM/yyyy', jornada.proximaVisita)}',
                                                    maxLines: 1,
                                                    style: AppTheme.of(context)
                                                        .bodyText2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              theme: ExpandableThemeData(
                                tapHeaderToExpand: true,
                                tapBodyToExpand: false,
                                tapBodyToCollapse: false,
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                hasIcon: true,
                                iconColor: AppTheme.of(context).secondaryText,
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
                            initialExpanded: false,
                            child: ExpandablePanel(
                              header: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 8, 0),
                                    child: Icon(
                                      Icons.folder_rounded,
                                      color: AppTheme.of(context).secondaryText,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    'Consultorías',
                                    style: AppTheme.of(context).title1.override(
                                          fontFamily:
                                              AppTheme.of(context).title1Family,
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 20,
                                        ),
                                  ),
                                ],
                              ),
                              collapsed: const Divider(
                                thickness: 1.5,
                                color: Color(0xFF8B8B8B),
                              ),
                              expanded: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: consultorias.length,
                                        itemBuilder: (context, index) {
                                          final consultoria =
                                              consultorias[index];
                                          return Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(15, 10, 15, 0),
                                            child: InkWell(
                                              onTap: () {
                                                // await Navigator
                                                //     .push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder:
                                                //         (context) =>
                                                //             DetalleJornadaWidget(
                                                //       proyectoDocRef:
                                                //           listViewConsultoriasRecord
                                                //               .refemprendimiento,
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF1F68CB),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      blurRadius: 4,
                                                      color: Color(0x32000000),
                                                      offset: Offset(0, 2),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              16, 5, 16, 5),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                0, 5, 0, 0),
                                                        child: Text(
                                                          'Consultoría No. ${consultoria.id}',
                                                          maxLines: 1,
                                                          style: AppTheme.of(
                                                                  context)
                                                              .title3
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              16, 0, 16, 5),
                                                      child: Text(
                                                        'Emprendedor: ${consultoria.emprendimiento.target?.emprendedor.target?.nombre ?? "Sin Emprendedor"}',
                                                        maxLines: 1,
                                                        style:
                                                            AppTheme.of(context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              16, 0, 16, 5),
                                                      child: Text(
                                                        'Registro: ${dateTimeFormat('dd/MM/yyyy', consultoria.fechaRegistro)}',
                                                        maxLines: 1,
                                                        style:
                                                            AppTheme.of(context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              theme: ExpandableThemeData(
                                tapHeaderToExpand: true,
                                tapBodyToExpand: false,
                                tapBodyToCollapse: false,
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                hasIcon: true,
                                iconColor: AppTheme.of(context).secondaryText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Menu inferior
            Positioned.fill(
              bottom: 30,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Material(
                  color: Colors.transparent,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xCF4672FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (widget.emprendimiento.emprendedor.target ==
                                    null) {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AgregarEmprendedorScreen(
                                        idEmprendimiento:
                                            widget.emprendimiento.id,
                                        nombreEmprendimiento:
                                            widget.emprendimiento.nombre,
                                      ),
                                    ),
                                  );
                                } else {
                                  snackbarKey.currentState
                                      ?.showSnackBar(const SnackBar(
                                    content: Text(
                                        "Ya hay un emprendedor registrado a este emprendimiento"),
                                  ));
                                }
                              },
                              child: const Icon(
                                Icons.groups_sharp,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Text(
                              'Emprendedores',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  // MaterialPageRoute(
                                  //   builder: (context) => AgregarJornadaScreen(
                                  //     idEmprendimiento:
                                  //         widget.emprendimiento.id,
                                  //     nombreEmprendimiento:
                                  //         widget.emprendimiento.nombre,
                                  //   ),
                                  // ),
                                  MaterialPageRoute(
                                    builder: (context) => const AgregarJornadaScreen(
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.folder_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Text(
                              'Jornada',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AgregarConsultoriaScreen(
                                      idEmprendimiento:
                                          widget.emprendimiento.id,
                                      nombreEmprendimiento:
                                          widget.emprendimiento.nombre,
                                      nombreEmprendedor: widget.emprendimiento
                                              .emprendedor.target?.nombre ??
                                          "SIN EMPRENDEDOR",
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.work_outlined,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Text(
                              'Consultoría',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // await Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         InversionWidget(
                                //       infoEmprendimiento:
                                //           widget.proyectoDocRef,
                                //     ),
                                //   ),
                                // );
                              },
                              child: const Icon(
                                Icons.stacked_line_chart_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            Text(
                              'Inversión',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.attach_money_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            Text(
                              'Ventas',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
