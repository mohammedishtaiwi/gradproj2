import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradproj2/pages/ticket_details_page.dart';
import 'package:gradproj2/tripsdetailsdetailpage.dart';

class BookedTicketsPage extends StatelessWidget {
  const BookedTicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not logged in.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Booked Tickets')),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
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
            var bookedTickets = userData['bookedTickets'] ?? [];

            if (bookedTickets.isEmpty) {
              return const Center(
                child: Text('No booked tickets available.'),
              );
            }

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Tickets')
                  .where(FieldPath.documentId, whereIn: bookedTickets)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No booked tickets available.'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var ticketData = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => tripsdetailpage(
                              ticketData: ticketData,
                              documentID: snapshot.data!.docs[index].id,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24))),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        '${ticketData['departureCity']}', //REPLACE WITH ABBRV
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: SizedBox(
                                          height: 8, // Your card content here

                                          width: 8,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors
                                                    .black, //DOT IN CIRCLE
                                                borderRadius:
                                                    BorderRadius.circular(5)),
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
                                                  builder:
                                                      (context, constraints) {
                                                    return Flex(
                                                      direction:
                                                          Axis.horizontal,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: List.generate(
                                                          (constraints.constrainWidth() /
                                                                  6)
                                                              .floor(),
                                                          (index) =>
                                                              const SizedBox(
                                                                height: 1,
                                                                width: 3,
                                                                child:
                                                                    DecoratedBox(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color:
                                                                              Colors.white), // DASHED LINE
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
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: SizedBox(
                                          height: 8,
                                          width: 8,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors
                                                    .black, //SECOND DO TIN CIRCLE
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        ' ${ticketData['arrivalCity']}', //REPLACE WITH ABBRV
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                          width: 100,
                                          child: Text(
                                            '${ticketData['departureCity']}',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          )),
                                      const Text(
                                        "6H 30M", // REPLACE WITH FLIGHT TIME
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                          width: 100,
                                          child: Text(
                                            '${ticketData['arrivalCity']}',
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '8:30 AM', //REPLACE WITH DEPARTURE TIME

                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "02:30 PM", //REPLACE WITH ARRIVAL TIME
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Text(
                                        "1 May 2020", //REPLACE WITH DATE
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Text(
                                            "Flight No: ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            '${ticketData['flightNumber']}',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.blueGrey,
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 20,
                                    width: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                          color:
                                              Colors.white), //SIDE CURVE LEFT
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          return Flex(
                                            direction: Axis.horizontal,
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                                (constraints.constrainWidth() /
                                                        10)
                                                    .floor(),
                                                (index) => const SizedBox(
                                                      height: 1,
                                                      width: 5,
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .white), //DASHED LINE
                                                      ),
                                                    )),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                    width: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          color:
                                              Colors.white), //SIDE CURVE RIGHT
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 12),
                              decoration: const BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.white, //CIRLE OF PLANE
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Icon(Icons.flight_land,
                                        color: Colors.black), //PLANE
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text('${ticketData['Airline']}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                  Expanded(
                                      child: Text(
                                          '${ticketData['ticketPrice']}',
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black))),
                                ],
                              ),
                            ),
                          ],
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
}
