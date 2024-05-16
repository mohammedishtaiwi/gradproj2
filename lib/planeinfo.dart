import 'package:flutter/material.dart';
import 'package:gradproj2/confirmation.dart';
import 'package:gradproj2/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'filtershortdetailpage.dart';

// ignore: camel_case_types
class planeinfo extends StatefulWidget {
  const planeinfo({Key? key}) : super(key: key);

  @override
  State<planeinfo> createState() => _planeinfoState();
}

// ignore: camel_case_types
class _planeinfoState extends State<planeinfo> {
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
          "Plane info",
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
                  const Text(
                    "Price",
                    style: TextStyle(
                        color: Color(0xff717171),
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
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'DEA',
                    style: TextStyle(
                        color: notifire.getdarkscolor,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy'),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 35,
                        width: 112,
                        child: Image.asset('assets/selectflight.png'),
                      ),
                      const Text(
                        '1h 30 Min',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Gilroy',
                            color: Colors.grey),
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
                        fontFamily: 'Gilroy',
                        color: Colors.grey),
                  ),
                  Text(
                    'Lahore',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Gilroy',
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    color: notifire.notificationbackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Container(
                          //height: 401,

                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 22, left: 15),
                          child: Text(
                            'Airbus A3-78',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Gilroy',
                              color: notifire.getdarkscolor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 214,
                          width: 193,
                          child: Image.asset(
                              'assets/planeinfocard-removebg-preview.png'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 34, right: 34),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Airbus A3-78',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Gilroy',
                                      color: Color(0xff9299A0),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    '9V-SHT',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: notifire.getdarkscolor,
                                        fontFamily: 'Gilroy'),
                                  ),
                                  const SizedBox(
                                    height: 23,
                                  ),
                                  const Text(
                                    'Cruising Speed',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff9299A0),
                                        fontFamily: 'Gilroy'),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    '674 mph',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: notifire.getdarkscolor,
                                        fontFamily: 'Gilroy'),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'ICAO Type',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff9299A0),
                                        fontFamily: 'Gilroy'),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    'A3ER',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: notifire.getdarkscolor,
                                        fontFamily: 'Gilroy'),
                                  ),
                                  const SizedBox(
                                    height: 23,
                                  ),
                                  const Text(
                                    'Range',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff9299A0),
                                        fontFamily: 'Gilroy'),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    'A3ER',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: notifire.getdarkscolor,
                                        fontFamily: 'Gilroy'),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tail No.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Gilroy',
                                      color: Color(0xff9299A0),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    '--',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: notifire.getdarkscolor,
                                        fontFamily: 'Gilroy'),
                                  ),
                                  const SizedBox(
                                    height: 23,
                                  ),
                                  const Text(
                                    'First Flight',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff9299A0),
                                        fontFamily: 'Gilroy'),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    '--',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: notifire.getdarkscolor,
                                        fontFamily: 'Gilroy'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            //Divider(thickness: 1),
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
            //         padding: EdgeInsets.only(top: 17),
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
            //                   const confirmpage(),
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
    );
  }
}
