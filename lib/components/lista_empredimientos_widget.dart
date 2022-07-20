import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bizpro_app/providers/database_providers/emprendimiento_controller.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListaEmpredimientosWidget extends StatefulWidget {
  const ListaEmpredimientosWidget({Key? key}) : super(key: key);

  @override
  State<ListaEmpredimientosWidget> createState() =>
      _ListaEmpredimientosWidgetState();
}

class _ListaEmpredimientosWidgetState extends State<ListaEmpredimientosWidget> {
  @override
  Widget build(BuildContext context) {
    final emprendimientoProvider =
        Provider.of<EmprendimientoController>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(emprendimientoProvider.emprendimientos.length,
            (columnIndex) {
          final columnProyectosRecord =
              emprendimientoProvider.emprendimientos[columnIndex];
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
            child: Container(
              width: double.infinity,
              height: 270,
              decoration: BoxDecoration(
                color: const Color(0x83FFFFFF),
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () {
                      // await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DetalleProyectoWidget(
                      //       proyectoDocRef: columnProyectosRecord.reference,
                      //     ),
                      //   ),
                      // );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: columnProyectosRecord.imagen,
                        width: double.infinity,
                        height: 190,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            maybeHandleOverflow(
                                columnProyectosRecord.nombre, 30, "..."),
                            maxLines: 1,
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            maybeHandleOverflow(
                                columnProyectosRecord.descripcion, 30, "..."),
                            maxLines: 1,
                            style: AppTheme.of(context).bodyText2.override(
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF393939),
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
