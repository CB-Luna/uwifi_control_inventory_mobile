import 'dart:convert';

GetStatusSupabase getStatusSupabaseFromMap(String str) => GetStatusSupabase.fromMap(json.decode(str));

String getStatusSupabaseToMap(GetStatusSupabase data) => json.encode(data.toMap());

class GetStatusSupabase {
    GetStatusSupabase({
        required this.id,
        required this.status,
        required this.dateAdded,
    });

    final String id;
    final String status;
    final DateTime dateAdded;

    factory GetStatusSupabase.fromMap(Map<String, dynamic> json) => GetStatusSupabase(
        id: json["id_status"],
        status: json["status"],
        dateAdded: DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toMap() => {
        "id_status": id,
        "status": status,
        "date_added": dateAdded.toIso8601String(),
    };
}
