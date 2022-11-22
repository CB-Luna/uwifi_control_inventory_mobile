import 'package:bizpro_app/modelsPocketbase/temporals/get_emi_user_pocketbase_temp.dart';
import 'package:bizpro_app/screens/emprendimientos/emprendimientos_screen.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'package:bizpro_app/theme/theme.dart';
import 'package:bizpro_app/screens/widgets/side_menu/side_menu.dart';

class EmprendimientosExternosScreen extends StatefulWidget {
  final List<GetEmiUserPocketbasetemp> listEmiUsers;

  const EmprendimientosExternosScreen({
    Key? key, 
    required this.listEmiUsers
    }) : super(key: key);

  @override
  State<EmprendimientosExternosScreen> createState() => _EmprendimientosExternosScreenState();
}

class _EmprendimientosExternosScreenState extends State<EmprendimientosExternosScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const SideMenu(),
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
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 10, 0, 0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 35, 0, 0),
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).secondaryText,
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
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 35, 0, 0),
                                  child: Text(
                                    'Emprendimientos Externos',
                                    style: AppTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: AppTheme.of(context)
                                              .bodyText1Family,
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
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
                                              obscureText: false,
                                              onChanged: (_) => setState(() {}),
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Ingresa búsqueda...',
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
                                              .fromSTEB(0, 0, 10, 0),
                                          child: FFButtonWidget(
                                            onPressed: () {
                                              setState(() {});
                                            },
                                            text: '',
                                            icon: const Icon(
                                              Icons.search_rounded,
                                              size: 15,
                                            ),
                                            options: FFButtonOptions(
                                              width: 45,
                                              height: 40,
                                              color: AppTheme.of(context)
                                                  .secondaryText,
                                              textStyle: AppTheme.of(context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily:
                                                        AppTheme.of(context)
                                                            .subtitle2Family,
                                                    color: Colors.white,
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(15, 25, 15, 25),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(widget.listEmiUsers.length,
                                      (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 71,
                                        child: Material(
                                          borderRadius: BorderRadius.circular(8),
                                          elevation: 3,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                        10, 0, 10, 0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: CircleAvatar(
                                                        backgroundImage: NetworkImage(
                                                            ''),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsetsDirectional
                                                            .fromSTEB(10, 0, 10, 0),
                                                        child: Text(
                                                          "${widget.listEmiUsers[index]
                                                          .nombreUsuario} ${widget.listEmiUsers[index]
                                                          .apellidoP} ${widget.listEmiUsers[index].apellidoM}",
                                                          style: AppTheme.of(context)
                                                              .title1
                                                              .override(
                                                                fontFamily: 'Roboto',
                                                                color: AppTheme.of(context)
                                                                    .primaryColor,
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
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
                                    );
                                  }),
                                ),
                              ),
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
    );
  }
}
