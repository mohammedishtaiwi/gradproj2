import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String newUsername = '';
  String newPassword = '';
  String profilePictureUrl = ''; // You can replace this with the actual URL of the profile picture.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // CircleAvatar(
            //   radius: 50,
            //   backgroundImage: profilePictureUrl.isNotEmpty
            //       ? NetworkImage(profilePictureUrl)
            //       : AssetImage('assets/default_profile_picture.png'), // You can set a default profile picture.
            // ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement profile picture editing logic here.
              },
              child: Text('Change Profile Picture'),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  newUsername = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Change Username',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  newPassword = value;
                });
              },
              obscureText: true, // Use this for password fields to hide the entered text.
              decoration: InputDecoration(
                labelText: 'Change Password',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement logic to update the user's information with newUsername, newPassword, and profilePictureUrl.
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: EditProfilePage(),
    ),
  );
}
