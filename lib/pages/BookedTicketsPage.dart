import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradproj2/PayPalPaymentPage.dart';
import 'package:gradproj2/tripsdetailsdetailpage.dart';
import 'package:intl/intl.dart';

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

            if (bookedTickets.isEmpty) {
              return const Center(
                child: Text('No booked tickets available.'),
              );
            }

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Flights')
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

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var ticketData = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
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
                                              Text(
                                                '${ticketData['Dep_city']}',
                                                style: const TextStyle(
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
                                      color: Color.fromARGB(255, 216, 230, 238),
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
                                                height:
                                                    47, // Adjust the size as needed
                                                width:
                                                    47, // Adjust the size as needed
                                                fit: BoxFit
                                                    .cover, // Ensure the image covers the circular area
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
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 216, 230, 238)),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const CheckoutPage(),
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
}
