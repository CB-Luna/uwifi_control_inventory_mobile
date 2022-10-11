import 'package:bizpro_app/screens/jornadas/registros/editar_inversion_jornada.dart';
import 'package:bizpro_app/screens/jornadas/registros/producto_jornada_eliminado.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_eliminar_producto.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/providers/database_providers/producto_inversion_jornada_controller.dart';
import 'package:bizpro_app/screens/jornadas/registros/producto_jornada_actualizado.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';

import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';


class EditarProductoInversionJornada extends StatefulWidget {
  final ProdSolicitado productoSol;
  final Jornadas jornada;
  final Emprendimientos emprendimientoActual;

  const EditarProductoInversionJornada({
    Key? key,
    required this.productoSol, 
    required this.jornada, required this.emprendimientoActual,
  }) : super(key: key);

  @override
  _EditarProductoInversionJornadaState createState() =>
      _EditarProductoInversionJornadaState();
}

class _EditarProductoInversionJornadaState
    extends State<EditarProductoInversionJornada> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String newFamilia = "";
  String newTipoEmpaques = "";
  String emprendedor = "";
  String? newImagen;
  XFile? image;
  late TextEditingController productoController;
  late TextEditingController descripcionController;
  late TextEditingController marcaController;
  late TextEditingController proveedorController;
  late TextEditingController costoController;
  late TextEditingController cantidadController;
  late TextEditingController porcentajeController;

  @override
  void initState() {
    super.initState();
    newImagen = widget.productoSol.imagen.target?.imagenes;
    newFamilia = widget.productoSol.familiaProducto.target!.nombre;
    newTipoEmpaques = widget.productoSol.tipoEmpaques.target!.tipo;
    productoController =
        TextEditingController(text: widget.productoSol.producto);
    descripcionController =
        TextEditingController(text: widget.productoSol.descripcion);
    marcaController =
        TextEditingController(text: widget.productoSol.marcaSugerida);
    proveedorController =
        TextEditingController(text: widget.productoSol.proveedorSugerido);
    costoController = TextEditingController(
        text: currencyFormat.format(
            widget.productoSol.costoEstimado?.toStringAsFixed(2) ?? ""));
    cantidadController =
        TextEditingController(text: widget.productoSol.cantidad.toString());
    porcentajeController = 
        TextEditingController(text: widget.productoSol.inversion.target!.porcentajePago.toString());
    emprendedor = "";
    if (widget.productoSol.inversion.target!.emprendimiento.target!.emprendedor.target != null) {
      emprendedor =
          "${widget.productoSol.
          inversion.target!.emprendimiento.
          target!.emprendedor.target!.nombre} ${widget.productoSol
          .inversion.target!.emprendimiento.
          target!.emprendedor.target!.apellidos}";
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.productoSol.costoEstimado.toString());
    final productoInversionJornadaController =
        Provider.of<ProductoInversionJornadaController>(context);
    List<String> listFamilias = [];
    List<String> listTipoEmpaques = [];
    dataBase.familiaProductosBox.getAll().forEach((element) {
      listFamilias.add(element.nombre);
    });
    listFamilias.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    dataBase.tipoEmpaquesBox.getAll().forEach((element) {
      listTipoEmpaques.add(element.tipo);
    });
    listTipoEmpaques.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
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
              Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 40, 20, 0),
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
                                            builder: (context) =>
                                                EditarInversionJornadaScreen(
                                                    inversion: 
                                                        widget.productoSol.inversion.target!,
                                                    jornada:
                                                        widget.jornada,
                                                    emprendimiento: widget.emprendimientoActual),
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
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 40, 20, 0),
                              child: Container(
                                width: 45,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4672FF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    String? option =
                                        await showModalBottomSheet(
                                      context: context,
                                      builder: (_) =>
                                          const BottomSheetEliminarProducto(),
                                    );
                                    if (option == 'eliminar') {
                                      productoInversionJornadaController.remove(widget.productoSol);
                                      // double totalVentas = 0.00;
                                      // Ventas venta = widget.prodVendido.venta.target!;
                                      // List<ProdVendidos> productosVenta = venta.prodVendidos.toList();
                                      // for (var i = 0; i < productosVenta.length; i++) {
                                      //   totalVentas += productosVenta[i].subtotal;
                                      // }
                                      // ventaProvider.update(
                                      //   venta.id,
                                      //   venta.fechaInicio,
                                      //   venta.fechaTermino,
                                      //   totalVentas,
                                      //   );
                                      // ignore: use_build_context_synchronously
                                      await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (context) =>
                                           ProductoJornadaEliminado(jornada: 
                                              widget.jornada,
                                              emprendimientoActual: widget.emprendimientoActual,
                                              ),
                                            ),
                                      );
                                    } else { //Se aborta la opción
                                      return;
                                    }
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Inversión Sugerida',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          AppTheme.of(context).bodyText1Family,
                                      fontSize: 20,
                                    ),
                              ),
                            ],
                          ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FormField(builder: (state) {
                                        return Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 5, 10),
                                              child: InkWell(
                                                onTap: () async {
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
                                                    image = pickedFile;
                                                    newImagen =
                                                        image!.path;
                                                  });
                                                },
                                                child: Container(
                                                  width:
                                                      MediaQuery.of(context).size.width * 0.9,
                                                  height: 180,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(
                                                      color: const Color(0xFF221573),
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Lottie.asset(
                                                        'assets/lottie_animations/75669-animation-for-the-photo-optimization-process.json',
                                                        width: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        height: 180,
                                                        fit: BoxFit.contain,
                                                        animate: true,
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(8),
                                                        child: getImage(newImagen),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          initialValue: emprendedor,
                                          enabled: false,
                                          readOnly: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Emprendedor*',
                                            labelStyle: AppTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: AppTheme.of(context)
                                                      .secondaryText,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                            hintText: 'Ingresa emprendedor...',
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
                                        ),
                                      ),
                                      FormField(
                                        builder: (state) {
                                          return Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(5, 0, 5, 10),
                                            child: DropDown(
                                              initialOption: newFamilia,
                                              options: listFamilias,
                                              onChanged: (val) => setState(() {
                                                if (listFamilias.isEmpty) {
                                                  snackbarKey.currentState
                                                      ?.showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Debes descargar los catálogos desde la sección de tu perfil"),
                                                  ));
                                                } else {
                                                  newFamilia = val!;
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
                                              hintText: 'Familia del producto*',
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
                                          if (newFamilia == "" ||
                                              newFamilia.isEmpty) {
                                            return 'Para continuar, seleccione una familia.';
                                          }
                                          return null;
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          enabled: false,
                                          readOnly: true,
                                          controller: productoController,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Producto*',
                                            labelStyle: AppTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: AppTheme.of(context)
                                                      .secondaryText,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                            hintText: 'Ingresa producto...',
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
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          enabled: false,
                                          readOnly: true,
                                          controller: descripcionController,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Descripción*',
                                            labelStyle: AppTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: AppTheme.of(context)
                                                      .secondaryText,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                            hintText: 'Descripción...',
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
                                          style: AppTheme.of(context)
                                              .title3
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: AppTheme.of(context)
                                                    .primaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                          maxLines: 3,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          controller: marcaController,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Marca sugerida',
                                            labelStyle: AppTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: AppTheme.of(context)
                                                      .secondaryText,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                            hintText: 'Marca sugerida...',
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
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          controller: proveedorController,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Proveedor sugerido',
                                            labelStyle: AppTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: AppTheme.of(context)
                                                      .secondaryText,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                            hintText: 'Proveedor sugerido...',
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
                                        ),
                                      ),
                                      // Form(
                                      FormField(
                                        builder: (state) {
                                          return Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(5, 0, 5, 10),
                                            child: DropDown(
                                              initialOption: newTipoEmpaques,
                                              options: listTipoEmpaques,
                                              onChanged: (val) => setState(() {
                                                if (listTipoEmpaques
                                                    .isEmpty) {
                                                  snackbarKey.currentState
                                                      ?.showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Debes descargar los catálogos desde la sección de tu perfil"),
                                                  ));
                                                } else {
                                                  newTipoEmpaques = val!;
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
                                              hintText: 'Tipo de Empaques*',
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
                                          if (newTipoEmpaques == "" ||
                                              newTipoEmpaques.isEmpty) {
                                            return 'Para continuar, seleccione un tipo de empaques.';
                                          }
                                          return null;
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          controller: cantidadController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Cantidad*',
                                            labelStyle: AppTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: AppTheme.of(context)
                                                      .secondaryText,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                            hintText: 'Ingresa cantidad...',
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
                                            if (val == null || val.isEmpty) {
                                              return 'Para continuar, ingrese una cantidad.';
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          controller: costoController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Costo estimado*',
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
                                                'Ingresa costo estimado...',
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
                                              return 'Para continuar, ingrese un costo sugerido.';
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          controller: porcentajeController,
                                          readOnly: true,
                                          enabled: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            suffixText: "%",
                                            suffixStyle: AppTheme.of(context)
                                              .title3
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: AppTheme.of(context)
                                                    .primaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            labelText: 'Porcentaje de pago*',
                                            labelStyle: AppTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: AppTheme.of(context)
                                                      .secondaryText,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                            hintText: 'Ingresa porcentaje de pago...',
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
                                              FilteringTextInputFormatter.digitsOnly,
                                              PercentageTextInputFormatter()
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      print("Desde inversion");
                                      if (productoInversionJornadaController
                                          .validateForm(formKey)) {
                                        if (productoController.text !=
                                                widget.productoSol.producto ||
                                            marcaController.text !=
                                                widget.productoSol
                                                    .marcaSugerida ||
                                            descripcionController.text !=
                                                widget
                                                    .productoSol.descripcion ||
                                            proveedorController.text !=
                                                widget.productoSol
                                                    .proveedorSugerido ||
                                            costoController.text.substring(1) !=
                                                widget.productoSol.costoEstimado
                                                    ?.toStringAsFixed(2) ||
                                            cantidadController.text !=
                                                widget.productoSol.cantidad
                                                    .toString() ||
                                            newFamilia !=
                                                widget
                                                    .productoSol
                                                    .familiaProducto
                                                    .target!
                                                    .nombre ||
                                            newTipoEmpaques !=
                                                widget.productoSol.tipoEmpaques
                                                    .target!.tipo) {
                                          final newIdFamiliaProd = dataBase
                                              .familiaProductosBox
                                              .query(FamiliaProd_.nombre
                                                  .equals(newFamilia))
                                              .build()
                                              .findFirst()
                                              ?.id;
                                          final newIdTipoEmpaques = dataBase
                                              .tipoEmpaquesBox
                                              .query(TipoEmpaques_.tipo
                                                  .equals(newTipoEmpaques))
                                              .build()
                                              .findFirst()
                                              ?.id;
                                          if (newIdFamiliaProd != null &&
                                              newIdTipoEmpaques != null) {
                                              productoInversionJornadaController.update(
                                              widget.productoSol.id,
                                              productoController.text,
                                              marcaController.text,
                                              descripcionController.text,
                                              proveedorController.text,
                                              costoController.text.replaceAll("\$", "").replaceAll(",", ""),
                                              cantidadController.text,
                                              newIdFamiliaProd,
                                              newIdTipoEmpaques,
                                              newImagen ?? ''
                                            );
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProductoJornadaActualizado(),
                                              ),
                                            );
                                          }
                                        }
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Campos vacíos'),
                                              content: const Text(
                                                  'Para continuar, debe llenar los campos solicitados.'),
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
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    options: FFButtonOptions(
                                      width: 150,
                                      height: 50,
                                      color: AppTheme.of(context).secondaryText,
                                      textStyle:
                                          AppTheme.of(context).title3.override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                              ),
                                      elevation: 3,
                                      borderSide: BorderSide(
                                        color:
                                            AppTheme.of(context).secondaryText,
                                        width: 0,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
