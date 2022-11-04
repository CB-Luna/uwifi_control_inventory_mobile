import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/screens/productos/producto_emprendedor_actualizado.dart';
import 'package:bizpro_app/providers/database_providers/producto_emprendedor_controller.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';

class EditarProductoEmprendedorScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;
  final ProductosEmp productoEmprendedor;
  const EditarProductoEmprendedorScreen({
    Key? key, 
    required this.emprendimiento, 
    required this.productoEmprendedor
    }) : super(key: key);

  @override
  _EditarProductoEmprendedorScreenState createState() =>
      _EditarProductoEmprendedorScreenState();
}

class _EditarProductoEmprendedorScreenState
    extends State<EditarProductoEmprendedorScreen> {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final formKey = GlobalKey<FormState>();
    XFile? image;
    late String newImagen;
    String unidadMedida = "";
    List<String> listUnidadesMedida = [];

    late TextEditingController nombreController;
    late TextEditingController descController;
    late TextEditingController costoController;

  @override
  void initState() {
    super.initState();
    newImagen = widget.productoEmprendedor.imagen.target?.path ?? "";
    nombreController =
        TextEditingController(text: widget.productoEmprendedor.nombre);
    descController =
        TextEditingController(text: widget.productoEmprendedor.descripcion);
    costoController =
        TextEditingController(text: currencyFormat.format(
            widget.productoEmprendedor.costo.toStringAsFixed(2)));
    unidadMedida = widget.productoEmprendedor.unidadMedida.target!.unidadMedida;
    listUnidadesMedida= [];
    dataBase.unidadesMedidaBox.getAll().forEach((element) {
      listUnidadesMedida.add(element.unidadMedida);
    });
    listUnidadesMedida.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
  }

  @override
  Widget build(BuildContext context) {
    final productoEmprendedorProvider =
        Provider.of<ProductoEmprendedorController>(context);
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
                                'Registro productos de Emprendedor',
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
                                    "${widget.
                                    emprendimiento.emprendedor.
                                    target!.nombre} ${widget.
                                    emprendimiento.emprendedor.
                                    target!.apellidos}",
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
                                    widget.
                                    emprendimiento.nombre,
                                    style: AppTheme.of(context).bodyText1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional
                                      .fromSTEB(10, 5, 0, 5),
                                  child: Text(
                                    "Tipo de proyecto: ${widget.emprendimiento.catalogoProyecto.target?.nombre ?? 'SIN TIPO DE PROYECTO'}",
                                    style: AppTheme.of(context).bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                          child: getImageProductoEmprendedor(newImagen, width: double.infinity),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 16, 15, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional
                                    .fromSTEB(5, 0, 5, 10),
                                child: TextFormField(
                                  maxLength: 50,
                                  controller: nombreController,
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
                                  maxLength: 100,
                                  controller: descController,
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
                                  validator: (value) {
                                    return capitalizadoCharacters
                                            .hasMatch(value ?? '')
                                        ? null
                                        : 'Para continuar, ingrese la descripción empezando por mayúscula';
                                  },
                                ),
                              ),
                              FormField(
                                builder: (state) {
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 5, 10),
                                    child: DropDown(
                                      initialOption: unidadMedida,
                                      options: listUnidadesMedida,
                                      onChanged: (val) => setState(() {
                                        unidadMedida = val!;
                                      }),
                                      width: double.infinity,
                                      height: 50,
                                      textStyle: AppTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: const Color(0xFF221573),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      hintText: 'Unidad de medida*',
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xFF221573),
                                        size: 30,
                                      ),
                                      fillColor: Colors.white,
                                      elevation: 2,
                                      borderColor: const Color(0xFF221573),
                                      borderWidth: 2,
                                      borderRadius: 8,
                                      margin: const EdgeInsetsDirectional
                                          .fromSTEB(12, 4, 12, 4),
                                      hidesUnderline: true,
                                    ),
                                  );
                                },
                                validator: (val) {
                                  if (unidadMedida == "" ||
                                      unidadMedida.isEmpty) {
                                    return 'Para continuar, seleccione una unidad de medida.';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional
                                    .fromSTEB(5, 0, 5, 10),
                                child: TextFormField(
                                  maxLength: 10,
                                  controller: costoController,
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Costo de unidad por medida*',
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
                                        'Ingresa el costo...',
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
                                  validator: 
                                  (val) {
                                            if(val!.length > 1){
                                              double costo = double.parse(val.replaceAll('\$', ''));
                                            if (costo == 0) {
                                              return 'Para continuar, ingrese el costo de unidad por medida.';
                                            }

                                            return null;
                                            }
                                            
                                          },
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
                                        if (newImagen !=
                                              widget.productoEmprendedor.imagen.target?.path ||
                                          nombreController.text !=
                                              widget.productoEmprendedor.nombre ||
                                          descController.text !=
                                              widget.productoEmprendedor.descripcion ||
                                          unidadMedida !=
                                              widget.productoEmprendedor.
                                                unidadMedida.target!.unidadMedida ||
                                          costoController.text.replaceAll("\$", "").replaceAll(",", "") !=
                                                widget.productoEmprendedor.costo
                                                    .toStringAsFixed(2)) {
                                        if (productoEmprendedorProvider
                                            .validateForm(formKey)) {
                                          final idUnidadMedida = dataBase.unidadesMedidaBox
                                              .query(UnidadMedida_.unidadMedida
                                                  .equals(unidadMedida))
                                              .build()
                                              .findFirst()
                                              ?.id;
                                          if (idUnidadMedida != null) {
                                                productoEmprendedorProvider.update(
                                                    widget.productoEmprendedor.id,
                                                    nombreController.text,
                                                    descController.text,
                                                    newImagen,
                                                    costoController.text.replaceAll("\$", "").replaceAll(",", ""),
                                                    idUnidadMedida);
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ProductoEmprendedorActualizado(),
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
                                      } 
                                      },
                                      text: 'Actualizar',
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
