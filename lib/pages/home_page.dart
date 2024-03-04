import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradproj2/Chatbot/chat_bot.dart';
import 'package:gradproj2/pages/BookedTicketsPage.dart';
import 'package:gradproj2/pages/profile_page.dart';
import 'ticket_details_page.dart';
import 'package:gradproj2/pages/tickets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

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
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize the selected cities here
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
      drawer: buildDrawer(context),
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
          buildDividerBox(context),
          buildselectorBox(context),
        ],
      ),
    );
  }

  Widget buildselectorBox(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: FirebaseFirestore.instance.collection('Tickets').snapshots().map(
        (snapshot) {
          Set<String> uniqueCities = Set<String>();
          snapshot.docs.forEach((doc) {
            var ticketData = doc.data() as Map<String, dynamic>;
            uniqueCities.add(ticketData['departureCity']);
            uniqueCities.add(ticketData['arrivalCity']);
          });
          return uniqueCities.toList();
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No cities found.');
        } else {
          List<String> cities = snapshot.data!;

          return Positioned(
            top: 2 / 3 * MediaQuery.of(context).size.height - 250,
            left: 10,
            right: 10,
            child: Container(
              height: 350.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 48, 48, 48),
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
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'From:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedDepartureCity,
                          items: cities.map((city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDepartureCity = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'To:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedArrivalCity,
                          items: cities.map((city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
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
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Date:  ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text(
                            selectedDate != null
                                ? DateFormat.yMMMd().format(selectedDate!)
                                : 'Select Date',
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
          style: TextStyle(
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

  Widget buildDividerBox(BuildContext context) {
    return Positioned(
      top: 1 / 3 * MediaQuery.of(context).size.height - 130,
      left: 5,
      right: 5,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Tickets')
            .orderBy('bookingTime', descending: true)
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('No booked tickets found.');
          } else {
            var ticketData =
                snapshot.data!.docs.first.data() as Map<String, dynamic>;

            bool isBooked = ticketData['booked'] ?? false;

            if (!isBooked) {
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No Flights Have Been Booked',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            DateTime flightTime =
                ticketData['flightTime']?.toDate() ?? DateTime.now();
            String formattedFlightTime = DateFormat.yMMMd().format(flightTime);

            return Container(
              height: 140.0,
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
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '$formattedFlightTime',
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
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                              height: 8,
                              width: 8,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Colors.black, //DOT IN CIRCLE
                                    borderRadius: BorderRadius.circular(5)),
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
                                          children: List.generate(
                                              (constraints.constrainWidth() / 6)
                                                  .floor(),
                                              (index) => SizedBox(
                                                    height: 1,
                                                    width: 3,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .white), // DASHED LINE
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
                                borderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                              height: 8,
                              width: 8,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Colors.black, //SECOND DO TIN CIRCLE
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            ' ${ticketData['arrivalCity']}', //REPLACE WITH ABBRV
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                      Center(
                        child: Text(
                          '${ticketData['flightDuration']}', // REPLACE WITH FLIGHT TIME
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
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
                                    documentID: snapshot.data!.docs.first.id,
                                    isBooked: isBooked,
                                  ),
                                ),
                              );
                            },
                            child: Text(
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

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 48, 48, 48),
        child: Column(
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
                      child: const Icon(Icons.person_outline),
                    ),
                    const SizedBox(width: 8),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile Name",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: "Inter",
                          ),
                        ),
                        SizedBox(height: 2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: Colors.white),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text(
                'Tickets',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TicketsPage()));
              },
            ),
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
                        builder: (_) => const BookedTicketsPage()));
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
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Home()));
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Profile()));
              },
            ),
          ],
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

      Set<String> uniqueCities = Set<String>();

      querySnapshot.docs.forEach((doc) {
        var ticketData = doc.data() as Map<String, dynamic>;
        uniqueCities.add(ticketData['departureCity']);
        uniqueCities.add(ticketData['arrivalCity']);
      });

      return uniqueCities.toList();
    } catch (e) {
      print('Error getting cities: $e');
      return []; // Return an empty list in case of an error
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: currentDate.add(const Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}
