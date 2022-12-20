import 'dart:ffi';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:google_fonts/google_fonts.dart';

class ReversoTarjetaDescripcionWidget extends StatefulWidget {
  final Emprendimientos emprendimiento;
  const ReversoTarjetaDescripcionWidget({
    Key? key,
    required this.emprendimiento,
  }) : super(key: key);

  @override
  State<ReversoTarjetaDescripcionWidget> createState() =>
      _ReversoTarjetaDescripcionWidgetState();
}

DataRow _getDataRow(ProdSolicitado prodSolicitado) {
  double size = 10.0;
  return DataRow(
    cells: <DataCell>[
      DataCell(Text(maybeHandleOverflow(prodSolicitado.producto, 8, "..."),
          style: GoogleFonts.roboto(
              fontSize: size,
              fontWeight: FontWeight.w400,
              color: Colors.white))),
      DataCell(Text(prodSolicitado.proveedorSugerido ?? '',
          style: GoogleFonts.roboto(
              fontSize: size,
              fontWeight: FontWeight.w400,
              color: Colors.white))),
      DataCell(Text(prodSolicitado.marcaSugerida ?? '',
          style: GoogleFonts.roboto(
              fontSize: size,
              fontWeight: FontWeight.w400,
              color: Colors.white))),
      DataCell(Text(prodSolicitado.tipoEmpaques.target!.tipo,
          style: GoogleFonts.roboto(
              fontSize: size,
              fontWeight: FontWeight.w400,
              color: Colors.white))),
      DataCell(Text(prodSolicitado.cantidad.toString(),
          style: GoogleFonts.roboto(
              fontSize: size,
              fontWeight: FontWeight.w400,
              color: Colors.white))),
      DataCell(Text(
          prodSolicitado.costoEstimado != null
              ? currencyFormat
                  .format(prodSolicitado.costoEstimado!.toStringAsFixed(2))
              : "-",
          style: GoogleFonts.roboto(
              fontSize: size,
              fontWeight: FontWeight.w400,
              color: Colors.white))),
    ],
  );
}

class _ReversoTarjetaDescripcionWidgetState
    extends State<ReversoTarjetaDescripcionWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Inversiones? inversionJornada3;
  List<ProdSolicitado> listProdSolicitados = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (widget.emprendimiento.inversiones.isNotEmpty) {
        inversionJornada3 = widget.emprendimiento.inversiones.first;
        if (inversionJornada3 != null) {
          listProdSolicitados = inversionJornada3!.prodSolicitados.toList();
        }
      } else {
        inversionJornada3 = null;
        listProdSolicitados = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = 10.0;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 275,
        decoration: BoxDecoration(
          color: widget.emprendimiento.faseEmp.last.fase == "Detenido"
              ? const Color.fromARGB(207, 255, 64, 128)
              : widget.emprendimiento.faseEmp.last.fase == "Consolidado"
                  ? const Color.fromARGB(207, 38, 128, 55)
                  : const Color(0xB14672FF),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x32000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DataTable(
                columnSpacing: 3.0,
                columns: <DataColumn>[
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    'Producto',
                    style: AppTheme.of(context).bodyText1.override(
                        fontFamily: AppTheme.of(context).bodyText1Family,
                        fontSize: size,
                        useGoogleFonts: GoogleFonts.asMap()
                            .containsKey(AppTheme.of(context).bodyText1Family),
                        color: Colors.white),
                  ))),
                  DataColumn(
                    label: Expanded(
                        child: Text('Proveedor\nSugerido',
                            textAlign: TextAlign.center,
                            style: AppTheme.of(context).bodyText1.override(
                                fontFamily:
                                    AppTheme.of(context).bodyText1Family,
                                fontSize: size,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    AppTheme.of(context).bodyText1Family),
                                color: Colors.white))),
                  ),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    'Marca\nSugerida',
                    textAlign: TextAlign.center,
                    style: AppTheme.of(context).bodyText1.override(
                        fontFamily: AppTheme.of(context).bodyText1Family,
                        fontSize: size,
                        useGoogleFonts: GoogleFonts.asMap()
                            .containsKey(AppTheme.of(context).bodyText1Family),
                        color: Colors.white),
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                              maybeHandleOverflow(
                                  'Unidad\n de medida', 10, "..."),
                              textAlign: TextAlign.center,
                              style: AppTheme.of(context).bodyText1.override(
                                  fontFamily:
                                      AppTheme.of(context).bodyText1Family,
                                  fontSize: size,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(
                                          AppTheme.of(context).bodyText1Family),
                                  color: Colors.white)))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    'Cantidad',
                    style: AppTheme.of(context).bodyText1.override(
                        fontFamily: AppTheme.of(context).bodyText1Family,
                        fontSize: size,
                        useGoogleFonts: GoogleFonts.asMap()
                            .containsKey(AppTheme.of(context).bodyText1Family),
                        color: Colors.white),
                  ))),
                  DataColumn(
                      label: Expanded(
                          child: Text(
                    'Costo\nEstimado',
                    textAlign: TextAlign.center,
                    style: AppTheme.of(context).bodyText1.override(
                        fontFamily: AppTheme.of(context).bodyText1Family,
                        fontSize: size,
                        useGoogleFonts: GoogleFonts.asMap()
                            .containsKey(AppTheme.of(context).bodyText1Family),
                        color: Colors.white),
                  ))),
                ],
                rows: List.generate(listProdSolicitados.length,
                    (index) => _getDataRow(listProdSolicitados[index])),
              ),
              Text(
                  "Monto Total:${inversionJornada3 != null ? currencyFormat.format(inversionJornada3!.totalInversion.toStringAsFixed(2)) : "-"}",
                  textAlign: TextAlign.end,
                  style: AppTheme.of(context).bodyText1.override(
                        fontFamily: AppTheme.of(context).bodyText1Family,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: GoogleFonts.asMap()
                            .containsKey(AppTheme.of(context).bodyText1Family),
                        color: Colors.white,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
