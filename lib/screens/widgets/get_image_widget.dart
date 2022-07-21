import 'dart:io';
import 'package:flutter/material.dart';

Widget? getImage(String? image) {
    if (image == null) {
      return null;
    } else if (image.startsWith('http')) {
      return FadeInImage(
        height: 180,
        width: double.infinity,
        placeholder:
            const AssetImage('assets/images/animation_500_l3ur8tqa.gif'),
        image: NetworkImage(image),
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      height: 180,
      width: double.infinity,
      File(image),
      fit: BoxFit.cover,
    );
  }