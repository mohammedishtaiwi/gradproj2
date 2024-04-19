// ignore_for_file: camel_case_types, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:gradproj2/tripspagenaviggationbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage1.dart';

class tripsdetailpage extends StatefulWidget {
  const tripsdetailpage({Key? key}) : super(key: key);

  @override
  State<tripsdetailpage> createState() => _tripsdetailpageState();
}

class _tripsdetailpageState extends State<tripsdetailpage> {
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
                  builder: (BuildContext context) =>
                      const tripspageofnavigationbar(),
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
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        title: Text(
          "Your Bookings",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DEA',
                      style: TextStyle(
                          fontSize: 24,
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy'),
                    ),
                    Column(
                      children: [
                        SizedBox(
                            height: 35,
                            width: 112,
                            child: Image.asset('assets/selectflight.png')),
                        const Text(
                          '1h 30 Min',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontFamily: 'Gilroy'),
                        ),
                      ],
                    ),
                    Text(
                      'LAH',
                      style: TextStyle(
                          fontSize: 24,
                          color: notifire.getdarkscolor,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Gilroy'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Dubai',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontFamily: 'Gilroy'),
                    ),
                    Text(
                      'Lahore',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontFamily: 'Gilroy'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 20, bottom: 20),
                child: Container(
                  height: 327,
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 22),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: notifire.notificationbackground,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Full Name',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff768089),
                                fontFamily: 'Gilroy'),
                          ),
                          Text(
                            'Percy Jackson',
                            style: TextStyle(
                                fontSize: 16,
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(thickness: 1),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Passport  ID',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff768089)),
                          ),
                          Text(
                            '87556278976',
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(thickness: 1),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Date of Birth',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Gilroy',
                                color: Color(0xff768089)),
                          ),
                          Text(
                            'Apr, 12 2021',
                            style: TextStyle(
                                fontSize: 16,
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Gate',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xff768089),
                                    fontFamily: 'Gilroy'),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                'B7',
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Flight number',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xff768089),
                                    fontFamily: 'Gilroy'),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                'EY71',
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Seat',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xff768089),
                                    fontFamily: 'Gilroy'),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                '21A',
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Class',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xff768089),
                                    fontFamily: 'Gilroy'),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                'Buisness',
                                style: TextStyle(
                                    color: notifire.getdarkscolor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 38.78),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 14,
                                width: 14,
                                child: Image.asset(
                                    'assets/clarity_briefcase-line.png'),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Cabin bag',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff768089),
                                  fontFamily: 'Gilroy',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '3 Kgs',
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22.33),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 14,
                                width: 14,
                                child: Image.asset('assets/suitcase.png'),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Check in',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff768089),
                                    fontSize: 12,
                                    fontFamily: 'Gilroy'),
                              ),
                            ],
                          ),
                          Text(
                            '25 Kgs',
                            style: TextStyle(
                                color: notifire.getdarkscolor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Gilroy'),
                          ),
                        ],
                      ),
                    ],
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
