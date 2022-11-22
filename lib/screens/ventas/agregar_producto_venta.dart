import 'package:bizpro_app/modelsPocketbase/temporals/id_prod_emp_nombre_prod_vendido.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/save_instruccion_producto_vendido.dart';
import 'package:bizpro_app/screens/ventas/registro_venta_screen.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/providers/database_providers/producto_venta_controller.dart';

import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class AgregarProductoVenta extends StatefulWidget {
  final Emprendimientos emprendimiento;
  final List<IdProdEmpNombreProdVendido> prodRegistradosEmpVendidos;
  final Ventas venta;
  const AgregarProductoVenta({
    Key? key, 
    required this.emprendimiento, 
    required this.prodRegistradosEmpVendidos,
    required this.venta
    }) : super(key: key);

  @override
  _AgregarProductoVentaState createState() =>
      _AgregarProductoVentaState();
}

class _AgregarProductoVentaState
    extends State<AgregarProductoVenta> {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final formKey = GlobalKey<FormState>();
    int idProductoEmp = -1;
    ProductosEmp? newProductoEmp;
    TextEditingController cantidadVendida = TextEditingController();
    TextEditingController precioVenta =  TextEditingController();
    TextEditingController subTotal =  TextEditingController();
    TextEditingController costoUnitario = TextEditingController();
    String descripcion = "";
    String producto = "";
    TextEditingController unidadMedida = TextEditingController();
    List<String> listProductos = [];
  @override
  void initState() {
    super.initState();
    idProductoEmp = -1;
    descripcion = "";
    cantidadVendida.text = "";
    precioVenta.text =  "";
    subTotal.text = "";
    costoUnitario = TextEditingController();
    producto = "";
    unidadMedida = TextEditingController();
    final productosEmp = widget.emprendimiento.productosEmp.toList();
    for (var i = 0; i < productosEmp.length; i++) {
      var index = widget.prodRegistradosEmpVendidos.indexWhere((element) => element.idProductoEmp == productosEmp[i].id);
      if (index == -1) {
        listProductos.add(productosEmp[i].nombre);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productoVentaProvider =
        Provider.of<ProductoVentaController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFD9EEF9),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/bglogin2.png',
                      ).image,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 45, 20, 0),
                            child: Container(
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
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Registro de producto Venta',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: const Color(0xFF221573),
                                      fontSize: 20,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 16, 15, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormField(
                                builder: (state) {
                                  return Padding(
                                    padding: const EdgeInsetsDirectional
                                        .fromSTEB(5, 0, 5, 10),
                                    child: DropDown(
                                      options: listProductos,
                                      onChanged: (val) => setState(() {
                                        if (listProductos.isEmpty) {
                                          snackbarKey.currentState
                                              ?.showSnackBar(
                                                  const SnackBar(
                                            content: Text(
                                                "Debes agregar productos al emprendimiento desde el módulo 'Productos'"),
                                          ));
                                        } else {
                                          idProductoEmp = -1;
                                          costoUnitario = TextEditingController(text: "");
                                          unidadMedida = TextEditingController(text: "");
                                          descripcion = "";
                                          producto = val!;
                                          dataBase.productosEmpBox
                                              .getAll()
                                              .forEach((element) {
                                            if (element.nombre ==
                                                producto) {
                                              descripcion = element.descripcion;
                                              costoUnitario.text = 
                                                currencyFormat.format(element.costo.toStringAsFixed(2));
                                              unidadMedida.text = 
                                                element.unidadMedida.target!.unidadMedida;
                                              idProductoEmp = 
                                                element.id;
                                              newProductoEmp = element;
                                            }
                                          });
                                        }
                                      }),
                                      width: double.infinity,
                                      height: 50,
                                      textStyle: AppTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Poppins',
                                            color:
                                                const Color(0xFF221573),
                                            fontSize: 15,
                                            fontWeight:
                                                FontWeight.normal,
                                          ),
                                      hintText: 'Producto*',
                                      icon: const Icon(
                                        Icons
                                            .keyboard_arrow_down_rounded,
                                        color: Color(0xFF221573),
                                        size: 30,
                                      ),
                                      fillColor: Colors.white,
                                      elevation: 2,
                                      borderColor:
                                          const Color(0xFF221573),
                                      borderWidth: 2,
                                      borderRadius: 8,
                                      margin:
                                          const EdgeInsetsDirectional
                                              .fromSTEB(12, 4, 12, 4),
                                      hidesUnderline: true,
                                    ),
                                  );
                                },
                                validator: (val) {
                                  if (producto == "" ||
                                      producto.isEmpty) {
                                    return 'Para continuar, seleccione un producto.';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  controller: unidadMedida,
                                  enabled: false,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Unidad de Medida',
                                    labelStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    hintText: 'Unidad de Medida...',
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
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0x49FFFFFF),
                                  ),
                                  style: AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional
                                    .fromSTEB(5, 0, 5, 10),
                                child: TextFormField(
                                  maxLength: 5,
                                  controller: cantidadVendida,
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  onChanged: (value) {
                                    productoVentaProvider.cantidad = value;
                                     try {
                                      if (value != "" && precioVenta.text != "" ) {
                                      subTotal.text = currencyFormat.format((double.parse(value) * double.parse(precioVenta.text.replaceAll("\$", "").replaceAll(",", "")))
                                      .toStringAsFixed(2));
                                      }  
                                    } catch (e) {
                                      null;
                                    }
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Cantidad Vendida*',
                                    labelStyle: AppTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: AppTheme.of(context)
                                              .secondaryText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    hintText: 'Ingresa la cantidad vendida...',
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
                                  inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                  ],
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
                                           
                                               double costo = double.parse(val!.replaceAll('\$', '').replaceAll(',', ''));
                                            if (costo <= 0) {
                                              return 'Para continuar, ingrese una cantidad mayor a 0.';
                                            }

                                            return null;
                                            
                                            
                                          },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  controller: costoUnitario,
                                  enabled: false,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Costo Unitario',
                                    labelStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    hintText: 'Costo Unitario...',
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
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppTheme.of(context).primaryText,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0x49FFFFFF),
                                  ),
                                  style: AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context).primaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional
                                    .fromSTEB(5, 0, 5, 10),
                                child: TextFormField(
                                  maxLength: 10,
                                  controller: precioVenta,
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  onChanged: (value) {
                                    productoVentaProvider.precioVenta = value.replaceAll("\$", "").replaceAll(",", "");
                                    try {
                                      if (value != "" && cantidadVendida.text != "" ) {
                                      subTotal.text = currencyFormat.format((double.parse(value.replaceAll("\$", "").replaceAll(",", "")) * double.parse(cantidadVendida.text)).toStringAsFixed(2));
                                    }  
                                    } catch (e) {
                                      null;
                                    }
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Precio de venta*',
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
                                        'Ingresa el precio de venta...',
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
                                  double precio = (val == null || val == "") ? 0 : double.parse(val.replaceAll("\$", "").replaceAll(",", ""));
                                    if (precio <= 0) {
                                      return 'Para continuar, ingrese un precio.';
                                    }

                                  return null;
                                },
                                ),
                              ),
                              Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 5, 0),
                                    child: Text(
                                      'TOTAL:',
                                      style: AppTheme.of(context)
                                          .bodyText1,
                                    ),
                                  ),
                                  Text(
                                    (cantidadVendida.text == "" 
                                    || precioVenta.text == "") ? 
                                    "\$0.00"
                                    :
                                    currencyFormat.format(subTotal.text),
                                    style: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily:
                                              AppTheme.of(context)
                                                  .bodyText1Family,
                                          color: AppTheme.of(context)
                                              .secondaryText,
                                          fontSize: 22,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        if (productoVentaProvider
                                                .validateForm(formKey)) {
                                          final newUnidadMedida = dataBase.unidadesMedidaBox
                                              .query(UnidadMedida_.unidadMedida
                                                  .equals(unidadMedida.text))
                                              .build()
                                              .findFirst();
                                          if (newUnidadMedida != null) {
                                            final newProductoVendido = ProdVendidos(
                                              nombreProd: producto, 
                                              descripcion: descripcion, 
                                              costo: double.parse(costoUnitario.text.replaceAll("\$", "").replaceAll(",","")),
                                              cantVendida: int.parse(cantidadVendida.text),
                                              subtotal: double.parse(subTotal.text.replaceAll("\$", "").replaceAll(",","")),
                                              precioVenta: double.parse(precioVenta.text.replaceAll("\$", "").replaceAll(",","")),
                                            );
                                            newProductoVendido.productoEmp.target = newProductoEmp;
                                            newProductoVendido.unidadMedida.target = newUnidadMedida;
                                            final newInstruccionProdVendido = SaveInstruccionProductoVendido(
                                              instruccion: "syncAddSingleProductoVendido", 
                                              prodVendido: newProductoVendido,
                                            );
                                            productoVentaProvider
                                              .listProdVendidosActual.add(newProductoVendido);
                                            productoVentaProvider
                                              .instruccionesProdVendido.add(newInstruccionProdVendido);
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistroVentaScreen(
                                                      venta: widget.venta, 
                                                      emprendimiento: widget.emprendimiento, 
                                                      prodVendidos: productoVentaProvider.listProdVendidosActual,
                                                    ),
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
                                                    'Para continuar, debe llenar todos los campos requeridos.'),
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
                                      text: 'Agregar',
                                      icon: const Icon(
                                        Icons.check_rounded,
                                        size: 15,
                                      ),
                                      options: FFButtonOptions(
                                        width: 150,
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
