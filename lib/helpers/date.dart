  import 'package:cloud_firestore/cloud_firestore.dart';

DateTime timestampToDateTime(Timestamp flightTime) {
    DateTime dateTime = flightTime.toDate();
    return dateTime;
  }
