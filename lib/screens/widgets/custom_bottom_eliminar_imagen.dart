import 'package:flutter/material.dart';

class CustomBottomEliminarImagen extends StatelessWidget {
  const CustomBottomEliminarImagen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: size.height * 0.100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.1,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, 'eliminar'),
                    child: const Text('eliminar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
