// import 'package:bizpro_app/screens/widgets/flutter_flow_animations.dart';
// import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
// import 'package:bizpro_app/theme/theme.dart';

// import '../custom_code/widgets/index.dart' as custom_widgets;
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';

// class DetalleJornadaWidget extends StatefulWidget {

//   const DetalleJornadaWidget({
//     Key? key,
//   }) : super(key: key);


//   @override
//   _DetalleJornadaWidgetState createState() => _DetalleJornadaWidgetState();
// }

// class _DetalleJornadaWidgetState extends State<DetalleJornadaWidget>
//     with TickerProviderStateMixin {
//   final animationsMap = {
//     'containerOnPageLoadAnimation': AnimationInfo(
//       trigger: AnimationTrigger.onPageLoad,
//       duration: 600,
//       hideBeforeAnimating: false,
//       fadeIn: true,
//       initialState: AnimationState(
//         offset: Offset(0, 70),
//         scale: 1,
//         opacity: 0,
//       ),
//       finalState: AnimationState(
//         offset: Offset(0, 0),
//         scale: 1,
//         opacity: 1,
//       ),
//     ),
//   };
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     startPageLoadAnimations(
//       animationsMap.values
//           .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
//       this,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//         return Scaffold(
//           key: scaffoldKey,
//           backgroundColor: AppTheme.of(context).primaryBackground,
//           body: GestureDetector(
//             onTap: () => FocusScope.of(context).unfocus(),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                       Stack(
//                         children: [
//                           Image.network(
//                             'https://picsum.photos/seed/836/600',
//                             width: double.infinity,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                           Container(
//                             width: double.infinity,
//                             height: 200,
//                             decoration: BoxDecoration(
//                               color: Color(0x51000000),
//                             ),
//                           ),
//                           Align(
//                             alignment: AlignmentDirectional(0, 0),
//                             child: Container(
//                               width: double.infinity,
//                               height: 200,
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Color(0x0014181B),
//                                     AppTheme.of(context)
//                                         .secondaryBackground
//                                   ],
//                                   stops: [0, 1],
//                                   begin: AlignmentDirectional(0, -1),
//                                   end: AlignmentDirectional(0, 1),
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(
//                                     16, 45, 16, 0),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   0, 0, 0, 10),
//                                           child: Container(
//                                             width: 80,
//                                             height: 40,
//                                             decoration: BoxDecoration(
//                                               color:
//                                                   AppTheme.of(context)
//                                                       .secondaryText,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                             ),
//                                             child: InkWell(
//                                               onTap: () async {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Row(
//                                                 mainAxisSize: MainAxisSize.max,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceEvenly,
//                                                 children: [
//                                                   Icon(
//                                                     Icons
//                                                         .arrow_back_ios_rounded,
//                                                     color: Colors.white,
//                                                     size: 16,
//                                                   ),
//                                                   Text(
//                                                     'Atrás',
//                                                     style: AppTheme.of(
//                                                             context)
//                                                         .bodyText1
//                                                         .override(
//                                                           fontFamily:
//                                                               AppTheme.of(
//                                                                       context)
//                                                                   .bodyText1Family,
//                                                           color: Colors.white,
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.w300,
//                                                         ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   0, 0, 0, 10),
//                                           child: Container(
//                                             width: 45,
//                                             height: 40,
//                                             decoration: BoxDecoration(
//                                               color:
//                                                   AppTheme.of(context)
//                                                       .secondaryText,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                             ),
//                                             child: Row(
//                                               mainAxisSize: MainAxisSize.max,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 Icon(
//                                                   Icons.edit_rounded,
//                                                   color: Colors.white,
//                                                   size: 20,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Text(
//                                       'Jornada No.',
//                                       maxLines: 1,
//                                       style: AppTheme.of(context)
//                                           .subtitle2
//                                           .override(
//                                             fontFamily:
//                                                 AppTheme.of(context)
//                                                     .subtitle2Family,
//                                             color: Colors.white,
//                                             fontSize: 18,
//                                           ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.9,
//                             decoration: BoxDecoration(
//                               color: Color(0x1C4672FF),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0, 5, 0, 0),
//                                     child: Text(
//                                       'Emprendimiento',
//                                       style: AppTheme.of(context)
//                                           .bodyText1
//                                           .override(
//                                             fontFamily:
//                                                 AppTheme.of(context)
//                                                     .bodyText1Family,
//                                             fontSize: 15,
//                                           ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0, 5, 0, 0),
//                                     child: AutoSizeText(
//                                       'Detalle',
//                                       textAlign: TextAlign.start,
//                                       maxLines: 4,
//                                       style: AppTheme.of(context)
//                                           .bodyText1
//                                           .override(
//                                             fontFamily:
//                                                 AppTheme.of(context)
//                                                     .bodyText1Family,
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.normal,
//                                           ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0, 5, 0, 0),
//                                     child: Text(
//                                       'Número de jornada',
//                                       style: AppTheme.of(context)
//                                           .bodyText1
//                                           .override(
//                                             fontFamily:
//                                                 AppTheme.of(context)
//                                                     .bodyText1Family,
//                                             fontSize: 15,
//                                           ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0, 5, 0, 0),
//                                     child: Text(
//                                       'NumJornada',
//                                       style: AppTheme.of(context)
//                                           .bodyText1
//                                           .override(
//                                             fontFamily:
//                                                 AppTheme.of(context)
//                                                     .bodyText1Family,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0, 5, 0, 0),
//                                     child: Text(
//                                       'Emprendedor',
//                                       style: AppTheme.of(context)
//                                           .bodyText1
//                                           .override(
//                                             fontFamily:
//                                                 AppTheme.of(context)
//                                                     .bodyText1Family,
//                                             fontSize: 15,
//                                           ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         0, 5, 0, 5),
//                                     child: AutoSizeText(
//                                       'Emprendedor',
//                                       textAlign: TextAlign.start,
//                                       maxLines: 1,
//                                       style: AppTheme.of(context)
//                                           .bodyText1
//                                           .override(
//                                             fontFamily:
//                                                 AppTheme.of(context)
//                                                     .bodyText1Family,
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.normal,
//                                           ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
//                           child: Text(
//                             'Tarea de ',
//                             style:
//                                 AppTheme.of(context).bodyText1.override(
//                                       fontFamily: AppTheme.of(context)
//                                           .bodyText1Family,
//                                       fontSize: 15,
//                                     ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
//                         child: FFButtonWidget(
//                           onPressed: () async {
//                             // await Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) => AgregarActividadWidget(),
//                             //   ),
//                             // );
//                           },
//                           text: '+ Tarea',
//                           options: FFButtonOptions(
//                             width: 100,
//                             height: 40,
//                             color: AppTheme.of(context).secondaryText,
//                             textStyle:
//                                 AppTheme.of(context).subtitle2.override(
//                                       fontFamily: AppTheme.of(context)
//                                           .subtitle2Family,
//                                       color: Colors.white,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                    ListView.builder(
//                         padding: EdgeInsets.zero,
//                         primary: false,
//                         shrinkWrap: true,
//                         scrollDirection: Axis.vertical,
//                         itemCount: 0,
//                         itemBuilder: (context, listViewIndex) {
//                           final listViewActividadesRecord = [];
//                           return Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
//                             child: Container(
//                               width: double.infinity,
//                               height: 120,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     blurRadius: 4,
//                                     color: Color(0x2B202529),
//                                     offset: Offset(0, 2),
//                                   )
//                                 ],
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         8, 0, 0, 0),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Expanded(
//                                           child: Padding(
//                                             padding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     8, 0, 0, 4),
//                                             child: Column(
//                                               mainAxisSize: MainAxisSize.max,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsetsDirectional
//                                                       .fromSTEB(0, 10, 0, 0),
//                                                   child: AutoSizeText(
//                                                     'Nombre',
//                                                     maxLines: 2,
//                                                     style: AppTheme.of(
//                                                             context)
//                                                         .subtitle1
//                                                         .override(
//                                                           fontFamily: 'Outfit',
//                                                           color: AppTheme
//                                                                   .of(context)
//                                                               .primaryText,
//                                                           fontSize: 20,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                         ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   0, 10, 10, 0),
//                                           child: Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.4,
//                                             height: 100,
//                                             decoration: BoxDecoration(
//                                               color: Color(0xFFEEEEEE),
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             child: Container(
//                                               width: 180,
//                                               height: 100,
//                                               child:
//                                                   custom_widgets.Carouselslider(
//                                                 width: 180,
//                                                 height: 100,
//                                                 listaImagenes:
//                                                     [],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ).animated([
//                               animationsMap['containerOnPageLoadAnimation']!
//                             ]),
//                           );
//                         },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//   }
// }
