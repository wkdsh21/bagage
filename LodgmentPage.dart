import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yeah/apis/Constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LodgmentPage(),
    );
  }
}

class LodgmentPage extends StatelessWidget {
  final Map<String, List<int>> data = {
    '서울': [50000],
    '광주': [39000],
    '대구': [44500],
    '대전': [41000],
    '부산': [40000],
    '울산': [41400],
    '인천': [39167],
    '강원': [42444],
    '경기': [44586],
    '경남': [42277],
    '경북': [47923],
    '전남': [46111],
    '전북': [38500],
    '충남': [46500],
    '충북': [45714],
    '제주': [41250],
  };

  void _showModal(BuildContext context) {
    String location = '';
    String accommodationName = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder( // 테두리 모양 설정
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '검색',
                    style: TextStyle(
                      fontFamily: 'Orbit',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close), // 닫기 아이콘
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // 원하는 테두리 색상 설정
                        width: 2, // 테두리 굵기 설정
                      ),
                      borderRadius: BorderRadius.circular(12), // 테두리를 둥글게 설정
                    ),
                    padding: EdgeInsets.all(4), // 아이콘 주위 패딩 설정
                    child: Icon(Icons.search, size: 30,), // 돋보기 아이콘
                  ),
                  SizedBox(width: 16), // 아이콘과 텍스트 사이 간격 조절
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '불법 업소 검색',
                          style: TextStyle(
                            fontFamily: 'Gugi',
                            fontSize: 16,
                          ),
                      ),
                      Text(
                          '지역 추천 서비스',
                          style: TextStyle(
                            fontFamily: 'Orbit',
                            fontSize: 12,
                            color: Colors.deepPurple[400]
                          ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: '지역',
                  labelStyle: TextStyle(color: Colors.grey, fontFamily: 'Orbit', fontSize: 14),
                  contentPadding: EdgeInsets.only(left: 8.0, right: 8.0), // 패딩 조정
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  prefixIcon: Icon(Icons.location_on, color: Colors.grey[800],), // 위치 아이콘
                ),
                onChanged: (value) => location = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '숙소명',
                  labelStyle: TextStyle(color: Colors.grey, fontFamily: 'Orbit', fontSize: 14),
                  contentPadding: EdgeInsets.only(left: 8.0, right: 8.0), // 패딩 조정
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  prefixIcon: Icon(Icons.apartment,color: Colors.grey[800],), // 숙소 아이콘
                ),
                onChanged: (value) => accommodationName = value,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => _handleServerResponse(context, accommodationName, location),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8), // 버튼의 세로 패딩 설정
                shape: RoundedRectangleBorder( // 테두리 모양 설정
                  borderRadius: BorderRadius.circular(15),
                ),
                primary: Colors.deepPurpleAccent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 아이콘과 텍스트를 가운데로 정렬
                children: [
                  Icon(Icons.analytics), // 분석하기 아이콘
                  SizedBox(width: 8), // 아이콘과 텍스트 사이 간격 조절
                  Text('판단하기'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleServerResponse(BuildContext context, String accommodationName, String location) async {
    String apiUrl = '${Constants.apiUrl}/lodgment/compare';
    String query = 'name=$accommodationName&region=$location';
    String fullUrl = '$apiUrl?$query';

    try {
      final response = await http.get(Uri.parse(fullUrl));

      if (response.statusCode == 200) {
        dynamic responseData = json.decode(utf8.decode(response.bodyBytes));
        // 두 번째 서버 요청
        String secondApiUrl = '${Constants.apiUrl}/lodgment/offer';
        String secondQuery = 'region=$location'; // 첫 번째 응답에서 가져오는 값 사용
        String secondFullUrl = '$secondApiUrl?$secondQuery';

        try {
          final secondResponse = await http.get(Uri.parse(secondFullUrl));

          if (secondResponse.statusCode == 200) {
            dynamic secondResponseData = json.decode(utf8.decode(secondResponse.bodyBytes));

            // 두 번째 서버 응답에 따라 Dialog 띄우기
            Navigator.of(context).pop();
            showResultDialog(context, responseData, secondResponseData);

          } else {
            print('두 번째 서버 요청 실패: ${secondResponse.statusCode}');
          }
        } catch (secondError) {
          print('두 번째 서버 요청 오류: $secondError');
        }

      } else {
        print('첫 번째 서버 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('첫 번째 서버 요청 오류: $e');
    }
  }

  void showResultDialog(BuildContext context, dynamic responseData, dynamic secondResponseData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // 원하는 둥글기 정도 설정
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '검색 결과',
                style: TextStyle(
                  fontFamily: 'Orbit',
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close), // 닫기 아이콘
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(responseData['code'] == 0)
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // 원하는 테두리 색상 설정
                              width: 2, // 테두리 굵기 설정
                            ),
                            borderRadius: BorderRadius.circular(
                                12), // 테두리를 둥글게 설정
                          ),
                          padding: EdgeInsets.all(4), // 아이콘 주위 패딩 설정
                          child: Icon(Icons.check, size: 30,
                              color: Colors.green), // 돋보기 아이콘
                        ),
                        SizedBox(width: 16), // 아이콘과 텍스트 사이 간격 조절
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${responseData['name']}',
                              style: TextStyle(
                                fontFamily: 'Gugi',
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '안전한 업체',
                              style: TextStyle(
                                fontFamily: 'Orbit',
                                fontSize: 12,
                                color: Colors.deepPurple[400],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.perm_identity, size: 28), // 아이콘 크기 설정
                        ),
                        Text(
                          responseData['license'],
                          style: TextStyle(
                              fontFamily: 'Orbit',
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.location_on, size: 28), // 아이콘 크기 설정
                        ),
                        Text(
                          responseData['address'],
                          style: TextStyle(
                            fontFamily: 'Orbit',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.apartment, size: 28), // 아이콘 크기 설정
                        ),
                        Text(
                          responseData['name'],
                          style: TextStyle(
                              fontFamily: 'Orbit',
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              // 첫 번째 서버 응답 데이터 표시
              if (responseData['code'] == 1)
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // 원하는 테두리 색상 설정
                              width: 2, // 테두리 굵기 설정
                            ),
                            borderRadius: BorderRadius.circular(
                                12), // 테두리를 둥글게 설정
                          ),
                          padding: EdgeInsets.all(4), // 아이콘 주위 패딩 설정
                          child: Icon(Icons.close, size: 30, color: Colors.red),
                        ),
                        SizedBox(width: 16), // 아이콘과 텍스트 사이 간격 조절
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${responseData['name']}',
                              style: TextStyle(
                                fontFamily: 'Gugi',
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '불법 업소 의심',
                              style: TextStyle(
                                fontFamily: 'Orbit',
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              Divider(),
              // 지역 숙소 추천 텍스트를 왼쪽으로 정렬
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '지역 숙소 추천',
                  style: TextStyle(
                      fontFamily: 'Orbit',
                      fontSize: 14,
                      color: Colors.grey[800]
                  ),
                ),
              ),
              // 두 번째 서버 응답 데이터 표시
              SizedBox(height: 16,),
              buildInfoWidget(
                  secondResponseData['lodgmentlist'][0]['add1'],
                  secondResponseData['lodgmentlist'][0]['title']
              ),
              buildInfoWidget(
                  secondResponseData['lodgmentlist'][1]['add1'],
                  secondResponseData['lodgmentlist'][1]['title']
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8), // 버튼의 세로 패딩 설정
                shape: RoundedRectangleBorder( // 테두리 모양 설정
                  borderRadius: BorderRadius.circular(15),
                ),
                primary: Colors.deepPurpleAccent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 텍스트를 가운데로 정렬
                children: [
                  Text('확인'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildInfoWidget(String address1, String hotelName) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(18), // 테두리를 둥글게 설정
              ),
            ),
            SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽 정렬로 설정
                children: [
                  Text(
                    hotelName,
                    style: TextStyle(
                      fontFamily: 'Jua',
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    address1,
                    style: TextStyle(
                      fontFamily: 'Orbit',
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.location_on, size: 29, color: Colors.grey,), // 오른쪽 끝에 위치
          ],
        ),
        Divider(),
      ],
    );
  }

  Color _calculatePriceColor(int price) {
    // 가격이 높을수록 빨간색에 가깝게 계산
    double normalizedPrice = (price - 38000) / 12000; // 최소값 38000, 최대값 50000
    int redValue = (255 * normalizedPrice).toInt();
    int blueValue = 255 - redValue;

    return Color.fromARGB(255, redValue, 0, blueValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150), // 높이 설정
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // 뒤로가기 버튼 클릭 시 동작
              Navigator.of(context).pop();
            },
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/imgs/background.jpg', // 이미지 경로 설정
              fit: BoxFit.cover, // 이미지를 적절하게 맞추어 배치
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // 모서리를 둥글게 설정
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '타도 바가지',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Orbit',
                color: Colors.deepPurple[300]
              ),
            ),
            SizedBox(height: 12,),
            Text(
              '숙박 바가지 서비스',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Gugi',
              ),
            ),
            Text(
              '숙박 지역별 평균 가격, 불법 업소 판단서비스를 제공합니다',
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'Orbit'
              ),
            ),
            SizedBox(height: 16,),
            Text(
              '숙박 지역별 평균 가격',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Jua'
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  String key = data.keys.elementAt(index);
                  List<int> values = data[key]!;

                  // 가격에 따라서 색상 계산
                  Color priceColor = _calculatePriceColor(values[0]);

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: priceColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Text(
                              key,
                              style: TextStyle(
                                fontFamily: 'Jua',
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${values[0]}원',
                              style: TextStyle(
                                fontFamily: 'Orbit',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 10), // 버튼과 리스트 사이 간격 조절
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(14),
                    primary: Colors.deepPurple[100], // 배경색 설정
                    shape: RoundedRectangleBorder( // 테두리 모양 설정
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white, // 아이콘 색상 설정
                  ),
                ),
                SizedBox(width: 32,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showModal(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      shape: RoundedRectangleBorder( // 테두리 모양 설정
                        borderRadius: BorderRadius.circular(15),
                      ),
                      primary: Colors.deepPurple[400]
                    ),
                    child: Text(
                        '검색',
                        style: TextStyle(fontFamily: 'Orbit', fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
