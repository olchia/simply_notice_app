import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'simulation_page_model.dart';
export 'simulation_page_model.dart';

class SimulationPageWidget extends StatefulWidget {
  const SimulationPageWidget({super.key});

  static String routeName = 'SimulationPage';
  static String routePath = '/simulationPage';

  @override
  State<SimulationPageWidget> createState() => _SimulationPageWidgetState();
}

class _SimulationPageWidgetState extends State<SimulationPageWidget> {
  late SimulationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SimulationPageModel());

    _model.sleepHoursTextController ??= TextEditingController();
    _model.sleepHoursFocusNode ??= FocusNode();

    _model.sleepMinutesTextController ??= TextEditingController();
    _model.sleepMinutesFocusNode ??= FocusNode();

    _model.stepsTextController ??= TextEditingController();
    _model.stepsFocusNode ??= FocusNode();

    _model.stressTextController ??= TextEditingController();
    _model.stressFocusNode ??= FocusNode();

    _model.energyTextController ??= TextEditingController();
    _model.energyFocusNode ??= FocusNode();

    _model.exhaustionTextController ??= TextEditingController();
    _model.exhaustionFocusNode ??= FocusNode();

    _model.socialSupportTextController ??= TextEditingController();
    _model.socialSupportFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF0B0F1A),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 30.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.safePop();
                      },
                      child: Text(
                        'Ввод данных за день',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              font: GoogleFonts.roboto(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                              color: Color(0xFFF0F1FB),
                              fontSize: 26.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ),
                ),
                FlutterFlowCalendar(
                  color: FlutterFlowTheme.of(context).primary,
                  iconColor: FlutterFlowTheme.of(context).secondaryText,
                  weekFormat: false,
                  weekStartsMonday: false,
                  rowHeight: 48.0,
                  onChange: (DateTimeRange? newSelectedDate) {
                    safeSetState(
                        () => _model.calendarSelectedDay = newSelectedDate);
                  },
                  titleStyle: FlutterFlowTheme.of(context).titleLarge.override(
                        font: GoogleFonts.interTight(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                        color: Color(0xFF57636C),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                  dayOfWeekStyle: FlutterFlowTheme.of(context)
                      .bodyLarge
                      .override(
                        font: GoogleFonts.inter(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        color: Color(0xFF57636C),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                  dateStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: Color(0xFF57636C),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                  selectedDateStyle: FlutterFlowTheme.of(context)
                      .titleSmall
                      .override(
                        font: GoogleFonts.interTight(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  inactiveDateStyle: FlutterFlowTheme.of(context)
                      .labelMedium
                      .override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 16.0),
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _model.sleepHoursTextController,
                      focusNode: _model.sleepHoursFocusNode,
                      autofocus: false,
                      enabled: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        hintText: 'Сон в часах',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF182633),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFF131A30),
                        contentPadding: EdgeInsets.all(18.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF6E7C89),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      keyboardType: TextInputType.number,
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      enableInteractiveSelection: true,
                      validator: _model.sleepHoursTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 16.0),
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _model.sleepMinutesTextController,
                      focusNode: _model.sleepMinutesFocusNode,
                      autofocus: false,
                      enabled: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        hintText: 'Сон в минутах',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF182633),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFF131A30),
                        contentPadding: EdgeInsets.all(18.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF6E7C89),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      keyboardType: TextInputType.number,
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      enableInteractiveSelection: true,
                      validator: _model.sleepMinutesTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 16.0),
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _model.stepsTextController,
                      focusNode: _model.stepsFocusNode,
                      autofocus: false,
                      enabled: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        hintText: 'Активность (шаги)',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF182633),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFF131A30),
                        contentPadding: EdgeInsets.all(18.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF6E7C89),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      keyboardType: TextInputType.number,
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      enableInteractiveSelection: true,
                      validator: _model.stepsTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 16.0),
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _model.stressTextController,
                      focusNode: _model.stressFocusNode,
                      autofocus: false,
                      enabled: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        hintText: 'Стресс (от 1 до 5)',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF182633),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFF131A30),
                        contentPadding: EdgeInsets.all(18.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF6E7C89),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      keyboardType: TextInputType.number,
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      enableInteractiveSelection: true,
                      validator: _model.stressTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 16.0),
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _model.energyTextController,
                      focusNode: _model.energyFocusNode,
                      autofocus: false,
                      enabled: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        hintText: 'Энергия (от 1 до 5)',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF182633),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFF131A30),
                        contentPadding: EdgeInsets.all(18.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF6E7C89),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      keyboardType: TextInputType.number,
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      enableInteractiveSelection: true,
                      validator: _model.energyTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 16.0),
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _model.exhaustionTextController,
                      focusNode: _model.exhaustionFocusNode,
                      autofocus: false,
                      enabled: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        hintText: 'Истощение (от 1 до 5)',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF182633),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFF131A30),
                        contentPadding: EdgeInsets.all(18.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF6E7C89),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      keyboardType: TextInputType.number,
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      enableInteractiveSelection: true,
                      validator: _model.exhaustionTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 40.0),
                  child: Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _model.socialSupportTextController,
                      focusNode: _model.socialSupportFocusNode,
                      autofocus: false,
                      enabled: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        hintText: 'Причастность к социуму (от 1 до 5)',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF182633),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFF131A30),
                        contentPadding: EdgeInsets.all(18.0),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: Color(0xFF6E7C89),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      keyboardType: TextInputType.number,
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      enableInteractiveSelection: true,
                      validator: _model.socialSupportTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(70.0, 0.0, 70.0, 19.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.selectedDayInput =
                          await queryDailyInputsRecordOnce(
                        queryBuilder: (dailyInputsRecord) => dailyInputsRecord
                            .where(
                              'uid',
                              isEqualTo: currentUserUid,
                            )
                            .where(
                              'date',
                              isEqualTo: _model.calendarSelectedDay?.start,
                            ),
                        limit: 1,
                      );
                      if (_model.selectedDayInput != null &&
                          (_model.selectedDayInput)!.isNotEmpty) {
                        await _model.selectedDayInput!
                            .elementAtOrNull(0)!
                            .reference
                            .update(createDailyInputsRecordData(
                              sleepHours: int.tryParse(
                                  _model.sleepHoursTextController.text),
                              sleepMinutes: int.tryParse(
                                  _model.sleepMinutesTextController.text),
                              steps:
                                  int.tryParse(_model.stepsTextController.text),
                              stress: int.tryParse(
                                  _model.stressTextController.text),
                              energy: int.tryParse(
                                  _model.energyTextController.text),
                              exhaustion: int.tryParse(
                                  _model.exhaustionTextController.text),
                              socialSupport: int.tryParse(
                                  _model.socialSupportTextController.text),
                              updatedAt: getCurrentTimestamp,
                              sleepDurationTotalMinutes:
                                  functions.calcSleepMinutes(
                                      int.parse(
                                          _model.sleepHoursTextController.text),
                                      int.parse(_model
                                          .sleepMinutesTextController.text)),
                            ));
                      } else {
                        await DailyInputsRecord.collection
                            .doc()
                            .set(createDailyInputsRecordData(
                              uid: currentUserUid,
                              date: _model.calendarSelectedDay?.start,
                              sleepHours: int.tryParse(
                                  _model.sleepHoursTextController.text),
                              sleepMinutes: int.tryParse(
                                  _model.sleepMinutesTextController.text),
                              steps:
                                  int.tryParse(_model.stepsTextController.text),
                              stress: int.tryParse(
                                  _model.stressTextController.text),
                              energy: int.tryParse(
                                  _model.energyTextController.text),
                              exhaustion: int.tryParse(
                                  _model.exhaustionTextController.text),
                              socialSupport: int.tryParse(
                                  _model.socialSupportTextController.text),
                              createdAt: getCurrentTimestamp,
                              updatedAt: getCurrentTimestamp,
                              sleepDurationTotalMinutes:
                                  functions.calcSleepMinutes(
                                      int.parse(
                                          _model.sleepHoursTextController.text),
                                      int.parse(_model
                                          .sleepMinutesTextController.text)),
                            ));
                      }

                      context.pushNamed(MainPageWidget.routeName);

                      safeSetState(() {});
                    },
                    text: 'Dev: сохранить данные дня',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 42.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFFF0F1FB),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: Color(0xFF0B0F1A),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(70.0, 0.0, 70.0, 19.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.selectedDayInputForScore =
                          await queryDailyInputsRecordOnce(
                        queryBuilder: (dailyInputsRecord) => dailyInputsRecord
                            .where(
                              'uid',
                              isEqualTo: currentUserUid,
                            )
                            .where(
                              'date',
                              isEqualTo: _model.calendarSelectedDay?.start,
                            ),
                        limit: 1,
                      );
                      if (_model.selectedDayInputForScore != null &&
                          (_model.selectedDayInputForScore)!.isNotEmpty) {
                        _model.previous14Inputs =
                            await queryDailyInputsRecordOnce(
                          queryBuilder: (dailyInputsRecord) => dailyInputsRecord
                              .where(
                                'uid',
                                isEqualTo: currentUserUid,
                              )
                              .where(
                                'date',
                                isLessThan: _model.calendarSelectedDay?.start,
                              )
                              .orderBy('date', descending: true),
                          limit: 14,
                        );
                        _model.selectedDayScore =
                            await queryDailyScoresRecordOnce(
                          queryBuilder: (dailyScoresRecord) => dailyScoresRecord
                              .where(
                                'uid',
                                isEqualTo: currentUserUid,
                              )
                              .where(
                                'date',
                                isEqualTo: _model.calendarSelectedDay?.start,
                              ),
                          limit: 1,
                        );
                        if (!(_model.selectedDayScore != null &&
                            (_model.selectedDayScore)!.isNotEmpty)) {
                          await DailyScoresRecord.collection
                              .doc()
                              .set(createDailyScoresRecordData(
                                uid: currentUserUid,
                                date: _model.calendarSelectedDay?.start,
                                createdAt: getCurrentTimestamp,
                                sleepDurationTotalMinutes: _model
                                    .selectedDayInputForScore
                                    ?.elementAtOrNull(0)
                                    ?.sleepDurationTotalMinutes,
                                steps: _model.selectedDayInputForScore
                                    ?.elementAtOrNull(0)
                                    ?.steps,
                                stress: _model.selectedDayInputForScore
                                    ?.elementAtOrNull(0)
                                    ?.stress,
                                energy: _model.selectedDayInputForScore
                                    ?.elementAtOrNull(0)
                                    ?.energy,
                                exhaustion: _model.selectedDayInputForScore
                                    ?.elementAtOrNull(0)
                                    ?.exhaustion,
                                socialSupport: _model.selectedDayInputForScore
                                    ?.elementAtOrNull(0)
                                    ?.socialSupport,
                                sleepZoneScore: functions.calcSleepZoneScore(
                                    _model.selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .sleepDurationTotalMinutes),
                                sleepBaseline14d: functions.calcAverageIntList(
                                    _model.previous14Inputs!
                                        .map((e) => e.sleepDurationTotalMinutes)
                                        .toList()),
                                sleepDeviation: functions.calcSleepDeviation(
                                    _model.selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .sleepDurationTotalMinutes,
                                    functions.calcAverageIntList(_model
                                        .previous14Inputs!
                                        .map((e) => e.sleepDurationTotalMinutes)
                                        .toList())),
                                sleepScore: functions.calcAverageTwoDoubles(
                                    functions.calcSleepZoneScore(_model
                                        .selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .sleepDurationTotalMinutes),
                                    functions.calcSleepDeviationScore(
                                        _model.selectedDayInputForScore!
                                            .elementAtOrNull(0)!
                                            .sleepDurationTotalMinutes
                                            .toDouble(),
                                        functions.calcAverageIntList(_model
                                            .previous14Inputs!
                                            .map((e) =>
                                                e.sleepDurationTotalMinutes)
                                            .toList()))),
                                stepsBaseline14d: functions.calcAverageIntList(
                                    _model.previous14Inputs!
                                        .map((e) => e.steps)
                                        .toList()),
                                stepsDeviation: functions.calcIntDeviation(
                                    _model.selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .steps,
                                    functions.calcAverageIntList(_model
                                        .previous14Inputs!
                                        .map((e) => e.steps)
                                        .toList())),
                                activityScore: functions.calcPositiveRatioScore(
                                    _model.selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .steps,
                                    functions.calcAverageIntList(_model
                                        .previous14Inputs!
                                        .map((e) => e.steps)
                                        .toList())),
                                stressBaseline14d: functions.calcAverageIntList(
                                    _model.previous14Inputs!
                                        .map((e) => e.stress)
                                        .toList()),
                                stressDeviation: functions.calcIntDeviation(
                                    _model.selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .stress,
                                    functions.calcAverageIntList(_model
                                        .previous14Inputs!
                                        .map((e) => e.stress)
                                        .toList())),
                                stressScore: functions.calcNegativeRatioScore(
                                    _model.selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .stress,
                                    functions.calcAverageIntList(_model
                                        .previous14Inputs!
                                        .map((e) => e.stress)
                                        .toList())),
                                energyBaseline14d: functions.calcAverageIntList(
                                    _model.previous14Inputs!
                                        .map((e) => e.energy)
                                        .toList()),
                                energyDeviation: functions.calcIntDeviation(
                                    _model.selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .energy,
                                    functions.calcAverageIntList(_model
                                        .previous14Inputs!
                                        .map((e) => e.energy)
                                        .toList())),
                                energyScore: functions.calcPositiveRatioScore(
                                    _model.selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .energy,
                                    functions.calcAverageIntList(_model
                                        .previous14Inputs!
                                        .map((e) => e.energy)
                                        .toList())),
                                exhaustionBaseline14d: functions
                                    .calcAverageIntList(_model.previous14Inputs!
                                        .map((e) => e.exhaustion)
                                        .toList()),
                                exhaustionDeviation: functions.calcIntDeviation(
                                    _model.selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .exhaustion,
                                    functions.calcAverageIntList(_model
                                        .previous14Inputs!
                                        .map((e) => e.exhaustion)
                                        .toList())),
                                exhaustionScore:
                                    functions.calcNegativeRatioScore(
                                        _model.selectedDayInputForScore!
                                            .elementAtOrNull(0)!
                                            .exhaustion,
                                        functions.calcAverageIntList(_model
                                            .previous14Inputs!
                                            .map((e) => e.exhaustion)
                                            .toList())),
                                socialBaseline14d: functions.calcAverageIntList(
                                    _model.previous14Inputs!
                                        .map((e) => e.socialSupport)
                                        .toList()),
                                socialDeviation: functions.calcIntDeviation(
                                    _model.selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .socialSupport,
                                    functions.calcAverageIntList(_model
                                        .previous14Inputs!
                                        .map((e) => e.socialSupport)
                                        .toList())),
                                socialScore: functions.calcPositiveRatioScore(
                                    _model.selectedDayInputForScore!
                                        .elementAtOrNull(0)!
                                        .socialSupport,
                                    functions.calcAverageIntList(_model
                                        .previous14Inputs!
                                        .map((e) => e.socialSupport)
                                        .toList())),
                                physiologicalGroupScore: functions.calcAverageTwoDoubles(
                                    functions.calcAverageTwoDoubles(
                                        functions.calcSleepZoneScore(_model
                                            .selectedDayInputForScore!
                                            .elementAtOrNull(0)!
                                            .sleepDurationTotalMinutes),
                                        functions.calcSleepDeviationScore(
                                            _model.selectedDayInputForScore!
                                                .elementAtOrNull(0)!
                                                .sleepDurationTotalMinutes
                                                .toDouble(),
                                            functions.calcAverageIntList(_model
                                                .previous14Inputs!
                                                .map((e) =>
                                                    e.sleepDurationTotalMinutes)
                                                .toList()))),
                                    functions.calcPositiveRatioScore(
                                        _model.selectedDayInputForScore!
                                            .elementAtOrNull(0)!
                                            .steps,
                                        functions.calcAverageIntList(
                                            _model.previous14Inputs!.map((e) => e.steps).toList()))),
                                psychologicalGroupScore:
                                    functions.calcAverageThreeDoubles(
                                        functions.calcNegativeRatioScore(
                                            _model.selectedDayInputForScore!
                                                .elementAtOrNull(0)!
                                                .stress,
                                            functions.calcAverageIntList(_model
                                                .previous14Inputs!
                                                .map((e) => e.stress)
                                                .toList())),
                                        functions.calcPositiveRatioScore(
                                            _model.selectedDayInputForScore!
                                                .elementAtOrNull(0)!
                                                .energy,
                                            functions.calcAverageIntList(_model
                                                .previous14Inputs!
                                                .map((e) => e.energy)
                                                .toList())),
                                        functions.calcNegativeRatioScore(
                                            _model.selectedDayInputForScore!
                                                .elementAtOrNull(0)!
                                                .exhaustion,
                                            functions.calcAverageIntList(_model
                                                .previous14Inputs!
                                                .map((e) => e.exhaustion)
                                                .toList()))),
                                socialGroupScore:
                                    functions.calcPositiveRatioScore(
                                        _model.selectedDayInputForScore!
                                            .elementAtOrNull(0)!
                                            .socialSupport,
                                        functions.calcAverageIntList(_model
                                            .previous14Inputs!
                                            .map((e) => e.socialSupport)
                                            .toList())),
                                overallStateScore: functions.calcAverageThreeDoubles(
                                    functions.calcAverageTwoDoubles(
                                        functions.calcAverageTwoDoubles(
                                            functions.calcSleepZoneScore(_model
                                                .selectedDayInputForScore!
                                                .elementAtOrNull(0)!
                                                .sleepDurationTotalMinutes),
                                            functions.calcSleepDeviationScore(
                                                _model.selectedDayInputForScore!
                                                    .elementAtOrNull(0)!
                                                    .sleepDurationTotalMinutes
                                                    .toDouble(),
                                                functions.calcAverageIntList(_model
                                                    .previous14Inputs!
                                                    .map((e) => e
                                                        .sleepDurationTotalMinutes)
                                                    .toList()))),
                                        functions.calcPositiveRatioScore(
                                            _model.selectedDayInputForScore!.elementAtOrNull(0)!.steps,
                                            functions.calcAverageIntList(_model.previous14Inputs!.map((e) => e.steps).toList()))),
                                    functions.calcAverageThreeDoubles(functions.calcNegativeRatioScore(_model.selectedDayInputForScore!.elementAtOrNull(0)!.stress, functions.calcAverageIntList(_model.previous14Inputs!.map((e) => e.stress).toList())), functions.calcPositiveRatioScore(_model.selectedDayInputForScore!.elementAtOrNull(0)!.energy, functions.calcAverageIntList(_model.previous14Inputs!.map((e) => e.energy).toList())), functions.calcNegativeRatioScore(_model.selectedDayInputForScore!.elementAtOrNull(0)!.exhaustion, functions.calcAverageIntList(_model.previous14Inputs!.map((e) => e.exhaustion).toList()))),
                                    functions.calcPositiveRatioScore(_model.selectedDayInputForScore!.elementAtOrNull(0)!.socialSupport, functions.calcAverageIntList(_model.previous14Inputs!.map((e) => e.socialSupport).toList()))),
                                stateZone: functions.calcStateZone(functions.calcAverageThreeDoubles(
                                    functions.calcAverageTwoDoubles(
                                        functions.calcAverageTwoDoubles(
                                            functions.calcSleepZoneScore(_model
                                                .selectedDayInputForScore!
                                                .elementAtOrNull(0)!
                                                .sleepDurationTotalMinutes),
                                            functions.calcSleepDeviationScore(
                                                _model.selectedDayInputForScore!
                                                    .elementAtOrNull(0)!
                                                    .sleepDurationTotalMinutes
                                                    .toDouble(),
                                                functions.calcAverageIntList(_model
                                                    .previous14Inputs!
                                                    .map((e) =>
                                                        e.sleepDurationTotalMinutes)
                                                    .toList()))),
                                        functions.calcPositiveRatioScore(_model.selectedDayInputForScore!.elementAtOrNull(0)!.steps, functions.calcAverageIntList(_model.previous14Inputs!.map((e) => e.steps).toList()))),
                                    functions.calcAverageThreeDoubles(functions.calcNegativeRatioScore(_model.selectedDayInputForScore!.elementAtOrNull(0)!.stress, functions.calcAverageIntList(_model.previous14Inputs!.map((e) => e.stress).toList())), functions.calcPositiveRatioScore(_model.selectedDayInputForScore!.elementAtOrNull(0)!.energy, functions.calcAverageIntList(_model.previous14Inputs!.map((e) => e.energy).toList())), functions.calcNegativeRatioScore(_model.selectedDayInputForScore!.elementAtOrNull(0)!.exhaustion, functions.calcAverageIntList(_model.previous14Inputs!.map((e) => e.exhaustion).toList()))),
                                    functions.calcPositiveRatioScore(_model.selectedDayInputForScore!.elementAtOrNull(0)!.socialSupport, functions.calcAverageIntList(_model.previous14Inputs!.map((e) => e.socialSupport).toList())))),
                              ));
                        }
                      }

                      safeSetState(() {});
                    },
                    text: 'Dev: пересчитать состояние',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 42.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Color(0xFFF0F1FB),
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: Color(0xFF0B0F1A),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
