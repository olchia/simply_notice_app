import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DailyScoresRecord extends FirestoreRecord {
  DailyScoresRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "sleep_duration_total_minutes" field.
  int? _sleepDurationTotalMinutes;
  int get sleepDurationTotalMinutes => _sleepDurationTotalMinutes ?? 0;
  bool hasSleepDurationTotalMinutes() => _sleepDurationTotalMinutes != null;

  // "sleep_zone_score" field.
  double? _sleepZoneScore;
  double get sleepZoneScore => _sleepZoneScore ?? 0.0;
  bool hasSleepZoneScore() => _sleepZoneScore != null;

  // "sleep_baseline_14d" field.
  double? _sleepBaseline14d;
  double get sleepBaseline14d => _sleepBaseline14d ?? 0.0;
  bool hasSleepBaseline14d() => _sleepBaseline14d != null;

  // "sleep_score" field.
  double? _sleepScore;
  double get sleepScore => _sleepScore ?? 0.0;
  bool hasSleepScore() => _sleepScore != null;

  // "steps_baseline_14d" field.
  double? _stepsBaseline14d;
  double get stepsBaseline14d => _stepsBaseline14d ?? 0.0;
  bool hasStepsBaseline14d() => _stepsBaseline14d != null;

  // "activity_score" field.
  double? _activityScore;
  double get activityScore => _activityScore ?? 0.0;
  bool hasActivityScore() => _activityScore != null;

  // "stress_baseline_14d" field.
  double? _stressBaseline14d;
  double get stressBaseline14d => _stressBaseline14d ?? 0.0;
  bool hasStressBaseline14d() => _stressBaseline14d != null;

  // "stress_deviation" field.
  double? _stressDeviation;
  double get stressDeviation => _stressDeviation ?? 0.0;
  bool hasStressDeviation() => _stressDeviation != null;

  // "stress_score" field.
  double? _stressScore;
  double get stressScore => _stressScore ?? 0.0;
  bool hasStressScore() => _stressScore != null;

  // "energy_baseline_14d" field.
  double? _energyBaseline14d;
  double get energyBaseline14d => _energyBaseline14d ?? 0.0;
  bool hasEnergyBaseline14d() => _energyBaseline14d != null;

  // "energy_deviation" field.
  double? _energyDeviation;
  double get energyDeviation => _energyDeviation ?? 0.0;
  bool hasEnergyDeviation() => _energyDeviation != null;

  // "energy_score" field.
  double? _energyScore;
  double get energyScore => _energyScore ?? 0.0;
  bool hasEnergyScore() => _energyScore != null;

  // "exhaustion_baseline_14d" field.
  double? _exhaustionBaseline14d;
  double get exhaustionBaseline14d => _exhaustionBaseline14d ?? 0.0;
  bool hasExhaustionBaseline14d() => _exhaustionBaseline14d != null;

  // "exhaustion_deviation" field.
  double? _exhaustionDeviation;
  double get exhaustionDeviation => _exhaustionDeviation ?? 0.0;
  bool hasExhaustionDeviation() => _exhaustionDeviation != null;

  // "exhaustion_score" field.
  double? _exhaustionScore;
  double get exhaustionScore => _exhaustionScore ?? 0.0;
  bool hasExhaustionScore() => _exhaustionScore != null;

  // "social_baseline_14d" field.
  double? _socialBaseline14d;
  double get socialBaseline14d => _socialBaseline14d ?? 0.0;
  bool hasSocialBaseline14d() => _socialBaseline14d != null;

  // "social_deviation" field.
  double? _socialDeviation;
  double get socialDeviation => _socialDeviation ?? 0.0;
  bool hasSocialDeviation() => _socialDeviation != null;

  // "social_score" field.
  double? _socialScore;
  double get socialScore => _socialScore ?? 0.0;
  bool hasSocialScore() => _socialScore != null;

  // "physiological_group_score" field.
  double? _physiologicalGroupScore;
  double get physiologicalGroupScore => _physiologicalGroupScore ?? 0.0;
  bool hasPhysiologicalGroupScore() => _physiologicalGroupScore != null;

  // "psychological_group_score" field.
  double? _psychologicalGroupScore;
  double get psychologicalGroupScore => _psychologicalGroupScore ?? 0.0;
  bool hasPsychologicalGroupScore() => _psychologicalGroupScore != null;

  // "social_group_score" field.
  double? _socialGroupScore;
  double get socialGroupScore => _socialGroupScore ?? 0.0;
  bool hasSocialGroupScore() => _socialGroupScore != null;

  // "overall_state_score" field.
  double? _overallStateScore;
  double get overallStateScore => _overallStateScore ?? 0.0;
  bool hasOverallStateScore() => _overallStateScore != null;

  // "state_zone" field.
  String? _stateZone;
  String get stateZone => _stateZone ?? '';
  bool hasStateZone() => _stateZone != null;

  // "steps" field.
  int? _steps;
  int get steps => _steps ?? 0;
  bool hasSteps() => _steps != null;

  // "stress" field.
  int? _stress;
  int get stress => _stress ?? 0;
  bool hasStress() => _stress != null;

  // "energy" field.
  int? _energy;
  int get energy => _energy ?? 0;
  bool hasEnergy() => _energy != null;

  // "exhaustion" field.
  int? _exhaustion;
  int get exhaustion => _exhaustion ?? 0;
  bool hasExhaustion() => _exhaustion != null;

  // "social_support" field.
  int? _socialSupport;
  int get socialSupport => _socialSupport ?? 0;
  bool hasSocialSupport() => _socialSupport != null;

  // "baseline_window_days" field.
  int? _baselineWindowDays;
  int get baselineWindowDays => _baselineWindowDays ?? 0;
  bool hasBaselineWindowDays() => _baselineWindowDays != null;

  // "baseline_valid_days_count" field.
  int? _baselineValidDaysCount;
  int get baselineValidDaysCount => _baselineValidDaysCount ?? 0;
  bool hasBaselineValidDaysCount() => _baselineValidDaysCount != null;

  // "score_available" field.
  bool? _scoreAvailable;
  bool get scoreAvailable => _scoreAvailable ?? false;
  bool hasScoreAvailable() => _scoreAvailable != null;

  // "missing_baseline_dates" field.
  List<String>? _missingBaselineDates;
  List<String> get missingBaselineDates => _missingBaselineDates ?? const [];
  bool hasMissingBaselineDates() => _missingBaselineDates != null;

  // "unavailable_reason" field.
  String? _unavailableReason;
  String get unavailableReason => _unavailableReason ?? '';
  bool hasUnavailableReason() => _unavailableReason != null;

  // "calculated_at" field.
  DateTime? _calculatedAt;
  DateTime? get calculatedAt => _calculatedAt;
  bool hasCalculatedAt() => _calculatedAt != null;

  // "sleep_baseline_14d_total_minutes" field.
  int? _sleepBaseline14dTotalMinutes;
  int get sleepBaseline14dTotalMinutes => _sleepBaseline14dTotalMinutes ?? 0;
  bool hasSleepBaseline14dTotalMinutes() =>
      _sleepBaseline14dTotalMinutes != null;

  // "sleep_baseline_14d_hours" field.
  int? _sleepBaseline14dHours;
  int get sleepBaseline14dHours => _sleepBaseline14dHours ?? 0;
  bool hasSleepBaseline14dHours() => _sleepBaseline14dHours != null;

  // "sleep_baseline_14d_minutes" field.
  int? _sleepBaseline14dMinutes;
  int get sleepBaseline14dMinutes => _sleepBaseline14dMinutes ?? 0;
  bool hasSleepBaseline14dMinutes() => _sleepBaseline14dMinutes != null;

  // "week_key" field.
  String? _weekKey;
  String get weekKey => _weekKey ?? '';
  bool hasWeekKey() => _weekKey != null;

  // "week_start_date" field.
  DateTime? _weekStartDate;
  DateTime? get weekStartDate => _weekStartDate;
  bool hasWeekStartDate() => _weekStartDate != null;

  // "week_end_date" field.
  DateTime? _weekEndDate;
  DateTime? get weekEndDate => _weekEndDate;
  bool hasWeekEndDate() => _weekEndDate != null;

  // "steps_deviation" field.
  double? _stepsDeviation;
  double get stepsDeviation => _stepsDeviation ?? 0.0;
  bool hasStepsDeviation() => _stepsDeviation != null;

  // "sleep_deviation" field.
  double? _sleepDeviation;
  double get sleepDeviation => _sleepDeviation ?? 0.0;
  bool hasSleepDeviation() => _sleepDeviation != null;

  // "factor_1_title" field.
  String? _factor1Title;
  String get factor1Title => _factor1Title ?? '';
  bool hasFactor1Title() => _factor1Title != null;

  // "factor_1_value" field.
  String? _factor1Value;
  String get factor1Value => _factor1Value ?? '';
  bool hasFactor1Value() => _factor1Value != null;

  // "factor_1_visible" field.
  bool? _factor1Visible;
  bool get factor1Visible => _factor1Visible ?? false;
  bool hasFactor1Visible() => _factor1Visible != null;

  // "factor_2_title" field.
  String? _factor2Title;
  String get factor2Title => _factor2Title ?? '';
  bool hasFactor2Title() => _factor2Title != null;

  // "factor_2_value" field.
  String? _factor2Value;
  String get factor2Value => _factor2Value ?? '';
  bool hasFactor2Value() => _factor2Value != null;

  // "factor_2_visible" field.
  bool? _factor2Visible;
  bool get factor2Visible => _factor2Visible ?? false;
  bool hasFactor2Visible() => _factor2Visible != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _sleepDurationTotalMinutes =
        castToType<int>(snapshotData['sleep_duration_total_minutes']);
    _sleepZoneScore = castToType<double>(snapshotData['sleep_zone_score']);
    _sleepBaseline14d = castToType<double>(snapshotData['sleep_baseline_14d']);
    _sleepScore = castToType<double>(snapshotData['sleep_score']);
    _stepsBaseline14d = castToType<double>(snapshotData['steps_baseline_14d']);
    _activityScore = castToType<double>(snapshotData['activity_score']);
    _stressBaseline14d =
        castToType<double>(snapshotData['stress_baseline_14d']);
    _stressDeviation = castToType<double>(snapshotData['stress_deviation']);
    _stressScore = castToType<double>(snapshotData['stress_score']);
    _energyBaseline14d =
        castToType<double>(snapshotData['energy_baseline_14d']);
    _energyDeviation = castToType<double>(snapshotData['energy_deviation']);
    _energyScore = castToType<double>(snapshotData['energy_score']);
    _exhaustionBaseline14d =
        castToType<double>(snapshotData['exhaustion_baseline_14d']);
    _exhaustionDeviation =
        castToType<double>(snapshotData['exhaustion_deviation']);
    _exhaustionScore = castToType<double>(snapshotData['exhaustion_score']);
    _socialBaseline14d =
        castToType<double>(snapshotData['social_baseline_14d']);
    _socialDeviation = castToType<double>(snapshotData['social_deviation']);
    _socialScore = castToType<double>(snapshotData['social_score']);
    _physiologicalGroupScore =
        castToType<double>(snapshotData['physiological_group_score']);
    _psychologicalGroupScore =
        castToType<double>(snapshotData['psychological_group_score']);
    _socialGroupScore = castToType<double>(snapshotData['social_group_score']);
    _overallStateScore =
        castToType<double>(snapshotData['overall_state_score']);
    _stateZone = snapshotData['state_zone'] as String?;
    _steps = castToType<int>(snapshotData['steps']);
    _stress = castToType<int>(snapshotData['stress']);
    _energy = castToType<int>(snapshotData['energy']);
    _exhaustion = castToType<int>(snapshotData['exhaustion']);
    _socialSupport = castToType<int>(snapshotData['social_support']);
    _baselineWindowDays = castToType<int>(snapshotData['baseline_window_days']);
    _baselineValidDaysCount =
        castToType<int>(snapshotData['baseline_valid_days_count']);
    _scoreAvailable = snapshotData['score_available'] as bool?;
    _missingBaselineDates = getDataList(snapshotData['missing_baseline_dates']);
    _unavailableReason = snapshotData['unavailable_reason'] as String?;
    _calculatedAt = snapshotData['calculated_at'] as DateTime?;
    _sleepBaseline14dTotalMinutes =
        castToType<int>(snapshotData['sleep_baseline_14d_total_minutes']);
    _sleepBaseline14dHours =
        castToType<int>(snapshotData['sleep_baseline_14d_hours']);
    _sleepBaseline14dMinutes =
        castToType<int>(snapshotData['sleep_baseline_14d_minutes']);
    _weekKey = snapshotData['week_key'] as String?;
    _weekStartDate = snapshotData['week_start_date'] as DateTime?;
    _weekEndDate = snapshotData['week_end_date'] as DateTime?;
    _stepsDeviation = castToType<double>(snapshotData['steps_deviation']);
    _sleepDeviation = castToType<double>(snapshotData['sleep_deviation']);
    _factor1Title = snapshotData['factor_1_title'] as String?;
    _factor1Value = snapshotData['factor_1_value'] as String?;
    _factor1Visible = snapshotData['factor_1_visible'] as bool?;
    _factor2Title = snapshotData['factor_2_title'] as String?;
    _factor2Value = snapshotData['factor_2_value'] as String?;
    _factor2Visible = snapshotData['factor_2_visible'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('daily_scores');

  static Stream<DailyScoresRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DailyScoresRecord.fromSnapshot(s));

  static Future<DailyScoresRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DailyScoresRecord.fromSnapshot(s));

  static DailyScoresRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DailyScoresRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DailyScoresRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DailyScoresRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DailyScoresRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DailyScoresRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDailyScoresRecordData({
  String? uid,
  DateTime? date,
  DateTime? createdAt,
  int? sleepDurationTotalMinutes,
  double? sleepZoneScore,
  double? sleepBaseline14d,
  double? sleepScore,
  double? stepsBaseline14d,
  double? activityScore,
  double? stressBaseline14d,
  double? stressDeviation,
  double? stressScore,
  double? energyBaseline14d,
  double? energyDeviation,
  double? energyScore,
  double? exhaustionBaseline14d,
  double? exhaustionDeviation,
  double? exhaustionScore,
  double? socialBaseline14d,
  double? socialDeviation,
  double? socialScore,
  double? physiologicalGroupScore,
  double? psychologicalGroupScore,
  double? socialGroupScore,
  double? overallStateScore,
  String? stateZone,
  int? steps,
  int? stress,
  int? energy,
  int? exhaustion,
  int? socialSupport,
  int? baselineWindowDays,
  int? baselineValidDaysCount,
  bool? scoreAvailable,
  String? unavailableReason,
  DateTime? calculatedAt,
  int? sleepBaseline14dTotalMinutes,
  int? sleepBaseline14dHours,
  int? sleepBaseline14dMinutes,
  String? weekKey,
  DateTime? weekStartDate,
  DateTime? weekEndDate,
  double? stepsDeviation,
  double? sleepDeviation,
  String? factor1Title,
  String? factor1Value,
  bool? factor1Visible,
  String? factor2Title,
  String? factor2Value,
  bool? factor2Visible,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'date': date,
      'created_at': createdAt,
      'sleep_duration_total_minutes': sleepDurationTotalMinutes,
      'sleep_zone_score': sleepZoneScore,
      'sleep_baseline_14d': sleepBaseline14d,
      'sleep_score': sleepScore,
      'steps_baseline_14d': stepsBaseline14d,
      'activity_score': activityScore,
      'stress_baseline_14d': stressBaseline14d,
      'stress_deviation': stressDeviation,
      'stress_score': stressScore,
      'energy_baseline_14d': energyBaseline14d,
      'energy_deviation': energyDeviation,
      'energy_score': energyScore,
      'exhaustion_baseline_14d': exhaustionBaseline14d,
      'exhaustion_deviation': exhaustionDeviation,
      'exhaustion_score': exhaustionScore,
      'social_baseline_14d': socialBaseline14d,
      'social_deviation': socialDeviation,
      'social_score': socialScore,
      'physiological_group_score': physiologicalGroupScore,
      'psychological_group_score': psychologicalGroupScore,
      'social_group_score': socialGroupScore,
      'overall_state_score': overallStateScore,
      'state_zone': stateZone,
      'steps': steps,
      'stress': stress,
      'energy': energy,
      'exhaustion': exhaustion,
      'social_support': socialSupport,
      'baseline_window_days': baselineWindowDays,
      'baseline_valid_days_count': baselineValidDaysCount,
      'score_available': scoreAvailable,
      'unavailable_reason': unavailableReason,
      'calculated_at': calculatedAt,
      'sleep_baseline_14d_total_minutes': sleepBaseline14dTotalMinutes,
      'sleep_baseline_14d_hours': sleepBaseline14dHours,
      'sleep_baseline_14d_minutes': sleepBaseline14dMinutes,
      'week_key': weekKey,
      'week_start_date': weekStartDate,
      'week_end_date': weekEndDate,
      'steps_deviation': stepsDeviation,
      'sleep_deviation': sleepDeviation,
      'factor_1_title': factor1Title,
      'factor_1_value': factor1Value,
      'factor_1_visible': factor1Visible,
      'factor_2_title': factor2Title,
      'factor_2_value': factor2Value,
      'factor_2_visible': factor2Visible,
    }.withoutNulls,
  );

  return firestoreData;
}

