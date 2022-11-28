import 'dart:io';
import 'package:flutter/material.dart';

Widget? getImage(String? image, {double height = 180}) {
  if (image == null || image == '') {
    return Image(
        height: height,
        width: double.infinity,
        image: const AssetImage("assets/images/default_image.png"),
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

Widget? getImageTareaConsultoria(String? image, {double height = 180, double width = 180}) {
  if (image == null || image == '') {
    return null;
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

Widget? getImageProductoEmprendedor(String? image, {double height = 180, double width = 180}) {
  if (image == null || image == '') {
    return null;
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

Widget getImageEmprendedor(String? image, {double height = 180}) {
  if (image == null || image == '') {
    return Image(
        height: height,
        width: double.infinity,
        image: const AssetImage("assets/images/default-user-profile-picture.png"),
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

Widget? getWidgetImageEmprendedor(String? image, double height, double width) {
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

Widget getWidgetCoverImage(String? image) {
  if (image == null || image == '') {
    return Container(
      color: Colors.grey,
      child: const Image(
        image: AssetImage("assets/images/default_image.png"),
        fit: BoxFit.cover,
      ),
    );
  } else if (image.startsWith('http') || image.startsWith('https')) {
    return FadeInImage(
      placeholder: const AssetImage('assets/images/default-image.jpeg'),
      image: NetworkImage(image),
      fit: BoxFit.cover,
    );
  }
  return Image.file(
    File(image),
    width: double.infinity,
    fit: BoxFit.cover,
  );
}

Widget getWidgetContainImage(String? image) {
  if (image == null || image == '') {
    return Container(
      color: Colors.transparent,
      child: const Image(
        image: AssetImage("assets/images/default_image.png"),
        fit: BoxFit.contain,
      ),
    );
  } else if (image.startsWith('http') || image.startsWith('https')) {
    return FadeInImage(
      placeholder: const AssetImage('assets/images/default-image.jpeg'),
      image: NetworkImage(image),
      fit: BoxFit.contain,
    );
  }
  return Image.file(
    File(image),
    width: double.infinity,
    fit: BoxFit.contain,
  );
}


Widget? getWidgetContainerImage(String? image, double height, double width) {
  if (image == null || image == '') {
    return Container(
      height: height,
      width: width,
      color: Colors.grey,
      child: const Image(
        image: AssetImage("assets/images/default_image.png"),
        fit: BoxFit.cover,
      ),
    );
  } else if (image.startsWith('http') || image.startsWith('https')) {
    return FadeInImage(
      height: height,
      width: width,
      placeholder: const AssetImage('assets/images/default-image.jpeg'),
      image: NetworkImage(image),
      fit: BoxFit.cover,
    );
  }
  return Image.file(
    height: height,
    width: width,
    File(image),
    fit: BoxFit.cover,
  );
}