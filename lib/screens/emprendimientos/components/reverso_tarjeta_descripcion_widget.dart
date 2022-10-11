import 'package:bizpro_app/helpers/constants.dart';
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

DataRow _getDataRow(ProdSolicitado prodSolicitado){
  return DataRow(cells: <DataCell>[
        
        DataCell(Text(prodSolicitado.producto,) ),
        DataCell(Text(prodSolicitado.proveedorSugerido ?? '')),
        DataCell(Text(prodSolicitado.marcaSugerida ?? '')),
        DataCell(Text(prodSolicitado.unidadMedida.target?.unidadMedida ?? "-")),
        DataCell(Text(prodSolicitado.cantidad.toString())),
        DataCell(Text(prodSolicitado.costoEstimado != null ? 
                                  currencyFormat.format(prodSolicitado.costoEstimado!.toStringAsFixed(2))
                                  :
                                  "-")),
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
    double size = 8.0;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          15, 10, 15, 10),
      child: Container(
        width: double.infinity,
        height: 275,
        decoration: BoxDecoration(
          color: widget.emprendimiento.faseEmp.last.fase == "Detenido" ?
          const Color.fromARGB(207, 255, 64, 128)
          :
          widget.emprendimiento.faseEmp.last.fase == "Consolidado" ?
          const Color.fromARGB(207, 38, 128, 55)
          :
          const Color(0xB14672FF),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x32000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
      child: DataTable(columns: <DataColumn>[
          DataColumn(
              label: Expanded(
                  child: Text(
            'Producto',
            style: AppTheme.of(context).bodyText1.override(
                fontFamily: AppTheme.of(context).bodyText1Family,
                fontSize: 10.0,
                useGoogleFonts: GoogleFonts.asMap()
                    .containsKey(AppTheme.of(context).bodyText1Family),
                color: Colors.black),
          ))),
          DataColumn(
            label: Expanded(
                child: Text('Proveedor\nSugerido',
                    textAlign: TextAlign.center,
                    style: AppTheme.of(context).bodyText1.override(
                        fontFamily: AppTheme.of(context).bodyText1Family,
                        fontSize: size,
                        useGoogleFonts: GoogleFonts.asMap()
                            .containsKey(AppTheme.of(context).bodyText1Family),
                        color: Colors.black))),
          ),
          DataColumn(
            label:Expanded(
              child:Text(
                'Marca\nSugerida',
                              textAlign: TextAlign.center,
                              style: AppTheme.of(
                                      context)
                                  .bodyText1
                                  .override(
                                    fontFamily:
                                        AppTheme.of(
                                                context)
                                            .bodyText1Family,
                                    fontSize: size,
                                    useGoogleFonts: GoogleFonts
                                            .asMap()
                                        .containsKey(
                                            AppTheme.of(
                                                    context)
                                                .bodyText1Family),
                                    color: Colors.black
                                  ),
              )
            )
          ),
          DataColumn(
              label: Expanded(
                  child: Text('Unidad de\nmedida',
                      textAlign: TextAlign.center,
                      style: AppTheme.of(context).bodyText1.override(
                          fontFamily: AppTheme.of(context).bodyText1Family,
                          fontSize: size,
                          useGoogleFonts: GoogleFonts.asMap()
                              .containsKey(AppTheme.of(context).bodyText1Family),
                          color: Colors.black)))),
          DataColumn(
              label: Expanded(
                  child: Text(
            'Cantidad',
            style: AppTheme.of(context).bodyText1.override(
                fontFamily: AppTheme.of(context).bodyText1Family,
                fontSize: size,
                useGoogleFonts: GoogleFonts.asMap()
                    .containsKey(AppTheme.of(context).bodyText1Family),
                color: Colors.black),
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
                color: Colors.black),
          ))),

        ], rows:
            List.generate(listProdSolicitados.length, (index) => _getDataRow(listProdSolicitados[index])),),
    ),
    );
    
  }
}
