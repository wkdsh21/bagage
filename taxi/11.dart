import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeah/models/taxi_predict_res.dart';
import 'package:yeah/taxi/22.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Taxi1(),
//     );
//   }
// }

class Taxi1 extends StatefulWidget {
  TaxiPredictRes taxiPredictRes;

  Taxi1(this.taxiPredictRes);

  @override
  _ProductPageState createState() => _ProductPageState(this.taxiPredictRes);
}

class _ProductPageState extends State<Taxi1> {
  TaxiPredictRes taxiPredictRes;
  String? startaddress;
  String? endaddress;

  _ProductPageState(this.taxiPredictRes);

  // @override
  // void initState() {
  //   super.initState();
  //   (() async {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     setState(() {
  //       startaddress = prefs.getString('startaddress') ?? "null";
  //       endaddress = prefs.getString('endaddress') ?? "null";
  //     });
  //   })();
  // }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(size: 38, Icons.location_on), Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Text(style: GoogleFonts.jua(
                  // GoogleFonts 위젯을 사용하여 폰트 설정
                  fontSize: 35,
                ), "목적지 설정"),
              )
              ]),
          Divider(thickness: 4,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(style: TextStyle(fontSize: 25), "${taxiPredictRes.startaddress}"),
              Icon(Icons.keyboard_double_arrow_right),
              Text(style: TextStyle(fontSize: 25), "${taxiPredictRes.endaddress}")
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Column(
                children: [Icon(Icons.attach_money_sharp), Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(style: TextStyle(fontSize: 25),
                      "${taxiPredictRes.fee} won"),
                )
                ],
              ),
              Column(
                children: [Icon(Icons.route_outlined), Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(style: TextStyle(fontSize: 25),
                      "${taxiPredictRes.distance} km"),
                )
                ],
              ),
              Column(
                children: [Icon(Icons.access_time), Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(style: TextStyle(fontSize: 25),
                      "${taxiPredictRes.usetime} m"),
                )
                ],
              )
            ]),
          ),
          Divider(thickness: 5,),
          SizedBox(width: 300, height: 50,
            child: ElevatedButton(style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF7165E3),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10.0), // 테두리를 둥글게 만들기
              ),
            ), onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context)
              {
                return Taxi2(this.taxiPredictRes);
              });
            },
              child: Text("탑승"),),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("탑승 시작시 바가지 예측을 위한 타이머가 시작됩니다."),
          ),
        ],
      ),
    );
  }
}
