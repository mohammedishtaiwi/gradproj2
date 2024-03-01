import 'package:flutter/material.dart';
import 'package:gradproj2/Chatbot/chat_bot.dart';
import 'package:gradproj2/pages/BookedTicketsPage.dart';
import 'package:gradproj2/pages/profile_page.dart';
import 'package:gradproj2/pages/tickets.dart';

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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Profile Name",
                        style: TextStyle(
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
