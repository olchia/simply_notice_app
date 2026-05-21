import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'checkin_page_widget.dart' show CheckinPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckinPageModel extends FlutterFlowModel<CheckinPageWidget> {
  ///  Local state fields for this page.

  double stressValue = 3.0;

  bool stressFilled = false;

  double energyValue = 3.0;

  double exhaustionValue = 3.0;

  double socialSupportValue = 3.0;

  bool energyFilled = false;

  bool exhaustionFilled = false;

  bool socialSupportFilled = false;

  int answeredCount = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<DailyInputsRecord>? todayInput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
