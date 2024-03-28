import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yeah/models/taxi_predict_res.dart';
import 'package:yeah/taxi/44.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Taxi3(null,null),
//     );
//   }
// }

class Taxi3 extends StatefulWidget {
  TaxiPredictRes? realtaxiPredictRes;
  TaxiPredictRes? predicttaxiPredictRes;

  Taxi3(this.realtaxiPredictRes,this.predicttaxiPredictRes);
  @override
  _ProductPageState createState() => _ProductPageState(this.realtaxiPredictRes,this.predicttaxiPredictRes);
}

class _ProductPageState extends State<Taxi3> {
  TaxiPredictRes? realtaxiPredictRes;
  TaxiPredictRes? predicttaxiPredictRes;
  final _formKey = GlobalKey<FormState>();
  int price=0;
  String carnumber="null";

  _ProductPageState(this.realtaxiPredictRes,this.predicttaxiPredictRes);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(size: 38, Icons.local_taxi),
                  Padding(
                    padding: const EdgeInsets.only(top: 13, left: 15),
                    child: Text(
                        style: GoogleFonts.jua(
                          // GoogleFonts 위젯을 사용하여 폰트 설정
                          fontSize: 35,
                        ),
                        "탑승 정보 입력"),
                  )
                ]),
            Divider(
              thickness: 5,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(style: TextStyle(fontSize: 25),"탑승 금액"),
                        SizedBox(
                          height: 50,
                          width: 250,
                          child: TextFormField(decoration: InputDecoration(
                            hintText: '탑승금액을 입력하세요',
                          ),
                            onSaved: (value) {
                              realtaxiPredictRes!.fee = int.parse(value!); // null인 경우 빈 문자열로 처리
                            },),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(style: TextStyle(fontSize: 25), "차량 번호"),
                        SizedBox(height: 50,width: 250,
                          child: TextFormField(decoration: InputDecoration(
                            hintText: '차량번호를 입력하세요',
                          ),
                            onSaved: (value) {
                              carnumber = value ?? ''; // null인 경우 빈 문자열로 처리
                            },),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 5,
                  ),
                  Text("바가지 판별을 위해 정보를 입력해 주세요."),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF7165E3),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // 테두리를 둥글게 만들기
                          ),
                        ),
                        onPressed: () {
                          _formKey.currentState?.save();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Taxi4(this.realtaxiPredictRes!,this.predicttaxiPredictRes!,this.carnumber),
                            ),
                          );
                          // showModalBottomSheet(
                          //     context: context,
                          //     builder: (context)
                          //     {
                          //       return Taxi4(this.realtaxiPredictRes!,this.predicttaxiPredictRes!,this.carnumber);
                          //     });
                        },
                        child: Text("입력"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
