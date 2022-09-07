import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/providers/database_providers/venta_controller.dart';
import 'package:bizpro_app/providers/database_providers/producto_venta_controller.dart';
import 'package:bizpro_app/screens/ventas/venta_actualizada.dart';
import 'package:badges/badges.dart';
import 'package:bizpro_app/screens/ventas/registro_venta_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EditarVentaScreen extends StatefulWidget {
  final Ventas venta;

  const EditarVentaScreen({
    Key? key,
    required this.venta,
  }) : super(key: key);

  @override
  _EditarVentaScreenState createState() => _EditarVentaScreenState();
}

class _EditarVentaScreenState extends State<EditarVentaScreen> {
  TextEditingController fechaInicioText = TextEditingController();
  TextEditingController fechaTerminoText = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String emprendedor = "";
  List<ProdVendidos> prodVendidos = [];
  double totalVenta = 0.00;
  late DateTime fechaInicio;
  late DateTime fechaTermino;

  @override
  void initState() {
    super.initState();
    fechaInicioText = TextEditingController(
        text: dateTimeFormat('yMMMd', widget.venta.fechaInicio));
    fechaTerminoText = TextEditingController(
        text: dateTimeFormat('yMMMd', widget.venta.fechaTermino));
    fechaInicio = widget.venta.fechaInicio;
    fechaTermino = widget.venta.fechaTermino;
    emprendedor = "";
    if (widget.venta.emprendimiento.target?.emprendedor != null) {
      emprendedor =
          "${widget.venta.emprendimiento.target!.emprendedor.target!.nombre} ${widget.venta.emprendimiento.target!.emprendedor.target!.apellidos}";
    }
    totalVenta = 0.00;
    for (var element in widget.venta.prodVendidos.toList()) {
      prodVendidos.add(element);
      totalVenta += element.subtotal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ventaProvider =
        Provider.of<VentaController>(context);
    final productoVentaProvider =
        Provider.of<ProductoVentaController>(context);
    String totalProductos =
        widget.venta.prodVendidos.toList().length.toString();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
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
                          image: FileImage(File(widget.venta.emprendimiento.target!.imagen)),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 45, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 10),
                                    child: Container(
                                      width: 80,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            AppTheme.of(context).secondaryText,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          productoVentaProvider.clearInformation();
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
                                  "Edición de Venta",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      AppTheme.of(context).subtitle2.override(
                                            fontFamily: 'Poppins',
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
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 16, 15, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: const Color(0x554672FF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 5, 0, 0),
                                        child: Text(
                                          widget.venta.emprendimiento.target?.nombre ?? "SIN EMPRENDIMIENTO",
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: AppTheme.of(context)
                                                    .bodyText1Family,
                                                color: AppTheme.of(context)
                                                    .primaryText,
                                                fontSize: 18,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 5, 0, 0),
                                        child: Text(
                                          emprendedor == ""
                                              ? "SIN EMPRENDEDOR"
                                              : emprendedor,
                                          style: AppTheme.of(context).bodyText1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                    controller: fechaInicioText,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onTap: () async {
                                      await DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                          setState(() {
                                            fechaInicio =
                                                date;
                                            fechaInicioText.text =
                                                dateTimeFormat('yMMMd', date);
                                          });
                                        },
                                        maxTime: getCurrentTimestamp,
                                      );
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Perido de inicio venta*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingrese el periodo de inicio venta...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    keyboardType: TextInputType.none,
                                    showCursor: false,
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Para continuar, ingrese el periodo de inicio';
                                      }
                                      return null;
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                    controller: fechaTerminoText,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onTap: () async {
                                      await DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                          setState(() {
                                            fechaTermino =
                                                date;
                                            fechaTerminoText.text =
                                                dateTimeFormat('yMMMd', date);
                                          });
                                        },
                                        minTime: getCurrentTimestamp,
                                      );
                                    },
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Periodo de término venta*',
                                      labelStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      hintText: 'Ingresa el periodo de término venta...',
                                      hintStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0x49FFFFFF),
                                    ),
                                    keyboardType: TextInputType.none,
                                    showCursor: false,
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Para continuar, ingrese el periodo de término';
                                      }
                                      return null;
                                    }),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        10, 12, 5, 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Badge(
                                      badgeContent: Text(totalProductos,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      showBadge: true,
                                      badgeColor: const Color(0xFFD20030),
                                      position: BadgePosition.topEnd(),
                                      elevation: 4,
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RegistroVentaScreen(venta: widget.venta,),
                                            ),
                                          );
                                        },
                                        text: 'Producto',
                                        icon: const Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                        options: FFButtonOptions(
                                          width: 150,
                                          height: 35,
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 20, 0, 10),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (ventaProvider
                                      .validateForm(formKey)
                                      && totalProductos != "0") {
                                  if (fechaInicio != 
                                        widget.venta.fechaInicio ||
                                      fechaTermino != 
                                        widget.venta.fechaTermino
                                        ) {
                                      ventaProvider.update(
                                        widget.venta.id,
                                        fechaInicio,
                                        fechaTermino,
                                        totalVenta
                                      );
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const VentaActualizadaScreen(),
                                        ),
                                      );
                                  }
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title:
                                          const Text('Campos vacíos'),
                                      content: const Text(
                                          'Para continuar, debe llenar todos los campos requeridos y agregar un producto de venta.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(
                                                  alertDialogContext),
                                          child: const Text('Bien'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return;
                              }
                            },
                            text: 'Actualizar',
                            icon: const Icon(
                              Icons.check_rounded,
                              size: 15,
                            ),
                            options: FFButtonOptions(
                              width: 130,
                              height: 40,
                              color: AppTheme.of(context).secondaryText,
                              textStyle: AppTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily:
                                        AppTheme.of(context).subtitle2Family,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
