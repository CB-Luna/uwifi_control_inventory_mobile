import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_control_inventory_mobile/providers/database/usuario_controller.dart';
import 'package:uwifi_control_inventory_mobile/providers/system/bundles_provider.dart';
import 'package:uwifi_control_inventory_mobile/screens/inventory/bundle/widgets/item_form_bundle.dart';
import 'package:uwifi_control_inventory_mobile/theme/theme.dart';
import 'package:uwifi_control_inventory_mobile/util/animations.dart';
import 'package:uwifi_control_inventory_mobile/screens/widgets/header_shimmer.dart';

class SearchBundlesCreated extends StatefulWidget {
  
  const SearchBundlesCreated({super.key});

  @override
  State<SearchBundlesCreated> createState() => _SearchBundlesCreatedState();
}
final scaffoldKey = GlobalKey<ScaffoldState>();
final animationsMap = {
    'moveLoadAnimationLR': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(-79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
        ),
      ],
    ),
    'moveLoadAnimationRL': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(79, 0),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(1, 1),
          end: const Offset(1, 1),
        ),
      ],
    ),
  };

class _SearchBundlesCreatedState extends State<SearchBundlesCreated> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final userProvider = Provider.of<UsuarioController>(
        context,
        listen: false,
      );
      BundlesProvider provider = Provider.of<BundlesProvider>(
        context,
        listen: false
      );
      await provider.updateState(userProvider.usuarioCurrent!.sequentialId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BundlesProvider>(context);
    final userProvider = Provider.of<UsuarioController>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            // HEADER
            HeaderShimmer(
              width: MediaQuery.of(context).size.width, 
              text: "Bundles Created Recently",
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  0, 10, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.transparent,
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
                              padding:
                                  const EdgeInsetsDirectional
                                      .fromSTEB(4, 0, 4, 0),
                              child: TextFormField(
                                controller: provider.searchController,
                                onChanged: (value) {
                                  provider.getBundles(userProvider.usuarioCurrent!.sequentialId);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Search...',
                                  labelStyle: AppTheme.of(
                                          context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: AppTheme.of(context).alternate,
                                        fontSize: 13,
                                        fontWeight:
                                            FontWeight.normal,
                                      ),
                                  enabledBorder:
                                      OutlineInputBorder(
                                    borderSide:
                                        BorderSide(
                                      color: AppTheme.of(context).grayLighter,
                                      width: 2,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(
                                            8),
                                  ),
                                  focusedBorder:
                                      OutlineInputBorder(
                                    borderSide:
                                        BorderSide(
                                      color: AppTheme.of(context).grayLighter,
                                      width: 2,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(
                                            8),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search_sharp,
                                    color: AppTheme.of(context).alternate,
                                    size: 15,
                                  ),
                                ),
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: AppTheme.of(context).primaryText,
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
                                    .white,
                                borderRadius:
                                    const BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(8),
                                  bottomRight:
                                      Radius.circular(30),
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(30),
                                ),
                                border: Border.all(
                                  color: AppTheme.of(context).alternate,
                                  width: 2)
                              ),
                              child: InkWell(
                                onTap: () async {
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.search_rounded,
                                  color: AppTheme.of(context).alternate,
                                  size: 24,
                                ),
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
            Padding(
               padding: const EdgeInsetsDirectional.fromSTEB(0, 8.0, 0, 8.0),
               child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 3.0,
                    color: AppTheme.of(context).alternate,
                    ),
                  borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                   child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Serial No.",
                        style: AppTheme.of(context)
                        .bodyText1.override(
                          fontFamily:
                                AppTheme.of(context).bodyText1Family,
                          color: AppTheme.of(context).alternate,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Created",
                        style: AppTheme.of(context)
                        .bodyText1.override(
                          fontFamily:
                                AppTheme.of(context).bodyText1Family,
                          color: AppTheme.of(context).alternate,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Options",
                        style: AppTheme.of(context)
                        .bodyText1.override(
                          fontFamily:
                                AppTheme.of(context).bodyText1Family,
                          color: AppTheme.of(context).alternate,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                   ),
                 ),
               ),
            ),
            Container(
            height: 400,
            clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2.0,
                  color: AppTheme.of(context).grayLighter,
                  ),
                borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Builder(
                builder: (context) {
                  return ListView.builder(
                  padding: const EdgeInsets.all(5.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: provider.bundles.length,
                  itemBuilder: (context, index) {
                    final bundle = provider.bundles[index];
                    return ItemFormBundle(
                      bundle: bundle,
                    );
                  });
                },
              ),
            ),
        ]),
      ),
    );
  }
}
