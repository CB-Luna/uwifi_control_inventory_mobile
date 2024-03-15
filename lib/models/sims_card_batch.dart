import 'dart:convert';

class SimsCardBatch {
  SimsCardBatch({
    this.sapId,
    this.pukCode,
    required this.provider,
    required this.imei,
  });

  String? sapId;
  String? pukCode;
  String provider;
  String imei;

  factory SimsCardBatch.fromJson(String str) => SimsCardBatch.fromMap(json.decode(str));

  factory SimsCardBatch.fromMap(Map<String, dynamic> json) {
    SimsCardBatch simsCardBatch = SimsCardBatch(
      sapId: json['sap_id'],
      pukCode: json['puk_code'],
      provider: json['provider'],
      imei: json['imei'],
    );

    return simsCardBatch;
  }
}
