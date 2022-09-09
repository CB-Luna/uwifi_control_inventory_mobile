import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bizpro_app/screens/emprendimientos/menu_inferior_detalle_emprendimiento.dart';
import 'package:bizpro_app/screens/emprendimientos/cuerpo_detalle_emprendimiento.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:bizpro_app/screens/emprendimientos/editar_emprendimiento.dart';

class DetalleEmprendimientoScreen extends StatefulWidget {
  final Emprendimientos emprendimiento;

  const DetalleEmprendimientoScreen({
    Key? key,
    required this.emprendimiento,
  }) : super(key: key);

  @override
  State<DetalleEmprendimientoScreen> createState() =>
      _DetalleEmprendimientoScreenState();
}

class _DetalleEmprendimientoScreenState
    extends State<DetalleEmprendimientoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    String emprendedor = "";
    if (widget.emprendimiento.emprendedor.target != null) {
      emprendedor =
          "${widget.emprendimiento.emprendedor.target!.nombre} ${widget.emprendimiento.emprendedor.target!.apellidos}";
    }
    final List<Jornadas> jornadas = [];
    for (var element in widget.emprendimiento.jornadas) {
      jornadas.add(element);
    }
    final List<Consultorias> consultorias = [];
    for (var element in widget.emprendimiento.consultorias) {
      consultorias.add(element);
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            //Imagen de fondo
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: AppTheme.of(context).secondaryBackground,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/bglogin2.png',
                ).image,
              ),
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          //Imagen de emprendimiento
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                    File(widget.emprendimiento.imagen)),
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

                          //Opciones superiores
                          Positioned(
                            left: 16,
                            top: 45,
                            right: 16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4672FF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const EmprendimientosScreen(),
                                        ),
                                      );
                                    },
                                    child: Row(
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
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 45,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4672FF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditarEmprendimientoScreen(
                                                    emprendimiento:
                                                        widget.emprendimiento)),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Titulo de emprendimiento
                          Positioned.fill(
                            top: 100,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
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
                            ),
                          ),
                          Positioned.fill(
                            top: 150,
                            child: Align(
                              alignment: Alignment.center,
                              child: Material(
                                color: Colors.transparent,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xCF4672FF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                            },
                                            child: const FaIcon(
                                              Icons.pause_circle_outline,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          Text(
                                            'Detener',
                                            style:
                                                AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                    ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: ()  {
                            
                                            },
                                            child: const Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          Text(
                                            'Reactivar',
                                            style:
                                                AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                    ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                            },
                                            child: const FaIcon(
                                              Icons.file_download_outlined,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          Text(
                                            'Archivar',
                                            style:
                                                AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                    ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CuerpoDetalleEmprendimiento(
                        emprendimiento: 
                        widget.emprendimiento
                      ),
                    ],
                  ),
                ),
                //Menu inferior
                MenuInferiorDetalleEmprendimiento(
                  emprendimiento: 
                  widget.emprendimiento
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
