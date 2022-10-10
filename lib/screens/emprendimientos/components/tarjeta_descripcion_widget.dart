import 'package:bizpro_app/screens/emprendimientos/components/frente_tarjeta_descripcion_widget.dart';
import 'package:bizpro_app/screens/emprendimientos/components/reverso_tarjeta_descripcion_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/database/entitys.dart';


class TargetaDescripcionWidget extends StatefulWidget {
  final Emprendimientos emprendimiento;
  const TargetaDescripcionWidget({
    Key? key, 
    required this.emprendimiento, 
    }) : super(key: key);

  @override
  State<TargetaDescripcionWidget> createState() => _TargetaDescripcionWidgetState();
}

class _TargetaDescripcionWidgetState extends State<TargetaDescripcionWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      flipOnTouch: widget.emprendimiento.faseActual != "Inscrito" &&
      widget.emprendimiento.faseActual != "Jornada 1" &&
      widget.emprendimiento.faseActual != "Jornada 2" &&
      widget.emprendimiento.archivado != true,
      front: FrenteTarjetaDescripcionWidget(emprendimiento: widget.emprendimiento), 
      back: ReversoTarjetaDescripcionWidget(
        emprendimiento: widget.emprendimiento)
      );
  }
}


