import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradproj2/pages/BookedTicketsPage.dart';
import 'package:gradproj2/pages/edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.popAndPushNamed(context, '/');
  }

  Future<void> _changePassword(BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: _user!.email!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password reset email sent. Check your inbox.'),
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to send password reset email: $error'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final userData =
                  await _firestore.collection('users').doc(_user?.uid).get();
              final profileImageUrl = userData.data()?['profileImageUrl'];
              final currentName = userData.data()?['name'];
              final currentUsername = userData.data()?['username'];

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProfilePage(
                    profileImageUrl: profileImageUrl ?? '',
                    currentName: currentName ?? '',
                    currentUsername: currentUsername ?? '',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _firestore.collection('users').doc(_user?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final userData = snapshot.data?.data();
            final profileImageUrl = userData?['profileImageUrl'];
            final name = userData?['name'];
            final email = _user?.email;

            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: profileImageUrl != null
                            ? NetworkImage(profileImageUrl)
                            : const AssetImage('assets/placeholder_image.png')
                                as ImageProvider<Object>?,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        name ?? 'User Name',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        email ?? 'user@example.comm',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const BookedTicketsPage(),
                                ),
                              );
                            },
                            child: const Text('Booked Tickets'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _changePassword(context);
                            },
                            child: const Text('Change Password'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _signOut(context);
                            },
                            child: const Text('Log Out'),
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
}
