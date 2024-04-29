import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfilePage extends StatefulWidget {
  final String profileImageUrl;
  final String currentName;
  final String currentUsername;

  const EditProfilePage({
    Key? key,
    required this.profileImageUrl,
    required this.currentName,
    required this.currentUsername,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? _user;

  late String _newName;
  late String _newUsername;
  late String _profilePictureUrl;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _newName = widget.currentName;
    _newUsername = widget.currentUsername;
    _profilePictureUrl = widget.profileImageUrl.isNotEmpty
        ? widget.profileImageUrl
        : 'assets/default_profile_picture.png';

    if (_profilePictureUrl == 'assets/default_profile_picture.png') {
      _fetchProfilePicture();
    }
  }

  Future<void> _saveChanges(BuildContext context) async {
    try {
      if (_profilePictureUrl != widget.profileImageUrl) {
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profile_pictures')
            .child('${_user?.uid}.jpg');

        final UploadTask uploadTask =
            storageReference.putFile(File(_profilePictureUrl));
        await uploadTask.whenComplete(() async {
          String downloadUrl = await storageReference.getDownloadURL();

          await _firestore
              .collection('users')
              .doc(_user?.uid)
              .update({'profileImageUrl': downloadUrl});
        });
      }

      // Update name if it's different from the current one
      if (_newName != widget.currentName) {
        await _user?.updateDisplayName(_newName);
        await _firestore
            .collection('users')
            .doc(_user?.uid)
            .update({'name': _newName});
      }

      // Update username if it's different from the current one
      if (_newUsername != widget.currentUsername) {
        await _firestore
            .collection('users')
            .doc(_user?.uid)
            .update({'username': _newUsername});
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );

      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profilePictureUrl.isNotEmpty
                      ? NetworkImage(_profilePictureUrl)
                      : const AssetImage('assets/default_profile_picture.png')
                          as ImageProvider<Object>?,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Change Profile Picture'),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _newName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Change Username',
                  hintText: widget.currentName,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _newUsername = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Change Email',
                  hintText: widget.currentUsername,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _saveChanges(context);
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePictureUrl = pickedFile.path;
      });
    }
  }

  Future<void> _fetchProfilePicture() async {
    try {
      final userData =
          await _firestore.collection('users').doc(_user?.uid).get();
      final profileImageUrl = userData.data()?['profileImageUrl'];
      setState(() {
        _profilePictureUrl =
            profileImageUrl ?? 'assets/default_profile_picture.png';
      });
    } catch (error) {
      print('Failed to fetch profile picture');
    }
  }
}
