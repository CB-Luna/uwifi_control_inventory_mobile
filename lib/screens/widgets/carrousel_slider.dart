// // Automatic FlutterFlow imports
// import 'package:flutter/material.dart';
// // Begin custom widget code
// import 'package:carousel_slider/carousel_slider.dart';
// import 'dart:io';

// class Carouselslider extends StatefulWidget {
//   const Carouselslider({
//     Key? key,
//     required this.width,
//     required this.height,
//     required this.listaImagenes,
//   }) : super(key: key);

//   final double width;
//   final double height;
//   final List<String> listaImagenes;

//   @override
//   _CarouselsliderState createState() => _CarouselsliderState();
// }

// class _CarouselsliderState extends State<Carouselslider> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: CarouselSlider(
//       options: CarouselOptions(height: 400.0),
//       items: widget.listaImagenes.map((i) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.symmetric(horizontal: 5.0),
//                 child: FadeInImage(
//                   image: NetworkImage(i),
//                   fit: BoxFit.cover, placeholder: null,
//                 ));
//           },
//         );
//       }).toList(),
//     ));
//   }
// }