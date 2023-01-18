import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/save_instruccion_producto_inversion_j3_temporal.dart';
import 'package:bizpro_app/screens/jornadas/registros/editar_inversion_jornada.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/services.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';

import 'package:bizpro_app/providers/database_providers/producto_inversion_jornada_controller.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';

import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class AgregarProductoInversionJornadaScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;
  final Jornadas jornada;
  final Inversiones inversion;
  final String emprendedor;
  final String porcentajePago;

  const AgregarProductoInversionJornadaScreen({
    Key? key,
    required this.emprendimiento,
    required this.jornada,
    required this.inversion,
    required this.emprendedor,
    required this.porcentajePago,
  }) : super(key: key);

  @override
  _AgregarProductoInversionJornadaScreenState createState() =>
      _AgregarProductoInversionJornadaScreenState();
}

class _AgregarProductoInversionJornadaScreenState
    extends State<AgregarProductoInversionJornadaScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String familia = "";
  String tipoEmpaque = "";
  XFile? image;
  String emprendedor = "";
  List<String> listFamilias = [];
  List<String> listTipoEmpaque = [];
  TextEditingController porcentajeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tipoEmpaque = "";
    emprendedor = "";
    listTipoEmpaque = [];

    dataBase.tipoEmpaquesBox.getAll().forEach((element) {
      listTipoEmpaque.add(element.tipo);
    });
    listTipoEmpaque
        .sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    emprendedor = widget.emprendedor;
    porcentajeController = TextEditingController(text: widget.porcentajePago);
  }

  @override
  Widget build(BuildContext context) {
    final productoInversionJornadaController =
        Provider.of<ProductoInversionJornadaController>(context);
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
                                          emprendimiento: widget.emprendimiento,
                                          jornada: widget.jornada,
                                          prodSolicitados:
                                              productoInversionJornadaController
                                                  .listProdSolicitadosActual,
                                          inversion: widget.inversion,
                                        ),
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
                                                        .fromSTEB(5, 0, 5, 10),
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
                                                      productoInversionJornadaController
                                                          .imagen = image!.path;
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
                                                              image?.path),
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
                                                  familia = val!;
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
                                          if (familia == "" ||
                                              familia.isEmpty) {
                                            return 'Para continuar, seleccione una familia.';
                                          }
                                          return null;
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          maxLength: 50,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (value) {
                                            productoInversionJornadaController
                                                .producto = value;
                                          },
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
                                          validator: (value) {
                                            return capitalizadoCharacters
                                                    .hasMatch(value ?? '')
                                                ? null
                                                : 'Para continuar, ingrese el producto empezando por mayúscula';
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          maxLength: 500,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (value) {
                                            productoInversionJornadaController
                                                .descripcion = value;
                                          },
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
                                          validator: (value) {
                                            return capitalizadoCharacters
                                                    .hasMatch(value ?? '')
                                                ? null
                                                : 'Para continuar, ingrese la descripción empezando por mayúscula';
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          maxLength: 50,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (value) {
                                            productoInversionJornadaController
                                                .marcaSugerida = value;
                                          },
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
                                          maxLength: 50,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (value) {
                                            productoInversionJornadaController
                                                .proveedorSugerido = value;
                                          },
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
                                                  tipoEmpaque = val!;
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
                                              hintText: 'Tipo de Empaque*',
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
                                          if (tipoEmpaque == "" ||
                                              tipoEmpaque.isEmpty) {
                                            return 'Para continuar, seleccione un tipo de empaque.';
                                          }
                                          return null;
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          maxLength: 5,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (value) {
                                            productoInversionJornadaController
                                                .cantidad = value;
                                          },
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
                                                double.tryParse(val!) ?? 0;
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
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (value) {
                                            productoInversionJornadaController
                                                    .costoEstimado =
                                                currencyFormat
                                                    .getUnformattedValue()
                                                    .toStringAsFixed(2);
                                          },
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
                                      print("Desde registro");
                                      if (productoInversionJornadaController
                                          .validateForm(formKey)) {
                                        final actualTipoEmpaque = dataBase
                                            .tipoEmpaquesBox
                                            .query(TipoEmpaques_.tipo
                                                .equals(tipoEmpaque))
                                            .build()
                                            .findFirst();
                                        if (actualTipoEmpaque != null) {
                                          // productoInversionJornadaController.addSingle(idInversion, idFamiliaProd, idTipoEmpaque)
                                          final newProductoSolicitado =
                                              ProdSolicitado(
                                            idInversion: widget.inversion.id,
                                            producto:
                                                productoInversionJornadaController
                                                    .producto,
                                            marcaSugerida:
                                                productoInversionJornadaController
                                                    .marcaSugerida,
                                            descripcion:
                                                productoInversionJornadaController
                                                    .descripcion,
                                            proveedorSugerido:
                                                productoInversionJornadaController
                                                    .proveedorSugerido,
                                            cantidad: int.parse(
                                                productoInversionJornadaController
                                                    .cantidad),
                                            costoEstimado: double.parse(
                                                productoInversionJornadaController
                                                    .costoEstimado),
                                            idEmprendimiento:
                                                widget.emprendimiento.id,
                                          );
                                          newProductoSolicitado.tipoEmpaques
                                              .target = actualTipoEmpaque;
                                          newProductoSolicitado.inversion
                                              .target = widget.inversion;
                                          final newInstruccionProdInversionJ3 =
                                              SaveInstruccionProductoInversionJ3Temporal(
                                            instruccion:
                                                "syncAddProductoInversionJ3",
                                            prodSolicitado:
                                                newProductoSolicitado,
                                          );
                                          productoInversionJornadaController
                                              .listProdSolicitadosActual
                                              .add(newProductoSolicitado);
                                          productoInversionJornadaController
                                              .instruccionesProdInversionJ3Temp
                                              .add(
                                                  newInstruccionProdInversionJ3);
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditarInversionJornadaScreen(
                                                emprendimiento:
                                                    widget.emprendimiento,
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
                                    text: 'Agregar',
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
