import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradproj2/tripsdetailsdetailpage.dart';
import 'package:intl/intl.dart';

class TicketsPage extends StatelessWidget {
  final String? departureCity;
  final String? arrivalCity;
  final bool? isRoundTrip;
  final DateTime? selectedFromDate;
  final DateTime? selectedToDate;
  final bool isRoundTripSelected;
  final bool isOneWaySelected;

  const TicketsPage({
    Key? key,
    this.departureCity,
    this.arrivalCity,
    this.selectedFromDate,
    this.selectedToDate,
    this.isRoundTrip,
  })  : isRoundTripSelected = isRoundTrip ?? true,
        isOneWaySelected = !(isRoundTrip ?? true),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Flights')),
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Flights').snapshots(),
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

              bool isRoundTrip = data['two_way'] ?? false;
              bool isOneWay = data['one_way'] ?? false;

              bool isMatchingCities = data['Dep_city'] == departureCity &&
                  data['Arr_city'] == arrivalCity;
              bool isMatchingDate = false;

              if (isOneWay && selectedFromDate != null) {
                DateTime flightDate = data['Dep_date_time'].toDate();
                isMatchingDate = flightDate.year == selectedFromDate!.year &&
                    flightDate.month == selectedFromDate!.month &&
                    flightDate.day == selectedFromDate!.day;
              } else if (isRoundTrip &&
                  selectedFromDate != null &&
                  selectedToDate != null) {
                DateTime flightDate = data['Dep_date_time'].toDate();
                DateTime returnDate = data['Return_dep_date_time'].toDate();
                isMatchingDate = (flightDate.year == selectedFromDate!.year &&
                        flightDate.month == selectedFromDate!.month &&
                        flightDate.day == selectedFromDate!.day) &&
                    (returnDate.year == selectedToDate!.year &&
                        returnDate.month == selectedToDate!.month &&
                        returnDate.day == selectedToDate!.day);
              }
              return (isRoundTrip && isRoundTripSelected ||
                      isOneWay && isOneWaySelected) &&
                  isMatchingCities &&
                  isMatchingDate;
            }).toList();

            if (filteredFlights.isEmpty) {
              return const Center(
                child: Text('No flights available.'),
              );
            }

            return ListView(
              children: filteredFlights.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => tripsdetailpage(
                          ticketData: data,
                          documentID: document.id,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                    '${data['Dep_city']}',
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
                                            color: Colors.black, //DOT IN CIRCLE
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
                                              builder: (context, constraints) {
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
                                                      (index) => const SizedBox(
                                                            height: 1,
                                                            width: 3,
                                                            child: DecoratedBox(
                                                              decoration:
                                                                  BoxDecoration(
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
                                    ' ${data['Arr_city']}',
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
                                        '${data['Dep_city']}',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      )),
                                  Text(
                                    '${data['Flight_duration']}',
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                      width: 100,
                                      child: Text(
                                        '${data['Arr_city']}',
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
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
                                    data['Arr_date_time'] != null
                                        ? extractTimeFromTimestamp(
                                            data['Arr_date_time'])
                                        : '',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data['Dep_date_time'] != null
                                        ? extractTimeFromTimestamp(
                                            data['Dep_date_time'])
                                        : '',
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
                                    _formatFlightTime(data['Dep_date_time']),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "Flight No: ${data['Flight_ID']}",
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
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
                              Text(
                                '${data['Airline_Name']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              // CHANGE ACCORDING TO CLASS CHOSEN
                              // Expanded(
                              //   child: Text(
                              //     '${data['ticketPrice']}',
                              //     textAlign: TextAlign.end,
                              //     style: const TextStyle(
                              //       fontSize: 18,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  String extractTimeFromTimestamp(Timestamp flightTime) {
    DateTime dateTime = flightTime.toDate();
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  String _formatFlightTime(Timestamp flightTime) {
    DateTime dateTime = flightTime.toDate();
    String formattedTime = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedTime;
  }
}
