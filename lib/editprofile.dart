import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gradproj2/homepage1.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class editprofile extends StatefulWidget {
  const editprofile({Key? key}) : super(key: key);

  @override
  State<editprofile> createState() => _editprofileState();
}

// ignore: camel_case_types
class _editprofileState extends State<editprofile> {
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
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => const contactinfo(),
              //   ),
              // );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Stack(
                  children: [
                    //Container(height:140,color: Colors.blue),
                    // Container(height:140,color: Colors.blue),
                    Container(
                      height: 113,
                      width: 113,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/editprofile.png",
                            ),
                            scale: 0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
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
                      hintText: 'Enter Your First Name',
                      labelText: "FIRST NAME",
                      labelStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: middlename,
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
                      hintText: 'Enter Your Middle Name',
                      labelText: "MIDDLE NAME",
                      labelStyle: TextStyle(
                          color: notifire.getdarkscolor, fontFamily: "gilroy"),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: lastname,
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
                      hintText: 'Enter Your Last Name',
                      labelText: "LAST NAME",
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
                        lastDate: lastdate,
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
}
// Widget imageProfile() {
//   return Center(
//     child: Stack(children: <Widget>[
//       CircleAvatar(
//         radius: 80.0,
//         backgroundImage: _imageFile == null
//             ? AssetImage("assets/profile.jpeg")
//             : FileImage(File(_imageFile.path)),
//       ),
//       Positioned(
//         bottom: 20.0,
//         right: 20.0,
//         child: InkWell(
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               builder: ((builder) => bottomSheet()),
//             );
//           },
//           child: Icon(
//             Icons.camera_alt,
//             color: Colors.teal,
//             size: 28.0,
//           ),
//         ),
//       ),
//     ]),
//   );
// }

// Widget bottomSheet() {
//   return Container(
//     height: 100.0,
//     //width: MediaQuery.of(context).size.width,
//     margin: EdgeInsets.symmetric(
//       horizontal: 20,
//       vertical: 20,
//     ),
//     child: Column(
//       children: <Widget>[
//         Text(
//           "Choose Profile photo",
//           style: TextStyle(
//             fontSize: 20.0,
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
//           FlatButton.icon(
//             icon: Icon(Icons.camera),
//             onPressed: () {
//               takePhoto(ImageSource.camera);
//             },
//             label: Text("Camera"),
//           ),
//           FlatButton.icon(
//             icon: Icon(Icons.image),
//             onPressed: () {
//               takePhoto(ImageSource.gallery);
//             },
//             label: Text("Gallery"),
//           ),
//         ])
//       ],
//     ),
//   );
// }
//
// void takePhoto(ImageSource source) async {
//   final pickedFile = await _picker.getImage(
//     source: source,
//   );
//   setState(() {
//     _imageFile = pickedFile;
//   });
// }
//
// class _imageFile {
// }
//
// void setState(Null Function() param0) {
// }
