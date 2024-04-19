// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:gradproj2/tripsdetailsdetailpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tripspageofnavigationbar extends StatefulWidget {
  const tripspageofnavigationbar({Key? key}) : super(key: key);

  @override
  State<tripspageofnavigationbar> createState() =>
      _tripspageofnavigationbarState();
}

class _tripspageofnavigationbarState extends State<tripspageofnavigationbar> {
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
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: notifire.backgroundallscreenColor,
        elevation: 0,
        title: Text(
          "Your booking",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: notifire.getdarkscolor,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Text(
              //       "Your booking",
              //       style: TextStyle(
              //           fontSize: 24,
              //           fontWeight: FontWeight.w600,
              //           color: Color(0xff0F182E),
              //           fontFamily: 'Gilroy'),
              //     ),
              //   ],
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const tripsdetailpage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: notifire.notificationbackground),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 33),
                          Row(
                            children: [
                              Image.asset(
                                "assets/boardingpassiconfirm.png",
                                scale: 14,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                "London",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: notifire.getdarkscolor,
                                    fontFamily: 'Gilroy'),
                              ),
                              const SizedBox(width: 12),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: notifire.getdarkscolor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "California",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy',
                                  color: notifire.getdarkscolor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Activity on Wed, Dec 1 at 11:00am",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffAEB4B9),
                                    fontFamily: 'Gilroy'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const tripsdetailpage(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff909CA7),
                                    size: 17),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const tripsdetailpage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: notifire.notificationbackground),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 33),
                          Row(
                            children: [
                              Image.asset(
                                "assets/hoteltrips.png",
                                scale: 12,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                "Hotel Palace",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: notifire.getdarkscolor,
                                    fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Check in Wed, Dec 1",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffAEB4B9),
                                    fontFamily: 'Gilroy'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const tripsdetailpage(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff909CA7),
                                    size: 17),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const tripsdetailpage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: notifire.notificationbackground),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 33),
                          Row(
                            children: [
                              Image.asset(
                                "assets/boardingpassiconfirm.png",
                                scale: 14,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                "London",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: notifire.getdarkscolor,
                                    fontFamily: 'Gilroy'),
                              ),
                              const SizedBox(width: 12),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: notifire.getdarkscolor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "California",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy',
                                  color: notifire.getdarkscolor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Activity on Wed, Dec 1 at 11:00am",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffAEB4B9),
                                    fontFamily: 'Gilroy'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const tripsdetailpage(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff909CA7),
                                    size: 17),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const tripsdetailpage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: notifire.notificationbackground),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 33),
                          Row(
                            children: [
                              Image.asset(
                                "assets/hoteltrips.png",
                                scale: 12,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                "Hotel Palace",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: notifire.getdarkscolor,
                                    fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Check in Wed, Dec 1",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffAEB4B9),
                                    fontFamily: 'Gilroy'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const tripsdetailpage(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Color(0xff909CA7),
                                    size: 17),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
