import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/util/util.dart';
import 'package:bizpro_app/providers/database_providers/usuario_controller.dart';
import 'package:bizpro_app/screens/emprendedores/detalle_emprendedor_screen.dart';
import 'package:bizpro_app/screens/widgets/get_image_widget.dart';


class GridEmprendedoresScreen extends StatefulWidget {
  final List<Emprendedores> emprendedores;
  const GridEmprendedoresScreen({
    Key? key, 
    required this.emprendedores
    }) : super(key: key);

  @override
  State<GridEmprendedoresScreen> createState() =>
      _GridEmprendedoresScreenState();
}

class _GridEmprendedoresScreenState extends State<GridEmprendedoresScreen> {
  TextEditingController searchController = TextEditingController();
  List<Emprendedores> emprendedores = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emprendedores = [];

  }
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioController>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false, //teclado no movera widgets
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/bglogin2.png',
                      ).image,
                    ),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 45, 20, 0),
                          child: Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4672FF),
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
                                    style:
                                        AppTheme.of(context).bodyText1.override(
                                              fontFamily: AppTheme.of(context)
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
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Text(
                                'Emprendedores',
                                textAlign: TextAlign.center,
                                style:
                                  AppTheme.of(context).bodyText1.override(
                                        fontFamily: AppTheme.of(context)
                                            .bodyText1Family,
                                        color: const Color(0xFF221573),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            15, 10, 0, 0),
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0x49FFFFFF),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x39000000),
                              )
                            ],
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(
                                    4, 4, 0, 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional
                                        .fromSTEB(4, 0, 4, 0),
                                    child: TextFormField(
                                      controller: searchController,
                                      onChanged: (value) =>
                                          setState(() {}),
                                      decoration: InputDecoration(
                                        labelText: 'Buscar...',
                                        labelStyle: AppTheme.of(context)
                                            .bodyText2
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight:
                                                  FontWeight.normal,
                                            ),
                                        enabledBorder:
                                            OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder:
                                            OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.search_sharp,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                      style: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight:
                                                FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional
                                      .fromSTEB(0, 0, 5, 0),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context)
                                          .secondaryText,
                                      borderRadius:
                                          const BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight:
                                            Radius.circular(30),
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {});
                                      },
                                      child: const Icon(
                                        Icons.search_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
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
      
                              //Busqueda
                              if (searchController.text != '') {
                                widget.emprendedores.removeWhere((element) {
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
                                itemCount: widget.emprendedores.length,
                                itemBuilder: (context, gridViewIndex) {
                                  final emprendedor = widget.emprendedores[gridViewIndex];
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
                                                      DetallesEmprendedorScreen(
                                                    emprendedor: emprendedor,
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
                                              child: getWidgetImageEmprendedor(
                                                emprendedor.imagen,
                                                155,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                10, 5, 10, 2),
                                            child: Text(
                                              emprendedor.nombre,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTheme.of(context).title3.override(
                                                    fontFamily: 'Poppins',
                                                    color: const Color(0xFF221573),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                10, 0, 10, 0),
                                            child: Text(
                                              emprendedor.comunidad.target?.nombre ??
                                                  '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
