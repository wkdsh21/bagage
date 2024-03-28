import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yeah/models/taxi_predict_res.dart';
import 'package:yeah/apis/Constants.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Taxi4(),
//     );
//   }
// }

class Taxi4 extends StatefulWidget {
  TaxiPredictRes realtaxiPredictRes;
  TaxiPredictRes predicttaxiPredictRes;
  String carnumber;

  Taxi4(this.realtaxiPredictRes, this.predicttaxiPredictRes, this.carnumber);

  @override
  _ProductPageState createState() => _ProductPageState(
      this.realtaxiPredictRes, this.predicttaxiPredictRes, this.carnumber);
}

class _ProductPageState extends State<Taxi4> {
  TaxiPredictRes realtaxiPredictRes;
  TaxiPredictRes predicttaxiPredictRes;
  String carnumber;
  String? _reportResult;
  String? _reportResult2;

  _ProductPageState(
      this.realtaxiPredictRes, this.predicttaxiPredictRes, this.carnumber);

  @override
  void initState() {
    super.initState();
    (() async {
      Map<String, dynamic> toServer = {
        'real': this.realtaxiPredictRes,
        'predict': this.predicttaxiPredictRes
      };
      String toServerJson = jsonEncode(toServer);
      print(toServerJson);
      try {
        final response = await http.post(
          Uri.parse('${Constants.apiUrl}/taxi/compare'),
          headers: {'Content-type': 'application/json'},
          body: toServerJson,
        );

        if (response.statusCode == 200 || response.statusCode == 404) {
          // 여기에 신고내용을 표시하면 됨
          setState(() {
            _reportResult =
                json.decode(utf8.decode(response.bodyBytes))["prompt"];
          });
        } else {
          print('서버 요청 실패: ${response.statusCode}');
        }
      } catch (e) {
        print('서버 요청 오류: $e');
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(size: 30, Icons.analytics),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 15),
                      child: Text(
                          style: GoogleFonts.jua(
                            // GoogleFonts 위젯을 사용하여 폰트 설정
                            fontSize: 25,
                          ),
                          "분석"),
                    )
                  ]),
              Divider(
                thickness: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                        style: TextStyle(fontSize: 25),
                        "${predicttaxiPredictRes.startaddress}"),
                    Icon(Icons.keyboard_double_arrow_right),
                    Text(
                        style: TextStyle(fontSize: 25),
                        "${predicttaxiPredictRes.endaddress}")
                  ],
                ),
              ),
              Divider(
                thickness: 4,
              ),
              Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(size: 30, Icons.view_timeline),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 15),
                          child: Text(
                              style: GoogleFonts.jua(
                                // GoogleFonts 위젯을 사용하여 폰트 설정
                                fontSize: 25,
                              ),
                              "예측 기록"),
                        )
                      ]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    Column(
                      children: [
                        Icon(Icons.attach_money_sharp),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              style: TextStyle(fontSize: 25),
                              "${predicttaxiPredictRes.fee} won"),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.route_outlined),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              style: TextStyle(fontSize: 25),
                              "${predicttaxiPredictRes.distance} km"),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.access_time),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              style: TextStyle(fontSize: 25),
                              "${predicttaxiPredictRes.usetime} m"),
                        )
                      ],
                    )
                  ]),
                ],
              ),
              Divider(
                thickness: 5,
              ),
              Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(size: 30, Icons.view_timeline),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 15),
                          child: Text(
                              style: GoogleFonts.jua(
                                // GoogleFonts 위젯을 사용하여 폰트 설정
                                fontSize: 25,
                              ),
                              "실제 기록"),
                        )
                      ]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    Column(
                      children: [
                        Icon(Icons.attach_money_sharp),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              style: TextStyle(fontSize: 25),
                              "${realtaxiPredictRes.fee} won"),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.route_outlined),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              style: TextStyle(fontSize: 25),
                              "${(realtaxiPredictRes!.distance!).toStringAsFixed(1)} km"),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.access_time),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              style: TextStyle(fontSize: 25),
                              "${realtaxiPredictRes.usetime} m"),
                        )
                      ],
                    )
                  ]),
                ],
              ),
              Divider(
                thickness: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // 테두리를 둥글게 만들기
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기 설정
                            ),
                            title: Text(
                              "AI 분석 결과",
                              style: TextStyle(
                                fontFamily: 'Gugi',
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: Text(
                                "$_reportResult",
                                style: TextStyle(
                                    fontFamily: 'Orbit'
                                ),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurpleAccent, // 버튼 배경색 변경
                                  padding: EdgeInsets.symmetric(vertical: 8), // 버튼 내부 패딩 설정
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15), // 버튼 모서리 둥글기 제거
                                  ),
                                ),
                                child: Container(
                                  width: double.infinity, // 가로 폭을 꽉 채우도록 설정
                                  child: Center(
                                    child: Text(
                                      '확인',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(style: TextStyle(fontSize: 20), "AI 분석결과 확인"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // 테두리를 둥글게 만들기
                      ),
                    ),
                    onPressed: () {
                      report();
                    },
                    child: Text(style: TextStyle(fontSize: 20), "신고 하기"),
                  ),
                ),
              ),
              Divider(
                thickness: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7165E3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // 테두리를 둥글게 만들기
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                        ..pop()
                        ..pop()
                        ..pop()
                        ..pop()
                        ..pop();
                    },
                    child: Text(style: TextStyle(fontSize: 20), "나가기"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  report() async {
    Map<String, dynamic> toServer = {
      'start': this.predicttaxiPredictRes.startaddress,
      'end': this.predicttaxiPredictRes.endaddress,
      'carnum': this.carnumber,
      'real': this.realtaxiPredictRes,
      'predict': this.predicttaxiPredictRes
    };
    String toServerJson = jsonEncode(toServer);
    print(toServerJson);
    try {
      final response = await http.post(
        Uri.parse('${Constants.apiUrl}/taxi/report'),
        headers: {'Content-type': 'application/json'},
        body: toServerJson,
      );

      if (response.statusCode == 200 || response.statusCode == 404) {
        // 여기에 신고내용을 표시하면 됨
        setState(() {
          _reportResult2 =
              json.decode(utf8.decode(response.bodyBytes))["prompt"];
        });
      } else {
        print('서버 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('서버 요청 오류: $e');
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기 설정
          ),
          title: Text(
          "신고 문구",
            style: TextStyle(
              fontFamily: 'Gugi',
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              "$_reportResult2",
              style: TextStyle(
                  fontFamily: 'Orbit'
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurpleAccent, // 버튼 배경색 변경
                padding: EdgeInsets.symmetric(vertical: 8), // 버튼 내부 패딩 설정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // 버튼 모서리 둥글기 제거
                ),
              ),
              child: Container(
                width: double.infinity, // 가로 폭을 꽉 채우도록 설정
                child: Center(
                  child: Text(
                    '확인',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('신고 문구'),
    //       content: SingleChildScrollView(
    //           child: Text("$_reportResult2")),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: Text('닫기'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}

// void showTextModal(BuildContext context, String title, String content) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기 설정
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontFamily: 'Gugi',
//           ),
//         ),
//         content: SingleChildScrollView(
//           child: Text(
//             content,
//             style: TextStyle(
//                 fontFamily: 'Orbit'
//             ),
//           ),
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             style: ElevatedButton.styleFrom(
//               primary: Colors.deepPurpleAccent, // 버튼 배경색 변경
//               padding: EdgeInsets.symmetric(vertical: 8), // 버튼 내부 패딩 설정
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15), // 버튼 모서리 둥글기 제거
//               ),
//             ),
//             child: Container(
//               width: double.infinity, // 가로 폭을 꽉 채우도록 설정
//               child: Center(
//                 child: Text(
//                   '확인',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }

