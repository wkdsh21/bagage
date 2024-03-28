// To parse this JSON data, do
//
//     final taxiPredictReq = taxiPredictReqFromJson(jsonString);

import 'dart:convert';

TaxiPredictReq taxiPredictReqFromJson(String str) => TaxiPredictReq.fromJson(json.decode(str));

String taxiPredictReqToJson(TaxiPredictReq data) => json.encode(data.toJson());

class TaxiPredictReq {
  Xy start;
  Xy end;

  TaxiPredictReq({
    required this.start,
    required this.end,
  });

  factory TaxiPredictReq.fromJson(Map<String, dynamic> json) => TaxiPredictReq(
    start: Xy.fromJson(json["start"]),
    end: Xy.fromJson(json["end"]),
  );

  Map<String, dynamic> toJson() => {
    "start": start.toJson(),
    "end": end.toJson(),
  };
}

class Xy {
  String? latitude;
  String? longitude;

  Xy({
    required this.latitude,
    required this.longitude,
  });

  factory Xy.fromJson(Map<String, dynamic> json) => Xy(
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}
