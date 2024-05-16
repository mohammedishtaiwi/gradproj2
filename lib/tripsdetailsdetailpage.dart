// ignore_for_file: camel_case_types, sort_child_properties_last

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'pages/BookedTicketsPage.dart';
import 'homepage1.dart';

class tripsdetailpage extends StatefulWidget {
  final Map<String, dynamic> ticketData;
  final String documentID;
  const tripsdetailpage({
    Key? key,
    required this.ticketData,
    required this.documentID,
  }) : super(key: key);

  @override
  State<tripsdetailpage> createState() => _tripsdetailpageState();
}

class _tripsdetailpageState extends State<tripsdetailpage> {
  late ColorNotifire notifire;
  final currentUser = FirebaseAuth.instance.currentUser;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);

    log('Ticket Data: ${widget.ticketData}'); // Log ticket data

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // or any loading indicator
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        bool isTicketBooked = false;
        if (snapshot.hasData) {
          Map<String, dynamic>? userData =
              snapshot.data!.data() as Map<String, dynamic>?;
          if (userData != null && userData.containsKey('bookedTickets')) {
            List<dynamic>? bookedTickets = userData['bookedTickets'];
            if (bookedTickets != null) {
              isTicketBooked = bookedTickets.contains(widget.documentID);
            }
          }
        }

        return Scaffold(
          backgroundColor: notifire.backgroundallscreenColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const home1(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4, top: 8),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                        ),
                        iconSize: 14,
                        color: Colors.black,
                        onPressed: () {
                          Navigator.of(context).pop(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BookedTicketsPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            automaticallyImplyLeading: true,
            title: const Text(
              "Ticket Details",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontFamily: 'Gilroy',
              ),
            ), //
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 34),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Amman',
                            style: TextStyle(
                              fontSize: 24,
                              // color: notifire.getdarkscolor,
                              // fontWeight: FontWeight.w400,
                              // fontFamily: 'Gilroy'
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                  height: 35,
                                  width: 112,
                                  child:
                                      Image.asset('assets/selectflight.png')),
                              Text(
                                '${widget.ticketData['Flight_duration']}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                          Text(
                            '${widget.ticketData['Arr_city']}',
                            style: TextStyle(
                                fontSize: 24,
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 20, bottom: 20),
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 22),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: notifire.notificationbackground,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Date',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff768089),
                                    fontFamily: 'Gilroy',
                                  ),
                                ),
                                Text(
                                  _formatFlightTime(widget.ticketData['Dep_date_time']),
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Time',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff768089),
                                    fontFamily: 'Gilroy',
                                  ),
                                ),
                                Text(
                                  extractTimeFromTimestamp(
                                      widget.ticketData['Dep_date_time']),
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(thickness: 1),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Flight Status',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy',
                                      color: Color(0xff768089)),
                                ),
                                Text(
                                  '${widget.ticketData['Flight_status']}'
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: notifire.getdarkscolor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            if (widget.ticketData['Flight_status'] == "Delayed")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Text(
                                            'Updated Departure',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              color: Color(0xff768089),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            _formatFlightTime(widget.ticketData[
                                                'New_dep_date_time']),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: notifire.getdarkscolor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Gilroy',
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            extractTimeFromTimestamp(
                                                widget.ticketData[
                                                    'New_dep_date_time']),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: notifire.getdarkscolor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Gilroy',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 7),
                                  Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Text(
                                            'Updated Arrival',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gilroy',
                                              color: Color(0xff768089),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 7),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            _formatFlightTime(widget.ticketData[
                                                'New_arr_date_time']),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: notifire.getdarkscolor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Gilroy',
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            extractTimeFromTimestamp(
                                                widget.ticketData[
                                                    'New_arr_date_time']),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: notifire.getdarkscolor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Gilroy',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            const SizedBox(height: 12),
                            const Divider(thickness: 1),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Gate',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Color(0xff768089),
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      'B7', // STATIC VALUE
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Flight number',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Color(0xff768089),
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      '${widget.ticketData['Flight_ID']}',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Seat', // STATIC VALUE
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Color(0xff768089),
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      '21A',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Class', // STATIC VALUE
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Color(0xff768089),
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      'Crown',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(thickness: 1),
                            const SizedBox(height: 12),
                            //   if (widget.ticketData['Flight_status'] == "Crown Class")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Ticket Price',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xff768089),
                                          fontFamily: 'Gilroy'),
                                    ),
                                    Text(
                                      '${widget.ticketData['Ticket_crown_price']} JOD',
                                      style: TextStyle(
                                          color: notifire.getdarkscolor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            if (!isTicketBooked)
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 114, 151, 172)),
                                ),
                                onPressed: () {
                                  _bookTicket(context, widget.ticketData,
                                      widget.documentID);
                                },
                                child: const Text(
                                  'Book Ticket',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Gilroy',
                                  ),
                                ),
                              ),
                            if (isTicketBooked &&
                                widget.ticketData['Flight_status'] !=
                                    "Cancelled")
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 114, 151, 172)),
                                ),
                                onPressed: () {
                                  _undoBooking(context, widget.documentID);
                                },
                                child: const Text(
                                  'Cancel Booking',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Gilroy',
                                  ),
                                ),
                              ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _bookTicket(BuildContext context,
      Map<String, dynamic> ticketData, String documentID) async {
    try {
      // Get the FCM token of the user's device
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
        // Update the flight document to include the FCM token
        await FirebaseFirestore.instance
            .collection('Flights')
            .doc(documentID)
            .update({
          'booked': true,
          'bookingTime': FieldValue.serverTimestamp(),
          'fcm': FieldValue.arrayUnion([fcmToken]),
        });

        // Update the user document to include the booked flight ID
        final currentUser = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .update({
          'bookedTickets': FieldValue.arrayUnion([
            {"id": documentID, "date": ticketData["Dep_date_time"]}
          ]),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ticket booked successfully!'),
          ),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to get FCM token. Please try again.'),
          ),
        );
      }
    } catch (e) {
      print('Error booking ticket: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to book the ticket. Please try again.'),
        ),
      );
    }
  }

  Future<void> _undoBooking(BuildContext context, String documentID) async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();

      print('Undoing booking for document with $documentID');

      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Flights')
          .where('booked', isEqualTo: true)
          .get();

      if (snapshot.docs.length == 1) {
        // If only one ticket is booked, clear the array
        final currentUser = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .update({
          'bookedTickets': FieldValue.delete(),
        });
      }

      // Otherwise, update the specific ticket document
      if (snapshot.docs.isNotEmpty) {
        final batch = FirebaseFirestore.instance.batch();
        for (var doc in snapshot.docs) {
          var fcmData = doc.data() as Map<String, dynamic>;
          log("$fcmData");
          var tokens = fcmData["fcm"] as List<dynamic>;
          List<dynamic> bookedTokens = tokens;
          if (tokens.isNotEmpty) {
            if (bookedTokens.contains(fcmToken)) {
              bookedTokens.remove(fcmToken);
            }
          }
          // bookedTokens.add();
          batch.update(doc.reference, {
            'booked': false,
            'bookingTime': null,
            "fcm": bookedTokens,
          });
        }
        await batch.commit();
      }

      // Remove the undone ticket from the user's bookedTickets array
      final currentUser = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({
        'bookedTickets': FieldValue.arrayRemove([documentID]),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking undone successfully!'),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      print('Error undoing booking: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to undo booking. Please try again.'),
        ),
      );
    }
  }

  String _formatFlightTime(Timestamp flightTime) {
    DateTime dateTime = flightTime.toDate();

    String formattedTime = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedTime;
  }

  String extractTimeFromTimestamp(Timestamp flightTime) {
    DateTime dateTime = flightTime.toDate();
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }
}