class DailyScoresRecordDocumentEquality implements Equality<DailyScoresRecord> {
  const DailyScoresRecordDocumentEquality();

  @override
  bool equals(DailyScoresRecord? e1, DailyScoresRecord? e2) {
    const listEquality = ListEquality();
    return e1?.uid == e2?.uid &&
        e1?.date == e2?.date &&
        e1?.createdAt == e2?.createdAt &&
        e1?.sleepDurationTotalMinutes == e2?.sleepDurationTotalMinutes &&
        e1?.sleepZoneScore == e2?.sleepZoneScore &&
        e1?.sleepBaseline14d == e2?.sleepBaseline14d &&
        e1?.sleepScore == e2?.sleepScore &&
        e1?.stepsBaseline14d == e2?.stepsBaseline14d &&
        e1?.activityScore == e2?.activityScore &&
        e1?.stressBaseline14d == e2?.stressBaseline14d &&
        e1?.stressDeviation == e2?.stressDeviation &&
        e1?.stressScore == e2?.stressScore &&
        e1?.energyBaseline14d == e2?.energyBaseline14d &&
        e1?.energyDeviation == e2?.energyDeviation &&
        e1?.energyScore == e2?.energyScore &&
        e1?.exhaustionBaseline14d == e2?.exhaustionBaseline14d &&
        e1?.exhaustionDeviation == e2?.exhaustionDeviation &&
        e1?.exhaustionScore == e2?.exhaustionScore &&
        e1?.socialBaseline14d == e2?.socialBaseline14d &&
        e1?.socialDeviation == e2?.socialDeviation &&
        e1?.socialScore == e2?.socialScore &&
        e1?.physiologicalGroupScore == e2?.physiologicalGroupScore &&
        e1?.psychologicalGroupScore == e2?.psychologicalGroupScore &&
        e1?.socialGroupScore == e2?.socialGroupScore &&
        e1?.overallStateScore == e2?.overallStateScore &&
        e1?.stateZone == e2?.stateZone &&
        e1?.steps == e2?.steps &&
        e1?.stress == e2?.stress &&
        e1?.energy == e2?.energy &&
        e1?.exhaustion == e2?.exhaustion &&
        e1?.socialSupport == e2?.socialSupport &&
        e1?.baselineWindowDays == e2?.baselineWindowDays &&
        e1?.baselineValidDaysCount == e2?.baselineValidDaysCount &&
        e1?.scoreAvailable == e2?.scoreAvailable &&
        listEquality.equals(
            e1?.missingBaselineDates, e2?.missingBaselineDates) &&
        e1?.unavailableReason == e2?.unavailableReason &&
        e1?.calculatedAt == e2?.calculatedAt &&
        e1?.sleepBaseline14dTotalMinutes == e2?.sleepBaseline14dTotalMinutes &&
        e1?.sleepBaseline14dHours == e2?.sleepBaseline14dHours &&
        e1?.sleepBaseline14dMinutes == e2?.sleepBaseline14dMinutes &&
        e1?.weekKey == e2?.weekKey &&
        e1?.weekStartDate == e2?.weekStartDate &&
        e1?.weekEndDate == e2?.weekEndDate &&
        e1?.stepsDeviation == e2?.stepsDeviation &&
        e1?.sleepDeviation == e2?.sleepDeviation &&
        e1?.factor1Title == e2?.factor1Title &&
        e1?.factor1Value == e2?.factor1Value &&
        e1?.factor1Visible == e2?.factor1Visible &&
        e1?.factor2Title == e2?.factor2Title &&
        e1?.factor2Value == e2?.factor2Value &&
        e1?.factor2Visible == e2?.factor2Visible;
  }

