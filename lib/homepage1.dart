import 'package:flutter/material.dart';
import 'package:gradproj2/editprofile.dart';
import 'package:gradproj2/notificationmain.dart';
import 'package:gradproj2/searchflight.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
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
                          ),
                        ),
                      );
                    },
                    child:
                        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: getUser(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            final data = snapshot.data!.data();
                            final String profileImageUrl =
                                data?['profileImageUrl'] ?? '';

                            return SizedBox(
                              height: 52,
                              width: 52,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: profileImageUrl != null
                                    ? NetworkImage(profileImageUrl)
                                    : const AssetImage(
                                            'assets/placeholder_image.png')
                                        as ImageProvider<Object>?,
                              ),
                            );
                          } else {
                            // Display default avatar image if data is not available
                            return SizedBox(
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
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                            fontFamily: "gilroy",
                            fontSize: 12,
                            color: notifire.getdarkscolor,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Color(0xff1F75EC),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Amman,",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                fontFamily: 'Gilroy'),
                          ),
                          Text(
                            "Jordan",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                fontFamily: 'Gilroy'),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
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
                              const notification(),
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
            padding: const EdgeInsets.all(10),
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
                            "Welcome, ${snapshot.data!['name']}",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Text(
                            "Welcome, User",
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              Row(
                children: [
                  Text(
                    "Search flight",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
              Container(
                //height: kToolbarHeight + 4,
                padding: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
              ),
              Expanded(
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
