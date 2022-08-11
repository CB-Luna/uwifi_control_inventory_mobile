import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/emprendimientos/detalle_emprendimiento_screen.dart';
import 'package:bizpro_app/screens/widgets/custom_button.dart';
import 'package:bizpro_app/screens/widgets/flutter_icon_button.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridEmprendimientosScreen extends StatefulWidget {
  const GridEmprendimientosScreen({Key? key}) : super(key: key);

  @override
  State<GridEmprendimientosScreen> createState() =>
      _GridEmprendimientosScreenState();
}

class _GridEmprendimientosScreenState extends State<GridEmprendimientosScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false, //teclado no movera widgets
      backgroundColor: const Color(0xFF3B9FE5),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 50, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                    child: Text(
                      'Emprendimientos',
                      style: AppTheme.of(context).bodyText1.override(
                            fontFamily: AppTheme.of(context).bodyText1Family,
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: FlutterIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 40,
                      fillColor: Colors.white,
                      icon: const Icon(
                        Icons.close_sharp,
                        color: Color(0xFF3B9FE5),
                        size: 20,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0x49FFFFFF),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x39000000),
                      offset: Offset(0, 1),
                    )
                  ],
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 0, 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                          child: TextFormField(
                            controller: searchController,
                            obscureText: false,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              labelText: 'Ingresa búsqueda...',
                              labelStyle:
                                  AppTheme.of(context).bodyText2.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                      ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0x00000000),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(
                                Icons.search_sharp,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: CustomButton(
                          onPressed: () async {
                            setState(() {});
                          },
                          text: 'Buscar',
                          options: ButtonOptions(
                            width: 68,
                            height: 40,
                            color: const Color(0xFF006AFF),
                            textStyle: AppTheme.of(context).subtitle2.override(
                                  fontFamily:
                                      AppTheme.of(context).subtitle2Family,
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Builder(
                  builder: (context) {
                    List<Emprendimientos> emprendimientos =
                        usuarioProvider.getEmprendimientos();

                    //Busqueda
                    if (searchController.text != '') {
                      emprendimientos.removeWhere((element) {
                        final tempNombre =
                            removeDiacritics(element.nombre).toLowerCase();
                        final tempBusqueda =
                            removeDiacritics(searchController.text)
                                .toLowerCase();
                        return !tempNombre.contains(tempBusqueda);
                      });
                    }
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: emprendimientos.length,
                      itemBuilder: (context, gridViewIndex) {
                        final emprendimiento = emprendimientos[gridViewIndex];
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 10, 15, 0),
                          child: Container(
                            width: 250,
                            height: 200,
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
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetalleEmprendimientoScreen(
                                          emprendimiento: emprendimiento,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    child: getImage(
                                      emprendimiento.imagen,
                                      height: 180,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 5, 10, 2),
                                  child: Text(
                                    emprendimiento.nombre,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTheme.of(context).title3.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Text(
                                    emprendimiento.comunidad.target?.nombre ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style:
                                        AppTheme.of(context).bodyText2.override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0xFF040404),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
