import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/objectbox.g.dart';

List<TipoServicio> listaServiciosData = [
  TipoServicio(
    id: 1,
    tipoServicio: "Cambio de bujías",
    imagen: 'assets/images/cambioBujias.jpeg',
    costo: 599.99,
  ),
  TipoServicio(
    id: 2,
    tipoServicio: "Cambio de aceite y filtro",
    imagen: 'assets/images/cambioAceiteFiltro.jpeg',
    costo: 899.99,
  ),
  TipoServicio(
    id: 3,
    tipoServicio: "Ajuste del clutch",
    imagen: 'assets/images/ajusteClutch.jpeg',
    costo: 1599.99,
  ),
  TipoServicio(
    id: 4,
    tipoServicio: "Limpieza de terminales de batería",
    imagen: 'assets/images/limpiezaBateria.jpeg',
    costo: 2999.99,
  ),
];