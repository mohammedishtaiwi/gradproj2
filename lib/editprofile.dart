import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gradproj2/homepage1.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: camel_case_types
class editprofile extends StatefulWidget {
  final String profileImageUrl;
  final String currentName;
  final String currentUsername;
  final String currentPass;
  const editprofile(
      {Key? key,
      required this.profileImageUrl,
      required this.currentName,
      required this.currentUsername,
      required this.currentPass})
      : super(key: key);

  @override
  State<editprofile> createState() => _editprofileState();
}

// ignore: camel_case_types
class _editprofileState extends State<editprofile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? _user;
  bool _isVisible = true;
  late String _newName;
  late String _newUsername;
  late String _newPassword;
  // late String _profilePictureUrl = 'assets/default_profile_picture.png';
  final firstname = TextEditingController();
  final middlename = TextEditingController();
  final lastname = TextEditingController();
  // final gender = TextEditingController();
  // final nationality = TextEditingController();
  // ignore: non_constant_identifier_names
  //final date_of_birth = TextEditingController();
  final email = TextEditingController();
  // final firstdate = DateTime(1900, 1);
  // final lastdate = DateTime(2050, 12);
  // DateTime selectedDate = DateTime.now();
  final passwordController = TextEditingController();

  bool load = false;
  late File imgFile;
  final imagepicker = ImagePicker();

  @override
  void initState() {
    _user = _auth.currentUser;
    _newName = widget.currentName;
    _newUsername = widget.currentUsername;
    _newPassword = widget.currentPass;
    // _profilePictureUrl = widget.profileImageUrl.isNotEmpty
    //     ? widget.profileImageUrl
    //     : 'assets/default_profile_picture.png';

    // if (_profilePictureUrl == 'assets/default_profile_picture.png') {
    //   _fetchProfilePicture();
    // }
    if (_user != null) {
      _fetchUserData(_user!.uid);
    }
    super.initState();
  }

  late ColorNotifire notifire;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.backgroundallscreenColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (BuildContext context) => const home1(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 8),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                    iconSize: 14,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const home1(),
                        ),
                      );
                    },
                  ),
                ),
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            fontFamily: 'Gilroy',
          ),
        ), //
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FloatingActionButton.extended(
                label: const Text(
                  "Save Changes",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "gilroy"),
                ),
                onPressed: () {
                  _saveChanges(context);
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Color.fromARGB(255, 114, 151, 172),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FloatingActionButton.extended(
                label: const Text(
                  "Log Out",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "Gilroy"),
                ),
                onPressed: () {
                  _signOut(context);
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Color.fromARGB(255, 114, 151, 172),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      // onTap: _pickImage,
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/default_profile_picture.png')
                                as ImageProvider<Object>?,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        // onTap: _pickImage,
                        child: Container(
                          height: 43,
                          width: 43,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 114, 151, 172),
                            image: const DecorationImage(
                                image: AssetImage(
                                  "assets/Cameraeditprofile.png",
                                ),
                                scale: 20),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _newName = value;
                      });
                    },
                    controller: firstname,
                    style: TextStyle(
                        color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                      hintStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                      fillColor: Colors.white,
                      hintText: "Enter New Username",
                      labelText: "NAME",
                      labelStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _newUsername = value;
                      });
                    },
                    controller: email,
                    style: TextStyle(
                        color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                      hintStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                      fillColor: Colors.white,
                      hintText: 'Enter New Email',
                      labelText: "EMAIL",
                      labelStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _newPassword = value;
                      });
                    },
                    style: TextStyle(
                        color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    controller: passwordController,
                    obscureText: _isVisible,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: _isVisible
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                color: Colors.grey,
                              )
                            : const Icon(
                                Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                      ),
                      hintText: 'Enter New Password',
                      hintStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                      labelText: "PASSWORD",
                      labelStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'For feedback or inquiry please contact us at qaiaavatars@gmail.com',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey,
                        fontFamily: 'Gilroy'),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _profilePictureUrl = pickedFile.path;
  //     });
  //   }
  // }

  // Future<void> _fetchProfilePicture() async {
  //   try {
  //     final userData =
  //         await _firestore.collection('users').doc(_user?.uid).get();
  //     final profileImageUrl = userData.data()?['profileImageUrl'];
  //     setState(() {
  //       _profilePictureUrl =
  //           profileImageUrl ?? 'assets/default_profile_picture.png';
  //     });
  //   } catch (error) {
  //     print('Failed to fetch profile picture');
  //   }
  // }

  Future<void> _fetchUserData(String userId) async {
    try {
      final userData = await _firestore.collection('users').doc(userId).get();
      final fetchedEmail = userData.data()?['username'];
      final fetchedName = userData.data()?['name'];
      final fetchedPassword = userData.data()?['password'];

      email.text = fetchedEmail ?? '';
      firstname.text = fetchedName ?? '';
      passwordController.text = fetchedPassword ?? '';
      setState(() {
        _newUsername = fetchedEmail ?? '';
        _newName = fetchedName ?? '';
      });
    } catch (error) {
      print('Failed to fetch user data: $error');
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  Future<void> _saveChanges(BuildContext context) async {
    try {
      if (_newName != widget.currentName) {
        await _user?.updateDisplayName(_newName);
        await _firestore
            .collection('users')
            .doc(_user?.uid)
            .update({'name': _newName});
      }

      if (_newUsername != widget.currentUsername) {
        await _firestore
            .collection('users')
            .doc(_user?.uid)
            .update({'username': _newUsername});
      }
      if (_newPassword.isNotEmpty && _newPassword != widget.currentPass) {
        await _user?.updatePassword(_newPassword);
        await _firestore
            .collection('users')
            .doc(_user?.uid)
            .update({'password': _newPassword});
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );

      Navigator.pop(context);
    } catch (error) {
      log(error.toString());
    }
  }
}
