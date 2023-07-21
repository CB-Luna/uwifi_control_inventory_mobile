import 'package:flutter/material.dart';

class CustomBottomDownloadInfo extends StatelessWidget {
  const CustomBottomDownloadInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 280,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: SizedBox(
                width: double.infinity,
                height: 80,
                child: TextButton(
                  onPressed: () => Navigator.pop(context, 'consultorias'),
                  child: const Text('Consultorías'),
                ),
              ),
            ),
            const Divider(thickness: 1),
            InkWell(
              child: SizedBox(
                width: double.infinity,
                height: 80,
                child: TextButton(
                  onPressed: () => Navigator.pop(context, 'emprendimientos'),
                  child: const Text('Emprendimientos'),
                ),
              ),
            ),
            const Divider(thickness: 1),
            InkWell(
              child: SizedBox(
                width: double.infinity,
                height: 80,
                child: TextButton(
                  onPressed: () => Navigator.pop(context, 'jornadas'),
                  child: const Text('Jornadas'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
