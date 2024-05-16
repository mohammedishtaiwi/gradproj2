  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

DateTime timestampToDateTime(Timestamp flightTime) {
    DateTime dateTime = flightTime.toDate();
    return dateTime;
  }
