import 'dart:convert';

class SimsCardBatch {
  SimsCardBatch({
    required this.sapId,
    required this.imei,
  });

  String sapId;
  String imei;

  factory SimsCardBatch.fromJson(String str) => SimsCardBatch.fromMap(json.decode(str));

  factory SimsCardBatch.fromMap(Map<String, dynamic> json) {
    SimsCardBatch simsCardBatch = SimsCardBatch(
      sapId: json['sap_id'],
      imei: json['imei'],
    );

    return simsCardBatch;
  }
}
