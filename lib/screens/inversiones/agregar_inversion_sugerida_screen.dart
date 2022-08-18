import 'dart:ffi';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:bizpro_app/providers/database_providers/inversion_sugerida_controller.dart';
import 'package:bizpro_app/screens/inversiones/inversion_sugerida_creada.dart';
import 'package:bizpro_app/screens/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_drop_down.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:provider/provider.dart';



class AgregarInversionSugeridaScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;

  const AgregarInversionSugeridaScreen({Key? key, required this.emprendimiento}) : super(key: key);

  @override
  _AgregarInversionSugeridaScreenState createState() =>
      _AgregarInversionSugeridaScreenState();
}

class _AgregarInversionSugeridaScreenState
    extends State<AgregarInversionSugeridaScreen> {
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
    final inversionSProvider = Provider.of<InversionSugeridaController>(context);
    List<String> listFamilias = [];
    List<String> listUnidadesMedida = [];
    dataBase.familiaInversionBox.getAll().forEach((element) {listFamilias.add(element.nombre);});
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
                                          fillColor: const Color(0x49FFFFFF),
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
                                          inversionSProvider.nombre = value;
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
                                          inversionSProvider.descripcion = value;
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
                                         
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Marca sugerida*',
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
                                        validator: (value) {
                                          return capitalizadoCharacters.hasMatch(value ?? '')
                                              ? null
                                              : 'Para continuar, ingrese la marca empezando por mayúscula';
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
                                          inversionSProvider.proveedor = value;
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Proveedor sugerido*',
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
                                        validator: (value) {
                                          return capitalizadoCharacters.hasMatch(value ?? '')
                                              ? null
                                              : 'Para continuar, ingrese el proveedor empezando por mayúscula';
                                          },
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
                                          fillColor: const Color(0x49FFFFFF),
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
                                          inversionSProvider.cantidad = value;
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
                                          inversionSProvider.costo = value;
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Costo sugerido*',
                                          labelStyle: AppTheme.of(context)
                                              .title3
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: AppTheme.of(context)
                                                    .secondaryText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                          hintText: 'Ingresa costo sugerido...',
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
                                    print("Desde inversion");
                                    if (inversionSProvider
                                  .validateForm(formKey)) {
                                      // comunidadProvider.add();
                                      final idFamiliaInversion = dataBase.familiaInversionBox.query(FamiliaInversion_.nombre.equals(familia)).build().findFirst()?.id;
                                      if (idFamiliaInversion != null) {
                                        inversionSProvider.add(widget.emprendimiento.id, idFamiliaInversion);
                                          await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const InversionSugeridaCreada(),
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
