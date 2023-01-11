import 'dart:convert';
import 'dart:io';

import 'package:bizpro_app/database/entitys.dart';
import 'package:bizpro_app/main.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_consultoria_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_emprendimeinto_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_imagen_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_inversion_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_inversion_x_prod_cotizados.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_jornada_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_pagos_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_producto_emp_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_producto_solicitado_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_producto_vendido.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_productos_cotizados_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_productos_proyecto_pocketbase.dart';
import 'package:bizpro_app/modelsPocketbase/temporals/get_basic_venta_pocketbase.dart';
import 'package:bizpro_app/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:bizpro_app/helpers/constants.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class SyncEmpExternosPocketbaseProvider extends ChangeNotifier {
  bool procesocargando = false;
  bool procesoterminado = false;
  bool procesoexitoso = false;
  String tokenGlobal = "";
  int? idEmprendimientoObjectBox;
  List<bool> banderasExitoSync = [];
  bool exitoso = true;
  bool usuarioExit = false;

  void procesoCargando(bool boleano) {
    procesocargando = boleano;
    // notifyListeners();
  }

  void procesoTerminado(bool boleano) {
    procesoterminado = boleano;
    // notifyListeners();
  }

  void procesoExitoso(bool boleano) {
    procesoexitoso = boleano;
    // notifyListeners();
  }


  Future<bool> getProyectosExternosPocketbase(String idEmprendimiento, Usuarios usuario) async {
    try {
      print("ID Emprendimiento en Descarga Proyectos Pocketbase: $idEmprendimiento");
        //Se recupera toda la colección de datos emprendimientos en Pocketbase
        var url = Uri.parse("$baseUrl/api/collections/emprendimientos/records?filter=(id='$idEmprendimiento')&expand=id_emprendedor_fk.id_comunidad_fk,id_fase_emp_fk,id_nombre_proyecto_fk");
        final headers = ({
            "Content-Type": "application/json",
          });
        var response = await get(
          url,
          headers: headers
        );
        var basicEmprendimiento = getBasicEmprendimientoPocketbaseFromMap(response.body);

        if (response.statusCode == 200) {
          print("STATUS 200");
          final faseEmp = dataBase.fasesEmpBox.query(FasesEmp_.fase.equals(basicEmprendimiento.items[0].expand.idFaseEmpFk.fase)).build().findFirst();
          final comunidad = dataBase.comunidadesBox.query(Comunidades_.nombre.equals(basicEmprendimiento.items[0].expand.idEmprendedorFk.expand.idComunidadFk.nombreComunidad)).build().findFirst();
          final catalogoProyecto = dataBase.catalogoProyectoBox.query(CatalogoProyecto_.nombre.equals(basicEmprendimiento.items[0].expand.idNombreProyectoFk?.nombreProyecto ?? "")).build().findFirst();
          if (faseEmp != null && comunidad != null) {
            print("Sí se ecnontró la fase y comunidad en el dispositivo para Pockectbase");
            final nuevoEmprendimiento = Emprendimientos(
              faseActual: faseEmp.fase, 
              faseAnterior: faseEmp.fase, 
              nombre: basicEmprendimiento.items[0].nombreEmprendimiento, 
              descripcion: basicEmprendimiento.items[0].descripcion,
              activo: basicEmprendimiento.items[0].activo,
              archivado: basicEmprendimiento.items[0].archivado,
              idDBR: basicEmprendimiento.items[0].id,
              idEmiWeb: basicEmprendimiento.items[0].idEmiWeb,
            );
            nuevoEmprendimiento.faseEmp.add(faseEmp);
            if (catalogoProyecto != null) {
              nuevoEmprendimiento.catalogoProyecto.target = catalogoProyecto;
            }
            final nuevoEmprendedor = Emprendedores(
              nombre: basicEmprendimiento.items[0].expand.idEmprendedorFk.nombreEmprendedor, 
              apellidos: basicEmprendimiento.items[0].expand.idEmprendedorFk.apellidosEmp,
              nacimiento: DateTime.parse("2000-02-27 13:27:00"), 
              curp: basicEmprendimiento.items[0].expand.idEmprendedorFk.curp, 
              integrantesFamilia: basicEmprendimiento.items[0].expand.idEmprendedorFk.integrantesFamilia.toString(), 
              telefono: basicEmprendimiento.items[0].expand.idEmprendedorFk.telefono, 
              comentarios: basicEmprendimiento.items[0].expand.idEmprendedorFk.comentarios ?? '', 
              idDBR: basicEmprendimiento.items[0].expand.idEmprendedorFk.id,
              idEmiWeb: basicEmprendimiento.items[0].expand.idEmprendedorFk.idEmiWeb,
            );
            final nuevaImagen = Imagenes(imagenes: "", idEmprendimiento: 0);
            nuevaImagen.emprendedor.target = nuevoEmprendedor;
            nuevoEmprendedor.comunidad.target = comunidad;
            nuevoEmprendedor.imagen.target = nuevaImagen;
            nuevoEmprendedor.emprendimiento.target = nuevoEmprendimiento;
            nuevoEmprendimiento.emprendedor.target = nuevoEmprendedor;
            nuevoEmprendimiento.usuario.target = usuario;
            idEmprendimientoObjectBox = dataBase.emprendimientosBox.put(nuevoEmprendimiento);
            usuario.emprendimientos.add(nuevoEmprendimiento);
            dataBase.usuariosBox.put(usuario);
            //Se recupera colección de datos jornadas en Pocketbase
            var urlJornadas = Uri.parse("$baseUrl/api/collections/jornadas/records?filter=(id_emprendimiento_fk='$idEmprendimiento')&expand=id_tarea_fk.id_imagenes_fk");
            final headers = ({
                "Content-Type": "application/json",
              });
            var responseJornada = await get(
              urlJornadas,
              headers: headers
            );
            var basicJornadas = getBasicJornadaPocketbaseFromMap(responseJornada.body);
            if (responseJornada.statusCode == 200) {
              for (var elementJornada in basicJornadas.items) {
                if (elementJornada.numJornada == 1) {
                  final nuevaJornada1 = Jornadas(
                    numJornada: elementJornada.numJornada.toString(),
                    fechaRevision: elementJornada.proximaVisita!,
                    fechaRegistro: elementJornada.created,
                    completada: elementJornada.completada,
                    idDBR: elementJornada.id,
                    idEmiWeb: elementJornada.idEmiWeb, 
                    idEmprendimiento: idEmprendimientoObjectBox!,
                  );
                  final nuevaTarea1 = Tareas(
                    tarea: elementJornada.expand.idTareaFk.tarea,
                    descripcion: "Creación Jornada 1",
                    fechaRevision: elementJornada.expand.idTareaFk.fechaRevision!,
                    fechaRegistro: elementJornada.expand.idTareaFk.created,
                    idDBR: elementJornada.expand.idTareaFk.id,
                    idEmiWeb: elementJornada.expand.idTareaFk.idEmiWeb,
                    idEmprendimiento: idEmprendimientoObjectBox!,
                  );
                  nuevaJornada1.tarea.target = nuevaTarea1;
                  nuevaJornada1.emprendimiento.target = nuevoEmprendimiento;
                  nuevaTarea1.jornada.target = nuevaJornada1;
                  nuevoEmprendimiento.jornadas.add(nuevaJornada1);
                  dataBase.jornadasBox.put(nuevaJornada1);
                  dataBase.tareasBox.put(nuevaTarea1);
                  dataBase.emprendimientosBox.put(nuevoEmprendimiento);
                }
                if (elementJornada.numJornada == 2) {
                  final nuevaJornada2 = Jornadas(
                    numJornada: elementJornada.numJornada.toString(),
                    fechaRevision: elementJornada.proximaVisita!,
                    fechaRegistro: elementJornada.created,
                    completada: elementJornada.completada,
                    idDBR: elementJornada.id,
                    idEmiWeb: elementJornada.idEmiWeb,
                    idEmprendimiento: idEmprendimientoObjectBox!,
                  );
                  final nuevaTarea2 = Tareas(
                    tarea: elementJornada.expand.idTareaFk.tarea,
                    descripcion: "Creación Jornada 2",
                    comentarios: elementJornada.expand.idTareaFk.comentarios,
                    fechaRevision: elementJornada.expand.idTareaFk.fechaRevision!,
                    fechaRegistro: elementJornada.expand.idTareaFk.created,
                    idDBR: elementJornada.expand.idTareaFk.id,
                    idEmiWeb: elementJornada.expand.idTareaFk.idEmiWeb,
                    idEmprendimiento: idEmprendimientoObjectBox!,
                  );
                  for (var i = 0; i < elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList().length; i++) {
                    // Se agrega nueva imagen
                    final uInt8ListImagen = base64Decode(elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].base64);
                    final tempDir = await getTemporaryDirectory();
                    File file = await File('${tempDir.path}/${elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].nombre}').create();
                    file.writeAsBytesSync(uInt8ListImagen);
                    final nuevaImagenTarea = Imagenes(
                      imagenes: file.path,
                      nombre: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].nombre,
                      path: file.path,
                      base64: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].base64,
                      idDBR: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].id,
                      idEmiWeb: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].idEmiWeb,
                      idEmprendimiento: idEmprendimientoObjectBox!,
                      ); //Se crea el objeto imagenes para la Tarea
                    nuevaImagenTarea.tarea.target = nuevaTarea2;
                    dataBase.imagenesBox.put(nuevaImagenTarea);
                    nuevaTarea2.imagenes.add(nuevaImagenTarea);
                  }
                  nuevaJornada2.tarea.target = nuevaTarea2;
                  nuevaJornada2.emprendimiento.target = nuevoEmprendimiento;
                  nuevaTarea2.jornada.target = nuevaJornada2;
                  nuevoEmprendimiento.jornadas.add(nuevaJornada2);
                  dataBase.jornadasBox.put(nuevaJornada2);
                  dataBase.tareasBox.put(nuevaTarea2);
                  dataBase.emprendimientosBox.put(nuevoEmprendimiento);
                }
                if (elementJornada.numJornada == 3) {
                  final nuevaJornada3 = Jornadas(
                    numJornada: elementJornada.numJornada.toString(),
                    fechaRevision: elementJornada.proximaVisita!,
                    fechaRegistro: elementJornada.created,
                    completada: elementJornada.completada,
                    idDBR: elementJornada.id,
                    idEmiWeb: elementJornada.idEmiWeb,
                    idEmprendimiento: idEmprendimientoObjectBox!,
                  );
                  final nuevaTarea3 = Tareas(
                    tarea: elementJornada.expand.idTareaFk.tarea,
                    descripcion: elementJornada.expand.idTareaFk.descripcion,
                    comentarios: elementJornada.expand.idTareaFk.comentarios,
                    fechaRevision: elementJornada.expand.idTareaFk.fechaRevision!,
                    fechaRegistro: elementJornada.expand.idTareaFk.created,
                    idDBR: elementJornada.expand.idTareaFk.id,
                    idEmiWeb: elementJornada.expand.idTareaFk.idEmiWeb,
                    idEmprendimiento: idEmprendimientoObjectBox!,
                  );
                  for (var i = 0; i < elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList().length; i++) {
                    // Se agrega nueva imagen
                    final uInt8ListImagen = base64Decode(elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].base64);
                    final tempDir = await getTemporaryDirectory();
                    File file = await File('${tempDir.path}/${elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].nombre}').create();
                    file.writeAsBytesSync(uInt8ListImagen);
                    final nuevaImagenTarea = Imagenes(
                      imagenes: file.path,
                      nombre: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].nombre,
                      path: file.path,
                      base64: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].base64,
                      idDBR: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].id,
                      idEmiWeb: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].idEmiWeb,
                      idEmprendimiento: idEmprendimientoObjectBox!,
                      ); //Se crea el objeto imagenes para la Tarea
                    nuevaImagenTarea.tarea.target = nuevaTarea3;
                    dataBase.imagenesBox.put(nuevaImagenTarea);
                    nuevaTarea3.imagenes.add(nuevaImagenTarea);
                  }
                  nuevaJornada3.tarea.target = nuevaTarea3;
                  nuevaJornada3.emprendimiento.target = nuevoEmprendimiento;
                  nuevaTarea3.jornada.target = nuevaJornada3;
                  nuevoEmprendimiento.jornadas.add(nuevaJornada3);
                  dataBase.jornadasBox.put(nuevaJornada3);
                  dataBase.tareasBox.put(nuevaTarea3);
                  dataBase.emprendimientosBox.put(nuevoEmprendimiento);
                }
                if (elementJornada.numJornada == 4) {
                  final nuevaJornada4 = Jornadas(
                    numJornada: elementJornada.numJornada.toString(),
                    fechaRevision: elementJornada.proximaVisita!,
                    fechaRegistro: elementJornada.created,
                    completada: elementJornada.completada,
                    idDBR: elementJornada.id,
                    idEmiWeb: elementJornada.idEmiWeb,
                    idEmprendimiento: idEmprendimientoObjectBox!,
                  );
                  final nuevaTarea4 = Tareas(
                    tarea: "Creación Jornada 4",
                    descripcion: "Creación Jornada 4",
                    comentarios: elementJornada.expand.idTareaFk.comentarios,
                    fechaRevision: elementJornada.expand.idTareaFk.fechaRevision!,
                    fechaRegistro: elementJornada.expand.idTareaFk.created,
                    idDBR: elementJornada.expand.idTareaFk.id,
                    idEmiWeb: elementJornada.expand.idTareaFk.idEmiWeb,
                    idEmprendimiento: idEmprendimientoObjectBox!,
                  );
                  for (var i = 0; i < elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList().length; i++) {
                    // Se agrega nueva imagen
                    final uInt8ListImagen = base64Decode(elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].base64);
                    final tempDir = await getTemporaryDirectory();
                    File file = await File('${tempDir.path}/${elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].nombre}').create();
                    file.writeAsBytesSync(uInt8ListImagen);
                    final nuevaImagenTarea = Imagenes(
                      imagenes: file.path,
                      nombre: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].nombre,
                      path: file.path,
                      base64: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].base64,
                      idDBR: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].id,
                      idEmiWeb: elementJornada.expand.idTareaFk.expand!.idImagenesFk.toList()[i].idEmiWeb,
                      idEmprendimiento: idEmprendimientoObjectBox!,
                      ); //Se crea el objeto imagenes para la Tarea
                    nuevaImagenTarea.tarea.target = nuevaTarea4;
                    dataBase.imagenesBox.put(nuevaImagenTarea);
                    nuevaTarea4.imagenes.add(nuevaImagenTarea);
                  }
                  nuevaJornada4.tarea.target = nuevaTarea4;
                  nuevaJornada4.emprendimiento.target = nuevoEmprendimiento;
                  nuevaTarea4.jornada.target = nuevaJornada4;
                  nuevoEmprendimiento.jornadas.add(nuevaJornada4);
                  dataBase.jornadasBox.put(nuevaJornada4);
                  dataBase.tareasBox.put(nuevaTarea4);
                  dataBase.emprendimientosBox.put(nuevoEmprendimiento);
                }
              }
              banderasExitoSync.add(true);
            } else {
              print("No éxito en recuperar jornadas");
              banderasExitoSync.add(false);
            }
            //Se recupera colección de datos consultorías en Pocketbase
            var urlConsultorias = Uri.parse("$baseUrl/api/collections/consultorias/records?filter=(id_emprendimiento_fk='$idEmprendimiento')&expand=id_ambito_fk,id_area_circulo_fk,id_tarea_fk.id_porcentaje_fk");

            var responseConsultoria = await get(
              urlConsultorias,
              headers: headers
            );
            var basicConsultorias = getBasicConsultoriaPocketbaseFromMap(responseConsultoria.body);
            if (responseConsultoria.statusCode == 200) {
              for (var elementConsultoria in basicConsultorias.items) {
                final nuevaConsultoria= Consultorias(
                  fechaRegistro: elementConsultoria.created,
                  archivado: elementConsultoria.archivado,
                  idDBR: elementConsultoria.id,
                  idEmiWeb: elementConsultoria.idEmiWeb,
                  idEmprendimiento: idEmprendimientoObjectBox!,
                );
                for (var i = 0; i < elementConsultoria.expand.idTareaFk.toList().length; i++) {
                  final nuevaTarea = Tareas(
                    tarea: elementConsultoria.expand.idTareaFk[i].tarea,
                    descripcion: elementConsultoria.expand.idTareaFk[i].descripcion,
                    comentarios: elementConsultoria.expand.idTareaFk[i].comentarios,
                    fechaRevision: elementConsultoria.expand.idTareaFk[i].fechaRevision!,
                    fechaRegistro: elementConsultoria.expand.idTareaFk[i].created,
                    idDBR: elementConsultoria.expand.idTareaFk[i].id,
                    idEmiWeb: elementConsultoria.expand.idTareaFk[i].idEmiWeb,
                    idEmprendimiento: idEmprendimientoObjectBox!,
                  );
                  final porcentajeAvance = dataBase.porcentajeAvanceBox.query(PorcentajeAvance_.idEmiWeb.equals(elementConsultoria.expand.idTareaFk[i].expand!.idPorcentajeFk.idEmiWeb)).build().findFirst();
                  final ambito = dataBase.ambitoConsultoriaBox.query(AmbitoConsultoria_.idEmiWeb.equals(elementConsultoria.expand.idAmbitoFk.idEmiWeb)).build().findFirst();
                  final areaCirculo = dataBase.areaCirculoBox.query(AreaCirculo_.idEmiWeb.equals(elementConsultoria.expand.idAreaCirculoFk.idEmiWeb)).build().findFirst();
                  if (porcentajeAvance != null && ambito != null && areaCirculo != null) {
                    nuevaTarea.porcentaje.target = porcentajeAvance;
                    nuevaConsultoria.ambitoConsultoria.target = ambito;
                    nuevaConsultoria.areaCirculo.target = areaCirculo;
                  }
                  if (elementConsultoria.expand.idTareaFk[i].idImagenesFk.isNotEmpty) {
                    final recordGetOneImagenConsultoria = await client.records.getOne('imagenes', elementConsultoria.expand.idTareaFk[i].idImagenesFk[0]);
                    if (recordGetOneImagenConsultoria.id.isNotEmpty) {
                      final imagenConsultoriaParse = getBasicImagenPocketbaseFromMap(recordGetOneImagenConsultoria.toString());
                      // Se agrega nueva imagen de la tarea
                      final uInt8ListImagen = base64Decode(imagenConsultoriaParse.base64);
                      final tempDir = await getTemporaryDirectory();
                      File file = await File('${tempDir.path}/${imagenConsultoriaParse.nombre}').create();
                      file.writeAsBytesSync(uInt8ListImagen);
                      final nuevaImagenTarea = Imagenes(
                        imagenes: file.path,
                        nombre: imagenConsultoriaParse.nombre,
                        path: file.path,
                        base64: imagenConsultoriaParse.base64,
                        idDBR: imagenConsultoriaParse.id,
                        idEmiWeb: imagenConsultoriaParse.idEmiWeb,
                        idEmprendimiento: idEmprendimientoObjectBox!,
                        ); //Se crea el objeto imagenes para la Tarea
                      nuevaImagenTarea.tarea.target = nuevaTarea;
                      dataBase.imagenesBox.put(nuevaImagenTarea);
                      nuevaTarea.imagenes.add(nuevaImagenTarea);
                    }
                  }
                  nuevaConsultoria.tareas.add(nuevaTarea);
                  nuevaConsultoria.emprendimiento.target = nuevoEmprendimiento;
                  nuevaTarea.consultoria.target = nuevaConsultoria;
                  nuevoEmprendimiento.consultorias.add(nuevaConsultoria);
                  dataBase.consultoriasBox.put(nuevaConsultoria);
                  dataBase.tareasBox.put(nuevaTarea);
                  dataBase.emprendimientosBox.put(nuevoEmprendimiento);
                }
              }
              banderasExitoSync.add(true);
            } else {
              print(responseConsultoria.statusCode);
              print("No éxito en recuperar consultorías");
              banderasExitoSync.add(false);
            }
            //Se recupera colección de datos productos emp en Pocketbase
            var urlProductosEmp = Uri.parse("$baseUrl/api/collections/productos_emp/records?filter=(id_emprendimiento_fk='$idEmprendimiento')&expand=id_imagen_fk,id_und_medida_fk");

            var responseProductosEmp = await get(
              urlProductosEmp,
              headers: headers
            );
            var basicProductosEmp = getBasicProductoEmpPocketbaseFromMap(responseProductosEmp.body);
            if (responseProductosEmp.statusCode == 200) {
              for (var elementProductoEmp in basicProductosEmp.items) {
                final nuevoProductoEmp = ProductosEmp(
                  nombre: elementProductoEmp.nombreProdEmp,
                  descripcion: elementProductoEmp.descripcion,
                  costo: elementProductoEmp.costoProdEmp,
                  idDBR: elementProductoEmp.id,
                  idEmiWeb: elementProductoEmp.idEmiWeb,
                  idEmprendimiento: idEmprendimientoObjectBox!,
                );
                final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idEmiWeb.equals(elementProductoEmp.expand.idUndMedidaFk.idEmiWeb)).build().findFirst();
                if (unidadMedida != null) {
                  nuevoProductoEmp.unidadMedida.target = unidadMedida;
                }
                if (elementProductoEmp.expand.idImagenFk?.created != null) {
                  // Se agrega nueva imagen del productoEmp
                  final uInt8ListImagen = base64Decode(elementProductoEmp.expand.idImagenFk!.base64);
                  final tempDir = await getTemporaryDirectory();
                  File file = await File('${tempDir.path}/${elementProductoEmp.expand.idImagenFk!.nombre}').create();
                  file.writeAsBytesSync(uInt8ListImagen);
                  final nuevaImagenProductoEmp = Imagenes(
                    imagenes: file.path,
                    nombre: elementProductoEmp.expand.idImagenFk!.nombre,
                    path: file.path,
                    base64: elementProductoEmp.expand.idImagenFk!.base64,
                    idDBR: elementProductoEmp.expand.idImagenFk!.id,
                    idEmiWeb: elementProductoEmp.expand.idImagenFk!.idEmiWeb,
                    idEmprendimiento: idEmprendimientoObjectBox!,
                    ); //Se crea el objeto imagenes para el productoEmp
                  nuevaImagenProductoEmp.productosEmp.target = nuevoProductoEmp;
                  dataBase.imagenesBox.put(nuevaImagenProductoEmp);
                  nuevoProductoEmp.imagen.target = nuevaImagenProductoEmp;
                }
                nuevoProductoEmp.emprendimientos.target = nuevoEmprendimiento;
                nuevoEmprendimiento.productosEmp.add(nuevoProductoEmp);
                dataBase.productosEmpBox.put(nuevoProductoEmp);
                dataBase.emprendimientosBox.put(nuevoEmprendimiento);
              }
              banderasExitoSync.add(true);
            } else {
              print(responseProductosEmp.statusCode);
              print("No éxito en recuperar productos emp");
              banderasExitoSync.add(false);
  
            }
            //Se recupera colección de datos ventas en Pocketbase
            var urlVentas = Uri.parse("$baseUrl/api/collections/ventas/records?filter=(id_emprendimiento_fk='$idEmprendimiento')");

            var responseVentas = await get(
              urlVentas,
              headers: headers
            );
            var basicVentas = getBasicVentaPocketbaseFromMap(responseVentas.body);
            if (responseVentas.statusCode == 200) {
              for (var elementVenta in basicVentas.items) {
                final nuevaVenta = Ventas(
                  fechaInicio: elementVenta.fechaInicio,
                  fechaTermino: elementVenta.fechaTermino,
                  total: elementVenta.total,
                  idDBR: elementVenta.id,
                  idEmiWeb: elementVenta.idEmiWeb,
                  idEmprendimiento: idEmprendimientoObjectBox!,
                );
                var urlProdVendidos = Uri.parse("$baseUrl/api/collections/prod_vendidos/records?filter=(id_venta_fk='${elementVenta.id}')&expand=id_und_medida_fk");

                var responseProdVendidos = await get(
                  urlProdVendidos,
                  headers: headers
                );
                var basicProdVendidos = getBasicProductoVendidoPocketbaseFromMap(responseProdVendidos.body);
                if (responseProdVendidos.statusCode == 200) {
                  for (var elementProdVendido in basicProdVendidos.items) {
                    // Se agrega nuevo prod vendido a la venta
                    final nuevoProdVendido = ProdVendidos(
                      nombreProd: elementProdVendido.nombreProd,
                      descripcion: elementProdVendido.descripcion,
                      costo: elementProdVendido.costo, 
                      cantVendida: elementProdVendido.cantidadVendida,
                      subtotal: elementProdVendido.subTotal,
                      precioVenta: elementProdVendido.precioVenta, 
                      idDBR: elementProdVendido.id,
                      idEmiWeb: elementProdVendido.idEmiWeb,
                      idEmprendimiento: idEmprendimientoObjectBox!,
                    );
                    final productoEmp = dataBase.productosEmpBox.query(ProductosEmp_.idDBR.equals(elementProdVendido.idProductosEmpFk)).build().findFirst();
                    final unidadMedida = dataBase.unidadesMedidaBox.query(UnidadMedida_.idEmiWeb.equals(elementProdVendido.expand.idUndMedidaFk.idEmiWeb)).build().findFirst();
                    if (unidadMedida != null && productoEmp != null) {
                      nuevoProdVendido.productoEmp.target = productoEmp;
                      nuevoProdVendido.unidadMedida.target = unidadMedida;
                    }
                    nuevoProdVendido.venta.target = nuevaVenta;
                    dataBase.productosVendidosBox.put(nuevoProdVendido);
                    nuevaVenta.prodVendidos.add(nuevoProdVendido);
                  }
                } else {
                  print(responseProdVendidos.statusCode);
                  print("No éxito en recuperar prod vendidos");
                  banderasExitoSync.add(false);
                  continue;
                }
                nuevaVenta.emprendimiento.target = nuevoEmprendimiento;
                nuevoEmprendimiento.ventas.add(nuevaVenta);
                dataBase.ventasBox.put(nuevaVenta);
                dataBase.emprendimientosBox.put(nuevoEmprendimiento);
              }
              banderasExitoSync.add(true);
            } else {
              print(responseVentas.statusCode);
              print("No éxito en recuperar ventas");
              banderasExitoSync.add(false);
            }
            //Se recupera colección de datos inveriones en Pocketbase
            var urlInversiones = Uri.parse("$baseUrl/api/collections/inversiones/records?filter=(id_emprendimiento_fk='$idEmprendimiento')&expand=id_estado_inversion_fk,id_imagen_firma_recibido_fk,id_imagen_producto_entregado_fk");

            var responseInverisones = await get(
              urlInversiones,
              headers: headers
            );
            var basicInversion = getBasicInversionPocketbaseFromMap(responseInverisones.body);
            if (responseInverisones.statusCode == 200) {
              for (var elementInversion in basicInversion.items) {
                final nuevaInversion = Inversiones(
                  porcentajePago: elementInversion.porcentajePago,
                  montoPagar: elementInversion.montoPagar,
                  saldo: elementInversion.saldo,
                  totalInversion: elementInversion.totalInversion,
                  fechaRegistro: elementInversion.created,
                  idDBR: elementInversion.id,
                  idEmiWeb: elementInversion.idEmiWeb,
                  jornada3: elementInversion.jornada3,
                  idEmprendimiento: idEmprendimientoObjectBox!,
                );
                final estadoInversion = dataBase.estadoInversionBox.query(EstadoInversion_.idDBR.equals(elementInversion.expand.idEstadoInversionFk.id)).build().findFirst();
                if (estadoInversion != null) {
                  nuevaInversion.estadoInversion.target = estadoInversion;
                }

                if (elementInversion.jornada3) {
                  nuevaInversion.emprendimiento.target = nuevoEmprendimiento;
                  nuevoEmprendimiento.inversiones.add(nuevaInversion);
                  final idInversion = dataBase.inversionesBox.put(nuevaInversion);
                  nuevoEmprendimiento.idInversionJornada = idInversion;
                  dataBase.emprendimientosBox.put(nuevoEmprendimiento); 

                  var urlProductosProyecto = Uri.parse("$baseUrl/api/collections/productos_proyecto/records?filter=(id_inversion_fk='${elementInversion.id}')&expand=id_familia_prod_fk,id_tipo_empaque_fk");

                  var responseProductosProyecto = await get(
                    urlProductosProyecto,
                    headers: headers
                  );
                  var basicProductosProyecto = getBasicProductosProyectoPocketbaseFromMap(responseProductosProyecto.body);
                  if (responseProductosProyecto.statusCode == 200) {
                    for (var elementProductosProyecto in basicProductosProyecto.items) {
                      // Se agrega nuevo prod solicitado a la inversion
                      final nuevoProdSolicitado = ProdSolicitado(
                        idInversion: idInversion,
                        producto: elementProductosProyecto.producto,
                        marcaSugerida: elementProductosProyecto.marcaSugerida,
                        descripcion: elementProductosProyecto.descripcion,
                        proveedorSugerido: elementProductosProyecto.proveedorSugerido,
                        cantidad: elementProductosProyecto.cantidad, 
                        costoEstimado: double.parse(elementProductosProyecto.costoEstimado),
                        fechaRegistro: elementProductosProyecto.created,
                        idDBR: elementProductosProyecto.id,
                        idEmiWeb: elementProductosProyecto.idEmiWeb,
                        idEmprendimiento: idEmprendimientoObjectBox!,
                      );
                      final familiaProd = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(elementProductosProyecto.idFamiliaProdFk)).build().findFirst();
                      final tipoEmpaques = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idDBR.equals(elementProductosProyecto.idTipoEmpaqueFk)).build().findFirst();
                      if (familiaProd != null && tipoEmpaques != null) {
                        nuevoProdSolicitado.familiaProducto.target = familiaProd;
                        nuevoProdSolicitado.tipoEmpaques.target = tipoEmpaques;
                      }
                      nuevoProdSolicitado.inversion.target = nuevaInversion;
                      dataBase.productosSolicitadosBox.put(nuevoProdSolicitado);
                      nuevaInversion.prodSolicitados.add(nuevoProdSolicitado);
                      dataBase.inversionesBox.put(nuevaInversion);
                    }
                    final nuevaInversionXProdCotizados = InversionesXProdCotizados(idEmprendimiento: idEmprendimientoObjectBox!,); //Se crea la inversion x prod Cotizados
                    nuevaInversionXProdCotizados.inversion.target = nuevaInversion;
                    dataBase.inversionesXprodCotizadosBox.put(nuevaInversionXProdCotizados);
                    nuevaInversion.inversionXprodCotizados.add(nuevaInversionXProdCotizados);
                    dataBase.inversionesBox.put(nuevaInversion);
                  } else {
                    print(responseProductosProyecto.statusCode);
                    print("No éxito en recuperar Productos Proyecto");
                    banderasExitoSync.add(false);
                    continue;
                  }
                  
                } else {
                  nuevaInversion.emprendimiento.target = nuevoEmprendimiento;
                  nuevoEmprendimiento.inversiones.add(nuevaInversion);
                  final idInversion = dataBase.inversionesBox.put(nuevaInversion);
                  dataBase.emprendimientosBox.put(nuevoEmprendimiento); 

                  var urlProdSolicitados = Uri.parse("$baseUrl/api/collections/productos_solicitados/records?filter=(id_inversion_fk='${elementInversion.id}')&expand=id_familia_prod_fk,id_tipo_empaques_fk,id_imagen_fk");

                  var responseProdSolicitados = await get(
                    urlProdSolicitados,
                    headers: headers
                  );
                  var basicProdSolicitados = getBasicProductoSolicitadoPocketbaseFromMap(responseProdSolicitados.body);
                  if (responseProdSolicitados.statusCode == 200) {
                    for (var elementProdSolicitado in basicProdSolicitados.items) {
                      // Se agrega nuevo prod solicitado a la inversion
                      final nuevoProdSolicitado = ProdSolicitado(
                        idInversion: idInversion,
                        producto: elementProdSolicitado.producto,
                        marcaSugerida: elementProdSolicitado.marcaSugerida,
                        descripcion: elementProdSolicitado.descripcion,
                        proveedorSugerido: elementProdSolicitado.proveedoSugerido,
                        cantidad: elementProdSolicitado.cantidad, 
                        costoEstimado: elementProdSolicitado.costoEstimado,
                        fechaRegistro: elementProdSolicitado.created,
                        idDBR: elementProdSolicitado.id,
                        idEmiWeb: elementProdSolicitado.idEmiWeb,
                        idEmprendimiento: idEmprendimientoObjectBox!,
                      );
                      final familiaProd = dataBase.familiaProductosBox.query(FamiliaProd_.idDBR.equals(elementProdSolicitado.idFamiliaProdFk)).build().findFirst();
                      final tipoEmpaques = dataBase.tipoEmpaquesBox.query(TipoEmpaques_.idDBR.equals(elementProdSolicitado.idTipoEmpaquesFk)).build().findFirst();
                      if (familiaProd != null && tipoEmpaques != null) {
                        nuevoProdSolicitado.familiaProducto.target = familiaProd;
                        nuevoProdSolicitado.tipoEmpaques.target = tipoEmpaques;
                      }
                      if (elementProdSolicitado.expand.idImagenFk?.created != null) {
                        // Se agrega nueva imagen del producto Solicitado
                        final uInt8ListImagen = base64Decode(elementProdSolicitado.expand.idImagenFk!.base64);
                        final tempDir = await getTemporaryDirectory();
                        File file = await File('${tempDir.path}/${elementProdSolicitado.expand.idImagenFk!.nombre}').create();
                        file.writeAsBytesSync(uInt8ListImagen);
                        final nuevaImagenProdSolicitado = Imagenes(
                          imagenes: file.path,
                          nombre: elementProdSolicitado.expand.idImagenFk!.nombre,
                          path: file.path,
                          base64: elementProdSolicitado.expand.idImagenFk!.base64,
                          idDBR: elementProdSolicitado.expand.idImagenFk!.id,
                          idEmiWeb: elementProdSolicitado.expand.idImagenFk!.idEmiWeb,
                          idEmprendimiento: idEmprendimientoObjectBox!,
                          ); //Se crea el objeto imagenes para el producto Solicitado
                        dataBase.imagenesBox.put(nuevaImagenProdSolicitado);
                        nuevoProdSolicitado.imagen.target = nuevaImagenProdSolicitado;
                      }
                      nuevoProdSolicitado.inversion.target = nuevaInversion;
                      dataBase.productosSolicitadosBox.put(nuevoProdSolicitado);
                      nuevaInversion.prodSolicitados.add(nuevoProdSolicitado);
                      dataBase.inversionesBox.put(nuevaInversion);
                    }
                  } else {
                    print(responseProdSolicitados.statusCode);
                    print("No éxito en recuperar prod solicitados");
                    banderasExitoSync.add(false);
                    continue;
                  }
                  var urlInversionXProdCotizados = Uri.parse("$baseUrl/api/collections/inversion_x_prod_cotizados/records?filter=(id_inversion_fk='${elementInversion.id}')");

                  var responseInversionXProdCotizados = await get(
                    urlInversionXProdCotizados,
                    headers: headers
                  );
                  var basicInversionXProdCotizados = getBasicInversionXProdCotizadosPocketbaseFromMap(responseInversionXProdCotizados.body);
                  if (responseInversionXProdCotizados.statusCode == 200) {
                    if (basicInversionXProdCotizados.items.toList().isEmpty) {
                        final nuevaInversionXProdCotizados = InversionesXProdCotizados(idEmprendimiento: idEmprendimientoObjectBox!,); //Se crea la inversion x prod Cotizados
                        nuevaInversionXProdCotizados.inversion.target = nuevaInversion;
                        dataBase.inversionesXprodCotizadosBox.put(nuevaInversionXProdCotizados);
                        nuevaInversion.inversionXprodCotizados.add(nuevaInversionXProdCotizados);
                        dataBase.inversionesBox.put(nuevaInversion);
                    } else {
                      for (var elementInversionXProdCotizados in basicInversionXProdCotizados.items) {
                        // Se agrega nueva InversionXProdCotizados a la inversion
                        final nuevaInversionXProdCotizados = InversionesXProdCotizados(
                          aceptado: elementInversionXProdCotizados.aceptado,
                          fechaRegistro: elementInversionXProdCotizados.created,
                          idDBR: elementInversionXProdCotizados.id,
                          idEmiWeb: elementInversionXProdCotizados.idEmiWeb,
                          idEmprendimiento: idEmprendimientoObjectBox!,
                        );
                        nuevaInversionXProdCotizados.inversion.target = nuevaInversion;
                        dataBase.inversionesXprodCotizadosBox.put(nuevaInversionXProdCotizados);
                        nuevaInversion.inversionXprodCotizados.add(nuevaInversionXProdCotizados);
                        dataBase.inversionesBox.put(nuevaInversion);

                        var urlProductosCotizados = Uri.parse("$baseUrl/api/collections/productos_cotizados/records?filter=(id_inversion_x_prod_cotizados_fk='${elementInversionXProdCotizados.id}')&expand=id_producto_prov_fk");

                        var responseProductosCotizados = await get(
                          urlProductosCotizados,
                          headers: headers
                        );
                        var basicProductosCotizados = getBasicProductosCotizadosPocketbaseFromMap(responseProductosCotizados.body);
                        if (responseProductosCotizados.statusCode == 200) {
                          for (var elementProductosCotizados in basicProductosCotizados.items) {
                            // Se agrega nueva ProductosCotizados a la inversion
                            final nuevoProductoCotizado = ProdCotizados(
                              aceptado: elementProductosCotizados.aceptado,
                              cantidad: elementProductosCotizados.cantidad,
                              costoTotal: elementProductosCotizados.costoTotal,
                              costoUnitario: (elementProductosCotizados.costoTotal/elementProductosCotizados.cantidad),
                              fechaRegistro: elementProductosCotizados.created,
                              idDBR: elementProductosCotizados.id,
                              idEmiWeb: elementProductosCotizados.idEmiWeb,
                              idEmprendimiento: idEmprendimientoObjectBox!,
                            );
                            final productoProv = dataBase.productosProvBox.query(ProductosProv_.idDBR.equals(elementProductosCotizados.idProductoProvFk)).build().findFirst();
                            if (productoProv != null) {
                              nuevoProductoCotizado.productosProv.target = productoProv;
                            }
                            nuevoProductoCotizado.inversionXprodCotizados.target = nuevaInversionXProdCotizados;
                            dataBase.productosCotBox.put(nuevoProductoCotizado);
                            nuevaInversionXProdCotizados.prodCotizados.add(nuevoProductoCotizado);
                            dataBase.inversionesXprodCotizadosBox.put(nuevaInversionXProdCotizados);
                          }
                        } else {
                          print(responseProductosCotizados.statusCode);
                          print("No éxito en recuperar Prod cotizados");
                          banderasExitoSync.add(false);
                          continue;
                        }
                      }
                    }
                  } else {
                    print(responseInversionXProdCotizados.statusCode);
                    print("No éxito en recuperar inversiones x Prod cotizados");
                    banderasExitoSync.add(false);
                    continue;
                  }
                }
                var urlPagos = Uri.parse("$baseUrl/api/collections/pagos/records?filter=(id_inversion_fk='${elementInversion.id}')");

                var responsePagos = await get(
                  urlPagos,
                  headers: headers
                );
                var basicPagos = getBasicPagosPocketbaseFromMap(responsePagos.body);
                if (responsePagos.statusCode == 200) {
                  for (var elementPagos in basicPagos.items) {
                    // Se agrega nuevo Pago a la inversion
                    final nuevoPago = Pagos(
                      montoAbonado: elementPagos.montoAbonado,
                      fechaMovimiento: elementPagos.fechaMovimiento,
                      fechaRegistro: elementPagos.created,
                      idDBR: elementPagos.id,
                      idEmiWeb: elementPagos.idEmiWeb,
                      idEmprendimiento: idEmprendimientoObjectBox!,
                    );
                    nuevoPago.inversion.target = nuevaInversion;
                    dataBase.pagosBox.put(nuevoPago);
                    nuevaInversion.pagos.add(nuevoPago);
                    dataBase.inversionesBox.put(nuevaInversion);
                  }
                } else {
                  print(responsePagos.statusCode);
                  print("No éxito en recuperar Prod cotizados");
                  banderasExitoSync.add(false);
                  continue;
                }
              }
              banderasExitoSync.add(true);
            } else {
              print(responseInverisones.statusCode);
              print("No éxito en recuperar inversiones");
              banderasExitoSync.add(false);
            }
          } else {
            print("No se encontro la fase y comunidad en Pocketbase en el dispositivo");
            banderasExitoSync.add(false);
          }
        } else {
          banderasExitoSync.add(false);
        }
      for (var element in banderasExitoSync) {
      //Aplicamos una operación and para validar que no haya habido un catálogo con False
        exitoso = exitoso && element;
      }
      //Verificamos que no haya habido errores al sincronizar con las banderas
      if (exitoso) {
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = true;
        banderasExitoSync.clear();
        notifyListeners();
        return exitoso;
      } else {
        procesocargando = false;
        procesoterminado = true;
        procesoexitoso = false;
        banderasExitoSync.clear();
        notifyListeners();
        return exitoso;
      }
    } catch (e) {
      print("Catch de Descarga Productos Externos Pocketbase: $e");
      procesocargando = false;
      procesoterminado = true;
      procesoexitoso = false;
      banderasExitoSync.clear();
      notifyListeners();
      return false;
    }
  }

}
