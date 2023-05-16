import 'package:flutter/material.dart';

class DraggableData {
  final int id;
  final String vin;
  final Color color;
  bool accept;
  final String image;

  DraggableData({
    required this.id,
    required this.vin, 
    required this.color,
    this.accept = true,
    required this.image,
  });
}


List<DraggableData> optionsDraggable = [
  DraggableData(
      id: 1,
      vin: "VINONETEST", 
      color: const Color(0xFF2E5099), 
      image: "assets/images/van1.jpg",
    ),
  DraggableData(
      id: 2,
      vin: "VINTWOTEST", 
      color: const Color(0xFF2E5099), 
      image: "assets/images/van2.jpeg",
    ),
  DraggableData(
      id: 3,
      vin: "VINTHREETEST", 
      color: const Color(0xFF2E5099), 
      image: "assets/images/van3.jpeg",
    ),
];