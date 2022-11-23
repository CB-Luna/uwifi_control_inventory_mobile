import 'dart:convert';

GetEmprendimientoPocketbaseTemp getEmprendimientoPocketbaseTempFromMap(String str) => GetEmprendimientoPocketbaseTemp.fromMap(json.decode(str));

String getEmprendimientoPocketbaseTempToMap(GetEmprendimientoPocketbaseTemp data) => json.encode(data.toMap());

class GetEmprendimientoPocketbaseTemp {
    GetEmprendimientoPocketbaseTemp({
        required this.collectionId,
        required this.collectionName,
        required this.id,
        required this.created,
        required this.updated,
        required this.nombreEmprendimiento,
        required this.descripcion,
        required this.activo,
        required this.archivado,
        required this.idPromotorFk,
        required this.idPrioridadFk,
        required this.idFaseEmpFk,
        required this.idStatusSyncFk,
        required this.idEmprendedorFk,
        required this.idNombreProyectoFk,
        required this.idEmiWeb,
    });

    final String collectionId;
    final String collectionName;
    final String id;
    final DateTime? created;
    final DateTime? updated;
    final String nombreEmprendimiento;
    final String descripcion;
    final bool activo;
    final bool archivado;
    final String idPromotorFk;
    final String idPrioridadFk;
    final String idFaseEmpFk;
    final String idStatusSyncFk;
    final String idEmprendedorFk;
    final String? idNombreProyectoFk;
    final String idEmiWeb;

    factory GetEmprendimientoPocketbaseTemp.fromMap(Map<String, dynamic> json) => GetEmprendimientoPocketbaseTemp(
        collectionId: json["@collectionId"],
        collectionName: json["@collectionName"],
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        nombreEmprendimiento: json["nombre_emprendimiento"],
        descripcion: json["descripcion"],
        activo: json["activo"],
        archivado: json["archivado"],
        idPromotorFk: json["id_promotor_fk"],
        idPrioridadFk: json["id_prioridad_fk"],
        idFaseEmpFk: json["id_fase_emp_fk"],
        idStatusSyncFk: json["id_status_sync_fk"],
        idEmprendedorFk: json["id_emprendedor_fk"],
        idNombreProyectoFk: json["id_nombre_proyecto_fk"],
        idEmiWeb: json["id_emi_web"],
    );

    Map<String, dynamic> toMap() => {
        "@collectionId": collectionId,
        "@collectionName": collectionName,
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "updated": updated == null ? null : updated!.toIso8601String(),
        "nombre_emprendimiento": nombreEmprendimiento,
        "descripcion": descripcion,
        "activo": activo,
        "archivado": archivado,
        "id_promotor_fk": idPromotorFk,
        "id_prioridad_fk": idPrioridadFk,
        "id_fase_emp_fk": idFaseEmpFk,
        "id_status_sync_fk": idStatusSyncFk,
        "id_emprendedor_fk": idEmprendedorFk,
        "id_nombre_proyecto_fk": idNombreProyectoFk,
        "id_emi_web": idEmiWeb,
    };
}
