import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TaxiResultModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for arrivalposition widget.
  TextEditingController? arrivalpositionController1;
  String? Function(BuildContext, String?)? arrivalpositionController1Validator;
  // State field(s) for arrivalposition widget.
  TextEditingController? arrivalpositionController2;
  String? Function(BuildContext, String?)? arrivalpositionController2Validator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    arrivalpositionController1?.dispose();
    arrivalpositionController2?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
