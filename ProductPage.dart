import 'package:flutter/material.dart';
import 'package:excel/excel.dart' as excel;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'apis/Constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductPage(),
    );
  }
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<List<dynamic>> _dataRows = [];
  List<Map<String, dynamic>> rowDataList = [];
  List<Map<String, dynamic>> _filteredData = [];
  String _searchKeyword = ''; // 검색어를 저장할 변수 추가
  List<Map<String, dynamic>> _countryCodeList = [
    {'name': '서울', 'code': '1101'},
    {'name': '부산', 'code': '2100'},
    {'name': '대구', 'code': '2200'},
    {'name': '인천', 'code': '2300'},
    {'name': '광주', 'code': '2401'},
    {'name': '대전', 'code': '2501'},
    {'name': '울산', 'code': '2601'},
    {'name': '수원', 'code': '3111'},
    {'name': '춘천', 'code': '3211'},
    {'name': '청주', 'code': '3311'},
    {'name': '전주', 'code': '3511'},
    {'name': '포항', 'code': '3711'},
    {'name': '제주', 'code': '3911'},
    {'name': '의정부', 'code': '3113'},
    {'name': '순천', 'code': '3613'},
    {'name': '안동', 'code': '3714'},
    {'name': '창원', 'code': '3814'},
    {'name': '용인', 'code': '3145'},
    // 다른 지역 코드도 추가할 수 있습니다.
  ];
  String _selectedCountryCode = '1101'; // 초기값 설정
  String _selectedCountryName = '서울'; // 초기값 설정
  dynamic _compareResult ;
  bool _isFloatingButtonsVisible = false;
  IconData _selectedIconData = Icons.restaurant_menu; // 초기 선택 아이콘

  Map<String, dynamic?> categoryIcons = {
    '100': {'icon': Icons.restaurant_menu, 'color': Colors.brown[200]},
    '200': {'icon': Icons.local_florist, 'color': Colors.lightGreen[600]},
    '300': {'icon': Icons.agriculture, 'color': Colors.brown[800]},
    '400': {'icon': Icons.local_grocery_store, 'color': Colors.lightGreen},
    '500': {'icon': Icons.pets, 'color': Colors.pinkAccent[700]},
    '600': {'icon': Icons.waves, 'color': Colors.indigoAccent[700]},
    'default': {'icon': Icons.category, 'color': Colors.black},
  };

  void _toggleFloatingButtonsVisibility() {
    setState(() {
      _isFloatingButtonsVisible = !_isFloatingButtonsVisible;
    });
  }

  // 원본 데이터를 필터링하여 _filteredData에 저장하는 함수
  void _filterDataByGroupCode(String groupCode) => setState(() => _filteredData = rowDataList.where((row) => row['품목 그룹코드'] == groupCode).toList());

  @override
  void initState() {
    super.initState();
    _readExcelFile();
  }

  void _readExcelFile() async {
    try {
      ByteData data = await rootBundle.load("assets/test3.xlsx");
      var bytes = data.buffer.asUint8List();
      var excelData = excel.Excel.decodeBytes(bytes);

      // 원하는 테이블 이름 가져오기 (예: 첫 번째 테이블)
      String table = excelData.tables.keys.first;

      setState(() {
        _dataRows = excelData.tables[table]!.rows;
        rowDataList.clear();
        for (var row in _dataRows) {
          Map<String, dynamic> rowData = {};
          for (var index = 0; index < row.length; index++) {
            var cell = row[index];
            String cellValue = cell.value?.toString() ?? '';
            List<String> keyNames = [
              '품목 그룹코드',
              '품목 그룹명',
              '품목 코드',
              '품목명',
              '품종코드',
              '품종명',
              '등급',
            ];
            String keyName = keyNames[index];
            rowData[keyName] = cellValue;
          }
          rowDataList.add(rowData);
        }
      });
    } catch (e) {
      print('Error reading Excel file: $e');
    }
  }

  // 품목 그룹코드로 필터링하는 함수
  void _filterByGroupCode(String groupCode) =>
      setState(() => _filteredData = rowDataList.where((row) => row['품목 그룹코드'] == groupCode).toList());

  // 검색어를 기준으로 데이터를 필터링하는 함수
  void _filterDataByKeyword(String keyword) {
    setState(() {
      _filteredData = keyword.isEmpty
          ? List.from(rowDataList) // 검색어가 비어있는 경우, 원본 데이터를 그대로 표시
          : rowDataList.where((row) {
        String productName = row['품목명'].toString().toLowerCase();
        return productName.contains(keyword.toLowerCase());
      }).toList(); // 검색어가 입력된 경우, 품목명이 검색어를 포함하는 데이터만 필터링
    });
  }

  void _showCountryCodeList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: _countryCodeList.map((country) {
            return ListTile(
              title: Text(
                  country['name'],
                style: TextStyle(
                  fontFamily: 'Orbit',
                  fontSize: 16,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedCountryCode = country['code'];
                  _selectedCountryName = country['name'];
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _postToServer(dynamic item, dynamic price) {
    _sendDataToServer(item, price).then((compareResult) {
      setState(() {
        _compareResult = compareResult;
      });
      _showResultDialog(_compareResult);
    }).catchError((e) {
      print('서버 요청 오류: $e');
    });
  }

  Future<Map<String, dynamic>> _sendDataToServer(dynamic item, dynamic price) async {
    Map<String, dynamic> toServerData = {
      "p_itemcategorycode": item['품목 그룹코드'],
      "p_itemcode": item['품목 코드'],
      "p_kindcode": item['품종코드'],
      "p_countycode": _selectedCountryCode,
      "p_productclscode": item['등급'],
      "userprice": price,
    };

    String apiUrl = '${Constants.apiUrl}/products/compare';
    String toServerJson = jsonEncode(toServerData);

    final response = await http.post(
      Uri.parse((apiUrl)),
      headers: {'Content-type': 'application/json'},
      body: toServerJson,
    );

    if (response.statusCode == 200) {
      // 서버로부터 온 데이터를 리턴
      print(json.decode(utf8.decode(response.bodyBytes))["prompt"]);
      dynamic responseData = json.decode(utf8.decode(response.bodyBytes));
      return {
        "prompt": responseData["prompt"],
        "rank": responseData['rank'],
        "price": responseData['price'],
        "weekprice": responseData['weekprice'],
        "userprice": responseData['userprice'],
      };
      return {
        "prompt": responseData["prompt"],
        "rank": responseData['rank'],
        "price": responseData['price'],
        "weekprice": responseData['weekprice'],
        "userprice": responseData['userprice'],
      };
    } else {
      throw Exception('서버 요청 실패: ${response.statusCode}');
    }
  }

  void _showItemDialog(dynamic item) {
    TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기 설정
          ),
          title: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black26,
                  width: 1.0,
                ),
              ),
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '농수산 바가지 판단', // 표시할 텍스트
                  style: TextStyle(
                    color: Colors.black, // 텍스트 색상 설정
                    fontSize: 20, // 텍스트 크기 설정
                    fontWeight: FontWeight.bold, // 텍스트 굵기 설정
                    fontFamily: 'Gugi',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 닫기 버튼을 눌렀을 때 다이얼로그 닫기
                  },
                  icon: Icon(Icons.close), // 닫기 아이콘 추가
                ),
              ],
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // 사각형의 둥근 모서리 설정
                      border: Border.all(
                        color: Colors.black38, // 테두리 색상 설정
                        width: 1, // 테두리 두께 설정
                      ),
                    ),
                    child: Icon(
                      _buildCategoryIcon(item['품목 그룹코드']),
                      color: _buildCategoryColor(item['품목 그룹코드']),
                      size: 32,
                    ),
                  ),
                  SizedBox(width: 8), // 아이콘과 텍스트 사이 간격
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽으로 정렬
                    children: [
                      Text(
                        item['품목명'],
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Jua',
                        ),
                      ),
                      Text(
                        item['품종명'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Orbit',
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 8), // 텍스트와 내용 사이 간격
              // SizedBox(height: 20),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: '가격을 입력해주세요',
                  labelStyle: TextStyle(color: Colors.grey, fontFamily: 'Orbit', fontSize: 14),
                  contentPadding: EdgeInsets.only(left: 12.0, right: 12.0), // 패딩 조정
                  suffixText: '원',
                  suffixStyle: TextStyle(fontFamily: 'Orbit'),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '가격을 입력해주세요';
                  }
                  return null;
                },
              )
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  String? price = priceController.text;
                  if (price != null && price.isNotEmpty) {
                    _postToServer(item, price);
                    Navigator.of(context).pop();
                  } else {
                    print('가격을 입력해주세요');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기 설정
                  ),
                  elevation: 4.0,
                ),
                child: Container(
                  width: double.infinity, // 가로 폭을 꽉 채우도록 설정
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 아이콘과 텍스트를 가운데로 정렬
                    children: [
                      Icon(
                        Icons.analytics, // 분석을 나타내는 아이콘 (예시로 사용한 아이콘)
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 8), // 아이콘과 텍스트 사이 간격
                      Text(
                        '판별',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Orbit',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showResultDialog(Map<String, dynamic> compareResult) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기 설정
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'AI 분석 결과',
                  style: TextStyle(
                    fontFamily: 'Gugi'
                  ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 닫기 버튼을 눌렀을 때 다이얼로그 닫기
                },
                icon: Icon(Icons.close, color: Colors.black), // 닫기 아이콘 추가
              ),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 36, // 색상 박스의 가로 크기 조절
                    height: 36, // 색상 박스의 세로 크기 조절
                    decoration: BoxDecoration(
                      color: getColorForRank(compareResult['rank']), // rank 값에 따라 색상 설정
                      borderRadius: BorderRadius.circular(6), // 테두리의 둥글기 설정
                      border: Border.all(
                        color: Colors.black38, // 테두리 색상 설정
                        width: 1, // 테두리 두께 설정
                      ),
                    ),
                  ),
                  SizedBox(width: 8), // 색상 박스와 텍스트 사이 간격
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(compareResult['rank'], style: TextStyle(fontFamily: 'Jua'),),
                      Text(
                        '${compareResult['userprice']}(원)',
                        style: TextStyle(
                            fontFamily: 'Orbit',
                            fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Divider(thickness: 2,),
              _buildText('기준가:', '${compareResult['price']}(원)'),
              _buildText('주간가:', '${compareResult['weekprice']}(원)'),

            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                showTextModal(context, '상세보기', compareResult['prompt']);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurpleAccent, // 버튼 배경색 변경
                padding: EdgeInsets.zero, // 버튼 내부 패딩 제거
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // 테두리 둥글게 설정
                ),
              ),
              child: Container(
                width: double.infinity, // 가로 폭을 꽉 채우도록 설정
                padding: EdgeInsets.symmetric(vertical: 8), // 아이콘과 텍스트의 위아래 패딩
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.zoom_in, color: Colors.white), // zoom_in 아이콘 추가
                    SizedBox(width: 8), // 아이콘과 텍스트 간격
                    Text(
                      '상세보기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // 텍스트 색상 변경
                        fontFamily: 'Orbit'
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showTextModal(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기 설정
          ),
          title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Gugi',
              ),
          ),
          content: SingleChildScrollView(
            child: Text(
                content,
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
  }

  IconData _buildCategoryIcon(String groupCode) {
    final Map<String, dynamic> categoryInfo = categoryIcons[groupCode] ?? categoryIcons['default'];

    return categoryInfo['icon'];
  }

  Color _buildCategoryColor(String groupCode) {
    final Map<String, dynamic> categoryInfo = categoryIcons[groupCode] ?? categoryIcons['default'];

    return categoryInfo['color'];
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

  Widget _buildColorBox(Color color) {
    return Container(
      width: 20, // 박스 너비
      height: 20, // 박스 높이
      margin: EdgeInsets.only(bottom: 4), // 박스와 텍스트 사이 간격
      decoration: BoxDecoration(
        color: color, // 박스 색상
        borderRadius: BorderRadius.circular(4), // 박스 둥근 모서리 설정
      ),
    );
  }

  Widget _buildText(String label, String value) {
    return Text(
        '$label $value',
        style: TextStyle(fontFamily: 'Orbit'),
    );
  }

  Widget _buildCategoryButton(String text, String groupCode, IconData iconData) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedIconData = iconData; // 클릭된 아이콘 정보 저장
        });
        _filterDataByGroupCode(groupCode);
        _toggleFloatingButtonsVisibility();
        },
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurpleAccent[100],
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.all(3), // 버튼 내용물과 버튼의 간격 설정
        elevation: 4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent[100],
              // borderRadius: BorderRadius.circular(30.0),
            ),
            child: Icon(
              iconData,
              size: 24,
              color: Colors.white,
            ),
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                fontFamily: 'Orbit',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData iconData, double size, Color color) {
    return Icon(
      iconData,
      size: size,
      color: color,
    );
  }

  Widget buildSearchField(Function(String) onChanged) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 6.0), // 오른쪽 패딩 값 설정
          child: IconButton(
            onPressed: () {
              // 뒤로가기 버튼 동작 추가
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        Text(
          '농수산 바가지 판단', // 표시할 텍스트
          style: TextStyle(
            color: Colors.black, // 텍스트 색상 설정
            fontSize: 20, // 텍스트 크기 설정
            fontFamily: 'Gugi',
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16,), // 왼쪽 패딩 추가
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                labelText: '검색',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0), // 높이 조정
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 4.0), // 왼쪽 패딩 추가
                ),
                suffixIcon: Icon(Icons.search, color: Colors.purple),
              ),
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Orbit',
              ), // 텍스트 크기 설정
              onTap: () {
                if(_isFloatingButtonsVisible)
                  _toggleFloatingButtonsVisibility();
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // 앱 바의 높이 설정
        child: Container(
          padding: EdgeInsets.only(left: 16), // 왼쪽 패딩 설정
          decoration: BoxDecoration(
            color: Colors.white24, // 앱 바의 배경색 설정
          ),
          alignment: Alignment.bottomLeft, // 텍스트 아래 왼쪽 정렬
          child: buildSearchField(_filterDataByKeyword), // 검색 필드 추가
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 16,),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredData.isNotEmpty ? _filteredData.length : rowDataList.length,
                  itemBuilder: (context, index) {
                    final item = _filteredData.isNotEmpty ? _filteredData[index] : rowDataList[index];
                    final IconData categoryIcon = _buildCategoryIcon(item['품목 그룹코드']);
                    final Color categoryColor = _buildCategoryColor(item['품목 그룹코드']);

                    return Column(
                      children: [
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10), // 사각형의 둥근 모서리 설정
                                      border: Border.all(
                                        color: Colors.black38, // 테두리 색상 설정
                                        width: 1, // 테두리 두께 설정
                                      ),
                                    ),
                                    child: Icon(
                                      categoryIcon,
                                      size: 32,
                                      color: categoryColor,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text('${item['품목명']}',
                                    style: TextStyle(
                                      color: Colors.black87, // 텍스트 색상 설정
                                      fontSize: 20, // 텍스트 크기 설정
                                      fontFamily: 'Jua',
                                    ),
                                  ),
                                ],
                              ),
                              Text('${item['품종명']}',
                                style: TextStyle(
                                  color: Colors.black87, // 텍스트 색상 설정
                                  fontSize: 18, // 텍스트 크기 설정
                                  fontFamily: 'Orbit',
                                ),
                              ),
                            ],
                          ),
                          onTap: () => _showItemDialog(item),
                        ),
                        Divider(height: 2,thickness: 1,),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          // 떠있는 버튼 애니메이션 추가
          Positioned(
            bottom: 16,
            left: 16,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _isFloatingButtonsVisible ? MediaQuery.of(context).size.height * 0.65 : 0, // 화면 높이의 50% 또는 0으로 설정
              child: Column(
                children: [
                  _buildCategoryButton('식량작물', '100', Icons.restaurant_menu),
                  SizedBox(height: 7,),
                  _buildCategoryButton('채소류', '200', Icons.local_florist),
                  SizedBox(height: 7,),
                  _buildCategoryButton('특용작물', '300', Icons.agriculture),
                  SizedBox(height: 7,),
                  _buildCategoryButton('과일류', '400', Icons.local_grocery_store),
                  SizedBox(height: 7,),
                  _buildCategoryButton('축산물', '500', Icons.pets),
                  SizedBox(height: 7,),
                  _buildCategoryButton('수산물', '600', Icons.waves),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              width: 60, // 원하는 너비로 조정
              height: 60, // 원하는 높이로 조정
              child: Material(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기 설정
                ),
                clipBehavior: Clip.antiAlias,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent[100],
                    borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기 설정
                  ),
                  child: InkWell(
                    onTap: () {
                      _toggleFloatingButtonsVisibility(); // 애니메이션 토글
                      // _showCountryCodeList();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: _buildIcon(_selectedIconData, 28, Colors.deepPurpleAccent),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 떠있는 버튼 추가
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              width: 60, // 원하는 너비로 조정
              height: 60, // 원하는 높이로 조정
              child: ElevatedButton(
                onPressed: _showCountryCodeList,
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // 테두리 둥글기 설정
                  ),
                  elevation: 4.0,
                ),
                child: Center(
                  child: Text(
                    '$_selectedCountryName',
                    style: TextStyle(
                      color: Colors.deepPurple[50],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Orbit'
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
