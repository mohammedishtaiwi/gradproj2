import 'dart:developer';
import 'package:flutter/material.dart';
import 'ticket_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Widget buildDividerBox(BuildContext context, String userId) {
  return Positioned(
    top: 1 / 3 * MediaQuery.of(context).size.height - 140,
    left: 5,
    right: 5,
    child: StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (userSnapshot.hasError) {
          return Text('Error: ${userSnapshot.error}');
        } else if (!userSnapshot.hasData || userSnapshot.data!.data() == null) {
          return const Text('User data not found.');
        } else {
          var userData = userSnapshot.data!.data() as Map<String, dynamic>;
          var bookedTickets = userData['bookedTickets'] ?? [];

          if (bookedTickets.isEmpty) {
            return Container(
              height: 130.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Card(
                elevation: 10,
                color: const Color.fromARGB(255, 48, 48, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Stack(
                  children: [
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          'No Flights Have Been Booked',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Tickets')
                .where(FieldPath.documentId, whereIn: bookedTickets)
                // .orderBy('bookingTime', descending: true)
                .limit(1)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Container(
                  height: 130.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: Card(
                    elevation: 10,
                    color: const Color.fromARGB(255, 48, 48, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Stack(
                      children: [
                        Positioned.fill(
                          child: Center(
                            child: Text(
                              'No Flights Have Been Booked',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                var ticketData =
                    snapshot.data!.docs.first.data() as Map<String, dynamic>;

                DateTime flightTime =
                    ticketData['flightTime']?.toDate() ?? DateTime.now();
                String formattedFlightTime =
                    DateFormat.yMMMd().format(flightTime);

                return Container(
                  height: 140.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: Card(
                    elevation: 10,
                    color: const Color.fromARGB(255, 62, 62, 62),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              formattedFlightTime,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '${ticketData['departureCity']}', //REPLACE WITH ABBRV
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: SizedBox(
                                  height: 8,
                                  width: 8,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.black, //DOT IN CIRCLE
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 24,
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return Flex(
                                              direction: Axis.horizontal,
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: List.generate(
                                                  (constraints.constrainWidth() /
                                                          6)
                                                      .floor(),
                                                  (index) => const SizedBox(
                                                        height: 1,
                                                        width: 3,
                                                        child: DecoratedBox(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white), // DASHED LINE
                                                        ),
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                      Center(
                                          child: Transform.rotate(
                                        angle: 1.5,
                                        child: const Icon(
                                          Icons.local_airport,
                                          color: Colors.white, //PLANE
                                          size: 24,
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.white, //SECOND CIRCLE
                                    borderRadius: BorderRadius.circular(20)),
                                child: SizedBox(
                                  height: 8,
                                  width: 8,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.black, //SECOND DOT IN CIRCLE
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                ' ${ticketData['arrivalCity']}', //REPLACE WITH ABBRV
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          Center(
                            child: Text(
                              '${ticketData['flightDuration']}', // REPLACE WITH FLIGHT TIME
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Flight Number ${ticketData['flightNumber']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => TicketDetailsPage(
                                        ticketData: ticketData,
                                        documentID:
                                            snapshot.data!.docs.first.id,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'View Ticket >',
                                  style: TextStyle(
                                    color: Colors
                                        .blue, // You can change the color as needed
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    ),
  );
}

Future<Map<String, dynamic>> getLatestBookedTicket() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Tickets')
        .orderBy('bookingTime', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data() as Map<String, dynamic>;
    } else {
      return {}; // Return an empty map if no booked tickets are found
    }
  } catch (e) {
    log(404 as String);
    return {}; // Return an empty map in case of an error
  }
}
