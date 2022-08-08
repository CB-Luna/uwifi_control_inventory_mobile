import 'dart:io';
import 'package:flutter/material.dart';

Widget? getImage(String? image, {double height = 180}) {
  if (image == null) {
    return null;
  } else if (image.startsWith('http') || image.startsWith('https')) {
    return FadeInImage(
      height: 180,
      width: double.infinity,
      placeholder: const AssetImage('assets/images/animation_500_l3ur8tqa.gif'),
      image: NetworkImage(image),
      fit: BoxFit.cover,
    );
  }
  return Image.file(
    File(image),
    height: height,
    width: double.infinity,
    fit: BoxFit.cover,
  );
}

Widget? getImageEmprendedor(String? image, double height) {
  if (image == null || image == '') {
    return Image(
      height: height,
      width: double.infinity,
      image: const AssetImage("assets/images/default-user-profile-picture.jpg"),
      fit: BoxFit.cover,
    );
  } else if (image.startsWith('http') || image.startsWith('https')) {
    return FadeInImage(
      height: height,
      width: double.infinity,
      placeholder: const AssetImage('assets/images/animation_500_l3ur8tqa.gif'),
      image: NetworkImage(image),
      fit: BoxFit.cover,
    );
  }
  return Image.file(
    File(image),
    height: height,
    width: double.infinity,
    fit: BoxFit.cover,
  );
}
