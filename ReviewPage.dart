import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReviewPage(),
    );
  }
}

class Review {
  final String region;
  final String comment;
  final double rating;

  Review({
    required this.region,
    required this.comment,
    required this.rating,
  });
}

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  String locationName = '서울';
  List<Review> _reviewList = [
    Review(
      region: '서울',
      comment: '좋은 장소입니다.',
      rating: 4.0,
    ),
    Review(
      region: '부산',
      comment: '꼭 다시 가고 싶은 곳입니다.',
      rating: 5.0,
    ),
    Review(
      region: '경기도',
      comment: '훌륭한 휴식처입니다.',
      rating: 4.0,
    ),
    Review(
      region: '강원도',
      comment: '자연 경치가 아름답습니다.',
      rating: 4.8,
    ),
    Review(
      region: '제주도',
      comment: '여유로운 분위기가 좋았습니다.',
      rating: 4.0,
    ),
    Review(
      region: '서울',
      comment: '다시 오고 싶은 장소입니다.',
      rating: 4.5,
    ),
    Review(
      region: '부산',
      comment: '놀러가면 즐거운 곳입니다.',
      rating: 4.2,
    ),
    Review(
      region: '경기도',
      comment: '가족과 함께 가기 좋은 곳입니다.',
      rating: 4.7,
    ),
    Review(
      region: '강원도',
      comment: '힐링이 되는 곳입니다.',
      rating: 4.3,
    ),
    Review(
      region: '서울',
      comment: '다시 오고 싶은 장소입니다.',
      rating: 4.5,
    ),
    Review(
      region: '부산',
      comment: '놀러가면 즐거운 곳입니다.',
      rating: 4.2,
    ),
    Review(
      region: '경기도',
      comment: '가족과 함께 가기 좋은 곳입니다.',
      rating: 4.7,
    ),
    Review(
      region: '강원도',
      comment: '힐링이 되는 곳입니다.',
      rating: 4.3,
    ),
    Review(
      region: '제주도',
      comment: '자연 속에서의 휴식이 좋았습니다.',
      rating: 4.6,
    ),
    Review(
      region: '서울',
      comment: '도심 속의 자연을 느낄 수 있었습니다.',
      rating: 4.8,
    ),
    Review(
      region: '부산',
      comment: '바다 풍경이 멋진 곳입니다.',
      rating: 4.4,
    ),
    Review(
      region: '경기도',
      comment: '공원이 아름다운 휴식처입니다.',
      rating: 4.9,
    ),
    Review(
      region: '강원도',
      comment: '산과 호수가 조화로운 곳입니다.',
      rating: 4.7,
    ),
    Review(
      region: '제주도',
      comment: '다양한 놀이 시설이 있는 곳입니다.',
      rating: 4.2,
    ),
  ];

  int _selectedStars = 0;
  String _searchKeyword = ''; // 추가: 검색어 저장 변수
  double averageRating = 0;
  int averageStarCount = 0;

  void _filterDataByKeyword(String keyword) {
    setState(() {
      _searchKeyword = keyword;
      if (_searchKeyword.isEmpty) {
        locationName = '서울'; // 검색어가 없을 때 기본값으로 설정
      } else {
        locationName = _searchKeyword; // 검색어를 locationName으로 사용
      }
    });
    _updateAverageRating();
  }

  void _updateAverageRating() {
    List<Review> reviewsForLocation = _reviewList.where((review) => review.region == locationName).toList();

    if (reviewsForLocation.isEmpty) {
      // 해당 지역의 리뷰가 없을 경우 평균 평점과 별 개수를 0으로 설정
      setState(() {
        averageRating = 0;
        averageStarCount = 0;
      });
    } else {
      double totalRating = reviewsForLocation.map((review) => review.rating).reduce((sum, rating) => sum + rating);
      double newAverageRating = totalRating / reviewsForLocation.length;

      // 평균 평점에 따라 별 개수 계산
      int newAverageStarCount = (newAverageRating / 0.5).round(); // 0.5 간격으로 별 1개 증가
      setState(() {
        averageRating = newAverageRating;
        averageStarCount = newAverageStarCount;
      });
    }
  }

  void _showReviewDialog(BuildContext context) {
    String location = '';
    String accommodationName = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '리뷰 작성',
                        style: TextStyle(
                          fontFamily: 'Gugi',
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedStars = index + 1;
                          });
                        },
                        child: Icon(
                          index < _selectedStars
                              ? Icons.star
                              : Icons.star_border,
                          size: 40,
                          color: Colors.yellow[700],
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '지역',
                      labelStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Orbit',
                          fontSize: 14),
                      contentPadding:
                      EdgeInsets.only(left: 8.0, right: 8.0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.grey[800],
                      ),
                    ),
                    onChanged: (value) => location = value,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '리뷰',
                      labelStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Orbit',
                          fontSize: 14),
                      contentPadding:
                      EdgeInsets.only(left: 8.0, right: 8.0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.deepPurpleAccent),
                      ),
                      prefixIcon: Icon(
                        Icons.comment,
                        color: Colors.grey[800],
                      ),
                    ),
                    onChanged: (value) => accommodationName = value,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    // 리뷰 저장 및 서버로 전송 로직 추가
                    Review newReview = Review(
                      region: location,
                      comment: accommodationName,
                      rating: _selectedStars.toDouble(),
                    );
                    setState(() {
                      _reviewList.add(newReview);
                    });
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    primary: Colors.deepPurpleAccent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('작성하기'),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildSearchField(Function(String) onChanged) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 6.0),
          child: IconButton(
            onPressed: () =>Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        Text(
          '리뷰',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Gugi',
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
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
                contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 4.0),
                ),
                suffixIcon: Icon(Icons.search, color: Colors.purple),
              ),
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Orbit',
              ),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Review> filteredReviews = _reviewList.where((review) {
      return review.region == locationName &&
          (review.comment.contains(_searchKeyword) ||
              review.region.contains(_searchKeyword));
    }).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          padding: EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: Colors.white24,
          ),
          alignment: Alignment.bottomLeft,
          child: buildSearchField(_filterDataByKeyword),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  '${locationName} 평균 평점',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 16,
                  ),
                ),
                Text(
                  averageRating.toStringAsFixed(1), // 소수점 한 자리까지 표시
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'Gugi',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    if (index < averageStarCount) {
                      return Icon(Icons.star, color: Colors.yellow[700]);
                    } else if (index == averageStarCount && averageStarCount - averageRating > 0.25) {
                      return Icon(Icons.star_half, color: Colors.yellow[700]);
                    } else {
                      return Icon(Icons.star_border, color: Colors.yellow[700]);
                    }
                  }),
                ),
                SizedBox(height: 16),
              ],
            ),
            Divider(thickness: 2,),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredReviews.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(
                          filteredReviews[index].region, // 변경된 부분
                          style: TextStyle(
                            fontFamily: 'Jua',
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 8,),
                        Row(
                          children: List.generate(
                            5,
                                (starIndex) => Icon(
                              starIndex < filteredReviews[index].rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.yellow[700],
                              size: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text(
                          '(${filteredReviews[index].rating})', // 변경된 부분
                          style: TextStyle(
                            fontFamily: 'Orbit',
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filteredReviews[index].comment, // 변경된 부분
                          style: TextStyle(
                              fontFamily: 'Orbit',
                              fontSize: 14
                          ),
                        ),
                        SizedBox(height: 8),
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showReviewDialog(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                primary: Colors.deepPurpleAccent,
                minimumSize: Size(double.infinity, 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.comment,),
                  SizedBox(width: 8),
                  Text(
                    '리뷰 작성하기',
                    style: TextStyle(
                        fontFamily: 'Orbit',
                        fontSize: 16
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
