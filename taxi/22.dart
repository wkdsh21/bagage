import 'dart:async';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yeah/taxi/33.dart';

import '../models/taxi_predict_res.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Taxi2(TaxiPredictRes(usetime: 0,fee: 0,distance: 0.0,startaddress: "null",endaddress: "null")),
//     );
//   }
// }

class Taxi2 extends StatefulWidget {
  TaxiPredictRes taxiPredictRes;

  Taxi2(this.taxiPredictRes);
  @override
  _ProductPageState createState() => _ProductPageState(this.taxiPredictRes);
}

class _ProductPageState extends State<Taxi2> {
  TaxiPredictRes? realtaxiPredictRes;
  TaxiPredictRes taxiPredictRes;
  Timer? timer;
  int time=0;
  // DateTime? startTime;
  // DateTime? endTime;
  List<Position> _positions = [];
  double _totalDistance = 0.0;
  StreamSubscription<Position>? streamSubscription;

  _ProductPageState(this.taxiPredictRes);

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   startTime = DateTime.now();
    //   endTime = null;
    // });
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        time+=1;
      });
      this.timer=timer;
    });
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
          print('${position.longitude}, ${position.latitude}');
          setState(() {
            _positions.add(position);
            if (_positions.length >= 2) {
              _totalDistance=0.0;
              for (int i = 1; i < _positions.length - 1; i++) {
                _totalDistance += Geolocator.distanceBetween(
                  _positions[i].latitude,
                  _positions[i].longitude,
                  _positions[i + 1].latitude,
                  _positions[i + 1].longitude,
                );
              }
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 380,
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
                        "택시 탑승 중"),
                  )
                ]),
            Divider(
              thickness: 5,
            ),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.crop_square),
                      Icon(Icons.arrow_downward),
                      Icon(Icons.square_rounded),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(style: TextStyle(fontSize: 25), "${taxiPredictRes.startaddress}"),
                        Text(style: TextStyle(fontSize: 25), "${taxiPredictRes.endaddress}")
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(style: TextStyle(fontSize: 25), "${taxiPredictRes.usetime} m"),
                      Text(style: TextStyle(fontSize: 25), "${taxiPredictRes.distance} km"),
                      Text(style: TextStyle(fontSize: 25), "${taxiPredictRes.fee} won")
                    ],
                  )
                ],
              ),
            ),
            Divider(thickness: 5,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.access_time),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(style: TextStyle(fontSize: 25), "$time m"),
                      )
                    ],
                  ),
                  Container(height: 100,child: VerticalDivider(thickness: 3,)),
                  Column(
                    children: [
                      Icon(Icons.route_outlined),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(style: TextStyle(fontSize: 25), "${(_totalDistance/1000).toStringAsFixed(1)} km"),
                      )
                    ],
                  )
                ]),
            Divider(
              thickness: 5,
            ),
            SizedBox(
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
                  realtaxiPredictRes = TaxiPredictRes(usetime: time, fee: 0, distance: _totalDistance/1000, startaddress: "null", endaddress: "null");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Taxi3(this.realtaxiPredictRes!,this.taxiPredictRes),
                    ),
                  );
                },
                child: Text("도착"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
