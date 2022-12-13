import 'dart:convert';
import 'dart:io';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimiento_actualizado.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_sheet.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';

class EditarEmprendimientoScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;

  const EditarEmprendimientoScreen({
    Key? key,
    required this.emprendimiento,
  }) : super(key: key);

  @override
  State<EditarEmprendimientoScreen> createState() =>
      _EditarEmprendimientoScreenState();
}

class _EditarEmprendimientoScreenState
    extends State<EditarEmprendimientoScreen> {
  String uploadedFileUrl = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  XFile? image;

  late TextEditingController nombreController;
  late TextEditingController descController;

  Imagenes? newImagen;
  String? imagenTemp;
  @override
  void initState() {
    super.initState();
    newImagen = widget.emprendimiento.imagen.target;
    imagenTemp = widget.emprendimiento.imagen.target?.path;
    nombreController =
        TextEditingController(text: widget.emprendimiento.nombre);
    descController =
        TextEditingController(text: widget.emprendimiento.descripcion);
  }

  @override
  Widget build(BuildContext context) {
    final emprendimientoProvider =
        Provider.of<EmprendimientoController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //Fondo y encabezado
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: widget.emprendimiento.imagen.target != null ?
                          FileImage(File(widget.emprendimiento.imagen.target!.path!))
                          :
                          Image.asset(
                              "assets/images/default_image.png",
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
                                  widget.emprendimiento.nombre,
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
                //Formulario
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Actualizar Emprendimiento',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily:
                                      AppTheme.of(context).bodyText1Family,
                                  color: const Color(0xFF0D0E0F),
                                  fontSize: 16,
                                ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                                imagenTemp = image!.path;
                                File file = File(image!.path);
                                List<int> fileInByte = file.readAsBytesSync();
                                String base64 = base64Encode(fileInByte);
                                newImagen = Imagenes(
                                  imagenes: image!.path,
                                  nombre: image!.name, 
                                  path: image!.path, 
                                  base64: base64);
                                emprendimientoProvider.imagenLocal = newImagen;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF221573),
                                  width: 2,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Lottie.asset(
                                    'assets/lottie_animations/75669-animation-for-the-photo-optimization-process.json',
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 180,
                                    fit: BoxFit.contain,
                                    animate: true,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: getImage(
                                      imagenTemp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 16, 5, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  maxLength: 50,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  controller: nombreController,
                                  decoration: InputDecoration(
                                    labelText: 'Nombre de emprendimiento',
                                    labelStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
                                              color: const Color(0xFF4672FF),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    hintText: 'Ingresa el nombre...',
                                    hintStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0xFF4672FF),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF221573),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF221573),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0x49FFFFFF),
                                  ),
                                  style: AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: const Color(0xFF221573),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  validator: (value) {
                                    if(palabras
                                            .hasMatch(value ?? '')){
                                              return null;
                                    }
                                    else{
                                              return 'Evita usar números y caracteres especiales como diéresis';
                                    }
                                         
                                         
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 0, 5, 10),
                                child: TextFormField(
                                  maxLength: 50,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: false,
                                  controller: descController,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Descripción de emprendimiento',
                                    labelStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
                                              color: const Color(0xFF4672FF),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    hintText:
                                        'Descripción del emprendimiento...',
                                    hintStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0xFF4672FF),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF221573),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFF221573),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0x49FFFFFF),
                                  ),
                                  style: AppTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: const Color(0xFF221573),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  maxLines: 5,
                                  validator: (value) {
                                    return capitalizadoCharacters
                                            .hasMatch(value ?? '')
                                        ? null
                                        : 'Para continuar, ingrese la descripción empezando por mayúscula';
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 10),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (nombreController.text !=
                                            widget.emprendimiento.nombre ||
                                        descController.text !=
                                            widget
                                                .emprendimiento.descripcion
                                        ) {
                                      if (emprendimientoProvider
                                          .validateForm(formKey)) {
                                        
                                        if (newImagen !=
                                            widget.emprendimiento.imagen.target) {
                                          emprendimientoProvider
                                          .updateImagen(
                                            widget.emprendimiento.imagen.target!.id, 
                                            newImagen!,
                                          );
                                        }
                                        emprendimientoProvider.update(
                                            widget.emprendimiento.id,
                                            nombreController.text,
                                            descController.text
                                            );
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EmprendimientoActualizado(),
                                          ),
                                        );
                                      } else {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Campos vacíos'),
                                              content: const Text(
                                                  'Para continuar, debe llenar todos los campos e incluír una imagen.'),
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
                                    } else {
                                      if (newImagen !=
                                            widget.emprendimiento.imagen.target) {
                                          if (emprendimientoProvider
                                          .validateForm(formKey)) {
                                          
                                          emprendimientoProvider
                                          .updateImagen(
                                            widget.emprendimiento.imagen.target!.id, 
                                            newImagen!,
                                          );
                                          
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const EmprendimientoActualizado(),
                                            ),
                                          );
                                        } else {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Campos vacíos'),
                                                content: const Text(
                                                    'Para continuar, debe llenar todos los campos e incluír una imagen.'),
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
                                    }
                                  },
                                  text: 'Actualizar ',
                                  icon: const Icon(
                                    Icons.check,
                                    size: 15,
                                  ),
                                  options: FFButtonOptions(
                                    width: 150,
                                    height: 50,
                                    color: const Color(0xFF4672FF),
                                    textStyle:
                                        AppTheme.of(context).title3.override(
                                              fontFamily: 'Montserrat',
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
