// To parse this JSON data, do
//
//     final taxiPredictRes = taxiPredictResFromJson(jsonString);

import 'dart:convert';

TaxiPredictRes taxiPredictResFromJson(String str) => TaxiPredictRes.fromJson(json.decode(str));

String taxiPredictResToJson(TaxiPredictRes data) => json.encode(data.toJson());

class TaxiPredictRes {
  int? usetime;
  int? fee;
  double? distance;
  String? startaddress;
  String? endaddress;

  TaxiPredictRes({
    required this.usetime,
    required this.fee,
    required this.distance,
    required this.startaddress,
    required this.endaddress
  });

  factory TaxiPredictRes.fromJson(Map<String, dynamic> json) => TaxiPredictRes(
    usetime: json["usetime"],
    fee: json["fee"],
    distance: json["distance"],
    startaddress: json["startaddress"],
    endaddress: json["endaddress"],
  );

  Map<String, dynamic> toJson() => {
    "usetime": usetime,
    "fee": fee,
    "distance": distance,
    "startaddress":startaddress,
    "endaddress":endaddress,
  };
}
