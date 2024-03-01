import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradproj2/Chatbot/chat_bot.dart';
import 'package:gradproj2/pages/BookedTicketsPage.dart';
import 'package:gradproj2/pages/profile_page.dart';
import 'package:gradproj2/pages/tickets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import the intl package


class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        ],
      ),
    );
  }
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


// ...

Widget buildDividerBox(BuildContext context) {
  return Positioned(
    top: 1 / 3 * MediaQuery.of(context).size.height - 130,
    left: 0,
    right: 0,
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Tickets')
          .orderBy('bookingTime', descending: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No booked tickets found.');
        } else {
          var ticketData = snapshot.data!.docs.first.data() as Map<String, dynamic>;

          // Check if the ticket is booked
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
                  Text('No Flights Have Been Booked',
                    style: const TextStyle(
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

          // Format the flight time
          DateTime flightTime = ticketData['flightTime']?.toDate() ?? DateTime.now();
          String formattedFlightTime = DateFormat.yMMMd().add_jm().format(flightTime);

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
              child: Padding( 
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flight Number: ${ticketData['flightNumber']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Departure City: ${ticketData['departureCity']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Arrival City: ${ticketData['arrivalCity']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Flight Time: $formattedFlightTime',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
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
          // Divider between profile and menu items
          Divider(color: Colors.white),
          //MENU ITEMS
          ListTile(
            leading: Icon(Icons.event),
            title: const Text(
              'Tickets',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          TicketsPage())); // Navigate to Tickets page
            },
          ),
          ListTile(
            leading: Icon(Icons.confirmation_number),
            title: const Text(
              'Booked Tickets',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          BookedTicketsPage())); // Navigate to Tickets page
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: const Text(
              'Chat',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Home())); // Navigate to Tickets page
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Profile())); // Navigate to Tickets page
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
    print('Error retrieving latest booked ticket: $e');
    return {}; // Return an empty map in case of an error
  }
}
