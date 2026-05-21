import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/apple_health_disconnect_sheet/apple_health_disconnect_sheet_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_page_model.dart';
export 'profile_page_model.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  static String routeName = 'ProfilePage';
  static String routePath = '/profilePage';

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late ProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> _requestAppleHealthAccessFromProfile(
    DocumentReference userInfoRef,
  ) async {
    final health = Health();

    final types = <HealthDataType>[
      HealthDataType.STEPS,
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
      HealthDataAccess.READ,
    ];

    try {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Началась синхронизация Apple Health...'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      final granted = await health.requestAuthorization(
        types,
        permissions: permissions,
      );

      if (!mounted) {
        return;
      }

      if (granted) {
        await userInfoRef.update(createUserInfoRecordData(
          appleHealthConnected: true,
        ));

        if (!mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Apple Health подключён'),
          ),
        );

        safeSetState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Доступ к Apple Health не предоставлен'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Не удалось подключить Apple Health: $e'),
        ),
      );
    }
  }


  Future<int> _readLastNightSleepMinutes(Health health) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final sleepStart = todayStart.subtract(const Duration(hours: 6));
    final sleepEnd = todayStart.add(const Duration(hours: 12));

    final sleepTypes = <HealthDataType>[
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_LIGHT,
      HealthDataType.SLEEP_DEEP,
      HealthDataType.SLEEP_REM,
    ];

    final sleepData = await health.getHealthDataFromTypes(
      types: sleepTypes,
      startTime: sleepStart,
      endTime: sleepEnd,
    );

    double totalMinutes = 0;

    for (final point in sleepData) {
      final value = point.value;
      if (value is NumericHealthValue) {
        totalMinutes += value.numericValue;
      }
    }

    return totalMinutes.round();
  }

  Future<DateTime> _getCurrentUserCreatedStartDate(
    DateTime fallbackStartDate,
  ) async {
    try {
      final userInfoSnapshot = await UserInfoRecord.collection
          .where('uid', isEqualTo: currentUserUid)
          .limit(1)
          .get();

      if (userInfoSnapshot.docs.isEmpty) {
        return fallbackStartDate;
      }

      final userInfo =
          UserInfoRecord.fromSnapshot(userInfoSnapshot.docs.first);
      final createdTime = userInfo.createdTime;

      if (createdTime == null) {
        return fallbackStartDate;
      }

      return DateTime(
        createdTime.year,
        createdTime.month,
        createdTime.day,
      );
    } catch (_) {
      return fallbackStartDate;
    }
  }

  Future<void> _showTodayStepsFromAppleHealth() async {
    final health = Health();

    final types = <HealthDataType>[
      HealthDataType.STEPS,
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
      HealthDataAccess.READ,
    ];

    try {
      final granted = await health.requestAuthorization(
        types,
        permissions: permissions,
      );

      if (!mounted) {
        return;
      }

      if (!granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Доступ к данным Apple Health не предоставлен'),
          ),
        );
        return;
      }

      if (currentUserUid.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Не удалось определить пользователя'),
          ),
        );
        return;
      }

      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final tomorrowStart = todayStart.add(const Duration(days: 1));

      final userInfoSnapshot = await UserInfoRecord.collection
          .where('uid', isEqualTo: currentUserUid)
          .limit(1)
          .get();

      DocumentReference? userInfoRef;
      DateTime? userCreatedStartDate;
      DateTime? lastSyncedAt;

      if (userInfoSnapshot.docs.isNotEmpty) {
        userInfoRef = userInfoSnapshot.docs.first.reference;
        final userInfo =
            UserInfoRecord.fromSnapshot(userInfoSnapshot.docs.first);
        final createdTime = userInfo.createdTime;

        if (createdTime != null) {
          userCreatedStartDate = DateTime(
            createdTime.year,
            createdTime.month,
            createdTime.day,
          );
        }

        final rawUserData =
            userInfoSnapshot.docs.first.data() as Map<String, dynamic>;
        final rawLastSyncedAt =
            rawUserData['apple_health_last_synced_at'];

        if (rawLastSyncedAt is DateTime) {
          lastSyncedAt = rawLastSyncedAt;
        } else if (rawLastSyncedAt is Timestamp) {
          lastSyncedAt = rawLastSyncedAt.toDate();
        }
      }

      final fallbackStartDate =
          todayStart.subtract(const Duration(days: 7));

      final syncStartDate = lastSyncedAt != null
          ? DateTime(
              lastSyncedAt!.year,
              lastSyncedAt!.month,
              lastSyncedAt!.day,
            ).subtract(const Duration(days: 1))
          : (userCreatedStartDate ?? fallbackStartDate);

      final existingInputsSnapshot = await DailyInputsRecord.collection
          .where('uid', isEqualTo: currentUserUid)
          .where('date', isGreaterThanOrEqualTo: syncStartDate)
          .where('date', isLessThan: tomorrowStart)
          .get();

      final sleepTypes = <HealthDataType>[
        HealthDataType.SLEEP_ASLEEP,
        HealthDataType.SLEEP_LIGHT,
        HealthDataType.SLEEP_DEEP,
        HealthDataType.SLEEP_REM,
      ];

      final updatedDateKeys = <String>{};
      int skippedDocs = 0;
      int totalSteps = 0;
      int sleepUpdatedDays = 0;

      for (final inputDoc in existingInputsSnapshot.docs) {
        final inputRecord = DailyInputsRecord.fromSnapshot(inputDoc);
        final inputDate = inputRecord.date;

        if (inputDate == null) {
          skippedDocs += 1;
          continue;
        }

        final dayStart = DateTime(
          inputDate.year,
          inputDate.month,
          inputDate.day,
        );
        final dayEnd = dayStart.add(const Duration(days: 1));

        final stepsEnd = dayStart == todayStart ? now : dayEnd;

        final steps = await health.getTotalStepsInInterval(
          dayStart,
          stepsEnd,
        );

        final stepsValue = steps ?? 0;

        final sleepStart = dayStart.subtract(const Duration(hours: 6));
        final sleepEnd = dayStart.add(const Duration(hours: 12));

        final sleepData = await health.getHealthDataFromTypes(
          types: sleepTypes,
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

        final sleepTotalMinutes = totalSleepMinutesRaw.round();
        final sleepHours = sleepTotalMinutes ~/ 60;
        final sleepMinutes = sleepTotalMinutes % 60;

        final updateData = <String, dynamic>{
          ...createDailyInputsRecordData(
            steps: stepsValue,
            updatedAt: now,
          ),
          'steps_source': 'apple_health',
        };

        // Сон обновляем только если Apple Health реально вернул сон.
        // Так мы не затираем существующие данные нулями.
        if (sleepTotalMinutes > 0) {
          updateData.addAll({
            ...createDailyInputsRecordData(
              sleepHours: sleepHours,
              sleepMinutes: sleepMinutes,
              sleepDurationTotalMinutes: sleepTotalMinutes,
              updatedAt: now,
            ),
            'sleep_source': 'apple_health',
          });

          sleepUpdatedDays += 1;
        }

        await inputDoc.reference.update(updateData);

        updatedDateKeys.add(_dateKeyForMarkerBackfill(dayStart));
        totalSteps += stepsValue;
      }

      await _backfillMarkerDailyValuesFromDailyInputs(
        syncStartDate: syncStartDate,
        syncUntilDate: tomorrowStart,
      );

      if (userInfoRef != null) {
        await userInfoRef.update({
          'apple_health_last_synced_at': now,
        });
      }

      if (!mounted) {
        return;
      }

      await showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Apple Health'),
            content: Text(
              'Синхронизация Apple Health выполнена.\n\nПериод: с ${syncStartDate.day.toString().padLeft(2, '0')}.${syncStartDate.month.toString().padLeft(2, '0')}.${syncStartDate.year} по сегодня\nОбновлено дней с check-in: ${updatedDateKeys.length}\nДокументов без даты пропущено: $skippedDocs\nСон обновлён за дней: $sleepUpdatedDays\nСуммарно шагов: $totalSteps',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('Ок'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Не удалось синхронизировать Apple Health: $e'),
        ),
      );
    }
  }

  String _dateKeyForMarkerBackfill(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    final year = normalized.year.toString().padLeft(4, '0');
    final month = normalized.month.toString().padLeft(2, '0');
    final day = normalized.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  Future<String> _backfillMarkerDailyValuesFromDailyInputs({
    required DateTime syncStartDate,
    required DateTime syncUntilDate,
  }) async {
    int inputsFound = 0;
    int markersFound = 0;
    int markersUpdated = 0;

    try {
      if (currentUserUid.isEmpty) {
        return 'Backfill: пользователь не определён';
      }

      final now = DateTime.now();
      final fromDate = DateTime(
        syncStartDate.year,
        syncStartDate.month,
        syncStartDate.day,
      );
      final untilDate = DateTime(
        syncUntilDate.year,
        syncUntilDate.month,
        syncUntilDate.day,
      );

      final dailyInputsSnapshot = await DailyInputsRecord.collection
          .where('uid', isEqualTo: currentUserUid)
          .where('date', isGreaterThanOrEqualTo: fromDate)
          .where('date', isLessThan: untilDate)
          .get();

      inputsFound = dailyInputsSnapshot.docs.length;

      final inputsByDateKey = <String, DailyInputsRecord>{};

      for (final inputDoc in dailyInputsSnapshot.docs) {
        final inputRecord = DailyInputsRecord.fromSnapshot(inputDoc);
        final inputDate = inputRecord.date;

        if (inputDate == null) {
          continue;
        }

        inputsByDateKey[_dateKeyForMarkerBackfill(inputDate)] = inputRecord;
      }

      final markerSnapshot = await MarkerDailyValuesRecord.collection
          .where('uid', isEqualTo: currentUserUid)
          .where('date', isGreaterThanOrEqualTo: fromDate)
          .where('date', isLessThan: untilDate)
          .get();

      markersFound = markerSnapshot.docs.length;

      for (final markerDoc in markerSnapshot.docs) {
        final markerRecord = MarkerDailyValuesRecord.fromSnapshot(markerDoc);
        final markerDate = markerRecord.date;

        if (markerDate == null) {
          continue;
        }

        final inputRecord =
            inputsByDateKey[_dateKeyForMarkerBackfill(markerDate)];

        if (inputRecord == null) {
          continue;
        }

        final markerType = markerRecord.markerType.trim();

        double? value;
        String? valueDisplay;
        int? valueHours;
        int? valueMinutes;

        switch (markerType) {
          case 'stress':
            if (inputRecord.hasStress() && inputRecord.stress > 0) {
              value = inputRecord.stress.toDouble();
              valueDisplay = inputRecord.stress.toString();
            }
            break;

          case 'energy':
            if (inputRecord.hasEnergy() && inputRecord.energy > 0) {
              value = inputRecord.energy.toDouble();
              valueDisplay = inputRecord.energy.toString();
            }
            break;

          case 'exhaustion':
            if (inputRecord.hasExhaustion() && inputRecord.exhaustion > 0) {
              value = inputRecord.exhaustion.toDouble();
              valueDisplay = inputRecord.exhaustion.toString();
            }
            break;

          case 'social_support':
            if (inputRecord.hasSocialSupport() &&
                inputRecord.socialSupport > 0) {
              value = inputRecord.socialSupport.toDouble();
              valueDisplay = inputRecord.socialSupport.toString();
            }
            break;

          case 'steps':
            if (inputRecord.hasSteps()) {
              value = inputRecord.steps.toDouble();
              valueDisplay = inputRecord.steps.toString();
            }
            break;

          case 'sleep':
            if (inputRecord.hasSleepDurationTotalMinutes() &&
                inputRecord.sleepDurationTotalMinutes > 0) {
              value = inputRecord.sleepDurationTotalMinutes.toDouble();
              valueHours = inputRecord.sleepHours;
              valueMinutes = inputRecord.sleepMinutes;
              valueDisplay =
                  '${inputRecord.sleepHours} ч ${inputRecord.sleepMinutes} мин';
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

        await markerDoc.reference.update(updateData);
        markersUpdated += 1;
      }

      return 'Backfill marker_daily_values:\ninputs: $inputsFound\nmarkers: $markersFound\nupdated: $markersUpdated';
    } catch (e) {
      return 'Backfill error: $e\ninputs: $inputsFound\nmarkers: $markersFound\nupdated: $markersUpdated';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserInfoRecord>>(
      stream: queryUserInfoRecord(
        queryBuilder: (userInfoRecord) => userInfoRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
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
        List<UserInfoRecord> profilePageUserInfoRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final profilePageUserInfoRecord =
            profilePageUserInfoRecordList.isNotEmpty
                ? profilePageUserInfoRecordList.first
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
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 44.0),
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: SvgPicture.asset(
                              'assets/images/avatar-default.svg',
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: Text(
                        'ПРОФИЛЬ',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontStyle,
                              ),
                              color: Color(0xB2FFFFFF),
                              fontSize: 15.0,
                              letterSpacing: 1.2,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontStyle,
                            ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Divider(
                          thickness: 1.0,
                          color: Color(0x25FFFFFF),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Имя',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Color(0x59FFFFFF),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              profilePageUserInfoRecord?.name,
                              'Пользователь',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Divider(
                          thickness: 1.0,
                          color: Color(0x0DFFFFFF),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Color(0x59FFFFFF),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                          Text(
                            currentUserEmail,
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Divider(
                          thickness: 1.0,
                          color: Color(0x26FFFFFF),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 27.0),
                      child: Text(
                        'ДАННЫЕ И СИНХРОНИЗАЦИЯ',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontStyle,
                              ),
                              color: Color(0xB2FFFFFF),
                              fontSize: 15.0,
                              letterSpacing: 1.2,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontStyle,
                            ),
                      ),
                    ),
                    if (profilePageUserInfoRecord?.appleHealthConnected ?? true)
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await _showTodayStepsFromAppleHealth();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Apple Здоровье',
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                          color: Colors.white,
                                          fontSize: 18.0,
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 6.0, 0.0, 0.0),
                                    child: Text(
                                      'Сон, шаги',
                                      style: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontStyle,
                                            ),
                                            color: Color(0x59FFFFFF),
                                            fontSize: 16.0,
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
                                ],
                              ),
                              Stack(
                                children: [
                                  if (valueOrDefault<bool>(
                                    profilePageUserInfoRecord
                                        ?.appleHealthConnected,
                                    true,
                                  ))
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 6.0, 0.0, 6.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      AppleHealthDisconnectSheetWidget(
                                                    userInfoRef:
                                                        profilePageUserInfoRecord
                                                            ?.reference,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then(
                                            (value) => safeSetState(() {}),
                                          );
                                        },
                                        child: Container(
                                        width: 140.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          color: Color(0x245EECD4),
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                        ),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Text(
                                            'Подключено',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  font: GoogleFonts.roboto(
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
                                                  color: Color(0xFF5EECD4),
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
                                        ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (!profilePageUserInfoRecord!.appleHealthConnected)
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Apple Здоровье',
                                  style: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .fontStyle,
                                        ),
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 6.0, 0.0, 0.0),
                                  child: Text(
                                    'Сон, шаги',
                                    style: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .fontStyle,
                                          ),
                                          color: Color(0x59FFFFFF),
                                          fontSize: 16.0,
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
                              ],
                            ),
                            Stack(
                              children: [
                                if (!valueOrDefault<bool>(
                                  profilePageUserInfoRecord
                                      ?.appleHealthConnected,
                                  true,
                                ))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 6.0, 0.0, 6.0),
                                    child: Container(
                                      width: 140.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        color: Color(0x1AFFFFFF),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          'Не подключено',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.roboto(
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
                                                color: Color(0x8CFFFFFF),
                                                fontSize: 16.0,
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
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Divider(
                          thickness: 1.0,
                          color: Color(0x25FFFFFF),
                        ),
                      ],
                    ),
                    if (!valueOrDefault<bool>(
                      profilePageUserInfoRecord?.appleHealthConnected,
                      true,
                    ))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            final userInfoRef =
                                profilePageUserInfoRecord?.reference;

                            if (userInfoRef == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Не удалось найти профиль пользователя'),
                                ),
                              );
                              return;
                            }

                            await _requestAppleHealthAccessFromProfile(
                                userInfoRef);
                          },
                          child: SafeArea(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1A26),
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Color(0x405EECD4),
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 18.0, 18.0, 0.0),
                                    child: Container(
                                      width: 44.0,
                                      height: 44.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/icon-apple-health-transparent.png',
                                          width: 200.0,
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                          alignment: Alignment(0.0, 0.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 18.0, 0.0, 10.0),
                                          child: Text(
                                            'Подключить Apple Здоровье',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  font: GoogleFonts.roboto(
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
                                                  fontSize: 20.0,
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
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 18.0),
                                          child: Text(
                                            'Сон и шаги помогут точнее понимать твоё состояние и видеть связь с самочувствием',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .override(
                                                  font: GoogleFonts.roboto(
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 5.0),
                      child: Text(
                        'ОБРАТНАЯ СВЯЗЬ',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontStyle,
                              ),
                              color: Color(0xB2FFFFFF),
                              fontSize: 15.0,
                              letterSpacing: 1.2,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .fontStyle,
                            ),
                      ),
                    ),
                    Container(
                      width: 100.0,
                      height: 62.0,
                      decoration: BoxDecoration(),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(FeedbackPageWidget.routeName);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Сообщить о проблеме',
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontStyle,
                                    ),
                                    color: Color(0x59FFFFFF),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/icon-chevron-right.png',
                                width: 22.0,
                                height: 22.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Divider(
                          thickness: 1.0,
                          color: Color(0x26FFFFFF),
                        ),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 40.0, 0.0, 40.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            GoRouter.of(context).prepareAuthEvent();
                            await authManager.signOut();
                            GoRouter.of(context).clearRedirectLocation();

                            context.pushNamedAuth(
                                LoginPageWidget.routeName, context.mounted);
                          },
                          child: Text(
                            'Выйти из аккаунта',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Color(0xFFFF6969),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
