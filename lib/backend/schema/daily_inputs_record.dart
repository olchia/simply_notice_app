import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DailyInputsRecord extends FirestoreRecord {
  DailyInputsRecord._(
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

  // "sleep_hours" field.
  int? _sleepHours;
  int get sleepHours => _sleepHours ?? 0;
  bool hasSleepHours() => _sleepHours != null;

  // "sleep_minutes" field.
  int? _sleepMinutes;
  int get sleepMinutes => _sleepMinutes ?? 0;
  bool hasSleepMinutes() => _sleepMinutes != null;

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

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  // "sleep_start_time" field.
  DateTime? _sleepStartTime;
  DateTime? get sleepStartTime => _sleepStartTime;
  bool hasSleepStartTime() => _sleepStartTime != null;

  // "sleep_end_time" field.
  DateTime? _sleepEndTime;
  DateTime? get sleepEndTime => _sleepEndTime;
  bool hasSleepEndTime() => _sleepEndTime != null;

  // "sleep_duration_total_minutes" field.
  int? _sleepDurationTotalMinutes;
  int get sleepDurationTotalMinutes => _sleepDurationTotalMinutes ?? 0;
  bool hasSleepDurationTotalMinutes() => _sleepDurationTotalMinutes != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _sleepHours = castToType<int>(snapshotData['sleep_hours']);
    _sleepMinutes = castToType<int>(snapshotData['sleep_minutes']);
    _steps = castToType<int>(snapshotData['steps']);
    _stress = castToType<int>(snapshotData['stress']);
    _energy = castToType<int>(snapshotData['energy']);
    _exhaustion = castToType<int>(snapshotData['exhaustion']);
    _socialSupport = castToType<int>(snapshotData['social_support']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
    _sleepStartTime = snapshotData['sleep_start_time'] as DateTime?;
    _sleepEndTime = snapshotData['sleep_end_time'] as DateTime?;
    _sleepDurationTotalMinutes =
        castToType<int>(snapshotData['sleep_duration_total_minutes']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('daily_inputs');

  static Stream<DailyInputsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DailyInputsRecord.fromSnapshot(s));

  static Future<DailyInputsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DailyInputsRecord.fromSnapshot(s));

  static DailyInputsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DailyInputsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DailyInputsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DailyInputsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DailyInputsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DailyInputsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDailyInputsRecordData({
  String? uid,
  DateTime? date,
  int? sleepHours,
  int? sleepMinutes,
  int? steps,
  int? stress,
  int? energy,
  int? exhaustion,
  int? socialSupport,
  DateTime? createdAt,
  DateTime? updatedAt,
  DateTime? sleepStartTime,
  DateTime? sleepEndTime,
  int? sleepDurationTotalMinutes,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'date': date,
      'sleep_hours': sleepHours,
      'sleep_minutes': sleepMinutes,
      'steps': steps,
      'stress': stress,
      'energy': energy,
      'exhaustion': exhaustion,
      'social_support': socialSupport,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'sleep_start_time': sleepStartTime,
      'sleep_end_time': sleepEndTime,
      'sleep_duration_total_minutes': sleepDurationTotalMinutes,
    }.withoutNulls,
  );

  return firestoreData;
}

class DailyInputsRecordDocumentEquality implements Equality<DailyInputsRecord> {
  const DailyInputsRecordDocumentEquality();

  @override
  bool equals(DailyInputsRecord? e1, DailyInputsRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.date == e2?.date &&
        e1?.sleepHours == e2?.sleepHours &&
        e1?.sleepMinutes == e2?.sleepMinutes &&
        e1?.steps == e2?.steps &&
        e1?.stress == e2?.stress &&
        e1?.energy == e2?.energy &&
        e1?.exhaustion == e2?.exhaustion &&
        e1?.socialSupport == e2?.socialSupport &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.sleepStartTime == e2?.sleepStartTime &&
        e1?.sleepEndTime == e2?.sleepEndTime &&
        e1?.sleepDurationTotalMinutes == e2?.sleepDurationTotalMinutes;
  }

  @override
  int hash(DailyInputsRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.date,
        e?.sleepHours,
        e?.sleepMinutes,
        e?.steps,
        e?.stress,
        e?.energy,
        e?.exhaustion,
        e?.socialSupport,
        e?.createdAt,
        e?.updatedAt,
        e?.sleepStartTime,
        e?.sleepEndTime,
        e?.sleepDurationTotalMinutes
      ]);

  @override
  bool isValidKey(Object? o) => o is DailyInputsRecord;
}
