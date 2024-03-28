import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'food_result_model.dart';
export 'food_result_model.dart';

class FoodResultWidget extends StatefulWidget {
  const FoodResultWidget({Key? key}) : super(key: key);

  @override
  _FoodResultWidgetState createState() => _FoodResultWidgetState();
}

class _FoodResultWidgetState extends State<FoodResultWidget> {
  late FoodResultModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FoodResultModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '평균가격',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Jua',
                                  fontSize: 16.0,
                                ),
                          ),
                          Divider(
                            thickness: 5.0,
                            color: FlutterFlowTheme.of(context).accent4,
                          ),
                          Text(
                            '12500',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  fontSize: 16.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '최대가격',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Jua',
                                  fontSize: 16.0,
                                ),
                          ),
                          Divider(
                            thickness: 5.0,
                            color: FlutterFlowTheme.of(context).accent4,
                          ),
                          Text(
                            '15000',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  fontSize: 16.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '최소가격',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Jua',
                                  fontSize: 16.0,
                                ),
                          ),
                          Divider(
                            thickness: 5.0,
                            color: FlutterFlowTheme.of(context).accent4,
                          ),
                          Text(
                            '10000',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  fontSize: 16.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '전국가격',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Jua',
                                  fontSize: 16.0,
                                ),
                          ),
                          Divider(
                            thickness: 5.0,
                            color: FlutterFlowTheme.of(context).accent4,
                          ),
                          Text(
                            '13000',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  fontSize: 16.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color:
                                      FlutterFlowTheme.of(context).customColor1,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).black600,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  '바가지 위험도는 적정 입니다.',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Jua',
                                        fontSize: 25.0,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          72.0, 10.0, 72.0, 10.0),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'AI 분석결과 자세히보기',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 54.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Jua',
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ListView(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '추천 식당',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Jua',
                            ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 5.0, 24.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 24.0, 24.0, 24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                CircularPercentIndicator(
                                  percent: 0.85,
                                  radius: 30.0,
                                  lineWidth: 4.0,
                                  animation: true,
                                  progressColor: Color(0xFF7165E3),
                                  backgroundColor: Color(0xFFE9E9E9),
                                ),
                                Text(
                                  '4.5',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '가게명',
                                            style: TextStyle(),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              fontSize: 16.0,
                                            ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '메뉴명',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                        Text(
                                          '가격',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 24.0,
                              borderWidth: 1.0,
                              buttonSize: 36.0,
                              fillColor: Color(0xFFE4DFFF),
                              icon: Icon(
                                Icons.location_on,
                                color: Color(0xFF7165E3),
                                size: 20.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 5.0, 24.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 24.0, 24.0, 24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                CircularPercentIndicator(
                                  percent: 0.85,
                                  radius: 30.0,
                                  lineWidth: 4.0,
                                  animation: true,
                                  progressColor: Color(0xFF7165E3),
                                  backgroundColor: Color(0xFFE9E9E9),
                                ),
                                Text(
                                  '4.5',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '가게명',
                                            style: TextStyle(),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              fontSize: 16.0,
                                            ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '메뉴명',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                        Text(
                                          '가격',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 24.0,
                              borderWidth: 1.0,
                              buttonSize: 36.0,
                              fillColor: Color(0xFFE4DFFF),
                              icon: Icon(
                                Icons.location_on,
                                color: Color(0xFF7165E3),
                                size: 20.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '모범 식당',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Jua',
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 5.0, 24.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 24.0, 24.0, 24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).success,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.mood,
                                  color: FlutterFlowTheme.of(context).success,
                                  size: 24.0,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '가게명',
                                            style: TextStyle(),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              fontSize: 16.0,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      '대표메뉴',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                    Text(
                                      '주소',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 24.0,
                              borderWidth: 1.0,
                              buttonSize: 36.0,
                              fillColor: Color(0xFFE4DFFF),
                              icon: Icon(
                                Icons.location_on,
                                color: Color(0xFF7165E3),
                                size: 20.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 5.0, 24.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 24.0, 24.0, 24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).success,
                                      width: 4.0,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.mood,
                                  color: FlutterFlowTheme.of(context).success,
                                  size: 24.0,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '가게명',
                                            style: TextStyle(),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              fontSize: 16.0,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      '대표메뉴',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                    Text(
                                      '주소',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 24.0,
                              borderWidth: 1.0,
                              buttonSize: 36.0,
                              fillColor: Color(0xFFE4DFFF),
                              icon: Icon(
                                Icons.location_on,
                                color: Color(0xFF7165E3),
                                size: 20.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
