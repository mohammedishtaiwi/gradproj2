import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradproj2/pages/BookedTicketsPage.dart';
import 'package:gradproj2/pages/profile_page.dart';
import 'ticket_details_page.dart';
import 'package:gradproj2/pages/tickets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

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

  Widget buildSelectorBox(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return StreamBuilder<List<String>>(
          stream:
              FirebaseFirestore.instance.collection('Tickets').snapshots().map(
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
                top: 2 / 3 * MediaQuery.of(context).size.height - 251,
                left: 10,
                right: 10,
                bottom: 19,
                child: Container(
                  height: 335.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(
                        255, 110, 131, 141), // Change the color to blue grey
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
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
      },
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Text(
            'Latest Booked Ticket',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDividerBox(BuildContext context, String userId) {
    return Positioned(
      top: 1 / 3 * MediaQuery.of(context).size.height - 140,
      left: 5,
      right: 5,
      child: StreamBuilder<DocumentSnapshot>(
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
                  .collection('Tickets')
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
                  var ticketData =
                      snapshot.data!.docs.first.data() as Map<String, dynamic>;

                  DateTime flightTime =
                      ticketData['flightTime']?.toDate() ?? DateTime.now();
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
                      color: const Color.fromARGB(255, 62, 62, 62),
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
                                  '${ticketData['departureCity']}', //REPLACE WITH ABBRV
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
                                      borderRadius: BorderRadius.circular(20)),
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
                                                mainAxisSize: MainAxisSize.max,
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
                                      borderRadius: BorderRadius.circular(20)),
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
                                  ' ${ticketData['arrivalCity']}', //REPLACE WITH ABBRV
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            Center(
                              child: Text(
                                '${ticketData['flightDuration']}', // REPLACE WITH FLIGHT TIME
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Flight Number ${ticketData['flightNumber']}',
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
                                        builder: (_) => TicketDetailsPage(
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
                                      color: Colors
                                          .blue, // You can change the color as needed
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

  Drawer buildDrawer(BuildContext context, User? user) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 48, 48, 48),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: firestore.collection('users').doc(user?.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final userData = snapshot.data?.data();
              final profileImageUrl = userData?['profileImageUrl'];

              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      bottom: 8,
                    ),
                    constraints: const BoxConstraints(maxWidth: 288),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 48, 48, 48),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            backgroundImage: profileImageUrl != null
                                ? NetworkImage(profileImageUrl)
                                : const AssetImage(
                                        'assets/default_profile_picture.png')
                                    as ImageProvider<Object>?,
                            child: profileImageUrl == null
                                ? const Icon(Icons.person_outline)
                                : null,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData?['name'] ?? "Profile Name",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: "Inter",
                                ),
                              ),
                              const SizedBox(height: 2),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white),
                  ListTile(
                    leading: const Icon(Icons.confirmation_number),
                    title: const Text(
                      'Booked Tickets',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BookedTicketsPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text(
                      'Chat',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      dynamic conversationObject = {
                        'appId': '1130b3f292a0ff1fcbfaadbaa81b21c96',
                        'withPreChat': true
                      };

                      KommunicateFlutterPlugin.buildConversation(
                              conversationObject)
                          .then((clientConversationId) {
                        print("Conversation builder success : " +
                            clientConversationId.toString());
                      }).catchError((error) {
                        print(
                            "Conversation builder error : " + error.toString());
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Profile()));
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getLatestBookedTicket() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Tickets')
          .orderBy('bookingTime', descending: true)
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
}
