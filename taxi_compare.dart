// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '/models/taxi_predict_res.dart';
// import 'apis/Constants.dart';
// import 'dart:async';
//
// void main() =>
//     runApp(TaxiCompare(TaxiPredictRes(usetime: 100, fee: 15000, distance: 15)));
//
// class TaxiCompare extends StatelessWidget {
//   TaxiPredictRes predict;
//
//   TaxiCompare(this.predict);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('서버로 보낼 데이터'),
//         ),
//         body: MyForm(predict),
//       ),
//     );
//   }
// }
//
// String fromServer =
//     '{"usetime(min)": "11", "fee(원)": "5600", "distance(km)": "3"}';
// Map<String, dynamic> taxiData = json.decode(fromServer);
//
// void showTaxiData() {
//   print(taxiData);
// }
//
// class MyForm extends StatefulWidget {
//   TaxiPredictRes predict;
//
//   MyForm(this.predict);
//
//   @override
//   _MyFormState createState() => _MyFormState(predict);
// }
//
// class _MyFormState extends State<MyForm> {
//   DateTime? startTime;
//   DateTime? endTime;
//   List<Position> _positions = [];
//   double _totalDistance = 0.0;
//   StreamSubscription<Position>? streamSubscription;
//   String? startaddress;
//   String? endaddress;
//   TaxiPredictRes real = TaxiPredictRes(usetime: 10, fee: 10, distance: 10);
//   TaxiPredictRes predict;
//   String _result = '';
//   String _reportResult = '';
//   String _carNumber = ''; // 입력된 차 번호를 저장하는 변수
//   bool showReportButton = false; // 신고하기 버튼 보이기/감추기 상태 변수
//   bool showCarNumberField = false; // 차 번호 입력칸 보이기/감추기 상태 변수
//   final _formKey = GlobalKey<FormState>(); // 폼 상태를 관리하기 위해
//
//   _MyFormState(this.predict);
//
//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       startTime = DateTime.now();
//       endTime = null;
//     });
//     (() async {
//       if (!await Permission.location.isGranted) {
//         PermissionStatus status = await Permission.location.request();
//         if (!status.isGranted) {
//           print('Location permission denied');
//         }
//       }
//       print("Fefsgsgfdgdg");
//       streamSubscription =
//           Geolocator.getPositionStream().listen((Position position) {
//         print('${position.longitude}, ${position.latitude}');
//         setState(() {
//           _positions.add(position);
//         });
//       });
//     })();
//   }
//
//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       // 여기서 폼 데이터를 서버로 전송하거나 필요한 처리를 수행할 수 있습니다.
//       streamSubscription?.cancel();
//       setState(() {
//         endTime = DateTime.now();
//       });
//       Duration difference = endTime!.difference(startTime!);
//       for (int i = 1; i < _positions.length; i++) {
//         _totalDistance += Geolocator.distanceBetween(
//           _positions[i - 1].latitude,
//           _positions[i - 1].longitude,
//           _positions[i].latitude,
//           _positions[i].longitude,
//         );
//       }
//       print(_totalDistance);
//       real.distance = _totalDistance;
//       real.usetime = difference.inMinutes;
//       Map<String, dynamic> toServer = {
//         'real': real.toJson(),
//         'predict': predict.toJson()
//       };
//       String toServerJson = jsonEncode(toServer);
//       print(toServerJson);
//       try {
//         final response = await http.post(
//           Uri.parse('${Constants.apiUrl}/taxi/compare'),
//           headers: {'Content-type': 'application/json'},
//           body: toServerJson,
//         );
//
//         if (response.statusCode == 200 || response.statusCode == 404) {
//           // 여기에 바가지인지 아닌지 판단하는 데이터가 들어옴
//           // 텍스트로 표시해주어야 함
//           print(response.body);
//           setState(() {
//             _result = json.decode(utf8.decode(response.bodyBytes))["prompt"];
//           });
//           // setState(() {
//           //   _result = '바가지입니다.';
//           // });
//           showReportButton = true; // 신고하기 버튼을 보이도록 상태 변경
//           showCarNumberField = true; // 차 번호 입력칸을 보이도록 상태 변경
//         } else {
//           print('서버 요청 실패: ${response.statusCode}');
//         }
//       } catch (e) {
//         setState(() {
//           showReportButton = false; // 신고하기 버튼 감추기
//           showCarNumberField = false; // 차 번호 입력칸 감추기
//         });
//         print('서버 요청 오류: $e');
//       }
//     }
//   }
//
//   void _reportTaxi() async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('신고'),
//           content: Text('$_carNumber을(를) 신고하시겠습니까?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('취소'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 setState(() {
//                   startaddress = prefs.getString('startaddress');
//                   endaddress = prefs.getString('endaddress');
//                 });
//                 print(startaddress);
//                 print(endaddress);
//                 Map<String, dynamic> toServer = {
//                   'start': startaddress,
//                   'end': endaddress,
//                   'carnum': _carNumber,
//                   'real': real,
//                   'predict': predict
//                 };
//                 String toServerJson = jsonEncode(toServer);
//                 print(toServerJson);
//                 try {
//                   final response = await http.post(
//                     Uri.parse('${Constants.apiUrl}/taxi/report'),
//                     headers: {'Content-type': 'application/json'},
//                     body: toServerJson,
//                   );
//
//                   if (response.statusCode == 200 ||
//                       response.statusCode == 404) {
//                     // 여기에 신고내용을 표시하면 됨
//                     setState(() {
//                       _reportResult = json
//                           .decode(utf8.decode(response.bodyBytes))["prompt"];
//                     });
//                   } else {
//                     print('서버 요청 실패: ${response.statusCode}');
//                   }
//                 } catch (e) {
//                   print('서버 요청 오류: $e');
//                 }
//                 Navigator.pop(context);
//               },
//               child: Text('신고하기'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(labelText: '요금(원)'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return '도착 후 요금을 입력해주세요.';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       real.fee = int.tryParse(value!);
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _submitForm,
//                     child: Text('확인'),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(_result), //응답받은 gpt 텍스트,
//             SizedBox(height: 16),
//             if (true)
//               TextFormField(
//                 decoration: InputDecoration(labelText: '차 번호 입력'),
//                 onChanged: (value) {
//                   setState(() {
//                     _carNumber = value;
//                   });
//                 },
//               ),
//             SizedBox(height: 16),
//             if (true)
//               ElevatedButton(
//                 onPressed: _reportTaxi,
//                 child: Text('신고하기'),
//               ),
//             SizedBox(height: 16),
//             Text(_reportResult),
//           ],
//         ),
//       ),
//     );
//   }
// }
