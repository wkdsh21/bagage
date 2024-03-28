// import 'package:flutter/material.dart';
// import 'place_picker/place_picker.dart';
// import '/models/taxi_predict_req.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '/apis/taxi_api.dart';
// import '/models/taxi_predict_res.dart';
// import 'taxi_compare.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TaxiMain(),
//     );
//   }
// }
//
// class TaxiMain extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => TaxiMainState();
// }
//
// class TaxiMainState extends State<TaxiMain> {
//   int? usetime;
//   int? fee;
//   double? distance;
//   bool responebar = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('도착지 설정 화면')),
//       body: Center(
//         child: Column(
//           children: [
//             Visibility(visible: !responebar, child: Text('버튼을 눌러 도착지를 설정해주세요')),
//             Visibility(
//               visible: responebar,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text('예상 시간: $usetime'),
//                       Text('예상 비용: $fee'),
//                       Text('예상 거리: $distance'),
//                     ],
//                   ),
//                   TextButton(
//                     child: Text("출발하기"),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => TaxiCompare(TaxiPredictRes(usetime: usetime,fee: fee,distance: distance)),
//                         ),
//                       ); //도착 화면으로이동;
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             TextButton(
//               child: Text("도착지 설정"),
//               onPressed: () async {
//                 TaxiPredictRes taxipredictres =
//                 await taxiPredict(await showPlacePicker());
//                 setState(() {
//                   usetime = taxipredictres.usetime;
//                   fee = taxipredictres.fee;
//                   distance = taxipredictres.distance;
//                   responebar=true;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<List<double?>> showPlacePicker() async {
//     LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) =>
//             PlacePicker("AIzaSyD0Zwmr6ERIT0VGzsvBof8E9aaH_GFR-YU")));
//     // Handle the result in your way
//     return [
//       result?.latLng?.latitude,
//       result?.latLng?.longitude
//     ];
//   }
//
// // void saveData() async {
// //   SharedPreferences prefs = await SharedPreferences.getInstance();
// //   // int 데이터 저장
// //   int intValue = 42;
// //   prefs.setInt('intValue', intValue);
// // }
//
// // void loadData() async {
// //   SharedPreferences prefs = await SharedPreferences.getInstance();
// //   // int 데이터 불러오기
// //   setState(() {
// //     _loadedData = prefs.getInt('intValue') ?? 0;
// //   });
// }
