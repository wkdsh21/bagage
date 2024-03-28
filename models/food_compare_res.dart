// To parse this JSON data, do
//
//     final foodCompareRes = foodCompareResFromJson(jsonString);

import 'dart:convert';

FoodCompareRes foodCompareResFromJson(String str) =>
    FoodCompareRes.fromJson(json.decode(str));

String foodCompareResToJson(FoodCompareRes data) => json.encode(data.toJson());

class FoodCompareRes {
  List<Shoplist> shoplist;
  List<Mobomlist> mobomlist;
  int avgprice;
  int maxprice;
  int minprice;
  int nationalprice;
  String prompt;
  String rank;

  FoodCompareRes({
    required this.shoplist,
    required this.mobomlist,
    required this.avgprice,
    required this.maxprice,
    required this.minprice,
    required this.nationalprice,
    required this.prompt,
    required this.rank,
  });

  factory FoodCompareRes.fromJson(Map<String, dynamic> json) => FoodCompareRes(
        shoplist: List<Shoplist>.from(
            json["shoplist"].map((x) => Shoplist.fromJson(x))),
        mobomlist: List<Mobomlist>.from(
            json["mobomlist"].map((x) => Mobomlist.fromJson(x))),
        avgprice: json["avgprice"],
        maxprice: json["maxprice"],
        minprice: json["minprice"],
        nationalprice: json["nationalprice"],
        prompt: json["prompt"],
        rank:json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "shoplist": List<dynamic>.from(shoplist.map((x) => x.toJson())),
        "mobomlist": List<dynamic>.from(mobomlist.map((x) => x.toJson())),
        "avgprice": avgprice,
        "maxprice": maxprice,
        "minprice": minprice,
        "nationalprice": nationalprice,
        "prompt": prompt,
        "rank":rank,
      };
}

class Mobomlist {
  String shopname;
  String address;
  String headmenu;

  Mobomlist({
    required this.shopname,
    required this.address,
    required this.headmenu,
  });

  factory Mobomlist.fromJson(Map<String, dynamic> json) => Mobomlist(
        shopname: json["shopname"],
        address: json["address"],
        headmenu: json["headmenu"],
      );

  Map<String, dynamic> toJson() => {
        "shopname": shopname,
        "address": address,
        "headmenu": headmenu,
      };
}

class Shoplist {
  String shopname;
  String shopmenu;
  int shopprice;
  String score;
  String address;

  Shoplist({
    required this.shopname,
    required this.shopmenu,
    required this.shopprice,
    required this.score,
    required this.address,
  });

  factory Shoplist.fromJson(Map<String, dynamic> json) => Shoplist(
        shopname: json["shopname"],
        shopmenu: json["shopmenu"],
        shopprice: json["shopprice"],
        score: json["score"],
        address:json["address"],
      );

  Map<String, dynamic> toJson() => {
        "shopname": shopname,
        "shopmenu": shopmenu,
        "shopprice": shopprice,
        "score": score,
        "address":address,
      };
}
