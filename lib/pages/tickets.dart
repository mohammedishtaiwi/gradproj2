import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ticket_details_page.dart';
import 'package:intl/intl.dart';

class TicketsPage extends StatelessWidget {
  final String? departureCity;
  final String? arrivalCity;
  final bool? isRoundTrip;
  final bool isRoundTripSelected;
  final bool isOneWaySelected;
  // final DateTime? selectedDate;

  TicketsPage({
    Key? key,
    this.departureCity,
    this.arrivalCity,
    this.isRoundTrip,
  })  : isRoundTripSelected = isRoundTrip ?? true,
        isOneWaySelected = !(isRoundTrip ?? true),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Tickets')),
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

            List<DocumentSnapshot> filteredFlights =
                snapshot.data!.docs.where((document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              bool isRoundTrip = data['isroundtrip'] ?? false;
              bool isOneWay = data['isoneway'] ?? false;

              bool isMatchingCities = data['departureCity'] == departureCity &&
                  data['arrivalCity'] == arrivalCity;

              return (isRoundTrip && isRoundTripSelected ||
                      isOneWay && isOneWaySelected) &&
                  isMatchingCities;
            }).toList();

            if (filteredFlights.isEmpty) {
              return Center(
                child: Text('No flights available.'),
              );
            }

            return ListView(
              children: filteredFlights.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                bool isBooked = data['booked'] ?? false;

                if (!isBooked) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TicketDetailsPage(
                            ticketData: data,
                            documentID: document.id,
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
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '${data['departureCity']}', //REPLACE WITH ABBRV
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
                                                    direction: Axis.horizontal,
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
                                      ' ${data['arrivalCity']}', //REPLACE WITH ABBRV
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
                                          '${data['departureCity']}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        )),
                                    Text(
                                      '${data['flightDuration']}', // REPLACE WITH FLIGHT TIME
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                        width: 100,
                                        child: Text(
                                          '${data['arrivalCity']}',
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '${data['departureTime']}', //REPLACE WITH DEPARTURE TIME

                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${data['arrivalTime']}', //REPLACE WITH ARRIVAL TIME
                                      style: const TextStyle(
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
                                    Text(
                                      _formatFlightTime(data['flightDate']),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Flight No: ${data['flightNumber']}",
                                          style: const TextStyle(
                                              fontSize: 12,
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
                                        bottomRight: Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                    ),
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
                                            (constraints.constrainWidth() / 10)
                                                .floor(),
                                            (index) => const SizedBox(
                                              height: 1,
                                              width: 5,
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
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
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                    ),
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
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(34),
                                  ),
                                  child: const Icon(
                                    Icons.flight_land,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Text(
                                  "Jet Airways",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${data['ticketPrice']}',
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  bool _isSameDate(Timestamp flightDate, DateTime? selectedDate) {
    if (flightDate == null || selectedDate == null) {
      return false;
    }

    DateTime dateTime = flightDate.toDate();
    return dateTime.year == selectedDate.year &&
        dateTime.month == selectedDate.month &&
        dateTime.day == selectedDate.day;
  }
}

String _formatFlightTime(Timestamp flightTime) {
  DateTime dateTime = flightTime.toDate();
  String formattedTime = DateFormat('yyyy-MM-dd').format(dateTime);
  return formattedTime;
}
