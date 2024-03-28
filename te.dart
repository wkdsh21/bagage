import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상품 정보'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '평균 가격: 12,000원',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('최고 가격: 15,000원'),
                Text('최저 가격: 10,000원'),
                Text('국내 가격: 10,000원'),
                SizedBox(height: 16),
                Text(
                  '판단 기준:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('바가지로 판단'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}