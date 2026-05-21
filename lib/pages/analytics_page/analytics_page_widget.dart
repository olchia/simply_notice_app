import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'analytics_page_model.dart';
export 'analytics_page_model.dart';

class AnalyticsPageWidget extends StatefulWidget {
  const AnalyticsPageWidget({super.key});

  static String routeName = 'AnalyticsPage';
  static String routePath = '/analyticsPage';

  @override
  State<AnalyticsPageWidget> createState() => _AnalyticsPageWidgetState();
}

class _AnalyticsPageWidgetState extends State<AnalyticsPageWidget> {
  late AnalyticsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnalyticsPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DailyScoresRecord>>(
      stream: queryDailyScoresRecord(
        queryBuilder: (dailyScoresRecord) => dailyScoresRecord
            .where(
              'uid',
              isEqualTo: currentUserUid,
            )
            .orderBy('date', descending: true),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFF0B0F1A),
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<DailyScoresRecord> analyticsPageDailyScoresRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final analyticsPageDailyScoresRecord =
            analyticsPageDailyScoresRecordList.isNotEmpty
                ? analyticsPageDailyScoresRecordList.first
                : null;

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
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 56.0, 16.0, 0.0),
                child: StreamBuilder<List<DailyInputsRecord>>(
                  stream: queryDailyInputsRecord(
                    queryBuilder: (dailyInputsRecord) => dailyInputsRecord
                        .where(
                          'uid',
                          isEqualTo: currentUserUid,
                        )
                        .orderBy('date', descending: true),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    List<DailyInputsRecord> listViewDailyInputsRecordList =
                        snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final listViewDailyInputsRecord =
                        listViewDailyInputsRecordList.isNotEmpty
                            ? listViewDailyInputsRecordList.first
                            : null;

                    return ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Сводка',
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: 34.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 32.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (analyticsPageDailyScoresRecord
                                          ?.scoreAvailable ==
                                      true)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 7.0, 0.0, 0.0),
                                      child: Text(
                                        'Обновлено: ',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                              color: Color(0x8DFFFFFF),
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  if (analyticsPageDailyScoresRecord
                                          ?.scoreAvailable ==
                                      true)
                                    Text(
                                      valueOrDefault<String>(
                                        dateTimeFormat(
                                            "dd.MM.yyyy, HH:mm",
                                            analyticsPageDailyScoresRecord
                                                ?.calculatedAt),
                                        'n/a',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontStyle,
                                            ),
                                            color: Color(0x8DFFFFFF),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 32.0),
                              child: Container(
                                width: double.infinity,
                                height: 160.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1A26),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15.0,
                                      color: Color(0x41000000),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                    color: Color(0x39FFFFFF),
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 134.0,
                                      height: 139.4,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            6.0, 0.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 7.0),
                                                child: Text(
                                                  'Физиология',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            if (analyticsPageDailyScoresRecord
                                                    ?.scoreAvailable ==
                                                true)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 7.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    analyticsPageDailyScoresRecord
                                                                ?.scoreAvailable ==
                                                            false
                                                        ? 'Нет данных'
                                                        : valueOrDefault<
                                                            String>(
                                                            analyticsPageDailyScoresRecord
                                                                ?.physiologicalGroupScore
                                                                ?.toString(),
                                                            'n/a',
                                                          ),
                                                    'n/a',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color: () {
                                                          if (analyticsPageDailyScoresRecord
                                                                  ?.scoreAvailable ==
                                                              false) {
                                                            return Color(
                                                                0x8DFFFFFF);
                                                          } else if (analyticsPageDailyScoresRecord!
                                                                  .physiologicalGroupScore >=
                                                              0.7) {
                                                            return Color(
                                                                0xFF5EECD4);
                                                          } else if (analyticsPageDailyScoresRecord!
                                                                  .physiologicalGroupScore >=
                                                              0.4) {
                                                            return Color(
                                                                0xFFFFD21F);
                                                          } else {
                                                            return Color(
                                                                0xFFFF5A5A);
                                                          }
                                                        }(),
                                                        fontSize: 17.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            if (analyticsPageDailyScoresRecord
                                                    ?.scoreAvailable ==
                                                true)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        2.0, 0.0, 2.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                    border: Border.all(
                                                      color: () {
                                                        if (analyticsPageDailyScoresRecord!
                                                                .physiologicalGroupScore >=
                                                            0.7) {
                                                          return Color(
                                                              0xFF5EECD4);
                                                        } else if (analyticsPageDailyScoresRecord!
                                                                .physiologicalGroupScore >=
                                                            0.4) {
                                                          return Color(
                                                              0xFFFFD21F);
                                                        } else {
                                                          return Color(
                                                              0xFFFF5A5A);
                                                        }
                                                      }(),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  4.0,
                                                                  4.0,
                                                                  4.0),
                                                      child: Text(
                                                        () {
                                                          if (analyticsPageDailyScoresRecord!
                                                                  .physiologicalGroupScore >=
                                                              0.7) {
                                                            return 'В пределах нормы';
                                                          } else if (analyticsPageDailyScoresRecord!
                                                                  .physiologicalGroupScore >=
                                                              0.4) {
                                                            return 'Есть признаки истощения';
                                                          } else {
                                                            return 'Ресурс заметно снижен';
                                                          }
                                                        }(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: () {
                                                                    if (analyticsPageDailyScoresRecord!
                                                                            .physiologicalGroupScore >=
                                                                        0.7) {
                                                                      return Color(
                                                                          0xFF5EECD4);
                                                                    } else if (analyticsPageDailyScoresRecord!
                                                                            .physiologicalGroupScore >=
                                                                        0.4) {
                                                                      return Color(
                                                                          0xFFFFD21F);
                                                                    } else {
                                                                      return Color(
                                                                          0xFFFF5A5A);
                                                                    }
                                                                  }(),
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 110.0,
                                      child: VerticalDivider(
                                        thickness: 1.0,
                                        color: Color(0x39FFFFFF),
                                      ),
                                    ),
                                    Container(
                                      width: 230.0,
                                      height: 137.5,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 10.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                    SleepPageWidget.routeName);
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.asset(
                                                      'assets/images/icon-sleep.png',
                                                      width: 35.0,
                                                      height: 35.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Сон',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            font: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  if ((analyticsPageDailyScoresRecord!
                                                              .sleepDurationTotalMinutes <
                                                          analyticsPageDailyScoresRecord!
                                                              .sleepBaseline14dTotalMinutes) &&
                                                      (analyticsPageDailyScoresRecord
                                                              ?.scoreAvailable ==
                                                          true))
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 20.0,
                                                        height: 20.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: analyticsPageDailyScoresRecord!
                                                                        .sleepDurationTotalMinutes <
                                                                    analyticsPageDailyScoresRecord!
                                                                        .sleepBaseline14dTotalMinutes
                                                                ? Color(
                                                                    0x8DFFFFFF)
                                                                : Color(
                                                                    0x00FFFFFF),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.arrow_downward,
                                                          color: analyticsPageDailyScoresRecord!
                                                                      .sleepDurationTotalMinutes <
                                                                  analyticsPageDailyScoresRecord!
                                                                      .sleepBaseline14dTotalMinutes
                                                              ? Color(
                                                                  0x8DFFFFFF)
                                                              : Color(
                                                                  0x00FFFFFF),
                                                          size: 14.0,
                                                        ),
                                                      ),
                                                    ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/icon-chevron-right.png',
                                                          width: 22.0,
                                                          height: 22.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1.0,
                                            color: Color(0x39FFFFFF),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 11.0, 0.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                    StepsPageWidget.routeName);
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.asset(
                                                      'assets/images/icon-steps.png',
                                                      width: 28.0,
                                                      height: 28.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Активность',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            font: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  if ((listViewDailyInputsRecord!
                                                              .steps <
                                                          functions.roundDoubleToInt(
                                                              analyticsPageDailyScoresRecord!
                                                                  .stepsBaseline14d)) &&
                                                      (analyticsPageDailyScoresRecord
                                                              ?.scoreAvailable ==
                                                          true))
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 20.0,
                                                        height: 20.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: listViewDailyInputsRecord!
                                                                        .steps <
                                                                    functions.roundDoubleToInt(
                                                                        analyticsPageDailyScoresRecord!
                                                                            .stepsBaseline14d)
                                                                ? Color(
                                                                    0x8DFFFFFF)
                                                                : Color(
                                                                    0x00FFFFFF),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.arrow_downward,
                                                          color: listViewDailyInputsRecord!
                                                                      .steps <
                                                                  functions.roundDoubleToInt(
                                                                      analyticsPageDailyScoresRecord!
                                                                          .stepsBaseline14d)
                                                              ? Color(
                                                                  0x8DFFFFFF)
                                                              : Color(
                                                                  0x00FFFFFF),
                                                          size: 14.0,
                                                        ),
                                                      ),
                                                    ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/icon-chevron-right.png',
                                                          width: 22.0,
                                                          height: 22.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 32.0),
                              child: Container(
                                width: double.infinity,
                                height: 221.51,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1A26),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15.0,
                                      color: Color(0x41000000),
                                      offset: Offset(
                                        0.0,
                                        8.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                    color: Color(0x39FFFFFF),
                                    width: 1.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 134.0,
                                      height: 139.4,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            6.0, 0.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 7.0),
                                                child: Text(
                                                  'Психология',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            if (analyticsPageDailyScoresRecord
                                                    ?.scoreAvailable ==
                                                true)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 7.0),
                                                child: Text(
                                                  analyticsPageDailyScoresRecord
                                                              ?.scoreAvailable ==
                                                          false
                                                      ? 'Нет данных'
                                                      : valueOrDefault<String>(
                                                          analyticsPageDailyScoresRecord
                                                              ?.psychologicalGroupScore
                                                              ?.toString(),
                                                          'n/a',
                                                        ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                        color: () {
                                                          if (analyticsPageDailyScoresRecord
                                                                  ?.scoreAvailable ==
                                                              false) {
                                                            return Color(
                                                                0x8DFFFFFF);
                                                          } else if (analyticsPageDailyScoresRecord!
                                                                  .psychologicalGroupScore >=
                                                              0.7) {
                                                            return Color(
                                                                0xFF5EECD4);
                                                          } else if (analyticsPageDailyScoresRecord!
                                                                  .psychologicalGroupScore >=
                                                              0.4) {
                                                            return Color(
                                                                0xFFFFD21F);
                                                          } else {
                                                            return Color(
                                                                0xFFFF5A5A);
                                                          }
                                                        }(),
                                                        fontSize: 17.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            if (analyticsPageDailyScoresRecord
                                                    ?.scoreAvailable ==
                                                true)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        2.0, 0.0, 2.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                    border: Border.all(
                                                      color: () {
                                                        if (analyticsPageDailyScoresRecord!
                                                                .psychologicalGroupScore >=
                                                            0.7) {
                                                          return Color(
                                                              0xFF5EECD4);
                                                        } else if (analyticsPageDailyScoresRecord!
                                                                .psychologicalGroupScore >=
                                                            0.4) {
                                                          return Color(
                                                              0xFFFFD21F);
                                                        } else {
                                                          return Color(
                                                              0xFFFF5A5A);
                                                        }
                                                      }(),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  4.0,
                                                                  4.0,
                                                                  4.0),
                                                      child: Text(
                                                        () {
                                                          if (analyticsPageDailyScoresRecord!
                                                                  .psychologicalGroupScore >=
                                                              0.7) {
                                                            return 'В пределах нормы';
                                                          } else if (analyticsPageDailyScoresRecord!
                                                                  .psychologicalGroupScore >=
                                                              0.4) {
                                                            return 'Есть признаки истощения';
                                                          } else {
                                                            return 'Ресурс заметно снижен';
                                                          }
                                                        }(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: () {
                                                                    if (analyticsPageDailyScoresRecord!
                                                                            .psychologicalGroupScore >=
                                                                        0.7) {
                                                                      return Color(
                                                                          0xFF5EECD4);
                                                                    } else if (analyticsPageDailyScoresRecord!
                                                                            .psychologicalGroupScore >=
                                                                        0.4) {
                                                                      return Color(
                                                                          0xFFFFD21F);
                                                                    } else {
                                                                      return Color(
                                                                          0xFFFF5A5A);
                                                                    }
                                                                  }(),
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 170.0,
                                      child: VerticalDivider(
                                        thickness: 1.0,
                                        color: Color(0x39FFFFFF),
                                      ),
                                    ),
                                    Container(
                                      width: 230.0,
                                      height: 233.9,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 10.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                    StressPageWidget.routeName);
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.asset(
                                                      'assets/images/icon-stress.png',
                                                      width: 35.0,
                                                      height: 35.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Стресс',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            font: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  if ((listViewDailyInputsRecord!
                                                              .stress >
                                                          functions.roundDoubleToInt(
                                                              analyticsPageDailyScoresRecord!
                                                                  .stressBaseline14d)) &&
                                                      (analyticsPageDailyScoresRecord
                                                              ?.scoreAvailable ==
                                                          true))
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 20.0,
                                                        height: 20.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: listViewDailyInputsRecord!
                                                                        .stress >
                                                                    functions.roundDoubleToInt(
                                                                        analyticsPageDailyScoresRecord!
                                                                            .stressBaseline14d)
                                                                ? Color(
                                                                    0x8DFFFFFF)
                                                                : Color(
                                                                    0x00FFFFFF),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.arrow_upward,
                                                          color: listViewDailyInputsRecord!
                                                                      .stress >
                                                                  functions.roundDoubleToInt(
                                                                      analyticsPageDailyScoresRecord!
                                                                          .stressBaseline14d)
                                                              ? Color(
                                                                  0x8DFFFFFF)
                                                              : Color(
                                                                  0x00FFFFFF),
                                                          size: 14.0,
                                                        ),
                                                      ),
                                                    ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/icon-chevron-right.png',
                                                          width: 22.0,
                                                          height: 22.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1.0,
                                            color: Color(0x39FFFFFF),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 11.0, 0.0, 10.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                    EnergyPageWidget.routeName);
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.asset(
                                                      'assets/images/icon-energy.png',
                                                      width: 35.0,
                                                      height: 35.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Энергия',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            font: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  if ((listViewDailyInputsRecord!
                                                              .energy <
                                                          functions.roundDoubleToInt(
                                                              analyticsPageDailyScoresRecord!
                                                                  .energyBaseline14d)) &&
                                                      (analyticsPageDailyScoresRecord
                                                              ?.scoreAvailable ==
                                                          true))
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 20.0,
                                                        height: 20.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: () {
                                                              if (listViewDailyInputsRecord!
                                                                      .energy <
                                                                  functions.roundDoubleToInt(
                                                                      analyticsPageDailyScoresRecord!
                                                                          .energyBaseline14d)) {
                                                                return Color(
                                                                    0x8DFFFFFF);
                                                              } else if (analyticsPageDailyScoresRecord!
                                                                      .energyScore <
                                                                  0.4) {
                                                                return Color(
                                                                    0xFFFF5A5A);
                                                              } else if (analyticsPageDailyScoresRecord
                                                                      ?.energyScore ==
                                                                  0.0) {
                                                                return Color(
                                                                    0xFFFF5A5A);
                                                              } else {
                                                                return Color(
                                                                    0x00FFFFFF);
                                                              }
                                                            }(),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.arrow_downward,
                                                          color: listViewDailyInputsRecord!
                                                                      .energy <
                                                                  functions.roundDoubleToInt(
                                                                      analyticsPageDailyScoresRecord!
                                                                          .energyBaseline14d)
                                                              ? Color(
                                                                  0x8DFFFFFF)
                                                              : Color(
                                                                  0x00FFFFFF),
                                                          size: 14.0,
                                                        ),
                                                      ),
                                                    ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/icon-chevron-right.png',
                                                          width: 22.0,
                                                          height: 22.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1.0,
                                            color: Color(0x39FFFFFF),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 11.0, 0.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                    ExhaustionPageWidget
                                                        .routeName);
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.asset(
                                                      'assets/images/icon-exhaust.png',
                                                      width: 35.0,
                                                      height: 35.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Истощение',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            font: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  if ((listViewDailyInputsRecord!
                                                              .exhaustion >
                                                          functions.roundDoubleToInt(
                                                              analyticsPageDailyScoresRecord!
                                                                  .exhaustionBaseline14d)) &&
                                                      (analyticsPageDailyScoresRecord
                                                              ?.scoreAvailable ==
                                                          true))
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 20.0,
                                                        height: 20.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: listViewDailyInputsRecord!
                                                                        .exhaustion >
                                                                    functions.roundDoubleToInt(
                                                                        analyticsPageDailyScoresRecord!
                                                                            .exhaustionBaseline14d)
                                                                ? Color(
                                                                    0x8DFFFFFF)
                                                                : Color(
                                                                    0x00FFFFFF),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.arrow_upward,
                                                          color: listViewDailyInputsRecord!
                                                                      .exhaustion >
                                                                  functions.roundDoubleToInt(
                                                                      analyticsPageDailyScoresRecord!
                                                                          .exhaustionBaseline14d)
                                                              ? Color(
                                                                  0x8DFFFFFF)
                                                              : Color(
                                                                  0x00FFFFFF),
                                                          size: 14.0,
                                                        ),
                                                      ),
                                                    ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/icon-chevron-right.png',
                                                          width: 22.0,
                                                          height: 22.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 127.13,
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1A26),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 15.0,
                                    color: Color(0x41000000),
                                    offset: Offset(
                                      0.0,
                                      8.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(
                                  color: Color(0x39FFFFFF),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 134.0,
                                    height: 120.0,
                                    decoration: BoxDecoration(),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          6.0, 0.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 7.0),
                                              child: Text(
                                                'Социум',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelLarge
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          if (analyticsPageDailyScoresRecord
                                                  ?.scoreAvailable ==
                                              true)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 7.0),
                                              child: Text(
                                                analyticsPageDailyScoresRecord
                                                            ?.scoreAvailable ==
                                                        false
                                                    ? 'Нет данных'
                                                    : valueOrDefault<String>(
                                                        analyticsPageDailyScoresRecord
                                                            ?.socialGroupScore
                                                            ?.toString(),
                                                        'n/a',
                                                      ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelLarge
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .fontStyle,
                                                      ),
                                                      color: () {
                                                        if (analyticsPageDailyScoresRecord
                                                                ?.scoreAvailable ==
                                                            false) {
                                                          return Color(
                                                              0x8DFFFFFF);
                                                        } else if (analyticsPageDailyScoresRecord!
                                                                .socialGroupScore >=
                                                            0.7) {
                                                          return Color(
                                                              0xFF5EECD4);
                                                        } else if (analyticsPageDailyScoresRecord!
                                                                .socialGroupScore >=
                                                            0.4) {
                                                          return Color(
                                                              0xFFFFD21F);
                                                        } else {
                                                          return Color(
                                                              0xFFFF5A5A);
                                                        }
                                                      }(),
                                                      fontSize: 17.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          if (analyticsPageDailyScoresRecord
                                                  ?.scoreAvailable ==
                                              true)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(2.0, 0.0, 2.0, 0.0),
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  border: Border.all(
                                                    color: () {
                                                      if (analyticsPageDailyScoresRecord!
                                                              .socialGroupScore >=
                                                          0.7) {
                                                        return Color(
                                                            0xFF5EECD4);
                                                      } else if (analyticsPageDailyScoresRecord!
                                                              .socialGroupScore >=
                                                          0.4) {
                                                        return Color(
                                                            0xFFFFD21F);
                                                      } else {
                                                        return Color(
                                                            0xFFFF5A5A);
                                                      }
                                                    }(),
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(4.0, 4.0,
                                                                4.0, 4.0),
                                                    child: Text(
                                                      () {
                                                        if (analyticsPageDailyScoresRecord!
                                                                .socialGroupScore >=
                                                            0.7) {
                                                          return 'В пределах нормы';
                                                        } else if (analyticsPageDailyScoresRecord!
                                                                .socialGroupScore >=
                                                            0.4) {
                                                          return 'Есть признаки истощения';
                                                        } else {
                                                          return 'Ресурс заметно снижен';
                                                        }
                                                      }(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontStyle,
                                                                ),
                                                                color: () {
                                                                  if (analyticsPageDailyScoresRecord!
                                                                          .socialGroupScore >=
                                                                      0.7) {
                                                                    return Color(
                                                                        0xFF5EECD4);
                                                                  } else if (analyticsPageDailyScoresRecord!
                                                                          .socialGroupScore >=
                                                                      0.4) {
                                                                    return Color(
                                                                        0xFFFFD21F);
                                                                  } else {
                                                                    return Color(
                                                                        0xFFFF5A5A);
                                                                  }
                                                                }(),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80.0,
                                    child: VerticalDivider(
                                      thickness: 1.0,
                                      color: Color(0x39FFFFFF),
                                    ),
                                  ),
                                  Container(
                                    width: 230.0,
                                    height: 55.0,
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                  SocialSupportPageWidget
                                                      .routeName);
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.asset(
                                                    'assets/images/icon-soc.png',
                                                    width: 35.0,
                                                    height: 35.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Связь с людьми',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelLarge
                                                          .override(
                                                            font: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontStyle,
                                                            ),
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                if ((listViewDailyInputsRecord!
                                                            .socialSupport <
                                                        functions.roundDoubleToInt(
                                                            analyticsPageDailyScoresRecord!
                                                                .socialBaseline14d)) &&
                                                    (analyticsPageDailyScoresRecord
                                                            ?.scoreAvailable ==
                                                        true))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child: Container(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: listViewDailyInputsRecord!
                                                                      .socialSupport <
                                                                  functions.roundDoubleToInt(
                                                                      analyticsPageDailyScoresRecord!
                                                                          .socialBaseline14d)
                                                              ? Color(
                                                                  0x8DFFFFFF)
                                                              : Color(
                                                                  0x00FFFFFF),
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.arrow_downward,
                                                        color: listViewDailyInputsRecord!
                                                                    .socialSupport <
                                                                functions.roundDoubleToInt(
                                                                    analyticsPageDailyScoresRecord!
                                                                        .socialBaseline14d)
                                                            ? Color(0x8DFFFFFF)
                                                            : Color(0x00FFFFFF),
                                                        size: 14.0,
                                                      ),
                                                    ),
                                                  ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                5.0, 0.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/images/icon-chevron-right.png',
                                                        width: 22.0,
                                                        height: 22.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
