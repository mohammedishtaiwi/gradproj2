import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gradproj2/pages/BookedTicketsPage.dart';
import 'package:gradproj2/pages/Chat_bot_page.dart';
import 'package:gradproj2/pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Chat()));
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
                        MaterialPageRoute(builder: (_) => const Profile()));
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
