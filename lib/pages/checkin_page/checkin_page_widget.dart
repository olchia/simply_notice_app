import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'checkin_page_model.dart';
export 'checkin_page_model.dart';

class CheckinPageWidget extends StatefulWidget {
  const CheckinPageWidget({super.key});

  static String routeName = 'CheckinPage';
  static String routePath = '/checkinPage';

  @override
  State<CheckinPageWidget> createState() => _CheckinPageWidgetState();
}

class _CheckinPageWidgetState extends State<CheckinPageWidget> {
  late CheckinPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckinPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<int?> _readTodayStepsFromAppleHealthForCheckin() async {
    try {
      if (currentUserUid.isEmpty) {
        return null;
      }

      final userInfoRecords = await queryUserInfoRecordOnce(
        queryBuilder: (userInfoRecord) => userInfoRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
        limit: 1,
      );

      if (userInfoRecords.isEmpty ||
          !userInfoRecords.first.appleHealthConnected) {
        return null;
      }

      final health = Health();

      final types = <HealthDataType>[
        HealthDataType.STEPS,
      ];

      final permissions = <HealthDataAccess>[
        HealthDataAccess.READ,
      ];

      final granted = await health.requestAuthorization(
        types,
        permissions: permissions,
      );

      if (!granted) {
        return null;
      }

      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);

      final steps = await health.getTotalStepsInInterval(
        startOfDay,
        now,
      );

      return steps ?? 0;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, int>?> _readLastNightSleepFromAppleHealthForCheckin() async {
    try {
      if (currentUserUid.isEmpty) {
        return null;
      }

      final userInfoRecords = await queryUserInfoRecordOnce(
        queryBuilder: (userInfoRecord) => userInfoRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
        limit: 1,
      );

      if (userInfoRecords.isEmpty ||
          !userInfoRecords.first.appleHealthConnected) {
        return null;
      }

      final health = Health();

      final types = <HealthDataType>[
        HealthDataType.SLEEP_ASLEEP,
        HealthDataType.SLEEP_LIGHT,
        HealthDataType.SLEEP_DEEP,
        HealthDataType.SLEEP_REM,
      ];

      final permissions = <HealthDataAccess>[
        HealthDataAccess.READ,
        HealthDataAccess.READ,
        HealthDataAccess.READ,
        HealthDataAccess.READ,
      ];

      final granted = await health.requestAuthorization(
        types,
        permissions: permissions,
      );

      if (!granted) {
        return null;
      }

      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);

      // Сон за ночь, которая закончилась сегодня утром:
      // вчера 18:00 → сегодня 12:00.
      final sleepStart = todayStart.subtract(const Duration(hours: 6));
      final sleepEnd = todayStart.add(const Duration(hours: 12));

      final sleepData = await health.getHealthDataFromTypes(
        types: types,
        startTime: sleepStart,
        endTime: sleepEnd,
      );

      double totalSleepMinutesRaw = 0;

      for (final point in sleepData) {
        final value = point.value;
        if (value is NumericHealthValue) {
          totalSleepMinutesRaw += value.numericValue;
        }
      }

      final totalMinutes = totalSleepMinutesRaw.round();

      return {
        'totalMinutes': totalMinutes,
        'hours': totalMinutes ~/ 60,
        'minutes': totalMinutes % 60,
      };
    } catch (_) {
      return null;
    }
  }

