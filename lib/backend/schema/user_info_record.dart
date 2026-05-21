import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserInfoRecord extends FirestoreRecord {
  UserInfoRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "onboarding_done" field.
  bool? _onboardingDone;
  bool get onboardingDone => _onboardingDone ?? false;
  bool hasOnboardingDone() => _onboardingDone != null;

  // "apple_health_connected" field.
  bool? _appleHealthConnected;
  bool get appleHealthConnected => _appleHealthConnected ?? false;
  bool hasAppleHealthConnected() => _appleHealthConnected != null;

  // "personal_data_consent_accepted" field.
  bool? _personalDataConsentAccepted;
  bool get personalDataConsentAccepted => _personalDataConsentAccepted ?? false;
  bool hasPersonalDataConsentAccepted() => _personalDataConsentAccepted != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _name = snapshotData['name'] as String?;
    _onboardingDone = snapshotData['onboarding_done'] as bool?;
    _appleHealthConnected = snapshotData['apple_health_connected'] as bool?;
    _personalDataConsentAccepted =
        snapshotData['personal_data_consent_accepted'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user_info');

  static Stream<UserInfoRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserInfoRecord.fromSnapshot(s));

  static Future<UserInfoRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserInfoRecord.fromSnapshot(s));

  static UserInfoRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserInfoRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserInfoRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserInfoRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserInfoRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserInfoRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserInfoRecordData({
  String? email,
  String? uid,
  DateTime? createdTime,
  String? name,
  bool? onboardingDone,
  bool? appleHealthConnected,
  bool? personalDataConsentAccepted,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'uid': uid,
      'created_time': createdTime,
      'name': name,
      'onboarding_done': onboardingDone,
      'apple_health_connected': appleHealthConnected,
      'personal_data_consent_accepted': personalDataConsentAccepted,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserInfoRecordDocumentEquality implements Equality<UserInfoRecord> {
  const UserInfoRecordDocumentEquality();

  @override
  bool equals(UserInfoRecord? e1, UserInfoRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.name == e2?.name &&
        e1?.onboardingDone == e2?.onboardingDone &&
        e1?.appleHealthConnected == e2?.appleHealthConnected &&
        e1?.personalDataConsentAccepted == e2?.personalDataConsentAccepted;
  }

  @override
  int hash(UserInfoRecord? e) => const ListEquality().hash([
        e?.email,
        e?.uid,
        e?.createdTime,
        e?.name,
        e?.onboardingDone,
        e?.appleHealthConnected,
        e?.personalDataConsentAccepted
      ]);

  @override
  bool isValidKey(Object? o) => o is UserInfoRecord;
}
