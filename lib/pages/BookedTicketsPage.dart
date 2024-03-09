import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradproj2/pages/ticket_details_page.dart';

class BookedTicketsPage extends StatelessWidget {
  const BookedTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Booked Tickets')),
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Tickets').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

            List<Map<String, dynamic>> bookedTickets = snapshot.data!.docs
                .map((DocumentSnapshot document) =>
                    document.data() as Map<String, dynamic>)
                .where((ticket) => ticket['booked'] ?? false)
                .toList();

            return ListView.builder(
              itemCount: bookedTickets.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> data = bookedTickets[index];

                bool isBooked = data['booked'] ?? true;

                if (isBooked) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TicketDetailsPage(
                            ticketData: data,
                            documentID: snapshot.data!.docs[index].id,
                            isBooked: isBooked,
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
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    topRight: Radius.circular(24))),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '${data['departureCity']}', //REPLACE WITH ABBRV
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: SizedBox(
                                        height: 8,
                                        width: 8,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black, //DOT IN CIRCLE
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
                                                    children: List.generate(
                                                        (constraints.constrainWidth() /
                                                                6)
                                                            .floor(),
                                                        (index) => SizedBox(
                                                              height: 1,
                                                              width: 3,
                                                              child:
                                                                  DecoratedBox(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white), // DASHED LINE
                                                              ),
                                                            )),
                                                    direction: Axis.horizontal,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                  );
                                                },
                                              ),
                                            ),
                                            Center(
                                                child: Transform.rotate(
                                              angle: 1.5,
                                              child: Icon(
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
                                      padding: EdgeInsets.all(6),
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
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      ' ${data['arrivalCity']}', //REPLACE WITH ABBRV
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                        width: 100,
                                        child: Text(
                                          '${data['departureCity']}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        )),
                                    Text(
                                      "6H 30M", // REPLACE WITH FLIGHT TIME
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                        width: 100,
                                        child: Text(
                                          '${data['arrivalCity']}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
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
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "1 May 2020", //REPLACE WITH DATE
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Flight No: ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '${data['flightNumber']}',
                                          style: TextStyle(
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
                                SizedBox(
                                  height: 20,
                                  width: 10,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        color: Colors.white), //SIDE CURVE LEFT
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Flex(
                                          children: List.generate(
                                              (constraints.constrainWidth() /
                                                      10)
                                                  .floor(),
                                              (index) => SizedBox(
                                                    height: 1,
                                                    width: 5,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .white), //DASHED LINE
                                                    ),
                                                  )),
                                          direction: Axis.horizontal,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 10,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        color: Colors.white), //SIDE CURVE RIGHT
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 12),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white, //CIRLE OF PLANE
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(Icons.flight_land,
                                      color: Colors.black), //PLANE
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text("Jet Airways", //REPLACE WITH AIRLINES
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                                Expanded(
                                    child: Text('${data['ticketPrice']}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
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
                }
                return null;
              },
            );
          },
        ),
      ),
    );
  }
}
