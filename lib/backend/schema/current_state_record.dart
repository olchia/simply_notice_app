import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CurrentStateRecord extends FirestoreRecord {
  CurrentStateRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "last_date" field.
  DateTime? _lastDate;
  DateTime? get lastDate => _lastDate;
  bool hasLastDate() => _lastDate != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "overall_state_score" field.
  double? _overallStateScore;
  double get overallStateScore => _overallStateScore ?? 0.0;
  bool hasOverallStateScore() => _overallStateScore != null;

  // "state_zone" field.
  String? _stateZone;
  String get stateZone => _stateZone ?? '';
  bool hasStateZone() => _stateZone != null;

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

  // "sleep_score" field.
  double? _sleepScore;
  double get sleepScore => _sleepScore ?? 0.0;
  bool hasSleepScore() => _sleepScore != null;

  // "activity_score" field.
  double? _activityScore;
  double get activityScore => _activityScore ?? 0.0;
  bool hasActivityScore() => _activityScore != null;

  // "stress_score" field.
  double? _stressScore;
  double get stressScore => _stressScore ?? 0.0;
  bool hasStressScore() => _stressScore != null;

  // "energy_score" field.
  double? _energyScore;
  double get energyScore => _energyScore ?? 0.0;
  bool hasEnergyScore() => _energyScore != null;

  // "exhaustion_score" field.
  double? _exhaustionScore;
  double get exhaustionScore => _exhaustionScore ?? 0.0;
  bool hasExhaustionScore() => _exhaustionScore != null;

  // "social_score" field.
  double? _socialScore;
  double get socialScore => _socialScore ?? 0.0;
  bool hasSocialScore() => _socialScore != null;

  // "signal_title" field.
  String? _signalTitle;
  String get signalTitle => _signalTitle ?? '';
  bool hasSignalTitle() => _signalTitle != null;

  // "signal_text" field.
  String? _signalText;
  String get signalText => _signalText ?? '';
  bool hasSignalText() => _signalText != null;

  // "recommendation" field.
  String? _recommendation;
  String get recommendation => _recommendation ?? '';
  bool hasRecommendation() => _recommendation != null;

  // "particles_density" field.
  double? _particlesDensity;
  double get particlesDensity => _particlesDensity ?? 0.0;
  bool hasParticlesDensity() => _particlesDensity != null;

  // "particles_spread" field.
  double? _particlesSpread;
  double get particlesSpread => _particlesSpread ?? 0.0;
  bool hasParticlesSpread() => _particlesSpread != null;

  // "particles_color" field.
  String? _particlesColor;
  String get particlesColor => _particlesColor ?? '';
  bool hasParticlesColor() => _particlesColor != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _lastDate = snapshotData['last_date'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _overallStateScore =
        castToType<double>(snapshotData['overall_state_score']);
    _stateZone = snapshotData['state_zone'] as String?;
    _physiologicalGroupScore =
        castToType<double>(snapshotData['physiological_group_score']);
    _psychologicalGroupScore =
        castToType<double>(snapshotData['psychological_group_score']);
    _socialGroupScore = castToType<double>(snapshotData['social_group_score']);
    _sleepScore = castToType<double>(snapshotData['sleep_score']);
    _activityScore = castToType<double>(snapshotData['activity_score']);
    _stressScore = castToType<double>(snapshotData['stress_score']);
    _energyScore = castToType<double>(snapshotData['energy_score']);
    _exhaustionScore = castToType<double>(snapshotData['exhaustion_score']);
    _socialScore = castToType<double>(snapshotData['social_score']);
    _signalTitle = snapshotData['signal_title'] as String?;
    _signalText = snapshotData['signal_text'] as String?;
    _recommendation = snapshotData['recommendation'] as String?;
    _particlesDensity = castToType<double>(snapshotData['particles_density']);
    _particlesSpread = castToType<double>(snapshotData['particles_spread']);
    _particlesColor = snapshotData['particles_color'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('current_state');

  static Stream<CurrentStateRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CurrentStateRecord.fromSnapshot(s));

  static Future<CurrentStateRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CurrentStateRecord.fromSnapshot(s));

  static CurrentStateRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CurrentStateRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CurrentStateRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CurrentStateRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CurrentStateRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CurrentStateRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCurrentStateRecordData({
  String? uid,
  DateTime? lastDate,
  DateTime? updatedAt,
  double? overallStateScore,
  String? stateZone,
  double? physiologicalGroupScore,
  double? psychologicalGroupScore,
  double? socialGroupScore,
  double? sleepScore,
  double? activityScore,
  double? stressScore,
  double? energyScore,
  double? exhaustionScore,
  double? socialScore,
  String? signalTitle,
  String? signalText,
  String? recommendation,
  double? particlesDensity,
  double? particlesSpread,
  String? particlesColor,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'last_date': lastDate,
      'updated_at': updatedAt,
      'overall_state_score': overallStateScore,
      'state_zone': stateZone,
      'physiological_group_score': physiologicalGroupScore,
      'psychological_group_score': psychologicalGroupScore,
      'social_group_score': socialGroupScore,
      'sleep_score': sleepScore,
      'activity_score': activityScore,
      'stress_score': stressScore,
      'energy_score': energyScore,
      'exhaustion_score': exhaustionScore,
      'social_score': socialScore,
      'signal_title': signalTitle,
      'signal_text': signalText,
      'recommendation': recommendation,
      'particles_density': particlesDensity,
      'particles_spread': particlesSpread,
      'particles_color': particlesColor,
    }.withoutNulls,
  );

  return firestoreData;
}

class CurrentStateRecordDocumentEquality
    implements Equality<CurrentStateRecord> {
  const CurrentStateRecordDocumentEquality();

  @override
  bool equals(CurrentStateRecord? e1, CurrentStateRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.lastDate == e2?.lastDate &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.overallStateScore == e2?.overallStateScore &&
        e1?.stateZone == e2?.stateZone &&
        e1?.physiologicalGroupScore == e2?.physiologicalGroupScore &&
        e1?.psychologicalGroupScore == e2?.psychologicalGroupScore &&
        e1?.socialGroupScore == e2?.socialGroupScore &&
        e1?.sleepScore == e2?.sleepScore &&
        e1?.activityScore == e2?.activityScore &&
        e1?.stressScore == e2?.stressScore &&
        e1?.energyScore == e2?.energyScore &&
        e1?.exhaustionScore == e2?.exhaustionScore &&
        e1?.socialScore == e2?.socialScore &&
        e1?.signalTitle == e2?.signalTitle &&
        e1?.signalText == e2?.signalText &&
        e1?.recommendation == e2?.recommendation &&
        e1?.particlesDensity == e2?.particlesDensity &&
        e1?.particlesSpread == e2?.particlesSpread &&
        e1?.particlesColor == e2?.particlesColor;
  }

  @override
  int hash(CurrentStateRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.lastDate,
        e?.updatedAt,
        e?.overallStateScore,
        e?.stateZone,
        e?.physiologicalGroupScore,
        e?.psychologicalGroupScore,
        e?.socialGroupScore,
        e?.sleepScore,
        e?.activityScore,
        e?.stressScore,
        e?.energyScore,
        e?.exhaustionScore,
        e?.socialScore,
        e?.signalTitle,
        e?.signalText,
        e?.recommendation,
        e?.particlesDensity,
        e?.particlesSpread,
        e?.particlesColor
      ]);

  @override
  bool isValidKey(Object? o) => o is CurrentStateRecord;
}
