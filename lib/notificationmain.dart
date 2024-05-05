import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:gradproj2/homepage1.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _token;
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        _token = token;

        // print(_token);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return Scaffold(
        body: Center(
          child: Text('User not logged in.'),
        ),
      );
    }

    return Scaffold(
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
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
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
        automaticallyImplyLeading: false,
        title: const Text(
          "Flight Status Updates",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            fontFamily: 'Gilroy',
          ),
        ),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.data() == null) {
              return const Center(
                child: Text('User data not found.'),
              );
            }

            var userData = snapshot.data!.data() as Map<String, dynamic>;
            var bookedTickets =
                (userData['bookedTickets'] as List<dynamic>).cast<String>();

            if (bookedTickets.isEmpty) {
              return const Center(
                child: Text('No booked tickets available.'),
              );
            }

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchBookedFlights(bookedTickets),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No delayed or cancelled flights.'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var flightData = snapshot.data![index];
                    return Dismissible(
                      key: Key(flightData[
                          'Flight_ID']), // Unique key for each notification
                      direction: DismissDirection
                          .endToStart, // Swipe direction to dismiss
                      onDismissed: (direction) async {
                        setState(() {
                          snapshot.data!.removeAt(index);
                        });
                      },
                      background: Container(
                        color: Color.fromARGB(255, 243, 89,
                            78), // Background color when swiping to delete
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200], // Background color
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Flight Number: ${flightData['Flight_ID']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Gilroy',
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Status: ${flightData['Flight_status']}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Gilroy',
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Delete the notification
                                  setState(() {
                                    snapshot.data!.removeAt(index);
                                  });
                                },
                                child: const Icon(Icons.close),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchBookedFlights(
      List<String> bookedTickets) async {
    var bookedFlights = <Map<String, dynamic>>[];

    var flightsSnapshot = await FirebaseFirestore.instance
        .collection('Flights')
        .where(FieldPath.documentId, whereIn: bookedTickets)
        .get();

    flightsSnapshot.docs.forEach((flightDoc) {
      var flightData = flightDoc.data() as Map<String, dynamic>;
      if (flightData['Flight_status'] == 'Delayed' ||
          flightData['Flight_status'] == 'Cancelled') {
        bookedFlights.add({
          'Flight_ID': flightData['Flight_ID'],
          'Flight_status': flightData['Flight_status'],
        });

        // Send push notification
        _sendNotification();
      }
    });

    return bookedFlights;
  }

  void _sendNotification() {
    print('test succesful');
    // if (_token != null) {
    //   try {
    //     // Send notification using FirebaseMessaging
    //     FirebaseMessaging.instance.sendMessage(
    //       // Create a message
    //       data: {
    //         'title': 'Flight Update',
    //         'body': 'One or more of your flights has been updated.',
    //       },
    //       // Set the recipient token
    //       to: _token,
    //     );
    //   } catch (e) {
    //     print('Error sending notification: $e');
    //   }
    // } else {
    //   print('FCM token is null. Unable to send notification.');
    // }
  }
}
