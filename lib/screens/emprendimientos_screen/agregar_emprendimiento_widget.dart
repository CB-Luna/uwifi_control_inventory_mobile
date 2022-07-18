import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/providers/database_providers/comunidad_controller.dart';
import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';

import 'package:bizpro_app/screens/widgets/emprendimiento_creado.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/theme/theme.dart';



class AgregarEmprendimientoWidget extends StatefulWidget {
  const AgregarEmprendimientoWidget({Key? key}) : super(key: key);

  @override
  _AgregarEmprendimientoWidgetState createState() =>
      _AgregarEmprendimientoWidgetState();
}

class _AgregarEmprendimientoWidgetState
    extends State<AgregarEmprendimientoWidget> {
  late AudioPlayer soundPlayer;
  final formKey1 = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final emprendimientoProvider = Provider.of<EmprendimientoController>(context);
    final comunidadProvider = Provider.of<ComunidadController>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF008DD4),
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
        title: Text(
          'Emprendimientos',
          style: AppTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFD9EEF9),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Registro de Emprendimiento',
                        style: AppTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF0D0E0F),
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: formKey1,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: InkWell(
                          onTap: ()  {
                            emprendimientoProvider.imagen = "https://www.amo-alebrijes.com/wp-content/uploads/2016/08/Tutoriales-tipos-de-alebrijes.jpg";
                            // final selectedMedia =
                            //     await selectMediaWithSourceBottomSheet(
                            //   context: context,
                            //   allowPhoto: true,
                            // );
                            // if (selectedMedia != null &&
                            //     selectedMedia.every((m) => validateFileFormat(
                            //         m.storagePath, context))) {
                            //   showUploadMessage(
                            //     context,
                            //     'Uploading file...',
                            //     showLoading: true,
                            //   );
                            //   final downloadUrls = 
                            //   // (await Future.wait(
                            //   //         selectedMedia.map((m) async =>
                            //   //             await uploadData(
                            //   //                 m.storagePath, m.bytes))))
                            //   //     .where((u) => u != null)
                            //   //     .toList();
                            //   null;
                            //   ScaffoldMessenger.of(context)
                            //       .hideCurrentSnackBar();
                            //   if (downloadUrls != null &&
                            //       downloadUrls.length == selectedMedia.length) {
                            //     setState(
                            //         () => emprendimientoProvider.imagen = downloadUrls.first);
                            //     showUploadMessage(
                            //       context,
                            //       'Success!',
                            //     );
                            //   } else {
                            //     showUploadMessage(
                            //       context,
                            //       'Failed to upload media',
                            //     );
                            //     return;
                            //   }
                            // }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/animation_500_l3ur8tqa.gif',
                                ).image,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFF2CC3F4),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(8),
                                //   child: Image.network(
                                //     "https://www.amo-alebrijes.com/wp-content/uploads/2016/08/Tutoriales-tipos-de-alebrijes.jpg",
                                //     width:
                                //         MediaQuery.of(context).size.width * 0.9,
                                //     height: 180,
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: formKey4,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              emprendimientoProvider.nombre = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Nombre de emprendimiento',
                              labelStyle:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Ingresa el nombre...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Para continuar, ingrese el nombre.';
                              }
                      
                              return null;
                            },
                          ),
                        ),
                      ),
                      Form(
                        key: formKey3,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              emprendimientoProvider.descripcion = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Descripción de emprendimiento',
                              labelStyle:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Descripción del emprendimiento...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF060606),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            maxLines: 5,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Para continuar, ingrese la descripción.';
                              }
                      
                              return null;
                            },
                          ),
                        ),
                      ),
                      Form(
                        key: formKey2,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              comunidadProvider.nombre = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Comunidad',
                              labelStyle:
                                  AppTheme.of(context).title3.override(
                                        fontFamily: 'Montserrat',
                                        color: AppTheme.of(context)
                                            .secondaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                              hintText: 'Ingresa comunidad...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Para continuar, ingrese la comunidad.';
                              }
                      
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                if (formKey1.currentState == null ||
                                    !formKey1.currentState!.validate()) {
                                  return;
                                }

                                if (emprendimientoProvider.imagen == null ||
                                    emprendimientoProvider.imagen.isEmpty) {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('Campos vacíos'),
                                        content: Text(
                                            'Para continuar, debe llenar todos los campos e incluír una imagen.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Bien'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return;
                                }

                                if (formKey4.currentState == null ||
                                    !formKey4.currentState!.validate()) {
                                  return;
                                }

                                if (formKey3.currentState == null ||
                                    !formKey3.currentState!.validate()) {
                                  return;
                                }

                                if (formKey2.currentState == null ||
                                    !formKey2.currentState!.validate()) {
                                  return;
                                }
                                
                                comunidadProvider.add();
                                emprendimientoProvider.add(comunidadProvider.comunidades.last.id);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EmprendimientoCreado(),
                                  ),
                                );
                                soundPlayer = AudioPlayer();
                                if (soundPlayer.playing) {
                                  await soundPlayer.stop();
                                }
                                soundPlayer.setVolume(1);
                                await soundPlayer
                                    .setAsset('assets/audios/successeffect.mp3')
                                    .then((_) => soundPlayer.play());
                              },
                              text: 'Agregar Emprendimiento',
                              options: FFButtonOptions(
                                width: 290,
                                height: 50,
                                color: Color(0xFF2CC3F4),
                                textStyle: AppTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Color(0xFF2CC3F4),
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
      ),
    );
  }
}
