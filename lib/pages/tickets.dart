import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradproj2/tripsdetailsdetailpage.dart';
import 'package:intl/intl.dart';
import 'package:gradproj2/homepage1.dart';

class TicketsPage extends StatelessWidget {
  final String departureCity;
  final String arrivalCity;
  final bool? isRoundTrip;
  final DateTime? selectedFromDate;
  final DateTime? selectedToDate;
  final bool isRoundTripSelected;
  final bool isOneWaySelected;

  const TicketsPage({
    Key? key,
    required this.departureCity,
    required this.arrivalCity,
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
                alignment: Alignment.center,
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
                          builder: (BuildContext context) => const home1(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "Tickets Available",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            fontFamily: 'Gilroy',
          ),
        ),
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

              bool isNotCancelled = (data['Flight_status'] != "Cancelled");

              bool isRoundTrip = data['two_way'] ?? false;
              bool isOneWay = data['one_way'] ?? false;

              bool isMatchingCities = data['Arr_city'] == arrivalCity;

              print(isMatchingCities);
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

              return isNotCancelled &&
                  ((isRoundTrip && isRoundTripSelected) ||
                      (isOneWay && isOneWaySelected)) &&
                  isMatchingCities &&
                  isMatchingDate;
            }).toList();

            if (filteredFlights.isEmpty) {
              return const Center(
                child: Text('No flights available'),
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
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 216, 230, 238),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24))),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Amman',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gilroy'),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                          height: 35,
                                          width: 112,
                                          child: Image.asset(
                                              'assets/selectflight.png')),
                                      Text(
                                        '${data['Flight_duration']}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 129, 129, 129),
                                            fontFamily: 'Gilroy'),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${data['Arr_city']}',
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Gilroy'),
                                  ),
                                ],
                              ),
                              if (data['Flight_status'] == 'Delayed')
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          data['New_dep_date_time'] != null
                                              ? extractTimeFromTimestamp(
                                                  data['New_dep_date_time'])
                                              : '',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Gilroy'),
                                        ),
                                        Text(
                                          data['New_arr_date_time'] != null
                                              ? extractTimeFromTimestamp(
                                                  data['New_arr_date_time'])
                                              : '',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Gilroy'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          _formatFlightTime(
                                              data['Dep_date_time']),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontFamily: 'Gilroy'),
                                        ),
                                        Text(
                                          "Flight No: ${data['Flight_ID']}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontFamily: 'Gilroy'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              if (data['Flight_status'] != 'Delayed')
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          data['Dep_date_time'] != null
                                              ? extractTimeFromTimestamp(
                                                  data['Dep_date_time'])
                                              : '',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Gilroy'),
                                        ),
                                        Text(
                                          data['Arr_date_time'] != null
                                              ? extractTimeFromTimestamp(
                                                  data['Arr_date_time'])
                                              : '',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Gilroy'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          _formatFlightTime(
                                              data['Dep_date_time']),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontFamily: 'Gilroy'),
                                        ),
                                        Text(
                                          "Flight No: ${data['Flight_ID']}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontFamily: 'Gilroy'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (data['Flight_status'] == "Delayed" ||
                                  data['Flight_status'] == "Cancelled")
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 20),
                                    Text(
                                      '${data['Flight_status']}'.toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Gilroy'),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        Container(
                          color: const Color.fromARGB(255, 216, 230, 238),
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
                                      color: Colors.white), //SIDE CURVE LEFT
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
                                      color: Colors.white), //SIDE CURVE RIGHT
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 12),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 216, 230, 238),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(0.5),
                                decoration: const BoxDecoration(
                                  color: Colors
                                      .white, // Background color for the circular shape
                                  shape:
                                      BoxShape.circle, // Shape of the container
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/RJ2.png',
                                    height: 47, // Adjust the size as needed
                                    width: 47, // Adjust the size as needed
                                    fit: BoxFit
                                        .cover, // Ensure the image covers the circular area
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 10,
                              ),
                              Text('${data['Airline_Name']}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontFamily: 'Gilroy')),
                              // MUST BE CHANGED DEPENDING ON CLASS CHOSEN
                              Expanded(
                                  child: Text(
                                      '${data['Ticket_crown_price']} JOD',
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontFamily: 'Gilroy'))),
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
