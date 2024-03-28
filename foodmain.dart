import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '/models/taxi_predict_req.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/apis/food_api.dart';
import '/models/taxi_predict_res.dart';
import 'models/food_compare_req.dart';
import 'models/food_compare_res.dart';
import 'taxi_compare.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FoodMain(),
    );
  }
}

class FoodMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FoodMainState();
}

class FoodMainState extends State<FoodMain> {
  final _formKey = GlobalKey<FormState>(); // 폼 상태를 관리하기 위해
  FoodCompareReq foodCompareReq = FoodCompareReq(
      latitude: "error", longitude: "error", name: "error", price: -1);
  FoodCompareRes? foodCompareRes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(title: const Text('음식바가지')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: foodCompareRes == null,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Align(
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '음식이름',
                                    style: GoogleFonts.jua(
                                      // GoogleFonts 위젯을 사용하여 폰트 설정
                                      fontSize: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 15.0, horizontal: 20.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide.none),
                                          labelText: '이름',
                                          hintText: '이름을 입력하세요',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '이름을 입력하세요';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          foodCompareReq.name = value!;
                                        }),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '음식가격',
                                    style: GoogleFonts.jua(
                                      // GoogleFonts 위젯을 사용하여 폰트 설정
                                      fontSize: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 15.0, horizontal: 20.0),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide.none),
                                          labelText: '가격',
                                          hintText: '가격을 입력하세요',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '가격을 입력하세요';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          foodCompareReq.price =
                                              int.tryParse(value!)!;
                                        }),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF7165E3),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10.0), // 테두리를 둥글게 만들기
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              }
                              foodCompareRes =
                                  await foodPredict(foodCompareReq);
                              // foodCompareRes=foodCompareResFromJson('{"shoplist":[{"shopname":"군순","shopmenu" : "순대국밥","shopprice" : 10000,"score" : "4.5","address" : "군산대 미룡동"},{"shopname":"군순","shopmenu":"순대국밥","shopprice":10000,"score" : "4.5","address" : "군산대 미룡동"}],"mobomlist":[{"shopname":"군순","address" : "전라북도 군산시..","headmenu" : "순대국밥"},{"shopname":"군순","address" : "전라북도 군산시..","headmenu" : "순대국밥"}],"avgprice" :12000,"maxprice" :15000,"minprice" :10000,"nationalprice":10000,"prompt" : "바가지로 판단"}');
                              setState(() {});
                            },
                            child: Text('분석하기'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Visibility(
                visible: foodCompareRes != null,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        style: GoogleFonts.jua(
                                          // GoogleFonts 위젯을 사용하여 폰트 설정
                                          fontSize: 24,
                                        ),
                                        "평균가격",
                                      ),
                                      Container(
                                          width: 90,
                                          child: Divider(
                                            thickness: 5,
                                          )),
                                      Text(
                                          style: GoogleFonts.jua(
                                            // GoogleFonts 위젯을 사용하여 폰트 설정
                                            fontSize: 24,
                                          ),
                                          "${foodCompareRes?.avgprice ?? "NULL"}"),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        style: GoogleFonts.jua(
                                          // GoogleFonts 위젯을 사용하여 폰트 설정
                                          fontSize: 24,
                                        ),
                                        "최대가격",
                                      ),
                                      Container(
                                          width: 90,
                                          child: Divider(
                                            thickness: 5,
                                          )),
                                      Text(
                                          style: GoogleFonts.jua(
                                            // GoogleFonts 위젯을 사용하여 폰트 설정
                                            fontSize: 24,
                                          ),
                                          "${foodCompareRes?.maxprice ?? "NULL"}"),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        style: GoogleFonts.jua(
                                          // GoogleFonts 위젯을 사용하여 폰트 설정
                                          fontSize: 24,
                                        ),
                                        "최소가격",
                                      ),
                                      Container(
                                          width: 90,
                                          child: Divider(
                                            thickness: 5,
                                          )),
                                      Text(
                                          style: GoogleFonts.jua(
                                            // GoogleFonts 위젯을 사용하여 폰트 설정
                                            fontSize: 24,
                                          ),
                                          "${foodCompareRes?.minprice ?? "NULL"}"),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        style: GoogleFonts.jua(
                                          // GoogleFonts 위젯을 사용하여 폰트 설정
                                          fontSize: 24,
                                        ),
                                        "전국가격",
                                      ),
                                      Container(
                                          width: 90,
                                          child: Divider(
                                            thickness: 5,
                                          )),
                                      Text(
                                          style: GoogleFonts.jua(
                                            // GoogleFonts 위젯을 사용하여 폰트 설정
                                            fontSize: 24,
                                          ),
                                          "${foodCompareRes?.nationalprice ?? "NULL"}"),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 36, // 색상 박스의 가로 크기 조절
                            height: 36, // 색상 박스의 세로 크기 조절
                            decoration: BoxDecoration(
                              color: getColorForRank(
                                  foodCompareRes?.rank ?? "null"),
                              // rank 값에 따라 색상 설정
                              borderRadius: BorderRadius.circular(6),
                              // 테두리의 둥글기 설정
                              border: Border.all(
                                color: Colors.black38, // 테두리 색상 설정
                                width: 1, // 테두리 두께 설정
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                    style: GoogleFonts.jua(
                                      // GoogleFonts 위젯을 사용하여 폰트 설정
                                      fontSize: 20,
                                    ),
                                    "${foodCompareRes?.rank ?? "null"}"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 350,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            String textToShow =
                                foodCompareRes?.prompt ?? "null";
                            _showTextDialog(context, textToShow);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF7165E3),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10.0), // 테두리를 둥글게 만들기
                            ),
                          ),
                          child: Text(
                              style: GoogleFonts.jua(
                                // GoogleFonts 위젯을 사용하여 폰트 설정
                                fontSize: 20,
                              ),
                              'AI 분석결과 자세히보기'),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                style: GoogleFonts.jua(
                                  // GoogleFonts 위젯을 사용하여 폰트 설정
                                  fontSize: 24,
                                ),
                                "추천 식당"),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: foodCompareRes?.shoplist.length ?? 2,
                          // items 리스트의 항목 개수를 지정
                          itemBuilder: (context, index) {
                            // index에 따라 해당하는 항목을 생성
                            return Card(
                              child: ListTile(
                                leading: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          value: ((double.tryParse(
                                                      foodCompareRes
                                                              ?.shoplist[index]
                                                              .score ??
                                                          "4" as String))
                                                  as double) /
                                              5.0,
                                          // 게이지의 값을 설정합니다 (0.0 ~ 1.0).
                                          strokeWidth: 5,
                                          // 게이지의 두께를 설정합니다.
                                          backgroundColor: Colors.grey[300],
                                          // 배경 색상을 설정합니다.
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              Color(
                                                  0xFF7165E3)), // 게이지 색상을 설정합니다.
                                        ),
                                      ),
                                      Text(
                                        '${foodCompareRes?.shoplist[index].score ?? "null"}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF7165E3),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                                title: Text(
                                    '${foodCompareRes?.shoplist[index].shopname ?? "null"}'),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        '${foodCompareRes?.shoplist[index].shopmenu ?? "null"}'),
                                    Text(
                                        '${foodCompareRes?.shoplist[index].shopprice ?? "null"} 원')
                                  ],
                                ),
                                trailing: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFE3DEFD), // 원하는 배경색 설정
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    size: 30,
                                    color: Color(0xFFBC7AE7),
                                  ),
                                ),
                                isThreeLine: true,
                                //dense: true,
                                onTap: () async {
                                  Uri uri = Uri.parse(
                                      'https://www.google.com/maps/search/?api=1&query=${foodCompareRes?.shoplist[index].shopname ?? "null"}');
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  } else {
                                    throw 'Could not launch map';
                                  }
                                  // 아이콘이 눌렸을 때 실행될 함수
                                },
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                style: GoogleFonts.jua(
                                  // GoogleFonts 위젯을 사용하여 폰트 설정
                                  fontSize: 24,
                                ),
                                "모범 식당"),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: foodCompareRes?.mobomlist.length ?? 2,
                          // items 리스트의 항목 개수를 지정
                          itemBuilder: (context, index) {
                            // index에 따라 해당하는 항목을 생성
                            return Card(
                              child: ListTile(
                                leading: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          value: 1,
                                          // 게이지의 값을 설정합니다 (0.0 ~ 1.0).
                                          strokeWidth: 5,
                                          // 게이지의 두께를 설정합니다.
                                          backgroundColor: Colors.grey[300],
                                          // 배경 색상을 설정합니다.
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              Color(
                                                  0xFF4CAF50)), // 게이지 색상을 설정합니다.
                                        ),
                                      ),
                                      Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.green,
                                      ),
                                    ]),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        '${foodCompareRes?.mobomlist[index].shopname ?? "null"}'),
                                  ],
                                ),
                                subtitle: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        '${foodCompareRes?.mobomlist[index].address ?? "null"}'),
                                    Text(
                                        '${foodCompareRes?.mobomlist[index].headmenu ?? "null"}')
                                  ],
                                ),
                                trailing: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFE3DEFD), // 원하는 배경색 설정
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    size: 30,
                                    color: Color(0xFFBC7AE7),
                                  ),
                                ),
                                isThreeLine: true,
                                //dense: true,
                                onTap: () async {
                                  Uri uri = Uri.parse(
                                      'https://www.google.com/maps/search/?api=1&query=${foodCompareRes?.mobomlist[index].address ?? "null"}');
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  } else {
                                    throw 'Could not launch map';
                                  }
                                  // 아이콘이 눌렸을 때 실행될 함수
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getColorForRank(String rank) {
    switch (rank) {
      case '저렴':
        return Colors.blue;
      case '적정':
        return Colors.green;
      case '위험':
        return Colors.orange;
      case '매우 위험':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}

void _showTextDialog(BuildContext context, String text) {
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
            "$text",
            style: TextStyle(fontFamily: 'Orbit'),
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
}
