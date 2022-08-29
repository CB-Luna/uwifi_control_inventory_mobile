import 'dart:ffi';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/providers/database_providers/registro_jornada_controller.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:provider/provider.dart';



class AgregarRegistroJornadaTemporal extends StatefulWidget {

  const AgregarRegistroJornadaTemporal({
    Key? key, 
    }) : super(key: key);

  @override
  _AgregarRegistroJornadaTemporalState createState() =>
      _AgregarRegistroJornadaTemporalState();
}

class _AgregarRegistroJornadaTemporalState
    extends State<AgregarRegistroJornadaTemporal> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String familia = "";
  String unidadMedida = "";

  @override
  void initState() {
    super.initState();
    familia = "";
    unidadMedida = "";
  }

  @override
  Widget build(BuildContext context) {
    final registroJornadaController = Provider.of<RegistroJornadaController>(context);
    List<String> listFamilias = [];
    List<String> listUnidadesMedida = [];
    dataBase.familiaProductosBox.getAll().forEach((element) {listFamilias.add(element.nombre);});
    dataBase.unidadesMedidaBox.getAll().forEach((element) {listUnidadesMedida.add(element.unidadMedida);});
    return Scaffold(
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
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                color:
                                    AppTheme.of(context).secondaryText,
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Inversión Sugerida',
                              style: AppTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: AppTheme.of(context)
                                        .bodyText1Family,
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
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FormField(builder: (state) {
                                      return Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 5, 10),
                                        child: DropDown(
                                          options: listFamilias,
                                          onChanged: (val) => setState((){
                                            if (listFamilias.isEmpty) {
                                              snackbarKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Debes descargar los catálogos desde la sección de tu perfil"),
                                              ));
                                            }
                                            else{
                                              familia = val!;
                                            }
                                            }),
                                          width: double.infinity,
                                          height: 50,
                                          textStyle: AppTheme.of(context).title3.override(
                                                fontFamily: 'Poppins',
                                                color: const Color(0xFF221573),
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                          hintText: 'Familia del producto*',
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
                                          margin: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                          hidesUnderline: true,
                                        ),
                                      );
                                      }, 
                                      validator: (val) {
                                          if ( familia == "" ||
                                              familia.isEmpty) {
                                            return 'Para continuar, seleccione una familia.';
                                          }
                                          return null;
                                        },
                                      ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                                      child: TextFormField(
                                        textCapitalization: TextCapitalization.sentences,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          registroJornadaController.producto = value;
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
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
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
                                          return capitalizadoCharacters.hasMatch(value ?? '')
                                              ? null
                                              : 'Para continuar, ingrese el producto empezando por mayúscula';
                                          },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                                      child: TextFormField(
                                        textCapitalization: TextCapitalization.sentences,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          registroJornadaController.descripcion = value;
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
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
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
                                          return capitalizadoCharacters.hasMatch(value ?? '')
                                              ? null
                                              : 'Para continuar, ingrese la descripción empezando por mayúscula';
                                          },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                                      child: TextFormField(
                                        textCapitalization: TextCapitalization.sentences,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          registroJornadaController.marcaSugerida = value;
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
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                                      child: TextFormField(
                                        textCapitalization: TextCapitalization.sentences,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          registroJornadaController.proveedorSugerido = value;
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
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
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
                                    FormField(builder: (state) {
                                      return Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 5, 10),
                                        child: DropDown(
                                          options: listUnidadesMedida,
                                          onChanged: (val) => setState((){
                                            if (listUnidadesMedida.isEmpty) {
                                              snackbarKey.currentState
                                              ?.showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Debes descargar los catálogos desde la sección de tu perfil"),
                                              ));
                                            }
                                            else{
                                              unidadMedida = val!;
                                            }
                                            }),
                                          width: double.infinity,
                                          height: 50,
                                          textStyle: AppTheme.of(context).title3.override(
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
                                          margin: const EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                                          hidesUnderline: true,
                                        ),
                                      );
                                      }, 
                                      validator: (val) {
                                          if ( unidadMedida == "" ||
                                              unidadMedida.isEmpty) {
                                            return 'Para continuar, seleccione una unidad de medida.';
                                          }
                                          return null;
                                        },
                                      ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                                      child: TextFormField(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          registroJornadaController.cantidad = value;
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
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor: const Color(0x49FFFFFF),
                                        ),
                                        keyboardType: TextInputType.number,
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                                      child: TextFormField(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          registroJornadaController.costoEstimado = 
                                            currencyFormat.getUnformattedValue().toStringAsFixed(2);
                                        },
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
                                          hintText: 'Ingresa costo estimado...',
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
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor: const Color(0x49FFFFFF),
                                        ),
                                        keyboardType: TextInputType.number,
                                         inputFormatters: [
                                          currencyFormat
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
                                            return 'Para continuar, ingrese un costo sugerido.';
                                          }
                                            
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    print("Desde registro");
                                    print(registroJornadaController.costoEstimado);
                                    print(currencyFormat.format(registroJornadaController.costoEstimado));
                                    if (registroJornadaController
                                  .validateForm(formKey)) {
                                      final idFamiliaProd = dataBase.familiaProductosBox.query(FamiliaProd_.nombre.equals(familia)).build().findFirst()?.id;
                                      final idUnidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.unidadMedida.equals(unidadMedida)).build().findFirst()?.id;
                                      if (idFamiliaProd != null && idUnidadMedida != null) {
                                        registroJornadaController.addTemporal(idFamiliaProd, familia, idUnidadMedida, unidadMedida);
                                        Navigator.pop(context);
                                        snackbarKey.currentState
                                        ?.showSnackBar(const SnackBar(
                                          content: Text(
                                              "¡Registro agregado éxitosamente!"),
                                        ));
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
                                    color: AppTheme.of(context)
                                        .secondaryText,
                                    textStyle: AppTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    elevation: 3,
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context)
                                          .secondaryText,
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
    );
  }
}
