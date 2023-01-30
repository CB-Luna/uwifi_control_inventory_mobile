// Automatic FlutterFlow imports
import 'package:bizpro_app/screens/widgets/bottom_sheet_validacion_eliminar_imagen.dart';
import 'package:bizpro_app/screens/widgets/custom_bottom_eliminar_imagen.dart';
import 'package:flutter/material.dart';
// Begin custom widget code
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

class EditFlutterFlowCarousel extends StatefulWidget {
  const EditFlutterFlowCarousel({
    Key? key,
    required this.width,
    required this.height,
    required this.listaImagenes,
  }) : super(key: key);

  final double width;
  final double height;
  final List<String> listaImagenes;

  @override
  _EditFlutterFlowCarouselState createState() => _EditFlutterFlowCarouselState();
}

class _EditFlutterFlowCarouselState extends State<EditFlutterFlowCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: widget.listaImagenes.map((i) {
    return Builder(
      builder: (BuildContext context) {
        return InkWell(
          onTap: () async {
            String? option =
                await showModalBottomSheet(
              context: context,
              builder: (_) =>
                  const CustomBottomEliminarImagen(),
            );
            if (option == 'eliminar') {
              //print("Eliminar a ${File(i)}");
              var booleano = await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.height * 0.45,
                      child: BottomSheetValidacionEliminarImagen(imagen: i,),
                    ),
                  );
                },
              );
              if (booleano) {
                //print("Se elimina IMAGEN");
                setState(() {
                  widget.listaImagenes.remove(i);
                });
              }

            } else { //Se aborta la opción
              return;
            }
            //print("Fin");
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.file(
                  File(i),
                  fit: BoxFit.cover,
                ),
          ),
        );
      },
    );
      }).toList(),
    );
  }
}