import 'package:flutter/material.dart';
import 'package:gradproj2/pages/BookedTicketsPage.dart';
import 'package:gradproj2/pages/tickets.dart';

Widget buildBlueSection(BuildContext context) {
  return Container(
    color: Colors.lightBlue,
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
    top: 1 / 3 * MediaQuery.of(context).size.height - 130.0,
    left: 0,
    right: 0,
    child: Container(
      height: 130.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 48, 48, 48),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10),
    ),
  );
}

PopupMenuButton<String> buildPopupMenuButton(BuildContext context, Function(String) onSelected) {
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
      child: ListView(
        padding: const EdgeInsets.only(top: 50),
        children: <Widget>[
          ListTile(
            title: const Text(
              'Tickets',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
           onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(context, MaterialPageRoute(builder: (_) => TicketsPage())); // Navigate to Tickets page
            },
          ),
           ListTile(
            title: const Text(
              'Booked Tickets',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
           onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(context, MaterialPageRoute(builder: (_) => BookedTicketsPage())); // Navigate to Tickets page
            },
          ),
          // Add more list tiles as needed
        ],
      ),
    ),
  );
}
