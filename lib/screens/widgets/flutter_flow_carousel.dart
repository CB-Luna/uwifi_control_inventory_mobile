// Automatic FlutterFlow imports
import 'package:flutter/material.dart';
// Begin custom widget code
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:io';
import 'package:taller_alex_app_asesor/database/image_evidence.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_expanded_image_view.dart';
class FlutterFlowCarousel extends StatefulWidget {
  const FlutterFlowCarousel({
    Key? key,
    required this.width,
    required this.height,
    required this.listaImagenes,
  }) : super(key: key);

  final double width;
  final double height;
  final List<ImageEvidence> listaImagenes;

  @override
  _FlutterFlowCarouselState createState() => _FlutterFlowCarouselState();
}

class _FlutterFlowCarouselState extends State<FlutterFlowCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: widget.listaImagenes.map((i) {
    return Builder(
      builder: (BuildContext context) {
        return InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: FlutterFlowExpandedImageView(
                  image: Image.file(
                    File(i.path),
                    fit: BoxFit.contain,
                  ),
                  allowRotation: false,
                  tag: i.path,
                  useHeroAnimation: true,
                ),
              ),
            );
          },
          child: Hero(
            tag: i.path,
            transitionOnUserGestures: true,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              width: MediaQuery.of(context).size.width,
              height: 200,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: //TODO: manejar imagen de red
                  Image.file(
                File(i.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
      }).toList(),
    );
  }
}