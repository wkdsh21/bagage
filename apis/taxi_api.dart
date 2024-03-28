import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constants.dart';
import '/models/taxi_predict_req.dart';
import '/models/taxi_predict_res.dart';

Future<TaxiPredictRes> taxiPredict(List<double?> xy) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  Xy start = Xy(
      latitude: position.latitude.toString(),
      longitude: position.longitude.toString());
  Xy end = Xy(latitude: xy[0].toString(), longitude: xy[1].toString());
  // final apiKey = 'AIzaSyD0Zwmr6ERIT0VGzsvBof8E9aaH_GFR-YU';
  // String apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${start.latitude},${start.longitude}&key=$apiKey';
  // http.Response response = await http.get(Uri.parse(apiUrl));
  // if (response.statusCode == 200) {
  //   final data = json.decode(response.body);
  //   if (data['status'] == 'OK' && data['results'].length > 0) {
  //     print(data['results'][0]);
  //     prefs.setString('startaddress', data['results'][0]['formatted_address']);
  //   }
  // }
  // apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${end.latitude},${end.longitude}&key=$apiKey';
  // response = await http.get(Uri.parse(apiUrl));
  // if (response.statusCode == 200) {
  //   final data = json.decode(response.body);
  //   if (data['status'] == 'OK' && data['results'].length > 0) {
  //     print(data['results'][0]);
  //     prefs.setString('endaddress', data['results'][0]['formatted_address']);
  //   }
  // }
  TaxiPredictReq requestData = TaxiPredictReq(start: start, end: end);
  try {
    // API 요청 보내기
    final response = await http.post(
      Uri.parse("${Constants.apiUrl}/taxi/predict"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestData.toJson()),
    );
    if (response.statusCode == 200) {
      // API 응답 데이터 파싱
      return taxiPredictResFromJson(utf8.decode(response.bodyBytes));
    } else {
      // 요청이 실패한 경우 예외 처리
      throw Exception('API 요청에 실패하였습니다.');
    }
  } catch (e) {
    // 예외 발생 시 예외 처리
    throw Exception('API 요청 중 오류가 발생하였습니다.');
  }
}

// void compareTaxi() async {
//   if (_formKey.currentState!.validate()) {
//     _formKey.currentState!.save();
//     print(_actualTaxiData);
//     // 여기서 폼 데이터를 서버로 전송하거나 필요한 처리를 수행할 수 있습니다.
//
//     Map<String, dynamic> toServer = {
//       'real': _actualTaxiData,
//       'predict': taxiData
//     };
//     print(jsonEncode(toServer));
//     String toServerJson = jsonEncode(toServer);
//
//     try {
//       final response = await http.post(
//         Uri.parse('${Constants.apiUrl}/taxi/compare'),
//         headers: {'Content-type': 'application/json'},
//         body: toServerJson,
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 404) {
//         // 여기에 바가지인지 아닌지 판단하는 데이터가 들어옴
//         // 텍스트로 표시해주어야 함
//         // print(response.body);
//         // setState(() {
//         //   _result = response.body;
//         // });
//         setState(() {
//           _result = '바가지입니다.';
//         });
//         showReportButton = true; // 신고하기 버튼을 보이도록 상태 변경
//         showCarNumberField = true; // 차 번호 입력칸을 보이도록 상태 변경
//       } else {
//         print('서버 요청 실패: ${response.statusCode}');
//       }
//     } catch (e) {
//       setState(() {
//         showReportButton = false; // 신고하기 버튼 감추기
//         showCarNumberField = false; // 차 번호 입력칸 감추기
//       });
//       print('서버 요청 오류: $e');
//     }
//   }
// }
//
// void reportTaxi() async {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('신고'),
//         content: Text('$_carNumber을(를) 신고하시겠습니까?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('취소'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               String apiUrl = '/taxi/report';
//               Map<String, dynamic> toServer = {
//                 'carnum': _carNumber,
//                 'real': _actualTaxiData,
//                 'predict': taxiData
//               };
//               String toServerJson = jsonEncode(toServer);
//               print(toServerJson);
//               try {
//                 final response = await http.post(
//                   Uri.parse((apiUrl)),
//                   headers: {'Content-type': 'application/json'},
//                   body: toServerJson,
//                 );
//
//                 if (response.statusCode == 200 ||
//                     response.statusCode == 404) {
//                   // 여기에 신고내용을 표시하면 됨
//                   setState(() {
//                     _reportResult = '신고내용';
//                   });
//                 } else {
//                   print('서버 요청 실패: ${response.statusCode}');
//                 }
//               } catch (e) {
//                 print('서버 요청 오류: $e');
//               }
//               Navigator.pop(context);
//             },
//             child: Text('신고하기'),
//           ),
//         ],
//       );
//     },
//   );
// }

// ResponseData responseData = await sendRequest();
