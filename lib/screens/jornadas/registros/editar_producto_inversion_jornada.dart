import 'dart:convert';
import 'dart:io';

import 'package:taller_alex_app_asesor/modelsPocketbase/temporals/save_instruccion_producto_inversion_j3_temporal.dart';
import 'package:taller_alex_app_asesor/screens/jornadas/registros/editar_inversion_jornada.dart';
import 'package:taller_alex_app_asesor/screens/widgets/bottom_sheet_eliminar_producto.dart';
import 'package:taller_alex_app_asesor/screens/widgets/custom_bottom_sheet.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:taller_alex_app_asesor/theme/theme.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/helpers/constants.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/producto_inversion_jornada_controller.dart';
import 'package:taller_alex_app_asesor/screens/widgets/drop_down.dart';

import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';

class EditarProductoInversionJornada extends StatefulWidget {
  final ProdSolicitado productoSol;
  final Jornadas jornada;
  final Emprendimientos emprendimientoActual;
  final Inversiones inversion;

  const EditarProductoInversionJornada({
    Key? key,
    required this.productoSol,
    required this.jornada,
    required this.emprendimientoActual,
    required this.inversion,
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
  String newTipoEmpaque = "";
  String emprendedor = "";
  String? newImagen;
  XFile? image;
  String path = "";
  String base64 = "";
  String nombreImagen = "";
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
    path = "";
    base64 = "";
    nombreImagen = "";
    newImagen = widget.productoSol.imagen.target?.imagenes;
    newFamilia = widget.productoSol.familiaInversion.target!.familiaInversion;
    newTipoEmpaque = widget.productoSol.tipoEmpaques.target!.tipo;
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
    porcentajeController = TextEditingController(
        text: widget.productoSol.inversion.target!.porcentajePago.toString());
    emprendedor = "";
    if (widget.productoSol.inversion.target!.emprendimiento.target!.emprendedor
            .target !=
        null) {
      emprendedor =
          "${widget.productoSol.inversion.target!.emprendimiento.target!.emprendedor.target!.nombre} ${widget.productoSol.inversion.target!.emprendimiento.target!.emprendedor.target!.apellidos}";
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.productoSol.costoEstimado.toString());
    final productoInversionJornadaController =
        Provider.of<ProductoInversionJornadaController>(context);
    List<String> listFamilias = [];
    List<String> listTipoEmpaque = [];
    dataBase.familiaInversionBox.getAll().forEach((element) {
      if (element.activo) {
        listFamilias.add(element.familiaInversion);
      }
    });
    listFamilias.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    dataBase.tipoEmpaquesBox.getAll().forEach((element) {
      listTipoEmpaque.add(element.tipo);
    });
    listTipoEmpaque.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                    prodSolicitados:
                                                        productoInversionJornadaController
                                                            .listProdSolicitadosActual,
                                                    jornada: widget.jornada,
                                                    emprendimiento: widget
                                                        .emprendimientoActual,
                                                    inversion:
                                                        widget.inversion),
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
                                    String? option = await showModalBottomSheet(
                                      context: context,
                                      builder: (_) =>
                                          const BottomSheetEliminarProducto(),
                                    );
                                    if (option == 'eliminar') {
                                      // productoInversionJornadaController.remove(widget.productoSol);
                                      productoInversionJornadaController
                                          .listProdSolicitadosActual
                                          .remove(widget.productoSol);
                                      final newInstruccionProdInversionJ3 =
                                          SaveInstruccionProductoInversionJ3Temporal(
                                        instruccion:
                                            "syncDeleteProductoInversionJ3",
                                        prodSolicitado: widget.productoSol,
                                      );
                                      productoInversionJornadaController
                                          .instruccionesProdInversionJ3Temp
                                          .add(newInstruccionProdInversionJ3);
                                      // ignore: use_build_context_synchronously
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditarInversionJornadaScreen(
                                            emprendimiento:
                                                widget.emprendimientoActual,
                                            jornada: widget.jornada,
                                            prodSolicitados:
                                                productoInversionJornadaController
                                                    .listProdSolicitadosActual,
                                            inversion: widget.inversion,
                                          ),
                                        ),
                                      );
                                    } else {
                                      //Se aborta la opción
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
                                      FormField(
                                        builder: (state) {
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(5, 0, 0, 10),
                                                child: InkWell(
                                                  onTap: () async {
                                                    String? option =
                                                        await showModalBottomSheet(
                                                      context: context,
                                                      builder: (_) =>
                                                          const CustomBottomSheet(),
                                                    );

                                                    if (option == null) return;

                                                    final picker =
                                                        ImagePicker();

                                                    late final XFile?
                                                        pickedFile;

                                                    if (option == 'camera') {
                                                      pickedFile = await picker
                                                          .pickImage(
                                                        source:
                                                            ImageSource.camera,
                                                        imageQuality: 50,
                                                      );
                                                    } else {
                                                      pickedFile = await picker
                                                          .pickImage(
                                                        source:
                                                            ImageSource.gallery,
                                                        imageQuality: 50,
                                                      );
                                                    }

                                                    if (pickedFile == null) {
                                                      return;
                                                    }

                                                    setState(() {
                                                      image = pickedFile;
                                                      File file =
                                                          File(image!.path);
                                                      List<int> fileInByte =
                                                          file.readAsBytesSync();
                                                      base64 = base64Encode(
                                                          fileInByte);
                                                      path = image!.path;
                                                      newImagen = image!.path;
                                                      nombreImagen =
                                                          image!.name;
                                                    });
                                                  },
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    height: 180,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xFF221573),
                                                        width: 1.5,
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Lottie.asset(
                                                          'assets/lottie_animations/75669-animation-for-the-photo-optimization-process.json',
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                          height: 180,
                                                          fit: BoxFit.contain,
                                                          animate: true,
                                                        ),
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: getImage(
                                                              newImagen),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
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
                                              hintText: 'Familia de inversión*',
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
                                            return 'Para continuar, seleccione una familia de inversión.';
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
                                              initialOption: newTipoEmpaque,
                                              options: listTipoEmpaque,
                                              onChanged: (val) => setState(() {
                                                if (listTipoEmpaque.isEmpty) {
                                                  snackbarKey.currentState
                                                      ?.showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Debes descargar los catálogos desde la sección de tu perfil"),
                                                  ));
                                                } else {
                                                  newTipoEmpaque = val!;
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
                                              hintText: 'Unidad de Medida*',
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
                                          if (newTipoEmpaque == "" ||
                                              newTipoEmpaque.isEmpty) {
                                            return 'Para continuar, seleccione una unidad de medida.';
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
                                            FilteringTextInputFormatter
                                                .digitsOnly
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
                                            double cantidad =
                                                double.parse(val!);
                                            if (cantidad <= 0) {
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
                                          maxLength: 15,
                                          controller: costoController,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText:
                                                'Costo por unidad estimado*',
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
                                                'Ingresa costo por unidad estimado...',
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
                                          //inputFormatters: [currencyFormat],
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
                                            if (val!.length > 1) {
                                              double costo = double.parse(val
                                                  .replaceAll('\$', '')
                                                  .replaceAll(',', ''));
                                              if (costo <= 0) {
                                                return 'Para continuar, ingrese un costo sugerido.';
                                              }

                                              return null;
                                            }
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
                                            hintText:
                                                'Ingresa porcentaje de pago...',
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
                                            FilteringTextInputFormatter
                                                .digitsOnly,
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
                                      //print("Desde inversion");
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
                                            costoController.text
                                                    .substring(1)
                                                    .replaceAll(",", "") !=
                                                widget.productoSol.costoEstimado
                                                    ?.toStringAsFixed(2) ||
                                            cantidadController.text !=
                                                widget.productoSol.cantidad
                                                    .toString() ||
                                            newFamilia !=
                                                widget
                                                    .productoSol
                                                    .familiaInversion
                                                    .target!
                                                    .familiaInversion ||
                                            newTipoEmpaque !=
                                                widget.productoSol.tipoEmpaques
                                                    .target!.tipo) {
                                          //print("Si se va a actualizar");
                                          if (newImagen !=
                                              widget.productoSol.imagen.target
                                                  ?.imagenes) {
                                            if (widget.productoSol.imagen.target
                                                    ?.path ==
                                                null) {
                                              //print("SE AGREGA IMAGEN NUEVA");
                                              productoInversionJornadaController
                                                  .addImagenProductoSol(
                                                      widget.productoSol,
                                                      nombreImagen,
                                                      path,
                                                      base64,
                                                      widget
                                                          .emprendimientoActual
                                                          .id);
                                            } else {
                                              //print("SE ACTUALIZA IMAGEN NUEVA");
                                              productoInversionJornadaController
                                                  .updateImagenProductoSol(
                                                      widget.productoSol,
                                                      widget.productoSol.imagen
                                                          .target!.id,
                                                      nombreImagen,
                                                      path,
                                                      base64);
                                            }
                                          }
                                          final nuevaFamiliaInversion = dataBase
                                                .familiaInversionBox
                                                .query(FamiliaInversion_.familiaInversion
                                                    .equals(newFamilia))
                                                .build()
                                                .findFirst();
                                          final nuevoTipoEmpaque = dataBase
                                              .tipoEmpaquesBox
                                              .query(TipoEmpaques_.tipo
                                                  .equals(newTipoEmpaque))
                                              .build()
                                              .findFirst();
                                          if (nuevaFamiliaInversion != null &&
                                              nuevoTipoEmpaque != null) {
                                            final indexUpdateProdSolicitado =
                                                productoInversionJornadaController
                                                    .listProdSolicitadosActual
                                                    .indexOf(
                                                        widget.productoSol);
                                            productoInversionJornadaController
                                                    .listProdSolicitadosActual[
                                                        indexUpdateProdSolicitado]
                                                    .marcaSugerida =
                                                marcaController.text;
                                            productoInversionJornadaController
                                                    .listProdSolicitadosActual[
                                                        indexUpdateProdSolicitado]
                                                    .proveedorSugerido =
                                                proveedorController.text;
                                            productoInversionJornadaController
                                                    .listProdSolicitadosActual[
                                                        indexUpdateProdSolicitado]
                                                    .cantidad =
                                                int.parse(
                                                    cantidadController.text);
                                            productoInversionJornadaController
                                                    .listProdSolicitadosActual[
                                                        indexUpdateProdSolicitado]
                                                    .costoEstimado =
                                                double.parse(costoController
                                                    .text
                                                    .replaceAll("\$", "")
                                                    .replaceAll(",", ""));
                                            productoInversionJornadaController
                                                .listProdSolicitadosActual[
                                                    indexUpdateProdSolicitado]
                                                .tipoEmpaques
                                                .target = nuevoTipoEmpaque;
                                            productoInversionJornadaController
                                                .listProdSolicitadosActual[
                                                    indexUpdateProdSolicitado]
                                                .familiaInversion
                                                .target = nuevaFamiliaInversion;
                                            final newInstruccionProdInversionJ3 =
                                                SaveInstruccionProductoInversionJ3Temporal(
                                              instruccion:
                                                  "syncUpdateProductoInversionJ3",
                                              prodSolicitado:
                                                  productoInversionJornadaController
                                                          .listProdSolicitadosActual[
                                                      indexUpdateProdSolicitado],
                                            );
                                            productoInversionJornadaController
                                                .instruccionesProdInversionJ3Temp
                                                .add(
                                                    newInstruccionProdInversionJ3);
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditarInversionJornadaScreen(
                                                  emprendimiento: widget
                                                      .emprendimientoActual,
                                                  jornada: widget.jornada,
                                                  prodSolicitados:
                                                      productoInversionJornadaController
                                                          .listProdSolicitadosActual,
                                                  inversion: widget.inversion,
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          if (newImagen !=
                                              widget.productoSol.imagen.target
                                                  ?.imagenes) {
                                            if (widget.productoSol.imagen.target
                                                    ?.path ==
                                                null) {
                                              //print("SE AGREGA IMAGEN NUEVA");
                                              productoInversionJornadaController
                                                  .addImagenProductoSol(
                                                      widget.productoSol,
                                                      nombreImagen,
                                                      path,
                                                      base64,
                                                      widget
                                                          .emprendimientoActual
                                                          .id);
                                            } else {
                                              //print("SE ACTUALIZA IMAGEN NUEVA");
                                              productoInversionJornadaController
                                                  .updateImagenProductoSol(
                                                      widget.productoSol,
                                                      widget.productoSol.imagen
                                                          .target!.id,
                                                      nombreImagen,
                                                      path,
                                                      base64);
                                            }
                                            snackbarKey.currentState
                                                ?.showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Se actualiza éxitosamente la imagen del Producto."),
                                            ));
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditarInversionJornadaScreen(
                                                  emprendimiento: widget
                                                      .emprendimientoActual,
                                                  jornada: widget.jornada,
                                                  prodSolicitados:
                                                      productoInversionJornadaController
                                                          .listProdSolicitadosActual,
                                                  inversion: widget.inversion,
                                                ),
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
