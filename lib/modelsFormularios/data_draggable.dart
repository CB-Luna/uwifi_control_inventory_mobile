import 'package:flutter/material.dart';

class DraggableData {
  final String text;
  final Color color;
  bool accept;

  DraggableData({
    required this.text, 
    required this.color,
    this.accept = true,
  });
}