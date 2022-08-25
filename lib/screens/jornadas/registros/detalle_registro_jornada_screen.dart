import 'dart:io';
import 'package:bizpro_app/screens/jornadas/registros/editar_detalle_registro_jornada.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/providers/database_providers/registro_controller.dart';
import 'package:bizpro_app/theme/theme.dart';

class DetalleRegistroJornadaScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;
  
  const DetalleRegistroJornadaScreen({
    Key? key,
    required this.emprendimiento,
  }) : super(key: key);


  @override
  _DetalleRegistroJornadaScreenState createState() =>
      _DetalleRegistroJornadaScreenState();
}

class _DetalleRegistroJornadaScreenState
    extends State<DetalleRegistroJornadaScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<ProductosEmp> listRegistros = [];

  @override
  Widget build(BuildContext context) {
    final registroController = Provider.of<RegistroController>(context);
    listRegistros = [];
    listRegistros = registroController.productosEmp;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
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
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Container(
                    width: double.infinity,
                    height: 200,
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
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 45, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);
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
                                                fontFamily:
                                                    AppTheme.of(context)
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
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: Container(
                                  width: 45,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(
                                        Icons.edit_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.emprendimiento.nombre,
                            maxLines: 1,
                            style:
                                AppTheme.of(context).subtitle2.override(
                                      fontFamily: AppTheme.of(context)
                                          .subtitle2Family,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: listRegistros.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditarDetalleRegistroJornada(productoEmp: listRegistros[index]),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        decoration: BoxDecoration(
                                          color: const Color(0x484672FF),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                                        0, 5, 15, 0),
                                                    child: Text(
                                                      'TOTAL',
                                                      style: AppTheme.of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                AppTheme.of(context)
                                                                    .bodyText1Family,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                                        0, 5, 15, 5),
                                                    child: AutoSizeText(
                                                      '\$TOTAL',
                                                      textAlign: TextAlign.start,
                                                      maxLines: 1,
                                                      style: AppTheme.of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                AppTheme.of(context)
                                                                    .bodyText1Family,
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                                child: Text(
                                                  'Familia',
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        fontSize: 15,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                                child: AutoSizeText(
                                                  'Familia',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 4,
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                                child: Text(
                                                  'Producto',
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        fontSize: 15,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                                child: Text(
                                                  listRegistros[index].nombre,
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                                child: Text(
                                                  'Descripción',
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        fontSize: 15,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 5),
                                                child: AutoSizeText(
                                                  listRegistros[index].descripcion,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 3,
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                                child: Text(
                                                  'Proveedor Sugerido',
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        fontSize: 15,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 5),
                                                child: AutoSizeText(
                                                  listRegistros[index].proveedor,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                                child: Text(
                                                  'Marca Sugerida',
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        fontSize: 15,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 5),
                                                child: AutoSizeText(
                                                  'marcasigerida',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                                child: Text(
                                                  'Unidad de medida',
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        fontSize: 15,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 5),
                                                child: AutoSizeText(
                                                  'unidadmedida',
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                                child: Text(
                                                  'Cantidad',
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        fontSize: 15,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 5),
                                                child: AutoSizeText(
                                                  listRegistros[index].cantidad.toString(),
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 0),
                                                child: Text(
                                                  'Costo Estimado',
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        fontSize: 15,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 5),
                                                child: AutoSizeText(
                                                  listRegistros[index].costo.toString(),
                                                  textAlign: TextAlign.start,
                                                  maxLines: 1,
                                                  style: AppTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            AppTheme.of(context)
                                                                .bodyText1Family,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                          ),                  
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF2F4F8),
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
          ],
        ),
      ),
    );
  }
}
