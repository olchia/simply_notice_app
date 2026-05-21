import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'stress_page_widget.dart' show StressPageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StressPageModel extends FlutterFlowModel<StressPageWidget> {
  ///  Local state fields for this page.

  int? selectedBarIndex = -1;

  bool isStressInfoExpanded = false;

  bool isRecommendationsExpanded = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
