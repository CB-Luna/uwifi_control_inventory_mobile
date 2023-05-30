// Automatic FlutterFlow imports
import 'package:flutter/material.dart';
// Begin custom widget code
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/database/image_evidence.dart';
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
        return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Image.file(
                File(i.path),
                fit: BoxFit.cover,
              ),
        );
      },
    );
      }).toList(),
    );
  }
}