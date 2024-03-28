// To parse this JSON data, do
//
//     final foodCompareReq = foodCompareReqFromJson(jsonString);

import 'dart:convert';

FoodCompareReq foodCompareReqFromJson(String str) =>
    FoodCompareReq.fromJson(json.decode(str));

String foodCompareReqToJson(FoodCompareReq data) => json.encode(data.toJson());

class FoodCompareReq {
  String latitude;
  String longitude;
  String name;
  int price;

  FoodCompareReq({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.price,
  });

  factory FoodCompareReq.fromJson(Map<String, dynamic> json) => FoodCompareReq(
        latitude: json["latitude"],
        longitude: json["longitude"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "name": name,
        "price": price,
      };
}
