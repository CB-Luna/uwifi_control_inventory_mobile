import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/helpers/globals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bizpro_app/screens/consultorias/agregar_consultoria_screen.dart';
import 'package:bizpro_app/screens/inversiones/inversiones_screen.dart';
import 'package:bizpro_app/screens/jornadas/agregar_jornada1_screen.dart';
import 'package:bizpro_app/screens/jornadas/agregar_jornada2_screen.dart';
import 'package:bizpro_app/screens/jornadas/agregar_jornada3_screen.dart';
import 'package:bizpro_app/screens/jornadas/agregar_jornada4_screen.dart';
import 'package:bizpro_app/screens/productos/productos_emprendedor_screen.dart';
import 'package:bizpro_app/screens/ventas/ventas_screen.dart';


class MenuInferiorDetalleEmprendimiento extends StatefulWidget {
  final Emprendimientos emprendimiento;
  const MenuInferiorDetalleEmprendimiento({
    Key? key, 
    required this.emprendimiento
    }) : super(key: key);

  @override
  State<MenuInferiorDetalleEmprendimiento> createState() => _MenuInferiorDetalleEmprendimientoState();
}

class _MenuInferiorDetalleEmprendimientoState extends State<MenuInferiorDetalleEmprendimiento> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 30,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          color: Colors.transparent,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xCF4672FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    if (widget.emprendimiento.emprendedor
                            .target !=
                        null) {
                      if (widget
                          .emprendimiento.jornadas.isNotEmpty) {
                        final int numJornada = int.parse(widget
                            .emprendimiento
                            .jornadas
                            .last
                            .numJornada);
                        if (numJornada < 4) {
                          switch (numJornada) {
                            case 1:
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AgregarJornada2Screen(
                                    emprendimiento:
                                        widget.emprendimiento,
                                    numJornada: numJornada + 1,
                                  ),
                                ),
                              );
                              break;
                            case 2:
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AgregarJornada3Screen(
                                    emprendimiento:
                                        widget.emprendimiento,
                                    numJornada: numJornada + 1,
                                  ),
                                ),
                              );
                              break;
                            case 3:
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AgregarJornada4Screen(
                                    emprendimiento:
                                        widget.emprendimiento,
                                    numJornada: numJornada + 1,
                                  ),
                                ),
                              );
                              break;
                            default:
                          }
                        } else {
                          snackbarKey.currentState
                              ?.showSnackBar(const SnackBar(
                            content: Text(
                                "No se pueden registrar más de 4 jornadas"),
                          ));
                        }
                      } else {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AgregarJornada1Screen(
                              emprendimiento:
                                  widget.emprendimiento,
                              numJornada: 1,
                            ),
                          ),
                        );
                      }
                    } else {
                      snackbarKey.currentState
                          ?.showSnackBar(const SnackBar(
                        content: Text(
                            "Necesitas registrar un emprendedor a este emprendimiento"),
                      ));
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.calendarCheck,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text(
                        'Jornada',
                        style:
                            AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (widget
                        .emprendimiento.jornadas.isNotEmpty) {
                      final int numJornada = int.parse(widget
                          .emprendimiento
                          .jornadas
                          .last
                          .numJornada);
                      if (numJornada == 4) {
                        if (widget.emprendimiento.consultorias
                            .isNotEmpty) {
                          final int numConsultoria = widget
                              .emprendimiento.consultorias
                              .toList()
                              .length;
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AgregarConsultoriaScreen(
                                emprendimiento:
                                    widget.emprendimiento,
                                numConsultoria:
                                    numConsultoria + 1,
                              ),
                            ),
                          );
                        } else {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AgregarConsultoriaScreen(
                                emprendimiento:
                                    widget.emprendimiento,
                                numConsultoria: 1,
                              ),
                            ),
                          );
                        }
                      } else {
                        snackbarKey.currentState
                            ?.showSnackBar(const SnackBar(
                          content: Text(
                              "Necesitas tener 4 jornadas registradas"),
                        ));
                      }
                    } else {
                      snackbarKey.currentState
                          ?.showSnackBar(const SnackBar(
                        content: Text(
                            "Necesitas tener 4 jornadas registradas"),
                      ));
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.folder_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text(
                        'Consultoría',
                        style:
                            AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (widget
                        .emprendimiento.jornadas.isNotEmpty) {
                      final int numJornada = int.parse(widget
                          .emprendimiento
                          .jornadas
                          .last
                          .numJornada);
                      if (numJornada == 4) {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductosEmprendedorScreen(
                                productosEmprendedor:
                                    widget.emprendimiento.productosEmp.toList(),
                                  emprendimiento: widget.emprendimiento,
                              ),
                            ),
                          );
                      } else {
                        snackbarKey.currentState
                            ?.showSnackBar(const SnackBar(
                          content: Text(
                              "Necesitas tener 4 jornadas registradas"),
                        ));
                      }
                    } else {
                      snackbarKey.currentState
                          ?.showSnackBar(const SnackBar(
                        content: Text(
                            "Necesitas tener 4 jornadas registradas"),
                      ));
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.productHunt,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text(
                        'Productos',
                        style:
                            AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (widget
                        .emprendimiento.productosEmp.isNotEmpty) {
                        await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VentasScreen(
                              ventas: 
                              widget.emprendimiento.
                                ventas.toList(),
                              emprendimiento:
                                  widget.emprendimiento),
                        ),
                      );
                    } else {
                      snackbarKey.currentState
                          ?.showSnackBar(const SnackBar(
                        content: Text(
                            "Para poder registrar una Venta es necesario que primero registres los productos del Emprendedor dentro del módulo 'Productos'"),
                      ));
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.stacked_line_chart_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text(
                        'Ventas',
                        style:
                            AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (widget
                        .emprendimiento.jornadas.isNotEmpty) {
                      final int numJornada = int.parse(widget
                          .emprendimiento
                          .jornadas
                          .last
                          .numJornada);
                      if (numJornada == 4) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InversionesScreen(
                              inversiones: 
                                    widget.emprendimiento
                                    .inversiones.toList(),
                                emprendimiento:
                                    widget.emprendimiento),
                          ),
                        );
                      } else {
                        snackbarKey.currentState
                            ?.showSnackBar(const SnackBar(
                          content: Text(
                              "Necesitas tener 4 jornadas registradas"),
                        ));
                      }
                    } else {
                      snackbarKey.currentState
                          ?.showSnackBar(const SnackBar(
                        content: Text(
                            "Necesitas tener 4 jornadas registradas"),
                      ));
                    } 
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.attach_money_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      Text(
                        'Inversión',
                        style:
                            AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 8,
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