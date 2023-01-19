import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/providers/database_providers/cotizacion_controller.dart';
import 'package:bizpro_app/providers/database_providers/producto_emprendedor_controller.dart';
import 'package:bizpro_app/screens/productos/editar_producto_emprendedor.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';

class DetalleCotizacion extends StatefulWidget {
  final ProdCotizados detalleCot;

  const DetalleCotizacion({
    Key? key,
    required this.detalleCot,
  }) : super(key: key);

  @override
  _DetalleCotizacionState createState() => _DetalleCotizacionState();
}

class _DetalleCotizacionState extends State<DetalleCotizacion> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final productoCotizadoProvider = Provider.of<CotizacionController>(context);
    print('que manda: ${widget.detalleCot.productosProv.target!.imagen
                                    .target}');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
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
                        image: widget.detalleCot.productosProv.target!.imagen
                                    .target !=
                                null
                            ? FileImage(File(widget.detalleCot.productosProv
                                .target!.imagen.target!.path!))
                            : Image.asset(
                                "assets/images/animation_500_l3ur8tqa.gif",
                              ).image,
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 45, 16, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).secondaryText,
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
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF4672FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                widget.detalleCot.productosProv.target!.nombre,
                                maxLines: 1,
                                style: AppTheme.of(context).subtitle2.override(
                                      fontFamily:
                                          AppTheme.of(context).subtitle2Family,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: const Color(0x484672FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: Text(
                                        'Nombre Producto',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontSize: 15,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 5),
                                      child: AutoSizeText(
                                        widget.detalleCot.productosProv.target!
                                            .nombre,
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: Text(
                                        'Descripción del producto',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontSize: 15,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: AutoSizeText(
                                        widget.detalleCot.productosProv.target!
                                            .descripcion,
                                        textAlign: TextAlign.start,
                                        maxLines: 4,
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: Text(
                                        'Proveedor',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontSize: 15,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 5),
                                      child: AutoSizeText(
                                        widget.detalleCot.productosProv.target!
                                            .proveedor.target!.nombreFiscal,
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: Text(
                                        'Marca Sugerida',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontSize: 15,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: Text(
                                        widget.detalleCot.productosProv.target!
                                            .marca,
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: Text(
                                        'Unidad de medida',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontSize: 15,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: Text(
                                        widget.detalleCot.productosProv.target!
                                            .unidadMedida.target!.unidadMedida,
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                     Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0,
                                              ),
                                      child: Text('Cantidad',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontSize: 15,
                                            ),
                                    ),        
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0,5,0,0),
                                      child: Text(
                                        widget.detalleCot.cantidad.toString(),
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: Text(
                                        'Costo por unidad de medida',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontSize: 15,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 5),
                                      child: AutoSizeText(
                                        currencyFormat.format(widget.detalleCot.productosProv.target!.costo.toStringAsFixed(2)),
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0,
                                              ),
                                      child: Text('Costo Total',
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
                                                  .bodyText1Family,
                                              fontSize: 15,
                                            ),
                                    ),        
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0,5,0,0),
                                      child: Text(
                                        currencyFormat.format(widget.detalleCot.productosProv.target!.costo.toStringAsFixed(2) * widget.detalleCot.cantidad),
                                        style: AppTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: AppTheme.of(context)
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
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 5, 0, 0),
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
      ),
    );
  }
}
