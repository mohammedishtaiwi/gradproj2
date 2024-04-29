// ignore_for_file: camel_case_types, sort_child_properties_last

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:gradproj2/tripsdetailsdetailpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  late ColorNotifire notifire;
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    String userId = currentUser!.uid;
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
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
                    .collection('Flights')
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
                    var ticketData = snapshot.data!.docs.first.data()
                        as Map<String, dynamic>;

                    DateTime flightTime =
                        ticketData['Dep_date_time']?.toDate() ?? DateTime.now();
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
                        color: Color.fromARGB(255, 68, 85, 93),
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
                                    '${ticketData['Dep_city']}',
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
                                                .black, //SECOND DOT IN CIRCLE
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    ' ${ticketData['Arr_city']}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              Center(
                                child: Text(
                                  '${ticketData['Flight_duration']}',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Flight Number ${ticketData['Flight_ID']}',
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
                                          builder: (_) => tripsdetailpage(
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
                                        color: Color.fromARGB(255, 106, 160,
                                            225), // You can change the color as needed
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
      ],
    );
  }

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

              return Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(
                        255, 228, 231, 235), // Change the color to blue grey
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 13.0, right: 13.0, top: 5, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: true,
                              groupValue: isOneWaySelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  isOneWaySelected = value ?? false;
                                  isRoundTripSelected = !isOneWaySelected;
                                });
                              },
                            ),
                            const Text(
                              'One Way',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16,
                              ),
                            ),
                            Radio(
                              value: true,
                              groupValue: isRoundTripSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  isRoundTripSelected = value ?? false;
                                  isOneWaySelected = !isRoundTripSelected;
                                });
                              },
                            ),
                            const Text(
                              'Round Trip',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Center(
                                child: Transform.rotate(
                              angle: 1,
                              child: const Icon(
                                Icons.local_airport,
                                color: Color.fromARGB(255, 0, 0, 0), //PLANE
                                size: 24,
                              ),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'From ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              value: selectedDepartureCity.isNotEmpty
                                  ? selectedDepartureCity
                                  : null,
                              items: cities
                                  .toSet() // Deduplicate the list of cities
                                  .where((city) =>
                                      city !=
                                      selectedArrivalCity) // Filter out selected arrival city
                                  .map((city) {
                                return DropdownMenuItem<String>(
                                  value: city,
                                  child: Text(
                                    city,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null &&
                                    value != selectedDepartureCity) {
                                  setState(() {
                                    selectedDepartureCity = value;
                                  });
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.swap_vert),
                              color: const Color.fromARGB(255, 0, 0, 0),
                              onPressed: () {
                                setState(() {
                                  final temp = selectedDepartureCity;
                                  selectedDepartureCity = selectedArrivalCity;
                                  selectedArrivalCity = temp;
                                });
                              },
                            ),
                          ],
                        ),
                        // const SizedBox(height: 5),
                        Row(
                          children: [
                            Center(
                                child: Transform.rotate(
                              angle: 1.9,
                              child: const Icon(
                                Icons.local_airport,
                                color: Color.fromARGB(255, 0, 0, 0), //PLANE
                                size: 24,
                              ),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'To ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              value: selectedArrivalCity.isNotEmpty
                                  ? selectedArrivalCity
                                  : null,
                              items: cities
                                  .toSet() // Deduplicate the list of cities
                                  .where((city) =>
                                      city !=
                                      selectedDepartureCity) // Filter out selected departure city
                                  .map((city) {
                                return DropdownMenuItem<String>(
                                  value: city,
                                  child: Text(
                                    city,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null &&
                                    value != selectedArrivalCity) {
                                  setState(() {
                                    selectedArrivalCity = value;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        // const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text(
                              'Departure',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.calendar_month),
                              color: Colors.black,
                              onPressed: () {
                                _selectDate(context, true);
                              },
                            ),
                            Text(
                              selectedFromDate != null
                                  ? DateFormat.yMMMd().format(selectedFromDate!)
                                  : '',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (isRoundTripSelected)
                          Row(
                            children: [
                              const Text(
                                'Return',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.calendar_month),
                                color: Colors.black,
                                onPressed: () {
                                  _selectDate(context, false);
                                },
                              ),
                              Text(
                                selectedToDate != null
                                    ? DateFormat.yMMMd().format(selectedToDate!)
                                    : '',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Class',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16,
                              ),
                            ),
                            Radio(
                              value: true,
                              groupValue: EconomyClassSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  EconomyClassSelected = value ?? false;
                                  CrownClassSelected = !EconomyClassSelected;
                                });
                              },
                            ),
                            const Text(
                              'Economy',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16,
                              ),
                            ),
                            Radio(
                              value: true,
                              groupValue: CrownClassSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  CrownClassSelected = value ?? false;
                                  EconomyClassSelected = !CrownClassSelected;
                                });
                              },
                            ),
                            const Text(
                              'Crown',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16,
                              ),
                            ),
                          ],
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
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                  onPressed: _searchFlights,
                                  child: const Text(
                                    "Search Flights",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
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
            departureCity: selectedDepartureCity,
            arrivalCity: selectedArrivalCity,
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

  Future<Map<String, dynamic>> getLatestBookedTicket() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Flights')
          .orderBy('is_booked_time', descending: true)
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
}