  @override
  int hash(DailyScoresRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.date,
        e?.createdAt,
        e?.sleepDurationTotalMinutes,
        e?.sleepZoneScore,
        e?.sleepBaseline14d,
        e?.sleepScore,
        e?.stepsBaseline14d,
        e?.activityScore,
        e?.stressBaseline14d,
        e?.stressDeviation,
        e?.stressScore,
        e?.energyBaseline14d,
        e?.energyDeviation,
        e?.energyScore,
        e?.exhaustionBaseline14d,
        e?.exhaustionDeviation,
        e?.exhaustionScore,
        e?.socialBaseline14d,
        e?.socialDeviation,
        e?.socialScore,
        e?.physiologicalGroupScore,
        e?.psychologicalGroupScore,
        e?.socialGroupScore,
        e?.overallStateScore,
        e?.stateZone,
        e?.steps,
        e?.stress,
        e?.energy,
        e?.exhaustion,
        e?.socialSupport,
        e?.baselineWindowDays,
        e?.baselineValidDaysCount,
        e?.scoreAvailable,
        e?.missingBaselineDates,
        e?.unavailableReason,
        e?.calculatedAt,
        e?.sleepBaseline14dTotalMinutes,
        e?.sleepBaseline14dHours,
        e?.sleepBaseline14dMinutes,
        e?.weekKey,
        e?.weekStartDate,
        e?.weekEndDate,
        e?.stepsDeviation,
        e?.sleepDeviation,
        e?.factor1Title,
        e?.factor1Value,
        e?.factor1Visible,
        e?.factor2Title,
        e?.factor2Value,
        e?.factor2Visible
      ]);

  @override
  bool isValidKey(Object? o) => o is DailyScoresRecord;
}