  Future<void> _updateTodayMarkerDailyValuesFromCheckin({
    required int stress,
    required int energy,
    required int exhaustion,
    required int socialSupport,
    int? appleHealthSteps,
    Map<String, int>? appleHealthSleep,
  }) async {
    try {
      if (currentUserUid.isEmpty) {
        return;
      }

      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final tomorrowStart = todayStart.add(const Duration(days: 1));

      final markerDocs = await MarkerDailyValuesRecord.collection
          .where('uid', isEqualTo: currentUserUid)
          .where('date', isGreaterThanOrEqualTo: todayStart)
          .where('date', isLessThan: tomorrowStart)
          .get();

      for (final doc in markerDocs.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final markerType = (data['marker_type'] as String? ?? '').trim();

        double? value;
        String? valueDisplay;
        int? valueHours;
        int? valueMinutes;

        switch (markerType) {
          case 'stress':
            value = stress.toDouble();
            valueDisplay = stress.toString();
            break;
          case 'energy':
            value = energy.toDouble();
            valueDisplay = energy.toString();
            break;
          case 'exhaustion':
            value = exhaustion.toDouble();
            valueDisplay = exhaustion.toString();
            break;
          case 'social_support':
            value = socialSupport.toDouble();
            valueDisplay = socialSupport.toString();
            break;
          case 'steps':
            if (appleHealthSteps != null) {
              value = appleHealthSteps.toDouble();
              valueDisplay = appleHealthSteps.toString();
            }
            break;
          case 'sleep':
            if (appleHealthSleep != null) {
              final totalMinutes = appleHealthSleep['totalMinutes'] ?? 0;
              final hours = appleHealthSleep['hours'] ?? 0;
              final minutes = appleHealthSleep['minutes'] ?? 0;

              value = totalMinutes.toDouble();
              valueHours = hours;
              valueMinutes = minutes;
              valueDisplay = '${hours} ч ${minutes} мин';
            }
            break;
        }

        if (value == null) {
          continue;
        }

        final updateData = <String, dynamic>{
          'value': value,
          'value_display': valueDisplay,
          'has_data': true,
          'calculated_at': now,
        };

        if (valueHours != null) {
          updateData['value_hours'] = valueHours;
        }

        if (valueMinutes != null) {
          updateData['value_minutes'] = valueMinutes;
        }

        await doc.reference.update(updateData);
      }
    } catch (_) {
      // Для MVP молча пропускаем, чтобы check-in не ломался из-за графиков.
      return;
    }
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
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 56.0, 16.0, 0.0),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                  child: Text(
                    'Как вы сейчас?',
                    style: FlutterFlowTheme.of(context).labelLarge.override(
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
                          fontStyle:
                              FlutterFlowTheme.of(context).labelLarge.fontStyle,
                        ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: () {
                          if (_model.stressFilled == false) {
                            return Color(0x1AFFFFFF);
                          } else if (_model.stressValue == 1.0) {
                            return Color(0xFF1A3A5C);
                          } else if (_model.stressValue == 2.0) {
                            return Color(0xFF1E5A8A);
                          } else if (_model.stressValue == 3.0) {
                            return Color(0xFF2B82C9);
                          } else if (_model.stressValue == 4.0) {
                            return Color(0xFF2FACF0);
                          } else {
                            return Color(0xFF38BDF8);
                          }
                        }(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    Container(
                      width: 80.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: () {
                          if (_model.energyFilled == false) {
                            return Color(0x1AFFFFFF);
                          } else if (_model.energyValue == 1.0) {
                            return Color(0xFF1A3A3A);
                          } else if (_model.energyValue == 2.0) {
                            return Color(0xFF1A6E6A);
                          } else if (_model.energyValue == 3.0) {
                            return Color(0xFF20A09A);
                          } else if (_model.energyValue == 4.0) {
                            return Color(0xFF3ACEC4);
                          } else {
                            return Color(0xFF5EECD4);
                          }
                        }(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    Container(
                      width: 80.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: () {
                          if (_model.exhaustionFilled == false) {
                            return Color(0x19FFFFFF);
                          } else if (_model.exhaustionValue == 1.0) {
                            return Color(0xFF1A1A3A);
                          } else if (_model.exhaustionValue == 2.0) {
                            return Color(0xFF4A3A7A);
                          } else if (_model.exhaustionValue == 3.0) {
                            return Color(0xFF6050A8);
                          } else if (_model.exhaustionValue == 4.0) {
                            return Color(0xFF7068D8);
                          } else {
                            return Color(0xFF818CF8);
                          }
                        }(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    Container(
                      width: 80.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: () {
                          if (_model.socialSupportFilled == false) {
                            return Color(0x19FFFFFF);
                          } else if (_model.socialSupportValue == 1.0) {
                            return Color(0xFF1A1A3A);
                          } else if (_model.socialSupportValue == 2.0) {
                            return Color(0xFF5A3A7A);
                          } else if (_model.socialSupportValue == 3.0) {
                            return Color(0xFF7A50A8);
                          } else if (_model.socialSupportValue == 4.0) {
                            return Color(0xFF9068D8);
                          } else {
                            return Color(0xFFA78BFA);
                          }
                        }(),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ].divide(SizedBox(width: 13.0)),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Стресс',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Color(0xB2FFFFFF),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (_model.stressFilled == true)
                                Align(
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  child: Text(
                                    _model.stressValue.toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                          color: Color(0xB3FFFFFF),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              if (_model.stressFilled == true)
                                Text(
                                  ' / 5',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        color: Color(0xB2FFFFFF),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        child: custom_widgets.CheckinSlider(
                          width: double.infinity,
                          height: 40.0,
                          value: _model.stressValue,
                          isFilled: _model.stressFilled,
                          trackStartColor: Color(0xFF0D1A26),
                          trackMidColor: Color(0xFF1E5A8A),
                          trackEndColor: Color(0xFF38BDF8),
                          thumbColor1: Color(0xFF1A3A5C),
                          thumbColor2: Color(0xFF1E5A8A),
                          thumbColor3: Color(0xFF2B82C9),
                          thumbColor4: Color(0xFF2FACF0),
                          thumbColor5: Color(0xFF38BDF8),
                          onChanged: (newValue) async {
                            if (_model.stressFilled == false) {
                              _model.answeredCount = _model.answeredCount + 1;
                              safeSetState(() {});
                            }
                            _model.stressValue = newValue;
                            _model.stressFilled = true;
                            safeSetState(() {});
                          },
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Спокойно',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: Color(0x8DFFFFFF),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            'Высокий',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: Color(0x8DFFFFFF),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Энергия',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Color(0xB2FFFFFF),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (_model.energyFilled == true)
                                Text(
                                  _model.energyValue.toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        color: Color(0xB2FFFFFF),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                ),
                              if (_model.energyFilled == true)
                                Text(
                                  ' / 5',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        color: Color(0xB2FFFFFF),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        child: custom_widgets.CheckinSlider(
                          width: double.infinity,
                          height: 40.0,
                          value: _model.energyValue,
                          isFilled: _model.energyFilled,
                          trackStartColor: Color(0xFF0D1A26),
                          trackMidColor: Color(0xFF1A6E6A),
                          trackEndColor: Color(0xFF5EECD4),
                          thumbColor1: Color(0xFF1A3A3A),
                          thumbColor2: Color(0xFF1A6E6A),
                          thumbColor3: Color(0xFF20A09A),
                          thumbColor4: Color(0xFF3ACEC4),
                          thumbColor5: Color(0xFF5EECD4),
                          onChanged: (newValue) async {
                            if (_model.energyFilled == false) {
                              _model.answeredCount = _model.answeredCount + 1;
                              safeSetState(() {});
                            }
                            _model.energyValue = newValue;
                            _model.energyFilled = true;
                            safeSetState(() {});
                          },
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Нет сил',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: Color(0x8DFFFFFF),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            'Много энергии',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: Color(0x8DFFFFFF),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Истощение',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Color(0xB2FFFFFF),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (_model.exhaustionFilled == true)
                                Text(
                                  _model.exhaustionValue.toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        color: Color(0xB2FFFFFF),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                ),
                              if (_model.exhaustionFilled == true)
                                Text(
                                  ' / 5',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        color: Color(0xB2FFFFFF),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        child: custom_widgets.CheckinSlider(
                          width: double.infinity,
                          height: 40.0,
                          value: _model.exhaustionValue,
                          isFilled: _model.exhaustionFilled,
                          trackStartColor: Color(0xFF0D1A26),
                          trackMidColor: Color(0xFF4A3A7A),
                          trackEndColor: Color(0xFF818CF8),
                          thumbColor1: Color(0xFF1A1A3A),
                          thumbColor2: Color(0xFF4A3A7A),
                          thumbColor3: Color(0xFF6050A8),
                          thumbColor4: Color(0xFF7068D8),
                          thumbColor5: Color(0xFF818CF8),
                          onChanged: (newValue) async {
                            if (_model.exhaustionFilled == false) {
                              _model.answeredCount = _model.answeredCount + 1;
                              safeSetState(() {});
                            }
                            _model.exhaustionValue = newValue;
                            _model.exhaustionFilled = true;
                            safeSetState(() {});
                          },
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Нет',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: Color(0x8DFFFFFF),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            'Сильное',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: Color(0x8DFFFFFF),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Связь с людьми',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Color(0xB2FFFFFF),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (_model.socialSupportFilled == true)
                                Text(
                                  _model.socialSupportValue.toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        color: Color(0xB2FFFFFF),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                ),
                              if (_model.socialSupportFilled == true)
                                Text(
                                  ' / 5',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        color: Color(0xB2FFFFFF),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        child: custom_widgets.CheckinSlider(
                          width: double.infinity,
                          height: 40.0,
                          value: _model.socialSupportValue,
                          isFilled: _model.socialSupportFilled,
                          trackStartColor: Color(0xFF0D1A26),
                          trackMidColor: Color(0xFF5A3A7A),
                          trackEndColor: Color(0xFFA78BFA),
                          thumbColor1: Color(0xFF1A1A3A),
                          thumbColor2: Color(0xFF5A3A7A),
                          thumbColor3: Color(0xFF7A50A8),
                          thumbColor4: Color(0xFF9068D8),
                          thumbColor5: Color(0xFFA78BFA),
                          onChanged: (newValue) async {
                            if (_model.socialSupportFilled == false) {
                              _model.answeredCount = _model.answeredCount + 1;
                              safeSetState(() {});
                            }
                            _model.socialSupportValue = newValue;
                            _model.socialSupportFilled = true;
                            safeSetState(() {});
                          },
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Изоляция',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: Color(0x8DFFFFFF),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            'Крепкая',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: Color(0x8DFFFFFF),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(38.0, 42.0, 38.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: (_model.answeredCount < 4)
                        ? null
                        : () async {
                            final appleHealthSteps =
                                await _readTodayStepsFromAppleHealthForCheckin();

                            final appleHealthSleep =
                                await _readLastNightSleepFromAppleHealthForCheckin();

                            final nowForCheckin = DateTime.now();
                            final todayStartForCheckin = DateTime(
                              nowForCheckin.year,
                              nowForCheckin.month,
                              nowForCheckin.day,
                            );
                            final tomorrowStartForCheckin =
                                todayStartForCheckin.add(
                              const Duration(days: 1),
                            );

                            _model.todayInput =
                                await queryDailyInputsRecordOnce(
                              queryBuilder: (dailyInputsRecord) =>
                                  dailyInputsRecord
                                      .where(
                                        'uid',
                                        isEqualTo: currentUserUid,
                                      )
                                      .where(
                                        'date',
                                        isGreaterThanOrEqualTo:
                                            todayStartForCheckin,
                                      )
                                      .where(
                                        'date',
                                        isLessThan: tomorrowStartForCheckin,
                                      ),
                            );

                            DocumentReference? todayInputRef;

                            if (_model.todayInput != null &&
                                (_model.todayInput)!.isNotEmpty) {
                              DailyInputsRecord selectedInput =
                                  (_model.todayInput)!.first;

                              for (final input in _model.todayInput!) {
                                if (input.hasStress() ||
                                    input.hasEnergy() ||
                                    input.hasExhaustion() ||
                                    input.hasSocialSupport()) {
                                  selectedInput = input;
                                  break;
                                }
                              }

                              todayInputRef = selectedInput.reference;

                              await todayInputRef.update(
                                createDailyInputsRecordData(
                                  stress: functions.roundDoubleToInt(
                                      _model.stressValue),
                                  energy: functions.roundDoubleToInt(
                                      _model.energyValue),
                                  exhaustion: functions.roundDoubleToInt(
                                      _model.exhaustionValue),
                                  socialSupport: functions.roundDoubleToInt(
                                      _model.socialSupportValue),
                                  steps: appleHealthSteps,
                                  sleepHours: appleHealthSleep?['hours'],
                                  sleepMinutes: appleHealthSleep?['minutes'],
                                  sleepDurationTotalMinutes:
                                      appleHealthSleep?['totalMinutes'],
                                  updatedAt: getCurrentTimestamp,
                                ),
                              );
                            } else {
                              todayInputRef =
                                  DailyInputsRecord.collection.doc();

                              await todayInputRef.set(
                                createDailyInputsRecordData(
                                  uid: currentUserUid,
                                  date: todayStartForCheckin,
                                  sleepHours:
                                      appleHealthSleep?['hours'] ?? 0,
                                  sleepMinutes:
                                      appleHealthSleep?['minutes'] ?? 0,
                                  sleepDurationTotalMinutes:
                                      appleHealthSleep?['totalMinutes'] ?? 0,
                                  steps: appleHealthSteps ?? 0,
                                  stress: functions.roundDoubleToInt(
                                      _model.stressValue),
                                  energy: functions.roundDoubleToInt(
                                      _model.energyValue),
                                  exhaustion: functions.roundDoubleToInt(
                                      _model.exhaustionValue),
                                  socialSupport: functions.roundDoubleToInt(
                                      _model.socialSupportValue),
                                  createdAt: getCurrentTimestamp,
                                  updatedAt: getCurrentTimestamp,
                                ),
                              );
                            }

                            if (todayInputRef != null &&
                                (appleHealthSteps != null ||
                                    appleHealthSleep != null)) {
                              final sourceUpdate = <String, dynamic>{};

                              if (appleHealthSteps != null) {
                                sourceUpdate['steps_source'] =
                                    'apple_health';
                              }

                              if (appleHealthSleep != null) {
                                sourceUpdate['sleep_source'] =
                                    'apple_health';
                              }

                              if (sourceUpdate.isNotEmpty) {
                                await todayInputRef.update(sourceUpdate);
                              }
                            }

                            await Future.delayed(
                              const Duration(seconds: 2),
                            );

                            await _updateTodayMarkerDailyValuesFromCheckin(
                              stress: functions.roundDoubleToInt(
                                  _model.stressValue),
                              energy: functions.roundDoubleToInt(
                                  _model.energyValue),
                              exhaustion: functions.roundDoubleToInt(
                                  _model.exhaustionValue),
                              socialSupport: functions.roundDoubleToInt(
                                  _model.socialSupportValue),
                              appleHealthSteps: appleHealthSteps,
                              appleHealthSleep: appleHealthSleep,
                            );

                            await queryDailyInputsRecordOnce(
                              queryBuilder: (dailyInputsRecord) =>
                                  dailyInputsRecord
                                      .where(
                                        'uid',
                                        isEqualTo: currentUserUid,
                                      )
                                      .where(
                                        'date',
                                        isEqualTo: functions
                                            .getStartOfDay(getCurrentTimestamp),
                                      ),
                              limit: 1,
                            );
                            if (_model.todayInput != null &&
                                (_model.todayInput)!.isNotEmpty) {
                              await _model.todayInput!
                                  .elementAtOrNull(0)!
                                  .reference
                                  .update(createDailyInputsRecordData(
                                    stress: functions
                                        .roundDoubleToInt(_model.stressValue),
                                    energy: functions
                                        .roundDoubleToInt(_model.energyValue),
                                    exhaustion: functions.roundDoubleToInt(
                                        _model.exhaustionValue),
                                    socialSupport: functions.roundDoubleToInt(
                                        _model.socialSupportValue),
                                    steps: appleHealthSteps,
                                    sleepHours: appleHealthSleep?['hours'],
                                    sleepMinutes: appleHealthSleep?['minutes'],
                                    sleepDurationTotalMinutes:
                                        appleHealthSleep?['totalMinutes'],
                                    updatedAt: getCurrentTimestamp,
                                  ));
                            } else {
                              await DailyInputsRecord.collection
                                  .doc()
                                  .set(createDailyInputsRecordData(
                                    uid: currentUserUid,
                                    date: functions
                                        .getStartOfDay(getCurrentTimestamp),
                                    sleepHours: appleHealthSleep?['hours'] ?? 0,
                                    sleepMinutes: appleHealthSleep?['minutes'] ?? 0,
                                    sleepDurationTotalMinutes:
                                        appleHealthSleep?['totalMinutes'] ?? 0,
                                    steps: appleHealthSteps ?? 0,
                                    stress: functions
                                        .roundDoubleToInt(_model.stressValue),
                                    energy: functions
                                        .roundDoubleToInt(_model.energyValue),
                                    exhaustion: functions.roundDoubleToInt(
                                        _model.exhaustionValue),
                                    socialSupport: functions.roundDoubleToInt(
                                        _model.socialSupportValue),
                                    createdAt: getCurrentTimestamp,
                                    updatedAt: getCurrentTimestamp,
                                  ));
                            }

                            if (appleHealthSteps != null ||
                                appleHealthSleep != null) {
                              final savedTodayInput =
                                  await queryDailyInputsRecordOnce(
                                queryBuilder: (dailyInputsRecord) =>
                                    dailyInputsRecord
                                        .where(
                                          'uid',
                                          isEqualTo: currentUserUid,
                                        )
                                        .where(
                                          'date',
                                          isEqualTo: functions.getStartOfDay(
                                              getCurrentTimestamp),
                                        ),
                                limit: 1,
                              );

                              if (savedTodayInput.isNotEmpty) {
                                final sourceUpdate = <String, dynamic>{};

                                if (appleHealthSteps != null) {
                                  sourceUpdate['steps_source'] =
                                      'apple_health';
                                }

                                if (appleHealthSleep != null) {
                                  sourceUpdate['sleep_source'] =
                                      'apple_health';
                                }

                                await savedTodayInput.first.reference
                                    .update(sourceUpdate);
                              }
                            }

                            await queryDailyInputsRecordOnce(
                              queryBuilder: (dailyInputsRecord) =>
                                  dailyInputsRecord
                                      .where(
                                        'uid',
                                        isEqualTo: currentUserUid,
                                      )
                                      .where(
                                        'date',
                                        isEqualTo: functions
                                            .getStartOfDay(getCurrentTimestamp),
                                      ),
                              limit: 1,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Данные по самонаблюдению отправлены',
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
                                        color: Color(0xFF0B0F1A),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: Color(0xA990FAAF),
                              ),
                            );

                            context.pushNamed(MainPageWidget.routeName);

                            safeSetState(() {});
                          },
                    text: () {
                      if (_model.answeredCount == 4) {
                        return 'Готово →';
                      } else if (_model.answeredCount == 3) {
                        return 'Остался 1';
                      } else if (_model.answeredCount == 2) {
                        return 'Осталось 2';
                      } else if (_model.answeredCount == 1) {
                        return 'Осталось 3';
                      } else {
                        return 'Осталось 4';
                      }
                    }(),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 44.0,
                      padding: EdgeInsets.all(0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: _model.answeredCount == 4
                          ? Color(0xFF5EECD4)
                          : Color(0x12FFFFFF),
                      textStyle:
                          FlutterFlowTheme.of(context).labelLarge.override(
                                font: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                                color: _model.answeredCount == 4
                                    ? Color(0xFF0D1520)
                                    : Color(0x40FFFFFF),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    showLoadingIndicator: false,
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
