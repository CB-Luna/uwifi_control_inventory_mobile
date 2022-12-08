import 'package:bizpro_app/helpers/globals.dart';
import 'package:bizpro_app/screens/emprendimientos/detalle_emprendimiento_screen.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/database/entitys.dart';


class FrenteTarjetaDescripcionWidget extends StatefulWidget {
  final Emprendimientos emprendimiento;
  const FrenteTarjetaDescripcionWidget({
    Key? key, 
    required this.emprendimiento, 
    }) : super(key: key);

  @override
  State<FrenteTarjetaDescripcionWidget> createState() => _FrenteTarjetaDescripcionWidgetState();
}

class _FrenteTarjetaDescripcionWidgetState extends State<FrenteTarjetaDescripcionWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          15, 10, 15, 10),
      child: Container(
        width: double.infinity,
        height: 275,
        decoration: BoxDecoration(
          color: widget.emprendimiento.faseActual == "Detenido" ?
          const Color.fromARGB(207, 255, 64, 128)
          :
          widget.emprendimiento.faseActual == "Consolidado" ?
          const Color.fromARGB(207, 38, 128, 55)
          :
          const Color(0xB14672FF),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x32000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                if (widget.emprendimiento.faseActual != "Detenido" 
                && widget.emprendimiento.faseActual != "Consolidado") {
                  await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetalleEmprendimientoScreen(
                      idEmprendimiento: widget.emprendimiento.id,
                    ),
                  ),
                );
                } else {
                  snackbarKey.currentState
                      ?.showSnackBar(const SnackBar(
                    content: Text(
                        "No se puede editar este emprendimiento."),
                  ));
                }
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child:
                    getImageEmprendimiento(widget.emprendimiento.imagen.target?.path),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional
                  .fromSTEB(16, 10, 16, 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    maybeHandleOverflow(widget.emprendimiento.nombre, 26, "..."),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.of(context)
                        .title3
                        .override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    widget.emprendimiento
                            .faseActual,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.of(context)
                        .title3
                        .override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional
                  .fromSTEB(16, 0, 16, 5),
              child: Text(
                widget.emprendimiento
                        .emprendedor.target?.comunidad.target?.nombre
                        .toString() ??
                    'INACTIVO',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.of(context)
                    .bodyText2
                    .override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional
                      .fromSTEB(16, 0, 16, 5),
                  child: Text(
                    widget.emprendimiento.emprendedor.target
                                ?.nombre ==
                            null
                        ? 'SIN EMPRENDEDOR'
                        : "${widget.emprendimiento.emprendedor.target!.nombre} ${widget.emprendimiento.emprendedor.target!.apellidos}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.of(context)
                        .bodyText2
                        .override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                Visibility(
                  visible: widget.emprendimiento.faseActual != "Inscrito" &&
                  widget.emprendimiento.faseActual != "Jornada 1" &&
                  widget.emprendimiento.faseActual != "Jornada 2" &&
                  widget.emprendimiento.archivado != true,
                  child: const Padding(
                    padding: EdgeInsetsDirectional
                        .fromSTEB(15, 0, 30, 5),
                    child: Icon(
                      Icons.visibility,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


