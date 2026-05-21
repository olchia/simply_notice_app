import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FeedbackReportsRecord extends FirestoreRecord {
  FeedbackReportsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _message = snapshotData['message'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('feedback_reports');

  static Stream<FeedbackReportsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FeedbackReportsRecord.fromSnapshot(s));

  static Future<FeedbackReportsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FeedbackReportsRecord.fromSnapshot(s));

  static FeedbackReportsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FeedbackReportsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FeedbackReportsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FeedbackReportsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FeedbackReportsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FeedbackReportsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFeedbackReportsRecordData({
  String? uid,
  String? message,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'message': message,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class FeedbackReportsRecordDocumentEquality
    implements Equality<FeedbackReportsRecord> {
  const FeedbackReportsRecordDocumentEquality();

  @override
  bool equals(FeedbackReportsRecord? e1, FeedbackReportsRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.message == e2?.message &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(FeedbackReportsRecord? e) =>
      const ListEquality().hash([e?.uid, e?.message, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is FeedbackReportsRecord;
}
