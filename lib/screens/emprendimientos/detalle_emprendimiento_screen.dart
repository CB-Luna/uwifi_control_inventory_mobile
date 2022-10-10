import 'dart:io';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimiento_consolidado_screen.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimiento_detenido_screen.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_consolidar_emprendimiento.dart';
import 'package:bizpro_app/screens/widgets/bottom_sheet_detener_emprendimiento.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/screens/emprendimientos/menu_inferior_detalle_emprendimiento.dart';
import 'package:bizpro_app/screens/emprendimientos/cuerpo_detalle_emprendimiento.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:bizpro_app/screens/emprendimientos/editar_emprendimiento.dart';

class DetalleEmprendimientoScreen extends StatefulWidget {
  final int idEmprendimiento;

  const DetalleEmprendimientoScreen({
    Key? key,
    required this.idEmprendimiento,
  }) : super(key: key);

  @override
  State<DetalleEmprendimientoScreen> createState() =>
      _DetalleEmprendimientoScreenState();
}

class _DetalleEmprendimientoScreenState
    extends State<DetalleEmprendimientoScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
Emprendimientos? emprendimientoActual;
  @override
  void initState() {
    super.initState();
    emprendimientoActual =
        dataBase.emprendimientosBox.get(widget.idEmprendimiento);
    if (emprendimientoActual != null) {
    }
  }
  @override
  Widget build(BuildContext context) {
    final emprendimientoProvider = Provider.of<EmprendimientoController>(context);
    String emprendedor = "";
    if (emprendimientoActual!.emprendedor.target != null) {
      emprendedor =
          "${emprendimientoActual!.emprendedor.target!.nombre} ${emprendimientoActual!.emprendedor.target!.apellidos}";
    }
    final List<Jornadas> jornadas = [];
    for (var element in emprendimientoActual!.jornadas) {
      jornadas.add(element);
    }
    final List<Consultorias> consultorias = [];
    for (var element in emprendimientoActual!.consultorias) {
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
                                    File(emprendimientoActual!.imagen)),
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
                                      if (emprendimientoActual!.usuario.target!.rol.target!.rol == "Voluntario Estratégico" ||
                                          emprendimientoActual!.usuario.target!.rol.target!.rol == "Amigo del Cambio" ||
                                          emprendimientoActual!.usuario.target!.rol.target!.rol == "Emprendedor") {
                                        snackbarKey.currentState
                                            ?.showSnackBar(const SnackBar(
                                          content: Text(
                                              "Este usuario no tiene permisos para esta acción."),
                                        ));
                                      } else {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditarEmprendimientoScreen(
                                                      emprendimiento:
                                                          emprendimientoActual!)),
                                        );
                                      }
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
                                  emprendimientoActual!.nombre,
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
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 55,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4672FF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (emprendimientoActual!.usuario.target!.rol.target!.rol == "Voluntario Estratégico" ||
                                                  emprendimientoActual!.usuario.target!.rol.target!.rol == "Amigo del Cambio" ||
                                                  emprendimientoActual!.usuario.target!.rol.target!.rol == "Emprendedor") {
                                                snackbarKey.currentState
                                                    ?.showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Este usuario no tiene permisos para esta acción."),
                                                ));
                                              } else {
                                                String? option =
                                                  await showModalBottomSheet(
                                                  context: context,
                                                  builder: (_) =>
                                                      const BottomSheetDetenerEmprendimiento(),
                                                );
                                                if (option == 'aceptar') {
                                                  emprendimientoProvider.detenerEmprendimiento(emprendimientoActual!.id);
                                                  // ignore: use_build_context_synchronously
                                                  await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                  builder: (context) =>
                                                      const EmprendimientoDetenidoScreen(),
                                                        ),
                                                  );
                                                } else { //Se aborta la opción
                                                  return;
                                                }
                                              }
                                            },
                                            child: const Icon(
                                              Icons.pause_circle_outline,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                          Text(
                                          'Detener',
                                          style:
                                              AppTheme.of(context).bodyText1.override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                        ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: emprendimientoActual!.faseEmp.last.fase == "Jornada 4" ||
                                      emprendimientoActual!.faseEmp.last.fase == "Consultoría",
                                      child: Container(
                                        width: 60,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF4672FF),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                if (emprendimientoActual!.usuario.target!.rol.target!.rol == "Voluntario Estratégico" ||
                                                      emprendimientoActual!.usuario.target!.rol.target!.rol == "Amigo del Cambio" ||
                                                      emprendimientoActual!.usuario.target!.rol.target!.rol == "Emprendedor") {
                                                    snackbarKey.currentState
                                                        ?.showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Este usuario no tiene permisos para esta acción."),
                                                    ));
                                                  } else {
                                                    String? option =
                                                      await showModalBottomSheet(
                                                      context: context,
                                                      builder: (_) =>
                                                          const BottomSheetConsolidarEmprendimiento(),
                                                    );
                                                    if (option == 'aceptar') {
                                                      emprendimientoProvider.consolidarEmprendimiento(emprendimientoActual!.id);
                                                      // ignore: use_build_context_synchronously
                                                      await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                      builder: (context) =>
                                                          const EmprendimientoConsolidadoScreen(),
                                                            ),
                                                      );
                                                    } else { //Se aborta la opción
                                                      return;
                                                    }
                                                }
                                              },
                                              child: const Icon(
                                                Icons.thumb_up_alt_outlined,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                            Text(
                                            'Consolidar',
                                            style:
                                                AppTheme.of(context).bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.white,
                                                      fontSize: 10,
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
                        ],
                      ),
                      CuerpoDetalleEmprendimiento(
                        emprendimiento: 
                        emprendimientoActual!
                      ),
                    ],
                  ),
                ),
                //Menu inferior
                MenuInferiorDetalleEmprendimiento(
                  emprendimiento: 
                  emprendimientoActual!
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
