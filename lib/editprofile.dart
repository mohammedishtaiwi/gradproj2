import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gradproj2/homepage1.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  const editprofile(
      {Key? key,
      required this.profileImageUrl,
      required this.currentName,
      required this.currentUsername})
      : super(key: key);

  @override
  State<editprofile> createState() => _editprofileState();
}

// ignore: camel_case_types
class _editprofileState extends State<editprofile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User? _user;

  late String _newName;
  late String _newUsername;
  late String _profilePictureUrl = 'assets/default_profile_picture.png';
  final firstname = TextEditingController();
  final middlename = TextEditingController();
  final lastname = TextEditingController();
  final gender = TextEditingController();
  final nationality = TextEditingController();
  // ignore: non_constant_identifier_names
  final date_of_birth = TextEditingController();
  final email = TextEditingController();
  final firstdate = DateTime(1900, 1);
  final lastdate = DateTime(2050, 12);
  DateTime selectedDate = DateTime.now();

  bool load = false;
  late File imgFile;
  final imagepicker = ImagePicker();

  // Widget displayimage() {
  //   if (imgFile == null){
  //     return Text("No Image selected");
  //   }
  //
  // }

  List<String> items = [
    'MALE',
    'FEMALE',
  ];

  List<String> items2 = [
    'England',
    'USA',
    'India',
    'Pakistan',
    'Canada',
    'Germany',
    'Afghanistan',
    'South Africa',
    'Dubai'
        'Paris'
        'Ireland'
        'Sri Lanka'
        'Australia'
        'Singapore'
  ];

  String? selectedValue;
  String? selectedValue2;

  @override
  void initState() {
    // TODO: implement initState
    selectedValue = items.first;
    selectedValue2 = items2.first;
    _user = _auth.currentUser;
    _newName = widget.currentName;
    _newUsername = widget.currentUsername;
    _profilePictureUrl = widget.profileImageUrl.isNotEmpty
        ? widget.profileImageUrl
        : 'assets/default_profile_picture.png';

    if (_profilePictureUrl == 'assets/default_profile_picture.png') {
      _fetchProfilePicture();
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

  Future<void> _saveChanges(BuildContext context) async {
    try {
      // Upload new profile picture if it's different from the current one
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
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.backgroundallscreenColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: notifire.backgroundallscreenColor,
        automaticallyImplyLeading: false,
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
                    border: Border.all(color: notifire.backbuttonborderColor),
                    borderRadius: BorderRadius.circular(16)),
                alignment: Alignment.center,
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: notifire.backbuttoniconColor,
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
              ),
            ),
          ),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: FloatingActionButton.extended(
            label: const Text(
              "SAVE CHANGES",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.blueAccent.shade400,
            onPressed: () {
              _saveChanges(context);
            },
          ),
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
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _profilePictureUrl.isNotEmpty
                            ? NetworkImage(_profilePictureUrl)
                            : const AssetImage(
                                    'assets/default_profile_picture.png')
                                as ImageProvider<Object>?,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 43,
                          width: 43,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xff1F75EC),
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
                      hintStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                      fillColor: Colors.white,
                      hintText: widget.currentName,
                      labelText: "NAME",
                      labelStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          label: Text(
                            'GENDER',
                            style: TextStyle(
                                fontFamily: "gilroy",
                                color: notifire.getdarkscolor),
                          ),
                          errorStyle: const TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          hintText: 'Select Your Country',
                          hintStyle: TextStyle(
                              fontFamily: "gilroy",
                              color: notifire.getdarkscolor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: notifire.getgreycolor,
                            ),
                          ),
                        ),
                        //isEmpty: _SelectedValue! == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedValue,
                            isDense: true,
                            isExpanded: true,
                            dropdownColor: notifire.notificationbackground,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: items.map((String items) {
                              return DropdownMenuItem<String>(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(
                                      fontFamily: "gilroy",
                                      color: notifire.greytextColor),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    style: TextStyle(
                        fontFamily: "gilroy", color: notifire.getdarkscolor),
                    controller: date_of_birth,
                    readOnly: true,
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: firstdate,
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        // ignore: avoid_print
                        print(selectedDate);
                        String formattedDate =
                            DateFormat.yMd().format(selectedDate);
                        // ignore: avoid_print
                        print(formattedDate);
                        setState(
                          () {
                            date_of_birth.text = formattedDate;
                          },
                        );
                      } else {
                        // ignore: avoid_print
                        print("Date is not selected");
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      suffixIcon:
                          Image.asset("assets/calendar07.png", scale: 3.5),
                      hintText: 'DATE OF BIRTH',
                      hintStyle: TextStyle(
                          fontFamily: "gilroy", color: notifire.getdarkscolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 5.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          label: Text('NATIONALITY',
                              style: TextStyle(
                                  fontFamily: "gilroy",
                                  color: notifire.getdarkscolor)),
                          //labelText: "items",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: notifire.getgreycolor,
                            ),
                          ),
                          errorStyle: const TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          hintText: 'Select Your Country',
                          hintStyle: TextStyle(
                              fontFamily: "gilroy",
                              color: notifire.getdarkscolor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        //isEmpty: _SelectedValue! == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedValue2,
                            isDense: true,
                            isExpanded: true,
                            dropdownColor: notifire.notificationbackground,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue2 = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: items2.map((String items) {
                              return DropdownMenuItem<String>(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(
                                      color: notifire.greytextColor,
                                      fontFamily: "gilroy"),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
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
                      hintStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                      fillColor: Colors.white,
                      hintText: 'Enter Your Email',
                      labelText: "EMAIL",
                      labelStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
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
