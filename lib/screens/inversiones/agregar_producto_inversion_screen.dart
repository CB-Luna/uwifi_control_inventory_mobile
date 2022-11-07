import 'dart:convert';
import 'dart:io';

import 'package:bizpro_app/modelsPocketbase/temporals/save_imagenes_local.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bizpro_app/providers/database_providers/inversion_controller.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:bizpro_app/screens/inversiones/producto_inversion_creado.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class AgregarProductoInversionScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;
  final Inversiones inversion;

  const AgregarProductoInversionScreen({
    Key? key, 
    required this.emprendimiento, 
    required this.inversion})
      : super(key: key);

  @override
  _AgregarProductoInversionScreenState createState() =>
      _AgregarProductoInversionScreenState();
}

class _AgregarProductoInversionScreenState
    extends State<AgregarProductoInversionScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController porcentajeController = TextEditingController();
  XFile? image;
  String familia = "";
  String tipoEmpaques = "";
  String emprendedor = "";
  String porcentaje = "";

  @override
  void initState() {
    super.initState();
    familia = "";
    tipoEmpaques = "";
    emprendedor = "";
    porcentaje = widget.inversion.porcentajePago.toString();
    porcentajeController = TextEditingController(text: "50");
    if (widget.emprendimiento.emprendedor.target != null) {
      emprendedor =
          "${widget.emprendimiento.emprendedor.target!.nombre} ${widget.emprendimiento.emprendedor.target!.apellidos}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final inversionProvider =
        Provider.of<InversionController>(context);
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
                                'Inversión',
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
                                FormField(builder: (state) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
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
                                              File file = File(image!.path);
                                              List<int> fileInByte = file.readAsBytesSync();
                                              String base64 = base64Encode(fileInByte);
                                              var newImagenLocal = SaveImagenesLocal(
                                                nombre: image!.name, 
                                                path: image!.path, 
                                                base64: base64);
                                              inversionProvider.imagen = newImagenLocal;
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
                                                  child: getImage(image?.path),
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      15, 16, 15, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                            inversionProvider.nombre = value;
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
                                          maxLength: 50,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (value) {
                                            inversionProvider
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
                                          maxLength: 100,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (value) {
                                            inversionProvider.descripcion =
                                                value;
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
                                            inversionProvider.proveedor =
                                                value;
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
                                      FormField(
                                        builder: (state) {
                                          return Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(5, 0, 5, 10),
                                            child: DropDown(
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
                                                  tipoEmpaques = val!;
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
                                              hintText: 'Tipo de empaque*',
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
                                          if (tipoEmpaques == "" ||
                                              tipoEmpaques.isEmpty) {
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
                                            inversionProvider.cantidad =
                                                value;
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
                                          validator: (value){
                                            double cant = double.parse(value!);
                                            if(cant <= 0){
                                              return 'Para continuar, ingrese una cantidad mayor a 0.';
                                            }
                                          }
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 0, 5, 10),
                                        child: TextFormField(
                                          maxLength: 13,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (value) {
                                            inversionProvider
                                                    .costo =
                                                currencyFormat
                                                    .getUnformattedValue()
                                                    .toStringAsFixed(2);
                                          },
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Costo por unidad estimado',
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
                                          inputFormatters:<TextInputFormatter>[currencyFormat],
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
                                            if(val!.length > 1){
                                               double costo = double.parse(val.replaceAll('\$', '').replaceAll(',', ''));
                                            if (costo <= 0) {
                                              return 'Para continuar, ingrese un costo mayor a 0.';
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
                                          maxLength: 4,
                                          initialValue: porcentaje,
                                          enabled: false,
                                          readOnly: true,
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
                                      0, 20, 0, 20),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      if (inversionProvider
                                          .validateForm(formKey)) {
                                        // comunidadProvider.add();
                                        final idFamiliaProducto = dataBase
                                            .familiaProductosBox
                                            .query(FamiliaProd_.nombre
                                                .equals(familia))
                                            .build()
                                            .findFirst()
                                            ?.id;
                                        final idTipoEmpaques = dataBase
                                            .tipoEmpaquesBox
                                            .query(TipoEmpaques_.tipo
                                                .equals(tipoEmpaques))
                                            .build()
                                            .findFirst()
                                            ?.id;
                                        if (idFamiliaProducto != null && idTipoEmpaques != null) {
                                          inversionProvider.addProductoSolicitado(
                                              widget.emprendimiento.id,
                                              widget.inversion.id,
                                              idFamiliaProducto,
                                              idTipoEmpaques
                                              );
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductoInversionCreado(
                                                    emprendimiento: widget.emprendimiento, 
                                                    idInversion: widget.inversion.id,),
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
                                const SizedBox(height: 50),
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
