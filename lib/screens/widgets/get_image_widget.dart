import 'dart:io';
import 'package:flutter/material.dart';

Widget getImageEmprendimiento(String? image, {double height = 180}) {
  if (image == null || image == '') {
    return Image(
      height: height,
      width: double.infinity,
      image: const AssetImage("assets/images/default_image_placeholder.jpeg"),
      fit: BoxFit.cover,
    );
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

Widget getImageContainer(String? image, {double height = 180, double width = double.infinity}) {
  if (image == null || image == '') {
    return Image(
      height: height,
      width: width,
      image: const AssetImage("assets/images/default_image_placeholder.jpeg"),
      fit: BoxFit.cover,
    );
  } else if (image.startsWith('http') || image.startsWith('https')) {
    return FadeInImage(
      height: 180,
      width: width,
      placeholder: const AssetImage('assets/images/default_image_placeholder.jpeg'),
      image: NetworkImage(image),
      fit: BoxFit.cover,
    );
  }
  return Image.file(
    File(image),
    height: height,
    width: width,
    fit: BoxFit.cover,
  );
}

Widget? getImage(String? image, {double height = 180, double width = double.infinity}) {
  if (image == null || image == '') {
    return Image(
      height: height,
      width: width,
      image: const AssetImage("assets/images/animation_500_l3ur8tqa.gif"),
      fit: BoxFit.cover,
    );
  } else if (image.startsWith('http') || image.startsWith('https')) {
    return FadeInImage(
      height: 180,
      width: width,
      placeholder: const AssetImage('assets/images/animation_500_l3ur8tqa.gif'),
      image: NetworkImage(image),
      fit: BoxFit.cover,
    );
  }
  return Image.file(
    File(image),
    height: height,
    width: width,
    fit: BoxFit.cover,
  );
}


Widget? getWidgetImageCliente(String? image, double height, double width) {
  if (image == null || image == '') {
    return Container(
      height: height,
      width: width,
      color: Colors.grey,
      child: const Image(
        image: AssetImage("assets/images/default-user-profile-picture.png"),
        fit: BoxFit.cover,
      ),
    );
  } else if (image.startsWith('http') || image.startsWith('https')) {
    return FadeInImage(
      height: height,
      width: width,
      placeholder: const AssetImage('assets/images/animation_500_l3ur8tqa.gif'),
      image: NetworkImage(image),
      fit: BoxFit.cover,
    );
  }
  return Image.file(
    File(image),
    height: height,
    width: width,
    fit: BoxFit.cover,
  );
}

Widget? getWidgetImagePerfilUsuario(String? image, double height, double width) {
  if (image == null || image == '') {
    return Container(
      height: height,
      width: width,
      color: Colors.transparent,
      child: const Image(
        image: AssetImage("assets/images/default-user-profile-picture.png"),
        fit: BoxFit.cover,
      ),
    );
  } else if (image.startsWith('http') || image.startsWith('https')) {
    return FadeInImage(
      height: height,
      width: width,
      placeholder: const AssetImage('assets/images/animation_500_l3ur8tqa.gif'),
      image: NetworkImage(image),
      fit: BoxFit.cover,
    );
  }
  return Image.file(
    File(image),
    height: height,
    width: width,
    fit: BoxFit.cover,
  );
}


