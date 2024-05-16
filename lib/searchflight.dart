// ignore_for_file: camel_case_types, sort_child_properties_last, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gradproj2/tripsdetailsdetailpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradproj2/pages/tickets.dart';
import 'package:intl/intl.dart';

class searchflight extends StatefulWidget {
  const searchflight({Key? key}) : super(key: key);

  @override
  State<searchflight> createState() => _searchflightState();
}

class _searchflightState extends State<searchflight>
    with SingleTickerProviderStateMixin {
  bool show = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> cities = [];
  String selectedDepartureCity = '';
  String selectedArrivalCity = '';
  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  bool isOneWaySelected = true;
  bool isRoundTripSelected = false;
  bool EconomyClassSelected = false;
  bool CrownClassSelected = true;
  @override
  void initState() {
    super.initState();
    getUniqueDepartureCity().then((city) {
      if (city.isNotEmpty) {
        setState(() {
          selectedDepartureCity = city;
        });
      }
    });

    getUniqueArrivalCity().then((city) {
      if (city.isNotEmpty) {
        setState(() {
          selectedArrivalCity = city;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    String userId = currentUser!.uid;
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Text(
                'Nearest Booked Ticket',
                style: TextStyle(
                    fontFamily: "gilroy",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          buildDividerBox(context, userId),
          buildSelectorBox(context),
        ],
      ),
    );
  }

  Widget buildDividerBox(BuildContext context, String userId) {
    return Stack(
      children: [
        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .snapshots(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (userSnapshot.hasError) {
              return Text('Error: ${userSnapshot.error}');
            } else if (!userSnapshot.hasData ||
                userSnapshot.data!.data() == null) {
              return const Text('User data not found.');
            } else {
              var userData = userSnapshot.data!.data() as Map<String, dynamic>;
              var bookedTickets = userData['bookedTickets'] ?? [];

              var bookedTicketsIds = [];
              for (var element in bookedTickets) {
                bookedTicketsIds.add(element["id"]);
              }

              if (bookedTickets.isEmpty) {
                return Container(
                  height: 130.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: Card(
                    elevation: 0,
                    color: const Color.fromARGB(255, 216, 230, 238),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const Stack(
                      children: [
                        Positioned.fill(
                          child: Center(
                            child: Text(
                              'Your upcoming flight will appear here',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Gilroy'),
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
                    .collection('Flights')
                    .where(FieldPath.documentId, whereIn: bookedTicketsIds)
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
                        elevation: 0,
                        color: const Color.fromARGB(255, 216, 230, 238),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: const Stack(
                          children: [
                            Positioned.fill(
                              child: Center(
                                child: Text(
                                  'Your upcoming flight will appear here',
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
                    var flights = snapshot.data!.docs;

                    // Sort the flights by departure date
                    flights.sort((a, b) {
                      DateTime dateA =
                          (a['Dep_date_time'] as Timestamp).toDate();
                      DateTime dateB =
                          (b['Dep_date_time'] as Timestamp).toDate();
                      return dateA.compareTo(dateB);
                    });

                    var ticketData =
                        flights.first.data() as Map<String, dynamic>;

                    return SizedBox(
                      child: Card(
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 500,
                              padding: const EdgeInsets.only(
                                  top: 16, left: 14, right: 14, bottom: 8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 193, 205, 213),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Amman',
                                        style: TextStyle(
                                            fontSize: 20,
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
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 129, 129, 129),
                                                fontFamily: 'Gilroy'),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${ticketData['Arr_city']}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Gilroy'),
                                      ),
                                    ],
                                  ),
                                  if (ticketData['Flight_status'] == 'Delayed')
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              ticketData['New_dep_date_time'] !=
                                                      null
                                                  ? extractTimeFromTimestamp(
                                                      ticketData[
                                                          'New_dep_date_time'])
                                                  : '',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
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
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Gilroy'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  if (ticketData['Flight_status'] != 'Delayed')
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              ticketData['Dep_date_time'] !=
                                                      null
                                                  ? extractTimeFromTimestamp(
                                                      ticketData[
                                                          'Dep_date_time'])
                                                  : '',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
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
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Gilroy'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(height: 5),
                                      // Text(
                                      //   'Flight Number: ${ticketData['Flight_ID']}',
                                      //   style: const TextStyle(
                                      //       color: Colors.black,
                                      //       fontSize: 16,
                                      //       fontWeight: FontWeight.w500,
                                      //       fontFamily: 'Gilroy'),
                                      // ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => tripsdetailpage(
                                                ticketData: ticketData,
                                                documentID: snapshot
                                                    .data!.docs.first.id,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'View Ticket >',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Gilroy',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ],
    );
  }

  List<String> ticketClasses = ['Economy', 'Crown'];
  int selectedIndex = 0; // Default selection index

  Widget buildSelectorBox(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return StreamBuilder<List<String>>(
          stream:
              FirebaseFirestore.instance.collection('Flights').snapshots().map(
            (snapshot) {
              Set<String> uniqueCities = <String>{};
              for (var doc in snapshot.docs) {
                var ticketData = doc.data();
                if (ticketData['Dep_city'] != null) {
                  uniqueCities.add(ticketData['Dep_city']);
                }
                if (ticketData['Arr_city'] != null) {
                  uniqueCities.add(ticketData['Arr_city']);
                }
              }
              return uniqueCities.toList();
            },
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No cities found.');
            } else {
              List<String> cities = snapshot.data!;

              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 429,
                      width: 372,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(80),
                          topRight: Radius.circular(80),
                          bottomLeft: Radius.circular(80),
                          bottomRight: Radius.circular(80),
                        ),
                        color: Color.fromARGB(255, 193, 205, 213),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, bottom: 5, top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isOneWaySelected = true;
                                      isRoundTripSelected = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isOneWaySelected
                                          ? Colors.blueGrey
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Text(
                                      'One Way',
                                      style: TextStyle(
                                          color: isOneWaySelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isOneWaySelected = false;
                                      isRoundTripSelected = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: !isOneWaySelected
                                          ? Colors.blueGrey
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Text(
                                      'Round Trip',
                                      style: TextStyle(
                                          color: !isOneWaySelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (isOneWaySelected)
                              const SizedBox(
                                height: 10,
                              ),
                            Row(
                              children: [
                                Transform.rotate(
                                  angle: 0.9,
                                  child: const Icon(
                                    Icons.local_airport,
                                    color: Color.fromARGB(255, 0, 0, 0), //PLANE
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: DropdownButton<String>(
                                    value: selectedArrivalCity.isNotEmpty
                                        ? selectedArrivalCity
                                        : null,
                                    items: cities
                                        .toSet()
                                        .where((city) =>
                                            city != selectedDepartureCity)
                                        .map((city) {
                                      return DropdownMenuItem<String>(
                                        value: city,
                                        child: Text(
                                          city,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: "gilroy",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "gilroy",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                    onChanged: (value) {
                                      if (value != null &&
                                          value != selectedArrivalCity) {
                                        setState(() {
                                          selectedArrivalCity = value;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text: selectedFromDate != null
                                          ? DateFormat.yMMMd()
                                              .format(selectedFromDate!)
                                          : '',
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Departure',
                                      labelStyle: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 17,
                                          fontFamily: 'Gilroy',
                                          fontWeight: FontWeight.w500),
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.calendar_month),
                                        color: Colors.black,
                                        onPressed: () {
                                          _selectDate(context, true);
                                        },
                                      ),
                                      // border: OutlineInputBorder(
                                      //   borderSide: const BorderSide(
                                      //       color:
                                      //           Color.fromARGB(255, 216, 230, 238)),
                                      //   borderRadius: BorderRadius.circular(8.0),
                                      // ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blueGrey),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (!isOneWaySelected)
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: TextEditingController(
                                        text: selectedToDate != null
                                            ? DateFormat.yMMMd()
                                                .format(selectedToDate!)
                                            : '',
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Return',
                                        labelStyle: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 17,
                                            fontFamily: 'Gilroy',
                                            fontWeight: FontWeight.w500),
                                        suffixIcon: IconButton(
                                          icon:
                                              const Icon(Icons.calendar_month),
                                          color: Colors.black,
                                          onPressed: () {
                                            _selectDate(context, false);
                                          },
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors
                                                  .blueGrey), // Ensure color is black
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:
                                  List.generate(ticketClasses.length, (index) {
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                              ticketClasses.length -
                                          16,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        color: selectedIndex == index
                                            ? Colors.blueGrey
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Center(
                                        child: Text(
                                          ticketClasses[index],
                                          style: TextStyle(
                                              color: selectedIndex == index
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      255, 0, 0, 0),
                                              fontSize: 16,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            // if (isOneWaySelected)
                            //   const SizedBox(
                            //     height: 10,
                            //   ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blueGrey),
                                        padding: MaterialStateProperty.all<
                                                EdgeInsetsGeometry>(
                                            const EdgeInsets.only(
                                                top: 10,
                                                bottom: 10,
                                                left: 30,
                                                right: 30)),
                                      ),
                                      onPressed: _searchFlights,
                                      child: const Text(
                                        "Search",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontFamily: 'Gilroy'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ]);
            }
          },
        );
      },
    );
  }

  Future<String> getUniqueDepartureCity() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Flights').get();

      Set<String> uniqueDepartureCities = <String>{};

      for (var doc in querySnapshot.docs) {
        var ticketData = doc.data() as Map<String, dynamic>;
        var departureCity = ticketData['Dep_city'] as String?;
        if (departureCity != null) {
          uniqueDepartureCities.add(departureCity);
        }
      }

      return uniqueDepartureCities.isNotEmpty
          ? uniqueDepartureCities.first
          : '';
    } catch (e) {
      print('Error getting departure city: $e');
      return ''; // Return an empty string in case of an error
    }
  }

  Future<String> getUniqueArrivalCity() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Flights').get();

      Set<String> uniqueArrivalCities = <String>{};

      for (var doc in querySnapshot.docs) {
        var ticketData = doc.data() as Map<String, dynamic>;
        var arrivalCity = ticketData['Arr_city'] as String?;
        if (arrivalCity != null) {
          uniqueArrivalCities.add(arrivalCity);
        }
      }

      return uniqueArrivalCities.isNotEmpty ? uniqueArrivalCities.first : '';
    } catch (e) {
      print('Error getting arrival city: $e');
      return ''; // Return an empty string in case of an error
    }
  }

  void _searchFlights() {
    if (isRoundTripSelected &&
        (selectedFromDate == null || selectedToDate == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both departure and return dates.'),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TicketsPage(
            departureCity: selectedDepartureCity.toString(),
            arrivalCity: selectedArrivalCity.toString(),
            isRoundTrip: isRoundTripSelected,
            selectedFromDate: selectedFromDate,
            selectedToDate: selectedToDate,
          ),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          selectedFromDate = picked;
          selectedToDate =
              null; // Reset the to date when changing the from date
        } else {
          selectedToDate = picked;
        }
      });
    }
  }

  String extractTimeFromTimestamp(Timestamp flightTime) {
    DateTime dateTime = flightTime.toDate();
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }
}
