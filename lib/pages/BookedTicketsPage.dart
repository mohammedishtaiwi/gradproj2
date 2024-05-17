import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:gradproj2/helpers/date.dart';
import 'package:gradproj2/tripsdetailsdetailpage.dart';
import 'package:intl/intl.dart';

class BookedTicketsPage extends StatefulWidget {
  const BookedTicketsPage({Key? key}) : super(key: key);

  @override
  State<BookedTicketsPage> createState() => _BookedTicketsPageState();
}

class _BookedTicketsPageState extends State<BookedTicketsPage> {
  int totalAmount = 0;
  int bookedTicketCount = 0; // New variable to store booked ticket count

  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
  }

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
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Booked Tickets",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              fontFamily: 'Gilroy',
            ),
          ),
        ),
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

            log("$bookedTickets");
            var bookedTicketsIds = [];
            for (var element in bookedTickets) {
              bookedTicketsIds.add(element["id"]);
            }
            if (bookedTickets.isEmpty) {
              return const Center(
                child: Text('No booked tickets available.'),
              );
            }

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Flights')
                  .where(FieldPath.documentId, whereIn: bookedTicketsIds)
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
                    child: Text('No booked tickets available'),
                  );
                }
                var apiData = [];
                for (var element in snapshot.data!.docs) {
                  apiData.add(element.data());
                }
                apiData.sort((a, b) {
                  DateTime dateA = timestampToDateTime(a['Dep_date_time']);
                  DateTime dateB = timestampToDateTime(b['Dep_date_time']);
                  return dateA.compareTo(dateB);
                });

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: apiData.length,
                        itemBuilder: (BuildContext context, int index) {
                          var ticketData =
                              apiData[index] as Map<String, dynamic>;
                          if ((ticketData['Arr_date_time'] as Timestamp)
                              .toDate()
                              .isBefore(DateTime.now())) {
                            return Container();
                          } else {
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
                                      padding: const EdgeInsets.only(
                                          top: 16, left: 16, right: 16),
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 216, 230, 238),
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
                                                    '${ticketData['Flight_duration']}',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 129, 129, 129),
                                                        fontFamily: 'Gilroy'),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '${ticketData['Arr_city']}',
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Gilroy'),
                                              ),
                                            ],
                                          ),
                                          if (ticketData['Flight_status'] ==
                                              'Delayed')
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      ticketData['New_dep_date_time'] !=
                                                              null
                                                          ? extractTimeFromTimestamp(
                                                              ticketData[
                                                                  'New_dep_date_time'])
                                                          : '',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Gilroy'),
                                                    ),
                                                    Text(
                                                      ticketData['New_arr_date_time'] !=
                                                              null
                                                          ? extractTimeFromTimestamp(
                                                              ticketData[
                                                                  'New_arr_date_time'])
                                                          : '',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Gilroy'),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                          if (ticketData['Flight_status'] !=
                                              'Delayed')
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      ticketData['Dep_date_time'] !=
                                                              null
                                                          ? extractTimeFromTimestamp(
                                                              ticketData[
                                                                  'Dep_date_time'])
                                                          : '',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Gilroy'),
                                                    ),
                                                    Text(
                                                      ticketData['Arr_date_time'] !=
                                                              null
                                                          ? extractTimeFromTimestamp(
                                                              ticketData[
                                                                  'Arr_date_time'])
                                                          : '',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Gilroy'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          if (ticketData['Flight_status'] ==
                                                  "Delayed" ||
                                              ticketData['Flight_status'] ==
                                                  "Cancelled")
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 20),
                                                Text(
                                                  '${ticketData['Flight_status']}'
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Gilroy'),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: const Color.fromARGB(
                                          255, 216, 230, 238),
                                      child: Row(
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 20,
                                            width: 10,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  color: Colors
                                                      .white), //SIDE CURVE LEFT
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                                10)
                                                            .floor(),
                                                        (index) =>
                                                            const SizedBox(
                                                              height: 1,
                                                              width: 5,
                                                              child:
                                                                  DecoratedBox(
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10)),
                                                  color: Colors
                                                      .white), //SIDE CURVE RIGHT
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16, bottom: 12),
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 216, 230, 238),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15))),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.all(0.5),
                                            decoration: const BoxDecoration(
                                              color: Colors
                                                  .white, // Background color for the circular shape
                                              shape: BoxShape
                                                  .circle, // Shape of the container
                                            ),
                                            child: ClipOval(
                                              child: Image.asset(
                                                'assets/RJ2.png',
                                                height: 47,
                                                width: 47,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text('${ticketData['Airline_Name']}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontFamily: 'Gilroy')),
                                          // MUST BE CHANGED DEPENDING ON CLASS CHOSEN
                                          Expanded(
                                              child: Text(
                                                  '${ticketData['Ticket_crown_price']} JOD',
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                      fontFamily: 'Gilroy'))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            if (!(!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty))
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 216, 230, 238)),
                                ),
                                onPressed: () async {
                                  await fetchTotalAmount();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          UsePaypal(
                                              sandboxMode: true,
                                              clientId:
                                                  "AWSmR0_iZMCQDbq4REl_YFPE31z8xTPWl0ZyiFNxz4DvkTKWhQYN3mY_6zGXBZDY3znEE0wRsVd1uefV",
                                              secretKey:
                                                  "EDeMBp2b7DD7cT4y1Qhc7QS5fTTfjSEtcfCw1yuam9B_K4gav0M7W-xO1FaoJYnWmwh58l5nhGP0nN1k",
                                              returnURL:
                                                  "https://samplesite.com/return",
                                              cancelURL:
                                                  "https://samplesite.com/cancel",
                                              transactions: [
                                                {
                                                  "amount": {
                                                    "total": '$totalAmount',
                                                    "currency": "USD",
                                                    "details": {
                                                      "subtotal":
                                                          '$totalAmount',
                                                      "shipping": '0',
                                                      "shipping_discount": 0
                                                    }
                                                  },
                                                  "description":
                                                      "The payment transaction description.",
                                                  "item_list": {
                                                    "items": [
                                                      {
                                                        "name":
                                                            "A demo product",
                                                        "quantity": 1,
                                                        "price": '$totalAmount',
                                                        "currency": "USD"
                                                      }
                                                    ],
                                                  }
                                                }
                                              ],
                                              note:
                                                  "Contact us for any questions on your order.",
                                              onSuccess: (Map params) async {
                                                print("onSuccess: $params");
                                              },
                                              onError: (error) {
                                                print("onError: $error");
                                              },
                                              onCancel: (params) {
                                                print('cancelled: $params');
                                              }),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Pay Now',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontFamily: 'Gilroy'),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
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

  Future<void> fetchBookedTicketCount() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userSnapshot.exists) {
          List<dynamic> bookedTickets = userSnapshot['bookedTickets'];
          setState(() {
            bookedTicketCount = bookedTickets.length;
          });
        }
      } catch (error) {
        print('Error fetching booked ticket count: $error');
      }
    }
  }

  Future<void> fetchTotalAmount() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userSnapshot.exists) {
          List<dynamic> bookedTickets = userSnapshot['bookedTickets'];

          int total = 0;
          for (var ticket in bookedTickets) {
            DocumentSnapshot ticketSnapshot = await FirebaseFirestore.instance
                .collection('Flights')
                .doc(ticket['id'])
                .get();

            if (ticketSnapshot.exists &&
                ticketSnapshot['Flight_status'] != 'Cancelled') {
              var ticketPrice = ticketSnapshot['Ticket_crown_price'];
              if (ticketPrice is int) {
                total += ticketPrice;
              } else if (ticketPrice is num) {
                total += ticketPrice.toInt();
              }
            }
          }

          setState(() {
            totalAmount = total;
          });

          print(totalAmount);
        }
      } catch (error) {
        print('Error fetching total amount: $error');
      }
    }
  }
}
