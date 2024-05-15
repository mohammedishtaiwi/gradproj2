import 'package:flutter/material.dart';
import 'package:gradproj2/editprofile.dart';
import 'package:gradproj2/notificationmain.dart';
import 'package:gradproj2/searchflight.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// ignore: camel_case_types
class home1 extends StatefulWidget {
  const home1({Key? key}) : super(key: key);

  @override
  State<home1> createState() => _home1State();
}

// ignore: camel_case_types
class _home1State extends State<home1> with TickerProviderStateMixin {
  bool show = false;
  late ColorNotifire notifire;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
    _firebaseMessaging.requestPermission();
  }

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

    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: notifire.backgroundallscreenColor,
          appBar: AppBar(
            backgroundColor: notifire.backgroundallscreenColor,
            automaticallyImplyLeading: false,
            toolbarHeight: 85,
            //toolbarOpacity: 0,
            elevation: 0,
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const editprofile(
                            profileImageUrl: '',
                            currentName: '',
                            currentUsername: '',
                            currentPass: '',
                          ),
                        ),
                      );
                    },
                    child:
                        // Inside your build method in _home1State class

                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream:
                          getUserStream(), // Listen for changes in the user document
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData) {
                            final data = snapshot.data!.data();
                            final String profileImageUrl =
                                data?['profileImageUrl'] ?? '';

                            return const SizedBox(
                              height: 52,
                              width: 52,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(
                                        'assets/default_profile_picture.png')
                                    as ImageProvider<Object>?,
                              ),
                            );
                          } else {
                            // Display default avatar image if data is not available
                            return const SizedBox(
                              height: 52,
                              width: 52,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/default_avatar.png'),
                                radius: 25,
                              ),
                            );
                          }
                        } else {
                          // Display a loading indicator while fetching data
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                            fontFamily: "gilroy",
                            fontSize: 13,
                            color: notifire.getdarkscolor,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Color.fromARGB(255, 106, 160, 225),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Amman, ",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                fontFamily: 'Gilroy'),
                          ),
                          Text(
                            "Jordan",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: 'Gilroy'),
                          ),
                          // const SizedBox(
                          //   width: 5,
                          // ),
                          // const Icon(Icons.keyboard_arrow_down_outlined,
                          //     color: Colors.blue),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const NotificationPage(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: SizedBox(
                        height: 52,
                        width: 52,
                        child: CircleAvatar(
                          backgroundColor: notifire.notificationbackground,
                          // ignore: sort_child_properties_last
                          child: Image.asset(
                            'assets/Notification.png',
                            height: 20,
                            color: notifire.backbuttoniconColor,
                          ),
                          radius: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Column(children: [
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: getUserStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          Text(
                            "    Welcome, ${snapshot.data!['name']}",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                fontFamily: 'Gilroy'),
                          ),
                          //const SizedBox(height: 20),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Text(
                            "    Welcome, User",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                fontFamily: 'Gilroy'),
                          ),
                          // const SizedBox(height: 20),
                        ],
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              // const SizedBox(height: 4),
              // const Divider(thickness: 1),
              // const SizedBox(height: 4),
              // Container(
              //   //height: kToolbarHeight + 4,
              //   padding: const EdgeInsets.only(top: 0),
              //   decoration: const BoxDecoration(
              //     color: Color.fromARGB(0, 203, 5, 5),
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(8.0),
              //       topRight: Radius.circular(8.0),
              //       bottomLeft: Radius.circular(8.0),
              //       bottomRight: Radius.circular(8.0),
              //     ),
              //   ),
              // ),
              const Expanded(
                child: searchflight(),
              ),
            ]),
          ),
        ));
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = _auth.currentUser;

  if (user != null) {
    final String uid = user.uid;

    final DocumentReference<Map<String, dynamic>> userDoc =
        FirebaseFirestore.instance.collection('users').doc(uid);

    final DocumentSnapshot<Map<String, dynamic>> doc = await userDoc.get();

    return doc;
  } else {
    // Handle case where user is not authenticated
    throw FirebaseAuthException(
      code: 'user-not-authenticated',
      message: 'User is not authenticated.',
    );
  }
}

Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream() {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = _auth.currentUser;

  if (user != null) {
    final String uid = user.uid;

    final DocumentReference<Map<String, dynamic>> userDoc =
        FirebaseFirestore.instance.collection('users').doc(uid);

    return userDoc.snapshots();
  } else {
    // Handle case where user is not authenticated
    throw FirebaseAuthException(
      code: 'user-not-authenticated',
      message: 'User is not authenticated.',
    );
  }
}
