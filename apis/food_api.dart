import 'dart:convert';
import '/models/food_compare_req.dart';
import '/models/food_compare_res.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constants.dart';
import '/models/taxi_predict_req.dart';
import '/models/taxi_predict_res.dart';

Future<FoodCompareRes> foodPredict(FoodCompareReq foodCompareReq) async {
  if (!await Permission.location.isGranted) {
    PermissionStatus status = await Permission.location.request();
    if (!status.isGranted) {
      print('Location permission denied');
    }
  }
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  foodCompareReq.latitude= position.latitude.toString();
  foodCompareReq.longitude= position.longitude.toString();
  print(foodCompareReqToJson(foodCompareReq));
  try {
    // API 요청 보내기
    final response = await http.post(
      Uri.parse("${Constants.apiUrl}/food/compare"),
      headers: {"Content-Type": "application/json"},
      body: foodCompareReqToJson(foodCompareReq),
    );
    if (response.statusCode == 200) {
      // API 응답 데이터 파싱
      print('성공');
      return foodCompareResFromJson(utf8.decode(response.bodyBytes));
    } else {
      // 요청이 실패한 경우 예외 처리
      throw Exception('API 요청에 실패하였습니다.');
    }
  } catch (e) {
    // 예외 발생 시 예외 처리
    throw Exception('API 요청 중 오류가 발생하였습니다.');
  }
}


// ResponseData responseData = await sendRequest();
