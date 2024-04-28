// ignore_for_file: camel_case_types, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:gradproj2/tripspagenaviggationbar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'homepage1.dart';

class tripsdetailpage extends StatefulWidget {
  final Map<String, dynamic> ticketData;
  final String documentID;
  tripsdetailpage({
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
            backgroundColor: notifire.backgroundallscreenColor,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const tripspageofnavigationbar(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4, top: 8),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: notifire.backbuttonborderColor),
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: notifire.backbuttoniconColor,
                        ),
                        iconSize: 14,
                        color: Colors.black,
                        onPressed: () {
                          Navigator.of(context).pop(
                            MaterialPageRoute(
                              builder: (BuildContext context) => const home1(),
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
                          Text(
                            '${widget.ticketData['departureCity']}',
                            style: TextStyle(
                                fontSize: 24,
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gilroy'),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                  height: 35,
                                  width: 112,
                                  child:
                                      Image.asset('assets/selectflight.png')),
                              Text(
                                '${widget.ticketData['flightDuration']}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                          Text(
                            '${widget.ticketData['arrivalCity']}',
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff768089)),
                                ),
                                Text(
                                  '${_formatFlightTime(widget.ticketData['flightDate'])}',
                                  style: TextStyle(
                                      color: notifire.getdarkscolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(thickness: 1),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Price',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Gilroy',
                                      color: Color(0xff768089)),
                                ),
                                Text(
                                  '${widget.ticketData['ticketPrice']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: notifire.getdarkscolor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Gilroy'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Gate',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color(0xff768089),
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      'B7',
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
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color(0xff768089),
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      'EY71',
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
                                      'Seat',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
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
                                      'Class',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color(0xff768089),
                                          fontFamily: 'Gilroy'),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      'Buisness',
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
                            const SizedBox(height: 38.78),
                            if (!isTicketBooked)
                              ElevatedButton(
                                onPressed: () {
                                  _bookTicket(context, widget.ticketData,
                                      widget.documentID);
                                },
                                child: const Text('Book'),
                              ),
                            if (isTicketBooked)
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                ),
                                onPressed: () {
                                  _undoBooking(context, widget.documentID);
                                },
                                child: const Text(
                                  'Undo Booking',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
      print('Booking document with $documentID');

      final DateTime now = DateTime.now();
      final Timestamp timestamp = Timestamp.fromDate(now);

      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(documentID)
          .update({
        'booked': true,
        'bookingTime': timestamp,
      });

      final currentUser = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({
        'bookedTickets': FieldValue.arrayUnion([documentID]),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ticket booked successfully!'),
        ),
      );

      Navigator.pop(context);
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
      print('Undoing booking for document with $documentID');

      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Tickets')
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
          batch.update(doc.reference, {
            'booked': false,
            'bookingTime': null,
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
}
