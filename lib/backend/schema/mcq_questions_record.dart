import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class McqQuestionsRecord extends FirestoreRecord {
  McqQuestionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "questionText" field.
  String? _questionText;
  String get questionText => _questionText ?? '';
  bool hasQuestionText() => _questionText != null;

  // "option1" field.
  String? _option1;
  String get option1 => _option1 ?? '';
  bool hasOption1() => _option1 != null;

  // "option2" field.
  String? _option2;
  String get option2 => _option2 ?? '';
  bool hasOption2() => _option2 != null;

  // "option3" field.
  String? _option3;
  String get option3 => _option3 ?? '';
  bool hasOption3() => _option3 != null;

  // "option4" field.
  String? _option4;
  String get option4 => _option4 ?? '';
  bool hasOption4() => _option4 != null;

  // "correctAnswer" field.
  String? _correctAnswer;
  String get correctAnswer => _correctAnswer ?? '';
  bool hasCorrectAnswer() => _correctAnswer != null;

  // "explanation" field.
  String? _explanation;
  String get explanation => _explanation ?? '';
  bool hasExplanation() => _explanation != null;

  // "topicId" field.
  String? _topicId;
  String get topicId => _topicId ?? '';
  bool hasTopicId() => _topicId != null;

  // "slno" field.
  int? _slno;
  int get slno => _slno ?? 0;
  bool hasSlno() => _slno != null;

  void _initializeFields() {
    _questionText = snapshotData['questionText'] as String?;
    _option1 = snapshotData['option1'] as String?;
    _option2 = snapshotData['option2'] as String?;
    _option3 = snapshotData['option3'] as String?;
    _option4 = snapshotData['option4'] as String?;
    _correctAnswer = snapshotData['correctAnswer'] as String?;
    _explanation = snapshotData['explanation'] as String?;
    _topicId = snapshotData['topicId'] as String?;
    _slno = castToType<int>(snapshotData['slno']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('mcq_questions');

  static Stream<McqQuestionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => McqQuestionsRecord.fromSnapshot(s));

  static Future<McqQuestionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => McqQuestionsRecord.fromSnapshot(s));

  static McqQuestionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      McqQuestionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static McqQuestionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      McqQuestionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'McqQuestionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is McqQuestionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMcqQuestionsRecordData({
  String? questionText,
  String? option1,
  String? option2,
  String? option3,
  String? option4,
  String? correctAnswer,
  String? explanation,
  String? topicId,
  int? slno,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'questionText': questionText,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'topicId': topicId,
      'slno': slno,
    }.withoutNulls,
  );

  return firestoreData;
}

class McqQuestionsRecordDocumentEquality
    implements Equality<McqQuestionsRecord> {
  const McqQuestionsRecordDocumentEquality();

  @override
  bool equals(McqQuestionsRecord? e1, McqQuestionsRecord? e2) {
    return e1?.questionText == e2?.questionText &&
        e1?.option1 == e2?.option1 &&
        e1?.option2 == e2?.option2 &&
        e1?.option3 == e2?.option3 &&
        e1?.option4 == e2?.option4 &&
        e1?.correctAnswer == e2?.correctAnswer &&
        e1?.explanation == e2?.explanation &&
        e1?.topicId == e2?.topicId &&
        e1?.slno == e2?.slno;
  }

  @override
  int hash(McqQuestionsRecord? e) => const ListEquality().hash([
        e?.questionText,
        e?.option1,
        e?.option2,
        e?.option3,
        e?.option4,
        e?.correctAnswer,
        e?.explanation,
        e?.topicId,
        e?.slno
      ]);

  @override
  bool isValidKey(Object? o) => o is McqQuestionsRecord;
}
