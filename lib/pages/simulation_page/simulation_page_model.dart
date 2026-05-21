import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'simulation_page_widget.dart' show SimulationPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SimulationPageModel extends FlutterFlowModel<SimulationPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // State field(s) for sleep_hours widget.
  FocusNode? sleepHoursFocusNode;
  TextEditingController? sleepHoursTextController;
  String? Function(BuildContext, String?)? sleepHoursTextControllerValidator;
  // State field(s) for sleep_minutes widget.
  FocusNode? sleepMinutesFocusNode;
  TextEditingController? sleepMinutesTextController;
  String? Function(BuildContext, String?)? sleepMinutesTextControllerValidator;
  // State field(s) for steps widget.
  FocusNode? stepsFocusNode;
  TextEditingController? stepsTextController;
  String? Function(BuildContext, String?)? stepsTextControllerValidator;
  // State field(s) for stress widget.
  FocusNode? stressFocusNode;
  TextEditingController? stressTextController;
  String? Function(BuildContext, String?)? stressTextControllerValidator;
  // State field(s) for energy widget.
  FocusNode? energyFocusNode;
  TextEditingController? energyTextController;
  String? Function(BuildContext, String?)? energyTextControllerValidator;
  // State field(s) for exhaustion widget.
  FocusNode? exhaustionFocusNode;
  TextEditingController? exhaustionTextController;
  String? Function(BuildContext, String?)? exhaustionTextControllerValidator;
  // State field(s) for social_support widget.
  FocusNode? socialSupportFocusNode;
  TextEditingController? socialSupportTextController;
  String? Function(BuildContext, String?)? socialSupportTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<DailyInputsRecord>? selectedDayInput;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<DailyInputsRecord>? selectedDayInputForScore;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<DailyInputsRecord>? previous14Inputs;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<DailyScoresRecord>? selectedDayScore;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {
    sleepHoursFocusNode?.dispose();
    sleepHoursTextController?.dispose();

    sleepMinutesFocusNode?.dispose();
    sleepMinutesTextController?.dispose();

    stepsFocusNode?.dispose();
    stepsTextController?.dispose();

    stressFocusNode?.dispose();
    stressTextController?.dispose();

    energyFocusNode?.dispose();
    energyTextController?.dispose();

    exhaustionFocusNode?.dispose();
    exhaustionTextController?.dispose();

    socialSupportFocusNode?.dispose();
    socialSupportTextController?.dispose();
  }
}
