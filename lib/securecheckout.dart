// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:gradproj2/confirmation.dart';
import 'package:gradproj2/filtershortdetailpage.dart';
import 'package:gradproj2/planeinfo.dart';
import 'package:gradproj2/pricebreakdownpage.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class checkoutpage extends StatefulWidget {
  const checkoutpage({Key? key}) : super(key: key);

  @override
  State<checkoutpage> createState() => _checkoutpageState();
}

class _checkoutpageState extends State<checkoutpage> {
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
                  builder: (BuildContext context) => const filtershortdetail(),
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
                // ignore: sort_child_properties_last
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
                          builder: (BuildContext context) =>
                              const filtershortdetail(),
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
          "Secure checkout",
          style: TextStyle(
              color: notifire.getdarkscolor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontFamily: 'Gilroy'),
        ),
      ),
      bottomNavigationBar: Container(
        height: 103,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            color: notifire.bottomnavigationbarbacground),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy'),
                  ),
                  Text(
                    "\$450",
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy'),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const confirmpage(),
                    ),
                  );
                },
                child: Container(
                  width: 173,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xff1F75EC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "CONFIRM",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
              //Expanded(child: SizedBox(height:10)),
              Padding(
                padding: const EdgeInsets.only(left: 27),
                child: Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset('assets/checkoutbreakdown.png'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff1F75EC),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const pricebreakdown(),
                          ),
                        );
                      },
                      child: const Text(
                        'Price breakdown',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gilroy'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 27),
                child: Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset('assets/planecheckout.png'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff1F75EC),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const planeinfo(),
                          ),
                        );
                      },
                      child: const Text(
                        'Plane info',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gilroy'),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 75,
              // ),
              // const Divider(thickness: 1),
              // SizedBox(
              //   //height: 53,
              //   width: 375,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 42, top: 17),
              //             child: Row(
              //               children: const [
              //                 Text(
              //                   "Price",
              //                   style: TextStyle(
              //                       color: Color(0xff717171),
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w400),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           const SizedBox(height: 5),
              //           Row(
              //             children: const [
              //               Text(
              //                 '\$450',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.w600, fontSize: 30),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(top: 17),
              //         child: SizedBox(
              //           height: 56,
              //           width: 173,
              //           child: FloatingActionButton(
              //             elevation: 0,
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(14)),
              //             // ignore: sort_child_properties_last
              //             child: const Text('CONFIRM',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.w600, fontSize: 16)),
              //             backgroundColor: Colors.blueAccent.shade400,
              //             onPressed: () {
              //               Navigator.of(context).push(
              //                 MaterialPageRoute(
              //                   builder: (BuildContext context) =>
              //                   const baordingpasspage(),
              //                 ),
              //               );
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
