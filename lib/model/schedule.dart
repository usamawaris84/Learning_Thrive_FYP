import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning_thrive/messaging/constants/constants.dart';

class Schedule {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;

  Schedule({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: this.idFrom,
      FirestoreConstants.idTo: this.idTo,
      FirestoreConstants.timestamp: this.timestamp,
      FirestoreConstants.content: this.content,
      FirestoreConstants.type: this.type,
    };
  }

  factory Schedule.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get(FirestoreConstants.idFrom);
    String idTo = doc.get(FirestoreConstants.idTo);
    String timestamp = doc.get(FirestoreConstants.timestamp);
    String content = doc.get(FirestoreConstants.content);
    int type = doc.get(FirestoreConstants.type);
    return Schedule(idFrom: idFrom, idTo: idTo, timestamp: timestamp, content: content, type: type);
  }
}
