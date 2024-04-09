import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradproj2/pages/tickets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'Sidebar.dart';
import 'latest_ticket_hp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> cities = [];
  String selectedDepartureCity = '';
  String selectedArrivalCity = '';
  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  bool isOneWaySelected = true;
  bool isRoundTripSelected = false;

  @override
  void initState() {
    super.initState();
    getUniqueCities().then((cities) {
      if (cities.isNotEmpty) {
        setState(() {
          selectedDepartureCity = cities.first;
          selectedArrivalCity = cities.first;
        });
      }
    });
  }

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String userId = currentUser!.uid;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          buildPopupMenuButton(context, (value) {
            if (value == 'logout') {
              _signOut(context);
            }
          }),
        ],
      ),
      drawer: buildDrawer(context, currentUser),
      body: Stack(
        children: [
          Column(
            children: [
              buildBlueSection(context),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          buildDividerBox(context, userId),
          buildSelectorBox(context),
        ],
      ),
    );
  }

  Widget buildDropdown({
    required String label,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        DropdownButton<String>(
          value: value,
          items: cities.map((city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(city),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget buildBlueSection(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      height: MediaQuery.of(context).size.height / 4,
      child: const Center(
        child: Text(
          '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(
      BuildContext context, Function(String) onSelected) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'logout',
          child: Text('Logout'),
        ),
      ],
    );
  }

// FLIGHT SELECTOR CODE
  Widget buildSelectorBox(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: FirebaseFirestore.instance.collection('Tickets').snapshots().map(
        (snapshot) {
          Set<String> uniqueCities = <String>{};
          for (var doc in snapshot.docs) {
            var ticketData = doc.data();
            uniqueCities.add(ticketData['departureCity']);
            uniqueCities.add(ticketData['arrivalCity']);
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

          return Positioned(
            top: 2 / 3 * MediaQuery.of(context).size.height - 265,
            left: 10,
            right: 10,
            bottom: 19,
            child: Container(
              height: 335.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey, // Change the color to blue grey
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Flight Selector',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                            color: Colors.white,
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
                            color: Colors.white,
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
                            color: Colors.white, //PLANE
                            size: 24,
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'From ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton<String>(
                          value: selectedDepartureCity,
                          items: cities.map((city) {
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
                            setState(() {
                              selectedDepartureCity = value!;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.swap_vert),
                          color: Colors.white,
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
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Center(
                            child: Transform.rotate(
                          angle: 1.9,
                          child: const Icon(
                            Icons.local_airport,
                            color: Colors.white, //PLANE
                            size: 24,
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'To ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton<String>(
                          value: selectedArrivalCity,
                          items: cities.map((city) {
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
                            setState(() {
                              selectedArrivalCity = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Departure',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (isRoundTripSelected)
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Return',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
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
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 0,
                          child: ElevatedButton(
                            onPressed: _searchFlights,
                            child: const Text(
                              "Search Flights",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
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
          );
        }
      },
    );
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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

  Future<List<String>> getUniqueCities() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Tickets').get();

      Set<String> uniqueCities = <String>{};

      for (var doc in querySnapshot.docs) {
        var ticketData = doc.data() as Map<String, dynamic>;
        uniqueCities.add(ticketData['departureCity']);
        uniqueCities.add(ticketData['arrivalCity']);
      }

      return uniqueCities.toList();
    } catch (e) {
      print('Error getting cities: $e');
      return []; // Return an empty list in case of an error
    }
  }
}
