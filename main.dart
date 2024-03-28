import 'package:yeah/LodgmentPage.dart';
import 'package:yeah/ProductPage.dart';
import 'package:yeah/ReviewPage.dart';
import 'package:yeah/foodmain.dart';
import 'package:yeah/place_picker/widgets/place_picker.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pages/home_page/home_page_model.dart';
export 'pages/home_page/home_page_model.dart';
import 'package:flutter_web_plugins/url_strategy.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
      create: (context) => appState,
      child: MaterialApp(
        home: HomePageWidget(),
      )));
}

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        RotateEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 900.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'rowOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: Offset(0.0, 80.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: Offset(0.0, 80.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: Offset(0.0, 80.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 600.ms,
          begin: Offset(0.0, 80.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'containerOnPageLoadAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 500.ms,
          duration: 600.ms,
          begin: Offset(0.0, 80.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 500.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 24.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/Sun.svg',
                                  width: 16.0,
                                  height: 16.0,
                                  fit: BoxFit.cover,
                                ).animateOnPageLoad(
                                    animationsMap['imageOnPageLoadAnimation']!),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      6.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'SAT 5 AUG',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Rubik',
                                          color: Color(0xFF8B80F8),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 6.0, 0.0, 0.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'TADO! 바가지',
                                      style: GoogleFonts.getFont(
                                        'Jua',
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Rubik',
                                        fontSize: 24.0,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6FA),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 24.0, 16.0, 24.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/Plygonx.svg',
                                        width: 80.0,
                                        height: 80.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        '72',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Rubik',
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '현재 지역의 평점',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 16.0,
                                                ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 6.0, 0.0, 6.0),
                                            child: Text(
                                              '청정지역이네요!',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color: Color(0xFF828282),
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                            ),
                                          ),
                                          Text(
                                            '다른지역 평점 보기',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Rubik',
                                                  color: Color(0xFF8B80F8),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).animateOnPageLoad(
                        animationsMap['columnOnPageLoadAnimation']!),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MENU',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Rubik',
                                    fontSize: 16.0,
                                  ),
                            ),
                          ],
                        ).animateOnPageLoad(
                            animationsMap['rowOnPageLoadAnimation']!),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: GridView(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 0.75,
                            ),
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodMain(),
                                    ),
                                  );
                                  // context.pushNamed(
                                  //   'food',
                                  //   extra: <String, dynamic>{
                                  //     kTransitionInfoKey: TransitionInfo(
                                  //       hasTransition: true,
                                  //       transitionType: PageTransitionType.fade,
                                  //     ),
                                  //   },
                                  // );
                                },
                                child: Container(
                                  width: 156.0,
                                  height: 216.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF8B80F8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.0,
                                        color: FlutterFlowTheme.of(context)
                                            .black600,
                                        offset: Offset(3.0, 3.0),
                                        spreadRadius: 0.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '음식',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Rubik',
                                                        color: Colors.white,
                                                        fontSize: 12.0,
                                                        letterSpacing: 1.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.food_bank,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          size: 100.0,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Flexible(
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        '음식 바가지\n',
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily: 'Jua',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 22.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation1']!),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 156.0,
                                  height: 216.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFAF8EFF),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.0,
                                        color:
                                            FlutterFlowTheme.of(context).black600,
                                        offset: Offset(3.0, 3.0),
                                        spreadRadius: 0.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '농수산',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    letterSpacing: 1.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        FaIcon(
                                          FontAwesomeIcons.fish,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          size: 100.0,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Align(
                                                    alignment: AlignmentDirectional(
                                                        0.0, 0.0),
                                                    child: Text(
                                                      '특산품 바가지\n',
                                                      textAlign: TextAlign.start,
                                                      style: FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Jua',
                                                            color: Colors.white,
                                                            fontSize: 22.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'containerOnPageLoadAnimation2']!),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlacePicker("AIzaSyD0Zwmr6ERIT0VGzsvBof8E9aaH_GFR-YU"),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 156.0,
                                  height: 216.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1E87FD),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.0,
                                        color:
                                            FlutterFlowTheme.of(context).black600,
                                        offset: Offset(3.0, 3.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '택시',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    letterSpacing: 1.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.local_taxi_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          size: 100.0,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Align(
                                            alignment: AlignmentDirectional(
                                            0.0, 0.0),
                                                    child: Text(
                                                      '택시 바가지\n',
                                                      style:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: 'Jua',
                                                                color: Colors.white,
                                                                fontSize: 22.0,
                                                                fontWeight:
                                                                    FontWeight.w500,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'containerOnPageLoadAnimation3']!),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LodgmentPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 156.0,
                                  height: 216.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4C5A81),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 7.0,
                                        color:
                                            FlutterFlowTheme.of(context).black600,
                                        offset: Offset(3.0, 3.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '숙박',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Rubik',
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    letterSpacing: 1.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.home_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          size: 100.0,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Align(
                                            alignment: AlignmentDirectional(
                                            0.0, 0.0),
                                                    child: Text(
                                                      '숙박 바가지\n',
                                                      style:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily: 'Jua',
                                                                color: Colors.white,
                                                                fontSize: 22.0,
                                                                fontWeight:
                                                                    FontWeight.w500,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'containerOnPageLoadAnimation4']!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
