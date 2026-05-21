import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MarkerDailyValuesRecord extends FirestoreRecord {
  MarkerDailyValuesRecord._(
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

  // "date_key" field.
  String? _dateKey;
  String get dateKey => _dateKey ?? '';
  bool hasDateKey() => _dateKey != null;

  // "marker_type" field.
  String? _markerType;
  String get markerType => _markerType ?? '';
  bool hasMarkerType() => _markerType != null;

  // "has_data" field.
  bool? _hasData;
  bool get hasData => _hasData ?? false;
  bool hasHasData() => _hasData != null;

  // "value_hours" field.
  int? _valueHours;
  int get valueHours => _valueHours ?? 0;
  bool hasValueHours() => _valueHours != null;

  // "value_minutes" field.
  int? _valueMinutes;
  int get valueMinutes => _valueMinutes ?? 0;
  bool hasValueMinutes() => _valueMinutes != null;

  // "value_display" field.
  String? _valueDisplay;
  String get valueDisplay => _valueDisplay ?? '';
  bool hasValueDisplay() => _valueDisplay != null;

  // "baseline_hours" field.
  int? _baselineHours;
  int get baselineHours => _baselineHours ?? 0;
  bool hasBaselineHours() => _baselineHours != null;

  // "baseline_minutes" field.
  int? _baselineMinutes;
  int get baselineMinutes => _baselineMinutes ?? 0;
  bool hasBaselineMinutes() => _baselineMinutes != null;

  // "baseline_display" field.
  String? _baselineDisplay;
  String get baselineDisplay => _baselineDisplay ?? '';
  bool hasBaselineDisplay() => _baselineDisplay != null;

  // "source_daily_input_id" field.
  String? _sourceDailyInputId;
  String get sourceDailyInputId => _sourceDailyInputId ?? '';
  bool hasSourceDailyInputId() => _sourceDailyInputId != null;

  // "calculated_at" field.
  DateTime? _calculatedAt;
  DateTime? get calculatedAt => _calculatedAt;
  bool hasCalculatedAt() => _calculatedAt != null;

  // "week_key" field.
  String? _weekKey;
  String get weekKey => _weekKey ?? '';
  bool hasWeekKey() => _weekKey != null;

  // "day_label" field.
  String? _dayLabel;
  String get dayLabel => _dayLabel ?? '';
  bool hasDayLabel() => _dayLabel != null;

  // "day_index" field.
  int? _dayIndex;
  int get dayIndex => _dayIndex ?? 0;
  bool hasDayIndex() => _dayIndex != null;

  // "baseline_value" field.
  double? _baselineValue;
  double get baselineValue => _baselineValue ?? 0.0;
  bool hasBaselineValue() => _baselineValue != null;

  // "value" field.
  double? _value;
  double get value => _value ?? 0.0;
  bool hasValue() => _value != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _dateKey = snapshotData['date_key'] as String?;
    _markerType = snapshotData['marker_type'] as String?;
    _hasData = snapshotData['has_data'] as bool?;
    _valueHours = castToType<int>(snapshotData['value_hours']);
    _valueMinutes = castToType<int>(snapshotData['value_minutes']);
    _valueDisplay = snapshotData['value_display'] as String?;
    _baselineHours = castToType<int>(snapshotData['baseline_hours']);
    _baselineMinutes = castToType<int>(snapshotData['baseline_minutes']);
    _baselineDisplay = snapshotData['baseline_display'] as String?;
    _sourceDailyInputId = snapshotData['source_daily_input_id'] as String?;
    _calculatedAt = snapshotData['calculated_at'] as DateTime?;
    _weekKey = snapshotData['week_key'] as String?;
    _dayLabel = snapshotData['day_label'] as String?;
    _dayIndex = castToType<int>(snapshotData['day_index']);
    _baselineValue = castToType<double>(snapshotData['baseline_value']);
    _value = castToType<double>(snapshotData['value']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('marker_daily_values');

  static Stream<MarkerDailyValuesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MarkerDailyValuesRecord.fromSnapshot(s));

  static Future<MarkerDailyValuesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => MarkerDailyValuesRecord.fromSnapshot(s));

  static MarkerDailyValuesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MarkerDailyValuesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MarkerDailyValuesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MarkerDailyValuesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MarkerDailyValuesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MarkerDailyValuesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMarkerDailyValuesRecordData({
  String? uid,
  DateTime? date,
  String? dateKey,
  String? markerType,
  bool? hasData,
  int? valueHours,
  int? valueMinutes,
  String? valueDisplay,
  int? baselineHours,
  int? baselineMinutes,
  String? baselineDisplay,
  String? sourceDailyInputId,
  DateTime? calculatedAt,
  String? weekKey,
  String? dayLabel,
  int? dayIndex,
  double? baselineValue,
  double? value,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'date': date,
      'date_key': dateKey,
      'marker_type': markerType,
      'has_data': hasData,
      'value_hours': valueHours,
      'value_minutes': valueMinutes,
      'value_display': valueDisplay,
      'baseline_hours': baselineHours,
      'baseline_minutes': baselineMinutes,
      'baseline_display': baselineDisplay,
      'source_daily_input_id': sourceDailyInputId,
      'calculated_at': calculatedAt,
      'week_key': weekKey,
      'day_label': dayLabel,
      'day_index': dayIndex,
      'baseline_value': baselineValue,
      'value': value,
    }.withoutNulls,
  );

  return firestoreData;
}

class MarkerDailyValuesRecordDocumentEquality
    implements Equality<MarkerDailyValuesRecord> {
  const MarkerDailyValuesRecordDocumentEquality();

  @override
  bool equals(MarkerDailyValuesRecord? e1, MarkerDailyValuesRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.date == e2?.date &&
        e1?.dateKey == e2?.dateKey &&
        e1?.markerType == e2?.markerType &&
        e1?.hasData == e2?.hasData &&
        e1?.valueHours == e2?.valueHours &&
        e1?.valueMinutes == e2?.valueMinutes &&
        e1?.valueDisplay == e2?.valueDisplay &&
        e1?.baselineHours == e2?.baselineHours &&
        e1?.baselineMinutes == e2?.baselineMinutes &&
        e1?.baselineDisplay == e2?.baselineDisplay &&
        e1?.sourceDailyInputId == e2?.sourceDailyInputId &&
        e1?.calculatedAt == e2?.calculatedAt &&
        e1?.weekKey == e2?.weekKey &&
        e1?.dayLabel == e2?.dayLabel &&
        e1?.dayIndex == e2?.dayIndex &&
        e1?.baselineValue == e2?.baselineValue &&
        e1?.value == e2?.value;
  }

  @override
  int hash(MarkerDailyValuesRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.date,
        e?.dateKey,
        e?.markerType,
        e?.hasData,
        e?.valueHours,
        e?.valueMinutes,
        e?.valueDisplay,
        e?.baselineHours,
        e?.baselineMinutes,
        e?.baselineDisplay,
        e?.sourceDailyInputId,
        e?.calculatedAt,
        e?.weekKey,
        e?.dayLabel,
        e?.dayIndex,
        e?.baselineValue,
        e?.value
      ]);

  @override
  bool isValidKey(Object? o) => o is MarkerDailyValuesRecord;
}
